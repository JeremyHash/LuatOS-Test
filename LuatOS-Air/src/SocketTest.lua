-- SocketTest
-- Author:openluat
-- CreateDate:20211012
-- UpdateDate:20220825
module(..., package.seeall)

local ip = "47.96.229.157"
-- port1 TCP UDP
-- port2 TCPSSL 单向
-- port3 TCPSSL 双向
local port1, port2, port3 = 2901, 2903, 443

-- 1KB
local testSendData1 = string.rep("SocketTest", 100)
-- 10KB
local testSendData2 = string.rep("\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09", 1000)

-- tcpClient1 -> 同步 TCP客户端
-- tcpClient2 -> 同步 TCPSSL单向认证客户端
-- tcpClient3 -> 同步 TCPSSL双向认证客户端
-- tcpClient4 -> 异步 TCP客户端

-- udpClient1 -> 同步 UDP客户端
-- udpClient2 -> 异步 UDP客户端
local tcpClient1, tcpClient2, tcpClient3, tcpClient4, udpClient1, udpClient2

local function socketTestTask()
    local connectResult, socketId
    local tag
    tag = "SocketTest.syncTcpTest"
    tcpClient1 = socket.tcp()
    connectResult, socketId = tcpClient1:connect(ip, port1)
    log.info(tag .. ".connectResult,socketId", connectResult, socketId)
    if connectResult == false then
        log.error(tag .. ".connect", "FAIL")
        outPutTestRes("SocketTest.syncTcpTest FAIL")
    else
        if tcpClient1:send("recv_big_file") then
            local fmd5Obj = crypto.flow_md5()
            log.info(tag .. ".sendResult", "SUCCESS")
            local recvLen = 0
            while true do
                local result, data, para = tcpClient1:recv(5000)
                if result then
                    recvLen = recvLen + #data
                    fmd5Obj:update(data)
                else
                    log.info(tag .. ".recv", "接收完毕")
                    break
                end
            end
            log.info(tag .. ".RecvLen", recvLen)
            local calcMD5 = fmd5Obj:hexdigest()
            if calcMD5 == "976CD4BFCA34702FE94BE41434397095" then
                log.info(tag .. ".recvLen.MD5check", "SUCCESS")
                outPutTestRes("SocketTest.syncTcpTest PASS")
            else
                log.error(tag .. ".recvLen.MD5check", "FAIL")
                outPutTestRes("SocketTest.syncTcpTest FAIL")

            end
        else
            log.error(tag .. ".sendResult", "FAIL")
            outPutTestRes("SocketTest.syncTcpTest FAIL")
        end
    end
    log.info(tag .. ".connection", "disconnecting")
    tcpClient1:close()
    log.info(tag .. ".connection", "disconnected")

    tag = "SocketTest.syncTcpOneWaySSLTest"
    tcpClient2 = socket.tcp(true, {
        caCert = "ca.crt"
    })
    connectResult, socketId = tcpClient2:connect(ip, port2)
    log.info(tag .. ".connectResult, socketId", connectResult, socketId)
    if connectResult then
        if tcpClient2:send(testSendData1) then
            log.info(tag .. ".sendResult", "SUCCESS")
            local recvLen = 0
            while true do
                local result, data, para = tcpClient2:recv(5000)
                if result then
                    recvLen = recvLen + #data
                else
                    log.info(tag .. ".recv", "接收完毕")
                    break
                end
            end
            log.info(tag .. ".recvLen", recvLen)
            if recvLen == 1000 then
                log.info(tag .. ".recvLen.check", "接收数据长度正确SUCCESS")
                outPutTestRes("SocketTest.syncTcpOneWaySSLTest PASS")
            else
                log.error(tag .. ".recvLen.check", "接收数据长度有误FAIL")
                outPutTestRes("SocketTest.syncTcpOneWaySSLTest FAIL")
            end
        else
            log.error(tag .. ".sendResult", "FAIL")
        end
    else
        log.error(tag .. ".connect", "FAIL")
        outPutTestRes("SocketTest.syncTcpOneWaySSLTest FAIL")
    end
    log.info(tag .. ".connection", "disconnecting")
    tcpClient2:close()
    log.info(tag .. ".connection", "disconnected")

    tag = "SocketTest.syncTcpTwoWaySSLTest"
    tcpClient3 = socket.tcp(true, {
        caCert = "ca.crt",
        clientCert = "client.crt",
        clientKey = "client.key"
    })
    connectResult, socketId = tcpClient3:connect(ip, port3)
    log.info(tag .. ".connectResult, socketId", connectResult, socketId)
    if connectResult then
        if tcpClient3:send("GET / HTTP/1.1\r\nHost: airtest.openluat.com\r\n\r\n") then
            log.info(tag .. ".sendResult", "SUCCESS")
            local recvLen = 0
            local content = ""
            while true do
                local result, data, para = tcpClient3:recv(5000)
                if result then
                    recvLen = recvLen + #data
                    content = content .. data
                else
                    log.info(tag .. ".recv", "接收完毕")
                    break
                end
            end
            log.info(tag .. ".recvLen", recvLen)
            -- log.info(tag .. ".content", content)
            if recvLen > 0 then
                log.info(tag .. ".recvLen.check", "接收数据长度正确SUCCESS")
                outPutTestRes("SocketTest.syncTcpTwoWaySSLTest PASS")
            else
                log.error(tag .. ".recvLen.check", "接收数据长度有误FAIL")
                outPutTestRes("SocketTest.syncTcpTwoWaySSLTest FAIL")
            end
        else
            log.error(tag .. ".sendResult", "FAIL")
        end
    else
        log.error(tag .. ".connect", "FAIL")
        outPutTestRes("SocketTest.syncTcpTwoWaySSLTest FAIL")
    end
    log.info(tag .. ".connection", "disconnecting")
    tcpClient3:close()
    log.info(tag .. ".connection", "disconnected")

    tag = "SocketTest.syncUdpTest"
    udpClient1 = socket.udp()
    connectResult, socketId = udpClient1:connect(ip, port1)
    log.info(tag .. ".connectResult, socketId", connectResult, socketId)
    if connectResult then
        if udpClient1:send("big_data_md5_test") then
            log.info(tag .. ".sendResult", "SUCCESS")
            local fmd5Obj = crypto.flow_md5()
            local recvLen = 0
            local getMD5 = ""
            local flag = true
            while true do
                local result, data, para = udpClient1:recv(5000)
                if result then
                    if recvLen == 0 and flag then
                        getMD5 = string.sub(data, 1, 32)
                        log.info(tag .. ".getMD5", string.upper(getMD5))
                        recvLen = recvLen + #data - 32
                        fmd5Obj:update(string.sub(data, 33))
                        flag = false
                    else
                        recvLen = recvLen + #data
                        fmd5Obj:update(data)
                    end
                else
                    log.info(tag .. ".recv", "接收完毕")
                    break
                end
            end
            log.info(tag .. ".RecvLen", recvLen)
            local calcMD5 = fmd5Obj:hexdigest()
            log.info(tag .. ".CalcMD5", calcMD5)
            if calcMD5 == string.upper(getMD5) then
                log.info(tag .. ".MD5Check", "SUCCESS")
                outPutTestRes("SocketTest.syncUdpTest PASS")
            else
                log.error(tag .. ".MD5Check", "FAIL")
                outPutTestRes("SocketTest.syncUdpTest FAIL")
            end
        else
            log.error(tag .. ".sendResult", "FAIL")
            outPutTestRes("SocketTest.syncUdpTest FAIL")
        end
    else
        log.error(tag .. ".connect", "FAIL")
        outPutTestRes("SocketTest.syncUdpTest FAIL")
    end
    udpClient1:close()

    tag = "SocketTest.asyncTcpTest"
    sys.taskInit(function()
        local res, data = sys.waitUntil("asyncTcpTestInitOK")
        if data == false then
            return
        else
            tcpClient3:asyncSend(testSendData1)
            local data = ""
            for i = 1, 50 do
                data = data .. tcpClient3:asyncRecv()
                sys.wait(100)
            end
            if #data == 1000 then
                log.info("data", data)
                outPutTestRes("SocketTest.asyncTcpTest PASS")
            else
                outPutTestRes("SocketTest.asyncTcpTest FAIL")
            end
            coroutine.resume(testTaskID, false)
        end
    end)
    tcpClient3 = socket.tcp()
    connectResult, socketId = tcpClient3:connect(ip, port1)
    log.info(tag .. ".connectResult, socketId", connectResult, socketId)
    if connectResult then
        sys.publish("asyncTcpTestInitOK", true)
        while tcpClient3:asyncSelect() do
        end
    else
        sys.publish("asyncTcpTestInitOK", false)
        outPutTestRes("SocketTest.asyncTcpTest FAIL")
        log.error(tag .. ".connect", "FAIL")
    end
    tcpClient3:close()

    tag = "SocketTest.asyncUdpTest"
    sys.taskInit(function()
        local res, data = sys.waitUntil("asyncUdpTestInitOK")
        if data == false then
            return
        else
            udpClient2:asyncSend(testSendData1)
            local data = ""
            for i = 1, 50 do
                data = data .. udpClient2:asyncRecv()
                sys.wait(100)
            end
            if #data == 1000 then
                log.info("data", data)
                outPutTestRes("SocketTest.asyncUdpTest PASS")
            else
                outPutTestRes("SocketTest.asyncUdpTest FAIL")
            end
            coroutine.resume(testTaskID, false)
        end
    end)
    udpClient2 = socket.udp()
    connectResult, socketId = udpClient2:connect(ip, port1)
    log.info(tag .. ".connectResult, socketId", connectResult, socketId)
    if connectResult then
        sys.publish("asyncUdpTestInitOK", true)
        while udpClient2:asyncSelect() do
        end
    else
        sys.publish("asyncUdpTestInitOK", false)
        outPutTestRes("SocketTest.asyncUdpTest FAIL")
        log.error(tag .. ".connect", "FAIL")
    end
    udpClient2:close()

    -- socket接收数据的另一种方式
    -- sys.subscribe("SOCKET_RECV", function(id)
    --     if client.id == id then local data = client:asyncRecv() end
    -- end)

    tag = "SocketTest.webSocketTest"
    local ws = websocket.new("ws://" .. ip .. ":2900/websocket")
    ws:on("message", function(msg)
        log.info(tag .. ".receive", msg)
        if msg == tag then
            log.info(tag .. ".receive", "CHECK_SUCCESS")
        else
            log.error(tag .. ".receive", "CHECK_FAIL")
        end
    end)
    ws:on("sent", function()
        log.info(tag .. ".sent", "发送SUCCESS")
    end)
    ws:on("error", function(msg)
        log.error(tag .. ".error", msg)
    end)
    ws:on("close", function(code)
        log.info(tag .. ".close", code)
    end)

    sys.taskInit(function()
        log.info(tag, "open start task")
        ws:start(180)
        log.info(tag, "close start task")
    end)

    sys.wait(2000)
    for i = 1, 3 do
        log.info(tag, "send")
        ws:send(tag, true)
        sys.wait(1000)
    end
    websocket.exit(ws)
end

function test()
    if socket == nil then
        log.error(tag, "this fireware is not support socket")
        return
    end
    local tag = "socketTest"
    log.info(tag, "START")
    socketTestTask()
    log.info(tag, "DONE")
end
