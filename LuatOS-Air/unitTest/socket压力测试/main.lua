-- socketTest
-- Author:openluat
-- CreateDate:20211112
-- UpdateDate:20211112
PROJECT = "socketTest"
VERSION = "1.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

require "sys"
require "net"
require "log"
require "common"
require "utils"
require "patch"
require "socket"

LOG_LEVEL = log.LOGLEVEL_TRACE

local tag = "socketTest"
local modType = "8910"
local connectResult, socketId, tcpClient
local ip, port = "airtest.openluat.com", 2901
local disconnectTimes, connectTimes, connectSuccessTimes, connectFailTimes,
      sendTimes, sendSuccessTimes, sendFailTimes, recvSuccessTimes,
      recvFailTimes, recvTimeoutTimes = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

local testData = string.rep("12345678", 128)

require "netLed"
if modType == "8910" then
    pmd.ldoset(15, pmd.LDO_VLCD)
    netLed.setup(true, 1, 4)
elseif modType == "1802S" then
    netLed.setup(true, 64, 65)
elseif modType == "1603E" or modType == "1603S" then
    netLed.setup(true, 121, 35)
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    while true do
        tcpClient = socket.tcp()
        connectResult, socketId = tcpClient:connect(ip, port)
        log.info(tag .. ".connectResult,socketId", connectResult, socketId)
        connectTimes = connectTimes + 1
        if connectResult == false then
            connectFailTimes = connectFailTimes + 1
            log.error(tag .. ".connect", "FAIL")
            log.info(tag .. ".connection", "disconnecting")
            tcpClient:close()
            log.info(tag .. ".connection", "disconnected")
        else
            connectSuccessTimes = connectSuccessTimes + 1
            while true do
                sendTimes = sendTimes + 1
                if tcpClient:send(testData) then
                    sendSuccessTimes = sendSuccessTimes + 1
                    log.info(tag .. ".sendResult", "SUCCESS")
                    local recvLen = 0
                    local recvData = ""
                    while true do
                        local result, data, para = tcpClient:recv(1000)
                        if result then
                            recvLen = recvLen + #data
                            recvData = recvData .. data
                        else
                            log.info(tag .. ".recv", "接收完毕")
                            break
                        end
                    end
                    -- log.info(tag .. ".recvLen", recvLen)
                    -- log.info(tag .. ".recvData", recvData)
                    if recvLen == 1024 and recvData == testData then
                        recvSuccessTimes = recvSuccessTimes + 1
                    elseif recvLen == 0 then
                        recvTimeoutTimes = recvTimeoutTimes + 1
                    else
                        recvFailTimes = recvFailTimes + 1
                    end
                else
                    disconnectTimes = disconnectTimes + 1
                    log.error(tag .. ".disconnect",
                              "与服务器断开连接，开始重连")
                    tcpClient:close()
                    break
                end
                sys.wait(10)
            end
        end
        sys.wait(1000)
    end
end)

sys.taskInit(function()
    while true do
        ril.request("AT+CESQ")
        ril.request("AT+CGATT?")
        ril.request("AT+CCED=0,1")
        log.info("发起连接次数", connectTimes)
        log.info("连接成功次数", connectSuccessTimes)
        log.info("连接失败次数", connectFailTimes)
        log.info("连接中断次数", disconnectTimes)
        log.info("发送数据次数", sendTimes)
        log.info("发送数据成功次数", sendSuccessTimes)
        log.info("接收数据成功次数", recvSuccessTimes)
        log.info("接收数据失败次数", recvFailTimes)
        log.info("接收数据超时次数", recvTimeoutTimes)
        sys.wait(5000)
    end
end)

ril.request("AT*EXASSERT=1")
ril.request("AT+RNDISCALL=0,1")

if modType == "8910" then
    ril.request("AT^TRACECTRL=0,1,1")
    ril.request("AT*SIMAUTO=0")
end

-- 启动系统框架
sys.init(0, 0)
sys.run()
