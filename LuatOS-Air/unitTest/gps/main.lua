-- GPSTest
-- Author:openluat
-- CreateDate:20211021
-- UpdateDate:20211029
PROJECT = "GPSTest"
VERSION = "1.0.0"

require "sys"
require "ntp"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- GK/ZKW/HXXT false/true
local gpsModType = "ZKW"
local rtk = false

local serverAddr = "http://114.55.242.59:2900"
local postGPSLocInfoAddress = serverAddr .. "/postGPSLocInfo"
local gpsLattmp, gpsLngtmp = "", ""
local GPSSendToServer = false

local tag = "GPSTest"

local function sendGPSInfoToServer(lat, lng)
    local gpsLocInfo = {lat = lat, lng = lng, timestamp = os.time()}
    http.request("POST", postGPSLocInfoAddress, nil,
                 {["Content-Type"] = "application/json"},
                 json.encode(gpsLocInfo), nil,
                 function(result, prompt, head, body)
        if result then
            log.info(tag .. ".sendGPSInfoToServer.result", "SUCCESS")
        else
            log.info(tag .. ".sendGPSInfoToServer.result", "FAIL")
        end
        log.info(tag .. ".sendGPSInfoToServer.prompt", "Http状态码:", prompt)
        if result and head then
            log.info(tag .. ".sendGPSInfoToServer.Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".sendGPSInfoToServer.Head", k .. " : " .. v)
            end
        end
        if result and body then
            log.info(tag .. ".sendGPSInfoToServer.Body", "body=" .. body)
            log.info(tag .. ".sendGPSInfoToServer.Body",
                     "bodyLen=" .. body:len())
        end
    end)
end

local function printGpsInfo()
    local selectedGPS
    if gpsModType == "GK" then
        selectedGPS = gps
    elseif gpsModType == "ZKW" then
        selectedGPS = gpsZkw
    elseif gpsModType == "HXXT" then
        selectedGPS = gpsHxxt
    else
        log.error(tag .. ".modType", "GPS模块型号错误FAIL")
        return
    end
    if selectedGPS.isOpen() and selectedGPS.isFix() then
        local tLocation = selectedGPS.getLocation()
        local lat = tLocation.lat
        local lng = tLocation.lng
        log.info(tag .. ".Info", lat, lng)
        -- local UTCTime = selectedGPS.getUtcTime()
        -- log.info("GPSLocTest.UTCTime", string.format("%d-%d-%d %d:%d:%d", UTCTime.year, UTCTime.month, UTCTime.day, UTCTime.hour, UTCTime.min, UTCTime.sec))

        if GPSSendToServer == true then
            if lat == gpsLattmp and lng == gpsLngtmp then
                log.info("GPSLocTest",
                         "GPS定位信息未发生改变，本次定位结果不上传服务器")
            else
                gpsLattmp = lat
                gpsLngtmp = lng
                sendGPSInfoToServer(lat, lng)
            end
        end
    end
end

local function nmeaCb(nmeaData)
    if rtk == true then rtk.write(nmeaData) end
    -- log.info("GPSTest.nmeaCb", nmeaData)
end

local function gpsTestTask()

    if rtk == true then
        rtos.on(rtos.MSG_RTK_INFO,
                function(msg)
            log.info("rtk", msg.id, msg.status, msg.data)
        end)

        local para = {
            appKey = "xyuwwhggzueyiqpgba",
            appSecret = "",
            solMode = rtk.SOLMODE_RTK,
            solSec = rtk.SEC_5S,
            reqSec = rtk.SEC_5S
        }
        rtk.open(para)
    end

    log.info(tag .. ".open", "打开GPS")

    if gpsModType == "GK" then
        require "gps"
        require "agps"

        pmd.ldoset(15, pmd.LDO_VIBR)
        gps.setNmeaMode(2, nmeaCb)
        gps.setUart(3, 115200, 8, uart.PAR_NONE, uart.STOP_1)
        gps.open(gps.DEFAULT, {tag = "GPSLocTest"})
    elseif gpsModType == "ZKW" then
        require "gpsZkw"
        require "agpsZkw"

        gpsZkw.setUart(3, 9600, 8, uart.PAR_NONE, uart.STOP_1)
        gpsZkw.open(gpsZkw.DEFAULT, {tag = "GPSLocTest"})
        gpsZkw.setNmeaMode(2, nmeaCb)
    elseif gpsModType == "HXXT" then
        require "gpsHxxt"
        require "agpsHxxt"

        gpsHxxt.setUart(2, 115200, 8, uart.PAR_NONE, uart.STOP_1)
        gpsHxxt.open(gpsHxxt.DEFAULT, {tag = "GPSLocTest"})
        gpsHxxt.setNmeaMode(2, nmeaCb)
    else
        log.error(tag .. ".modType", "GPS模块型号错误FAIL")
        return
    end

    sys.timerLoopStart(printGpsInfo, 2000)
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, GPS测试开始")
    gpsTestTask()
end)

sys.init(0, 0)
sys.run()
