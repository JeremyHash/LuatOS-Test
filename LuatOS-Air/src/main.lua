-- LuatOS-Air-Test
-- Author:openluat
-- CreateDate:20211011
-- UpdateDate:20211011
PROJECT = "LuatOS-Air-Test"
VERSION = "1.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- 测试配置 设置为true代表开启此项测试
testConfig = {
    -- 8910 1603S 1603E
    modType = "8910",
    -- single loop
    testMode = "single",
    gpsModType = "GK",
    netLed = true,
    consoleTest = false,
    lteTest = true,
    socketTest = false,
    httpTest = false,
    mqttTest = false,
    ftpTest = false,
    iotTest = false,
    rtmpTest = false,
    audioTest = false,
    lvglTest = false,
    peripheralsTest = false,
    fsTest = false,
    gpioTest = false,
    lbsLocTest = false,
    bleTest = false,
    gpsTest = false,
    keypadTest = false
}

-- cmux ppp alarm  simdetect usb download factory fota

require "sys"
require "net"
require "common"
require "utils"
require "misc"
require "ntp"
require "http"
require "socket"
require "websocket"
require "mqtt"
require "ftp"
require "pins"
require "lbsLoc"
require "pm"
require "nvm"
require "aLiYun"
require "pb"
require "ril"
require "patch"
-- require "wdt"

if testConfig.modType == "8910" or testConfig.modType == "1603E" then
    require "cc"
    require "wifiScan"
    require "scanCode"
    require "uiWin"
    require "audio"
    require "record"
end

function outPutTestRes(data)
    if testConfig.testMode == "single" then
        uart.write(uart.USB, data .. "\r\n")
    end
end

function printTable(tbl, lv)
    lv = lv and lv .. "\t" or ""
    print(lv .. "{")
    for k, v in pairs(tbl) do
        if type(k) == "string" then k = "\"" .. k .. "\"" end
        if "string" == type(v) then
            local qv = string.match(string.format("%q", v), ".(.*).")
            v = qv == v and '"' .. v .. '"' or "'" .. v:toHex() .. "'"
        end
        if type(v) == "table" then
            print(lv .. "\t" .. tostring(k) .. " = ")
            printTable(v, lv)
        else

            print(lv .. "\t" .. tostring(k) .. " = " .. tostring(v) .. ",")
        end
    end
    print(lv .. "},")
end

if testConfig.testMode == "single" then
    local tag = "singleTest"
    local res = uart.setup(uart.USB, 921600, 8, uart.PAR_NONE, uart.STOP_1)
    log.info(tag,
             "结果输出串口初始化成功，初始化波特率" .. res)
end

if testConfig.netLed == true then
    require "netLed"
    if testConfig.modType == "8910" then
        pmd.ldoset(15, pmd.LDO_VLCD)
        netLed.setup(true, 1, 4)
    elseif testConfig.modType == "1802S" then
        netLed.setup(true, 64, 65)
    elseif testConfig.modType == "1603E" or testConfig.modType == "1603S" then
        netLed.setup(true, 121, 35)
    end
end

if testConfig.consoleTest == true then
    pm.wake("LuatOSTest")

    require "console"
    console.setup(uart.USB, 921600)
end

if testConfig.lteTest == true then require "LteTest" end

if testConfig.socketTest == true then require "SocketTest" end

if testConfig.httpTest == true then require "HttpTest" end

if testConfig.mqttTest == true then require "MqttTest" end

if testConfig.ftpTest == true then require "FtpTest" end

if testConfig.lbsLocTest == true then require "LbsLocTest" end

if testConfig.peripheralsTest == true then require "PeripheralsTest" end

if testConfig.gpsTest == true then require "GpsTest" end

-- sys.taskInit(function()
--     while true do
--         log.info("PROJECT", PROJECT)
--         log.info("CORE", rtos.get_version())
--         log.info("USER_SCRIPT", VERSION)
--         log.info("LIB", sys.SCRIPT_LIB_VER)
--         log.info("FS_TOTAL_SIZE", rtos.get_fs_total_size() .. "Bytes")
--         log.info("FS_FREE_SIZE", rtos.get_fs_free_size() .. "Bytes")
--         log.info("RAM_USEAGE", collectgarbage("count") .. "KB")
--         log.info("SOCKET_STATUS", socket.isReady())
--         log.info("PERCENTAGE", rtos.get_env_usage() .. "%")
--         log.info("PWRON_REASON", rtos.poweron_reason())
--         local timeTable = misc.getClock()
--         log.info("TIME",
--                  string.format("%d-%d-%d %d:%d:%d", timeTable.year,
--                                timeTable.month, timeTable.day, timeTable.hour,
--                                timeTable.min, timeTable.sec))
--         sys.wait(3000)
--     end
-- end)

ntp.timeSync(nil, function(time, result)
    local tag = "ntpTimeSync"
    if result == true then
        log.info(tag .. ".result", "校时成功")
        log.info(tag .. ".time", "tableInfo")
        printTable(time)
    elseif result == false then
        log.info(tag .. ".result", "校时失败")
    else
        log.info(tag .. ".result", result)
        log.info(tag .. ".time", time)
    end
end)

ril.request("AT*EXASSERT=1")
ril.request("AT+RNDISCALL=0,1")

if testConfig.modType == "8910" then
    ril.request("AT^TRACECTRL=0,1,1")
    ril.request("AT*SIMAUTO=0")
end

sys.init(0, 0)
sys.run()
