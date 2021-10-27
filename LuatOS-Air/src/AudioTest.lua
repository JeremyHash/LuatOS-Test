-- AudioTest
-- Author:openluat
-- CreateDate:20211026
-- UpdateDate:20211026
module(..., package.seeall)

local modType = testConfig.modType

-- 音频播放优先级，数值越大，优先级越高
local PWRON, CALL, SMS, TTS, REC = 4, 3, 2, 1, 0

local waitTime1 = 1000
local waitTime2 = 3000
local waitTime3 = 10000
local waitTime4 = 30000

local playVol = 1
local micVol = 1
local count = 1
local speed = 4
local ttsStr = "上海合宙通信科技有限公司欢迎您"
local streamRecordFile
local tag = "AudioTest"

local tAudioFile = {
    [audiocore.WAV] = "call.wav",
    [audiocore.AMR] = "tip.amr",
    [audiocore.SPX] = "record.spx",
    -- [audiocore.PCM] = "alarm_door.pcm",
    [audiocore.MP3] = "sms.mp3"
}

local function audioStreamPlayTest(streamType)
    sys.taskInit(function()
        log.info(tag .. ".AudioStreamTest", "AudioStreamPlay Start",
                 tAudioFile[streamType])

        local fileHandle = io.open("/lua/" .. tAudioFile[streamType], "rb")
        if fileHandle == nil then
            log.error(tag .. ".AudioStreamTest", "Open file fail")
            outPutTestRes("AudioTest.AudioStreamTest Open file FAIL")
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
                outPutTestRes("AudioTest.AudioStreamTest AudioStreamPlay Over")
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
    outPutTestRes("AudioTest.RecordTest 录音播放结束")
    record.delete()
    sys.publish("FileRecordTestFinish")
end

function recordCb(result, size)
    log.info(tag .. ".RecordTest.RecordCb", "录音结束")
    outPutTestRes("AudioTest.RecordTest.RecordCb 录音结束")
    log.info(tag .. ".RecordTest.RecordCb.result, size", result, size)
    if result == true then
        log.info(tag .. ".RecordTest.RecordCb", "录制成功SUCCESS")
        outPutTestRes("AudioTest.RecordTest.RecordCb 录制成功SUCCESS")
        log.info(tag .. ".RecordTest.GetData", record.getData(0, size))
        log.info(tag .. ".RecordTest.GetSize", record.getSize())
        log.info(tag .. ".RecordTest.Exists", record.exists())
        log.info(tag .. ".RecordTest.IsBusy", record.isBusy())
        log.info(tag .. ".RecordTest.filePath", record.getFilePath())
        -- 播放录音内容
        log.info(tag .. ".RecordTest", "开始播放录音")
        outPutTestRes("AudioTest.RecordTest 开始播放录音")
        audio.play(REC, "FILE", record.getFilePath(), playVol, recordPlayCb)
    else
        log.info(tag .. ".RecordTest.RecordCb", "录制失败FAIL")
        outPutTestRes("AudioTest.RecordTest.RecordCb 录制失败FAIL")
        sys.publish("FileRecordTestFinish")
    end
end

local streamRecordBuffer = ""

function streamRecordCb1(result, size, label)
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
        outPutTestRes("AudioTest.RecordTest.StreamPlay 开始流录音播放")
        audio.play(REC, "FILE", "/streamRecordFile.amr", playVol, function()
            log.info(tag .. ".RecordTest.StreamPlay", "流录音播放结束")
            outPutTestRes(
                "AudioTest.RecordTest.StreamPlay 流录音播放结束")
            sys.publish("StreamRecordTestFinish")
        end)
    else
        log.error(tag .. ".RecordTest", "流录音FAIL")
        outPutTestRes("AudioTest.RecordTest 流录音FAIL")
    end
end

function streamRecordCb2(result, size, label)
    log.info(tag .. ".RecordTest.streamRecordCb", result, size, label)
    if label == "STREAM" then
        local s = audiocore.streamrecordread(size)
        streamRecordBuffer = streamRecordBuffer .. s
    else
        record.delete() -- 释放record资源
        log.info(tag .. ".RecordTest.StreamPlay", "开始流录音播放")
        outPutTestRes("AudioTest.RecordTest.StreamPlay 开始流录音播放")
        audiocore.streamplay(audiocore.AMR, "#!AMR\n" .. streamRecordBuffer)
        sys.timerStart(audiocore.stop, 5000)
        log.info(tag .. ".RecordTest.StreamPlay", "流录音播放结束")
        outPutTestRes("AudioTest.RecordTest.StreamPlay 流录音播放结束")
        streamRecordBuffer = ""
        sys.publish("StreamRecordTestFinish")
    end
end

local function audioPlayTestCb(result)
    if result == 0 then
        log.info(tag .. ".audioPlayTestCb", "播放成功SUCCESS")
        outPutTestRes("AudioTest.audioPlayTestCb 播放成功SUCCESS")
    elseif result == 1 then
        log.info(tag .. ".audioPlayTestCb", "播放出错FAIL")
        outPutTestRes("AudioTest.audioPlayTestCb 播放出错FAIL")
    elseif result == 2 then
        log.info(tag .. ".audioPlayTestCb",
                 "播放优先级不够，没有播放")
        outPutTestRes(
            "AudioTest.audioPlayTestCb 播放优先级不够，没有播放")
    elseif result == 3 then
        log.info(tag .. ".audioPlayTestCb",
                 "传入的参数出错，没有播放")
        outPutTestRes(
            "AudioTest.audioPlayTestCb 传入的参数出错，没有播放")
    elseif result == 4 then
        log.info(tag .. ".audioPlayTestCb", "被新的播放请求中止")
        outPutTestRes("AudioTest.audioPlayTestCb 播放成功SUCCESS")
    elseif result == 5 then
        log.info(tag .. ".audioPlayTestCb", "调用audio.stop接口主动停止")
        outPutTestRes(
            "AudioTest.audioPlayTestCb 调用audio.stop接口主动停止")
    end
end

local function playStopCb(result)
    if result == 0 then
        log.info(tag .. ".playStopCb", "SUCCESS")
        outPutTestRes("AudioTest.playStopCb SUCCESS")
    elseif result == 1 then
        log.info(tag .. ".playStopCb", "please wait")
        outPutTestRes("AudioTest.playStopCb please wait")
    end
end

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

local function audioTestTask()

    audio.setChannel(2, 0)

    -- 耳机插拔，音频通道自动切换(1603暂不支持)
    -- audiocore.headsetinit(1)

    local isTTSVersion = rtos.get_version():upper():find("TS")

    -- audiocore.playdata(audioData,audioFormat[,audioLoop]) demo中没有
    -- audiocore.setpa(audioClass) audiocore.getpa() audiocore.pa(gpio,devout,[plus_count],[plus_period]) 不清楚什么意思

    audio.setVolume(playVol)
    log.info(tag .. ".当前播放音量", playVol)

    local setMicResult = audio.setMicGain("record", micVol)
    if setMicResult == true then
        log.info(tag .. ".SetMicGain", "SUCCESS")
        outPutTestRes("AudioTest.SetMicGain SUCCESS")
    else
        log.error(tag .. ".SetMicGain", "FAIL")
        outPutTestRes("AudioTest.SetMicGain FAIL")
    end

    -- 播放音频文件
    log.info("AudioTest.AudioPlayTest.PlayFileTest", "第" .. count .. "次")
    audio.play(CALL, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb, true)
    sys.wait(waitTime2)
    audio.stop(playStopCb)
    log.info("AudioTest.AudioPlayTest.Stop", "播放中断")
    outPutTestRes("AudioTest.AudioPlayTest.Stop 播放中断")
    sys.wait(waitTime2)

    -- tts播放时，请求播放新的tts
    if isTTSVersion then
        log.info('AudioTest.AudioPlayTest.speed', speed)
        log.info(tag .. ".AudioPlayTest.PlayTtsTest", "第" .. count .. "次")
        audio.setTTSSpeed(speed)

        -- 设置优先级相同时的播放策略，1表示停止当前播放，播放新的播放请求
        audio.setStrategy(1)
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime1)
        log.info("AudioTest.AudioPlayTest.PlayTtsTest",
                 "相同优先级停止当前播放")
        outPutTestRes(
            "AudioTest.AudioPlayTest.PlayTtsTest 相同优先级停止当前播放")
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime3)

        -- 设置优先级相同时的播放策略，0表示继续播放正在播放的音频，忽略请求播放的新音频
        audio.setStrategy(0)
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime1)
        log.info("AudioTest.AudioPlayTest.PlayTtsTest",
                 "当前播放不会被打断")
        outPutTestRes(
            "AudioTest.AudioPlayTest.PlayTtsTest 当前播放不会被打断")
        audio.play(TTS, "TTS", ttsStr, playVol, audioPlayTestCb)
        sys.wait(waitTime3)
    end

    -- 播放冲突1
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1",
             "第" .. count .. "次")
    -- 循环播放来电铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1", "优先级: ", CALL)
    audio.play(CALL, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb, true)
    sys.wait(waitTime2)
    -- 3秒钟后，播放开机铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1",
             "优先级较高的开机铃声播放")
    outPutTestRes(
        "AudioTest.AudioPlayTest.PlayConflictTest1 优先级较高的开机铃声播放")
    log.info("AudioTest.AudioPlayTest.PlayConflictTest1", "优先级: ", PWRON)
    audio.play(PWRON, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb)
    sys.wait(waitTime2)

    -- 播放冲突2
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2",
             "第" .. count .. "次")
    -- 播放来电铃声
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2", "优先级: ", CALL)
    audio.play(CALL, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb, true)
    sys.wait(waitTime2)
    -- 3秒钟后，尝试循环播放新短信铃声，但是优先级不够，不会播放
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2",
             "优先级较低的短信铃声不能播放")
    outPutTestRes(
        "AudioTest.AudioPlayTest.PlayConflictTest2 优先级较低的短信铃声不能播放")
    log.info("AudioTest.AudioPlayTest.PlayConflictTest2", "优先级: ", SMS)
    audio.play(SMS, "FILE", "/lua/sms.mp3", playVol, audioPlayTestCb)
    sys.wait(waitTime2)
    audio.stop(playStopCb)
    sys.wait(waitTime2)

    -- # 流播放
    log.info(tag .. ".AudioStreamTest.WAVFilePlayTest", "Start")
    outPutTestRes("AudioTest.AudioStreamTest.WAVFilePlayTest Start")
    audioStreamPlayTest(audiocore.WAV)
    sys.wait(waitTime4)

    log.info(tag .. ".AudioStreamTest.AMRFilePlayTest", "Start")
    outPutTestRes("AudioTest.AudioStreamTest.AMRFilePlayTest Start")
    audioStreamPlayTest(audiocore.AMR)
    sys.wait(waitTime4)

    log.info(tag .. ".AudioStreamTest.MP3FilePlayTest", "Start")
    outPutTestRes("AudioTest.AudioStreamTest.MP3FilePlayTest Start")
    audioStreamPlayTest(audiocore.MP3)
    sys.wait(waitTime4)

    if modType == "8910" then
        -- 1603流播放不支持SPX和PCM
        log.info(tag .. ".AudioStreamTest.SPXFilePlayTest", "Start")
        outPutTestRes("AudioTest.AudioStreamTest.SPXFilePlayTest Start")
        audioStreamPlayTest(audiocore.SPX)
        sys.wait(waitTime4)

        -- log.info(tag..".AudioStreamTest.PCMFilePlayTest", "Start")
        -- outPutTestRes("AudioTest.AudioStreamTest.PCMFilePlayTest Start")
        -- audioStreamPlayTest(audiocore.PCM)
        -- sys.wait(waitTime4)
    end

    log.info(tag .. ".RecordTest", "当前MIC音量：", micVol)

    log.info(tag .. ".RecordTest", "开始普通录音")
    outPutTestRes("AudioTest.RecordTest 开始普通录音")
    record.start(5, recordCb, "FILE", 1, 1)
    sys.waitUntil("FileRecordTestFinish")

    if modType == "8910" then
        log.info(tag .. ".RecordTest", "开始流录音")
        outPutTestRes("AudioTest.RecordTest 开始流录音")
        os.remove("/streamRecordFile.amr")
        streamRecordFile = io.open("/streamRecordFile.amr", "a+")
        if streamRecordFile == nil then
            log.error(tag .. ".RecordTest", "创建录音文件FAIL")
            outPutTestRes("AudioTest.RecordTest 创建录音文件FAIL")
        else
            record.start(10, streamRecordCb1, "STREAM", 1, 1)
            sys.waitUntil("StreamRecordTestFinish", 25000)
        end
        sys.wait(waitTime4)
    elseif modType == "1603E" then
        log.info(tag .. ".RecordTest", "开始流录音")
        outPutTestRes("AudioTest.RecordTest 开始流录音")
        record.start(5, streamRecordCb2, "STREAM")
        sys.waitUntil("StreamRecordTestFinish")
        sys.wait(waitTime3)
    end

    local getPlayVol = audio.getVolume()

    if getPlayVol == playVol then
        log.info(tag .. ".PlayVolCheck", "SUCCESS")
        outPutTestRes("AudioTest.PlayVolCheck SUCCESS")
    else
        log.error(tag .. ".PlayVolCheck", "FAIL")
        outPutTestRes("AudioTest.PlayVolCheck FAIL")
    end

    count = count + 1
    playVol = (playVol == 7) and 1 or (playVol + 1)
    micVol = (micVol == 7) and 1 or (micVol + 1)
    speed = (speed == 100) and 4 or (speed + 16)
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Audio测试开始")
    if testConfig.testMode == "single" then
        audioTestTask()
    elseif testConfig.testMode == "loop" then
        while true do audioTestTask() end
    end
end)
