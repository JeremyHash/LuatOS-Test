-- RtmpTest
-- Author:LuatTest
-- CreateDate:20211025
-- UpdateDate:20211025
module(..., package.seeall)

local tag = "RtmpTest"
audio.setChannel(1)
audio.setVolume(7)
local g_play_continue = false
local function audioMsg(msg)
    --log.info("audio.MSG_AUDIO",msg.play_end_ind,msg.play_error_ind)
	--[[
		result_code：
			0  ==  播放成功
			1  ==  播放失败
			2  ==  停止成功
			3  ==  停止失败
			4  ==  接收超时
			5  ==  连接失败
	]]
    log.info("audioMsgCb",msg.result,msg.result_code)
	--sys.publish("RTMP_PLAY_OVER")
    if msg.result_code == 0 then
		log.info(tag..".open SUCCESS")
        outPutTestRes("RtmpTest  PASS")
    elseif msg.result_code == 2 then
        log.info(tag..".close SUCCESS")
    else
        log.info(tag..".close FAIL")
        outPutTestRes("RtmpTest  FAIL")
	end
		sys.publish("RTMP_STOP_OK",msg.result_code)

end

rtos.on(rtos.MSG_RTMP, audioMsg)

--打印RAM空间
local function onRsp(currcmd, result, respdata, interdata)

	log.info("HEAPINFO: ",respdata)

end

local function rtmpTestTask()
    audio.setVolume(1)
	audio.setChannel(2)
	g_play_continue = false
	log.info(tag.."rtmpopen .....")
	--[[
		功能：打开rtmp播放
		参数：rtmp的链接地址
		返回：成功为1，失败为0
	]]
	--"rtmp://test/mp3"  "rtmp://wiki.airm2m.com:41935/live/test"
	audiocore.rtmpopen("rtmp://wiki.airm2m.com:41935/live/test") 
	sys.wait(20000)
	log.info(tag.."rtmpclose .....")
	audiocore.rtmpclose()
	local result, data = sys.waitUntil("RTMP_STOP_OK")
    if data == "0" then
        log.info(tag.."播放成功")
    elseif data == "1" then
        log.info(tag.."播放失败") 
    elseif data == "2" then
        log.info(tag.."停止成功") 
    elseif data == "3" then
        log.info(tag.."停止失败") 
    elseif data == "4" then
        log.info(tag.."接收超时") 
    elseif data == "5" then
        log.info(tag.."连接失败") 
    end
	ril.request("AT^HEAPINFO",nil,onRsp)
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Rtmp测试开始")
    if testConfig.testMode == "single" then
        rtmpTestTask()
    elseif testConfig.testMode == "loop" then
        while true do rtmpTestTask() end
    end
end)