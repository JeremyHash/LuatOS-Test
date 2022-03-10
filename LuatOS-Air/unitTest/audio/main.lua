-- AudioTest
-- Author:openluat
-- CreateDate:20211028
-- UpdateDate:20211028
PROJECT = "AudioTest"
VERSION = "1.0.0"

require "sys"
require "ntp"
require "audio"
require "record"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- 8910/1603E loop/single
local modType = "8910"
local testMode = "loop"

-- 音频播放优先级，数值越大，优先级越高
local PWRON, CALL, SMS, TTS, REC = 4, 3, 2, 1, 0

local waitTime1 = 1000
local waitTime2 = 3000
local waitTime3 = 10000

local playVol = 1
local micVol = 1
local speed = 4
local ttsStr = "上海合宙通信科技有限公司欢迎您"
local streamRecordFile
local streamRecordBuffer = ""
local isTTSVersion = rtos.get_version():upper():find("TS")
local tag = "AudioTest"

local tAudioFile = {
    [audiocore.WAV] = "call.wav",
    [audiocore.AMR] = "tip.amr",
    [audiocore.SPX] = "record.spx",
    [audiocore.PCM] = "alarm_door.pcm",
    [audiocore.MP3] = "sms.mp3"
}

local function audioStreamPlayTest(streamType)
    sys.taskInit(function()
        log.info(tag .. ".AudioStreamTest", "AudioStreamPlay Start",
                 tAudioFile[streamType])
        local fileHandle = io.open("/lua/" .. tAudioFile[streamType], "rb")
        if fileHandle == nil then
            log.error(tag .. ".AudioStreamTest", "Open file fail")
            return
        end
        while true do
            local data = fileHandle:read(
                             streamType == audiocore.SPX and 1200 or 1024)
            if not data then
                fileHandle:close()
                while audiocore.streamremain() ~= 0 do
                    sys.wait(20)
                end
                sys.wait(1000)
                audiocore.stop()
                log.info(tag .. ".AudioStreamTest", "AudioStreamPlay Over")
                sys.publish("streamPlayFinish")
                return
            end
            local data_len = string.len(data)
            local curr_len = 1
            while true do
                curr_len = curr_len +
                               audiocore.streamplay(streamType, string.sub(data,
                                                                           curr_len,
                                                                           -1))
                if curr_len >= data_len then
                    break
                elseif curr_len == 0 then
                    log.error(tag .. ".AudioStreamTest",
                              "AudioStreamPlay Error", tAudioFile[streamType])
                    audiocore.stop()
                    sys.publish("streamPlayFinish")
                    return
                end
                sys.wait(10)
            end
            sys.wait(10)
        end
    end)
end

local function recordPlayCb(result)
    log.info(tag .. ".RecordTest.PlayCb", result)
    log.info(tag .. ".RecordTest", "录音播放结束")
    record.delete()
    sys.publish("FileRecordTestFinish")
end

function recordCb(result, size)
    log.info(tag .. ".RecordTest.RecordCb", "录音结束")
    log.info(tag .. ".RecordTest.RecordCb.result, size", result, size)
    if result == true then
        log.info(tag .. ".RecordTest.RecordCb", "录制成功SUCCESS")
        log.info(tag .. ".RecordTest.GetData", record.getData(0, size))
        log.info(tag .. ".RecordTest.GetSize", record.getSize())
        log.info(tag .. ".RecordTest.Exists", record.exists())
        log.info(tag .. ".RecordTest.IsBusy", record.isBusy())
        log.info(tag .. ".RecordTest.filePath", record.getFilePath())
        -- 播放录音内容
        log.info(tag .. ".RecordTest", "开始播放录音")
        audio.play(REC, "FILE", record.getFilePath(), playVol, recordPlayCb)
    else
        log.info(tag .. ".RecordTest.RecordCb", "录制失败FAIL")
        sys.publish("FileRecordTestFinish")
    end
end

local function streamRecordCb(result, size, label)
    log.info(tag .. ".RecordTest.streamRecordCb", result, size, label)
    if label == "STREAM" then
        streamRecordBuffer = streamRecordBuffer ..
                                 audiocore.streamrecordread(size)
        if #streamRecordBuffer > 4096 then
            streamRecordFile:write(streamRecordBuffer)
            streamRecordBuffer = ""
        end
    elseif label == "END" then
        streamRecordFile:write(streamRecordBuffer)
        streamRecordFile:close()
        streamRecordBuffer = ""
        log.info(tag .. ".RecordTest.StreamPlay", "开始流录音播放")
        audio.play(REC, "FILE", "/streamRecordFile.amr", playVol, function()
            log.info(tag .. ".RecordTest.StreamPlay", "流录音播放结束")
            sys.publish("StreamRecordTestFinish")
        end)
    else
        log.error(tag .. ".RecordTest", "流录音FAIL")
        sys.publish("StreamRecordTestFinish")
    end
end

local function audioPlayTestCb(result)
    if result == 0 then
        log.info(tag .. ".audioPlayTestCb", "播放成功SUCCESS")
    elseif result == 1 then
        log.info(tag .. ".audioPlayTestCb", "播放出错FAIL")
    elseif result == 2 then
        log.info(tag .. ".audioPlayTestCb",
                 "播放优先级不够，没有播放")
    elseif result == 3 then
        log.info(tag .. ".audioPlayTestCb",
                 "传入的参数出错，没有播放")
    elseif result == 4 then
        log.info(tag .. ".audioPlayTestCb", "被新的播放请求中止")
    elseif result == 5 then
        log.info(tag .. ".audioPlayTestCb", "调用audio.stop接口主动停止")
    end
    sys.publish("playAudioFinish")
end

local function audioPlayStopCb(result)
    if result == 0 then
        log.info(tag .. ".audioPlayStopCb", "SUCCESS")
    elseif result == 1 then
        log.info(tag .. ".audioPlayStopCb", "please wait")
    end
end

local function audioTestTask()

    audio.setChannel(2, 0)
    -- audiocore.pa(19, 2)
    
    -- audiocore.playdata(audioData,audioFormat[,audioLoop]) demo中没有
    -- audiocore.setpa(audioClass) audiocore.getpa() audiocore.pa(gpio,devout,[plus_count],[plus_period]) 不清楚什么意思

    log.info(tag .. ".playVol", playVol)
    log.info(tag .. ".micVol", micVol)

    local setVolRes = audio.setVolume(playVol)
    if setVolRes == true then
        log.info(tag .. ".setVolume", "SUCCESS")
    else
        log.error(tag .. ".setVolume", "FAIL")
    end

    local setMicRes = audio.setMicGain("record", micVol)
    if setMicRes == true then
        log.info(tag .. ".setMicGain", "SUCCESS")
    else
        log.error(tag .. ".setMicGain", "FAIL")
    end

    -- tts播放时，请求播放新的tts
    if isTTSVersion then
        log.info('AudioTest.AudioPlayTest.speed', speed)
        audio.setTTSSpeed(speed)

        -- 设置优先级相同时的播放策略，1表示停止当前播放，播放新的播放请求
        audio.setStrategy(1)
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime1)
        log.info("AudioTest.AudioPlayTest.PlayTtsTest",
                 "相同优先级停止当前播放")
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime3)

        -- 设置优先级相同时的播放策略，0表示继续播放正在播放的音频，忽略请求播放的新音频
        audio.setStrategy(0)
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime1)
        log.info("AudioTest.AudioPlayTest.PlayTtsTest",
                 "当前播放不会被打断")
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime3)
    end

    -- 播放冲突1
    -- 循环播放来电铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1", "优先级: ", CALL)
    audio.play(CALL, "FILE", "/lua/tip.amr", playVol, audioPlayTestCb, true)
    sys.wait(waitTime2)
    -- 3秒钟后，播放开机铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1",
             "优先级较高的开机铃声播放")
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1", "优先级: ", PWRON)
    audio.play(PWRON, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb)
    sys.wait(waitTime2)

    -- 播放冲突2
    -- 播放来电铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2", "优先级: ", CALL)
    audio.play(CALL, "FILE", "/lua/tip.amr", playVol, audioPlayTestCb, true)
    sys.wait(waitTime2)
    -- 3秒钟后，尝试循环播放新短信铃声，但是优先级不够，不会播放
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2",
             "优先级较低的短信铃声不能播放")
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2", "优先级: ", SMS)
    audio.play(SMS, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb)
    audio.stop(audioPlayStopCb)
    sys.wait(waitTime2)

    -- 流播放
    log.info(tag .. ".AudioStreamTest.AMRFilePlayTest", "Start")
    audioStreamPlayTest(audiocore.AMR)
    sys.waitUntil("streamPlayFinish")

    log.info(tag .. ".AudioStreamTest.MP3FilePlayTest", "Start")
    audioStreamPlayTest(audiocore.MP3)
    sys.waitUntil("streamPlayFinish")

    if modType == "8910" then
        audio.play(CALL, "FILE", "/lua/alarm_door.pcm", playVol, audioPlayTestCb)
        sys.waitUntil("playAudioFinish")

        log.info(tag .. ".AudioStreamTest.SPXFilePlayTest", "Start")
        audioStreamPlayTest(audiocore.SPX)
        sys.waitUntil("streamPlayFinish")

        log.info(tag .. ".AudioStreamTest.PCMFilePlayTest", "Start")
        audioStreamPlayTest(audiocore.PCM)
        sys.waitUntil("streamPlayFinish")
    elseif modType == "1603E" then
        audio.play(CALL, "FILE", "/lua/call.wav", playVol, audioPlayTestCb)
        sys.waitUntil("playAudioFinish")

        log.info(tag .. ".AudioStreamTest.WAVFilePlayTest", "Start")
        audioStreamPlayTest(audiocore.WAV)
        sys.waitUntil("streamPlayFinish")
    end

    log.info(tag .. ".RecordTest", "开始普通录音")
    record.start(5, recordCb, "FILE", 1, 1)
    sys.waitUntil("FileRecordTestFinish")

    log.info(tag .. ".RecordTest", "开始流录音")
    os.remove("/streamRecordFile.amr")
    streamRecordFile = io.open("/streamRecordFile.amr", "a+")
    if streamRecordFile == nil then
        log.error(tag .. ".RecordTest", "创建录音文件FAIL")
    else
        if modType == "1603E" then streamRecordFile:write("#!AMR\n") end
        record.start(10, streamRecordCb, "STREAM", 1, 1)
        sys.waitUntil("StreamRecordTestFinish")
    end

    local getPlayVol = audio.getVolume()

    if getPlayVol == playVol then
        log.info(tag .. ".PlayVolCheck", "SUCCESS")
    else
        log.error(tag .. ".PlayVolCheck", "FAIL")
    end

    playVol = (playVol == 7) and 0 or (playVol + 1)
    micVol = (micVol == 7) and 0 or (micVol + 1)
    speed = (speed == 100) and 4 or (speed + 16)
end

sys.taskInit(function()
    sys.wait(3000)
    if testMode == "single" then
        audioTestTask()
    elseif testMode == "loop" then
        while true do audioTestTask() end
    end
end)

local function headsetCb(msg)
    if msg.type == 1 then
        log.info("音频通道切换为耳机")
        audiocore.setchannel(1, 0)
    elseif msg.type == 2 then
        log.info("音频通道切换为喇叭")
        audiocore.setchannel(2, 0)
    elseif msg.type == 3 then
        log.info("耳机按键按下")
    elseif msg.type == 4 then
        log.info("耳机按键弹起")
    end
end
-- 注册core上报的rtos.MSG_AUDIO消息的处理函数
-- rtos.on(rtos.MSG_HEADSET, headsetCb)
-- audiocore.headsetinit(0)

sys.init(0, 0)
sys.run()
