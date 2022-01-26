-- LuatOS-Air-Test
-- Author:openluat
-- CreateDate:20211011
-- UpdateDate:20211105
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
    testMode = "loop",
    netLed = true,
    adcTest = true,
    i2cTest = true,
    spiTest = true,
    bitTest = true,
    cryptoTest = true,
    packTest = true,
    stringTest = true,
    commonTest = true,
    ntpTest = true,
    tableTest = true,
    uartTest = true,
    simTest = true,
    jsonTest = true,
    mathTest = true,
    rtosTest = true,
    consoleTest = false,
    socketTest = false,
    httpTest = false,
    mqttTest = false,
    fsTest = false,
    lbsLocTest = false
}

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
    pm.wake(PROJECT)

    require "console"
    console.setup(uart.USB, 921600)
end

function testTask()
    if testConfig.adcTest == true then require"adcTest".test() end
    if testConfig.i2cTest == true then require"i2cTest".test() end
    if testConfig.spiTest == true then require"spiTest".test() end
    if testConfig.bitTest == true then require"bitTest".test() end
    if testConfig.cryptoTest == true then require"cryptoTest".test() end
    if testConfig.packTest == true then require"packTest".test() end
    if testConfig.stringTest == true then require"stringTest".test() end
    if testConfig.commonTest == true then require"commonTest".test() end
    if testConfig.ntpTest == true then require"ntpTest".test() end
    if testConfig.tableTest == true then require"tableTest".test() end
    if testConfig.uartTest == true then require"uartTest".test() end
    if testConfig.simTest == true then require"simTest".test() end
    if testConfig.jsonTest == true then require"jsonTest".test() end
    if testConfig.mathTest == true then require"mathTest".test() end
    if testConfig.rtosTest == true then require"rtosTest".test() end
    if testConfig.socketTest == true then require "SocketTest" end
    if testConfig.httpTest == true then require "HttpTest" end
    if testConfig.mqttTest == true then require "MqttTest" end
    if testConfig.fsTest == true then require "FsTest" end
    if testConfig.lbsLocTest == true then require "LbsLocTest" end
end

sys.taskInit(function()
    sys.wait(5000)
    if testConfig.testMode == "single" then
        testTask()
    elseif testConfig.testMode == "loop" then
        while true do
            testTask()
            sys.wait(100)
        end
    end
end)

sys.taskInit(function()
    while true do
        sys.wait(10000)
        log.info("PROJECT", PROJECT)
        log.info("IMEI", misc.getImei())
        log.info("CORE", rtos.get_version())
        -- log.info("MODEL_HWVER", rtos.get_hardware())
        log.info("USER_SCRIPT", VERSION)
        log.info("LIB", sys.SCRIPT_LIB_VER)
        log.info("FS_TOTAL_SIZE", rtos.get_fs_total_size() .. "Bytes")
        log.info("FS_FREE_SIZE", rtos.get_fs_free_size() .. "Bytes")
        log.info("RAM_USEAGE", collectgarbage("count") .. "KB")
        log.info("SOCKET_STATUS", socket.isReady())
        log.info("PERCENTAGE", rtos.get_env_usage() .. "%")
        log.info("PWRON_REASON", rtos.poweron_reason())
        local timeTable = misc.getClock()
        log.info("TIME",
                 string.format("%d-%d-%d %d:%d:%d", timeTable.year,
                               timeTable.month, timeTable.day, timeTable.hour,
                               timeTable.min, timeTable.sec))
    end
end)

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
