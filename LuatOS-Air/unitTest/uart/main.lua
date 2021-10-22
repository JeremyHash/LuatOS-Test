PROJECT = "uartTest"
VERSION = "1.0.0"

require"utils"
require"pm"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "UartTransferTest"

-- 8910开发板 uart通道1 2 3
-- 1603开发板 uart通道1 2 3 4
-- 串口配置
local uartId = 1
local baud = 115200
local databits = 8

-- 透传服务器配置
local tcpClient
local ip = "114.55.242.59"
local port = 2901
local sendDataLen = 0
local receiveDataLen = 0

local function read()
    local uartData = ""
    while true do
        tmp = uart.read(uartId, "*l")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    if tcpClient ~= nil then
        tcpClient:asyncSend(uartData)
        sendDataLen = sendDataLen + string.len(uartData)
        log.info(tag .. ".sendDataLen", sendDataLen)
    else
        log.error(tag, "网络未就绪")
    end
end

-- UART相关的测试必须要防止模块休眠，不然会有串口收发数据的问题
pm.wake("UartTransferTest")

uart.setup(uartId, baud, databits, uart.PAR_NONE, uart.STOP_1)
uart.on(uartId, "receive", read)

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    sys.wait(5000)
    log.info(tag, "成功访问网络, UartTransferTest测试开始")
    tcpClient = socket.tcp()
    local connectResult, socketId = tcpClient:connect(ip, port)
    log.info(tag .. ".tcpClient.connectResult, socketId", connectResult,
             socketId)
    if connectResult then
        sys.publish("AsyncTcpSocketInitComplete")
        log.info(tag .. ".tcpClient.connect", "SUCCESS")
        while tcpClient:asyncSelect() do end
        log.error(tag .. ".tcpClient", "连接断开")
    else
        log.error(tag .. ".tcpClient.connect", "FAIL")
    end
    tcpClient:close()
    tcpClient = nil
end)

sys.subscribe("SOCKET_RECV", function(id)
    if tcpClient.id == id then
        local data = tcpClient:asyncRecv()
        receiveDataLen = receiveDataLen + data:len()
        log.info(tag .. ".receiveDataLen", receiveDataLen)
        uart.write(uartId, data)
    end
end)

sys.init(0, 0)
sys.run()
