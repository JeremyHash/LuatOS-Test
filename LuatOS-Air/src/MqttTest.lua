-- MqttTest
-- Author:LuatTest
-- CreateDate:20211019
-- UpdateDate:20211125
module(..., package.seeall)

local tag = "MqttTest"
local pubTag = "MqttTest.pubClient"
local recvTag = "MqttTest.recvClient"

local ip = "47.96.229.157"
-- 普通MQTT端口
local port1 = 1883
-- 单双向认证的MQTT端口
local port2 = 8883
local transport = "tcp"

local testImei, topic1, topic2, topic3, topicList

local function pubTestTask()
    local pubClient = mqtt.client(pubTag .. "-" .. misc.getImei() .. "-" ..
                                      os.time(), 60)
    log.info(pubTag .. ".connect", "开始连接")

    if not pubClient:connect(ip, port1, transport) then
        log.info(pubTag .. ".connect", "连接FAIL")
        pubClient:disconnect()
        return
    end
    log.info(pubTag .. ".connect", "连接SUCCESS")
    sys.wait(5000)
    for k, v in pairs(topicList) do
        if not pubClient:publish(v, tostring(os.time()), k - 1, 0) then
            log.error(pubTag .. ".publish." .. v, "发布FAIL")
            pubClient:disconnect()
            return
        end
        log.info(pubTag .. ".publish." .. v, "发布SUCCESS")
    end
    log.info(pubTag .. ".disconnect", "断开连接")
    pubClient:disconnect()
end

local function recvTestTask()
    local recvClient = mqtt.client(recvTag .. "-" .. misc.getImei() .. "-" ..
                                       os.time(), 60)

    log.info(recvTag .. ".connect", "开始连接")
    if not recvClient:connect(ip, port1, transport) then
        log.info(recvTag .. ".connect", "连接FAIL")
        recvClient:disconnect()
        sys.publish("MQTTTEST_FINISH")
        return
    end
    log.info(recvTag .. ".connect", "连接SUCCESS")

    if not recvClient:subscribe({[topic1] = 0, [topic2] = 1, [topic3] = 2}) then
        log.error(recvTag .. ".subscribe", "订阅FAIL")
        recvClient:disconnect()
        sys.publish("MQTTTEST_FINISH")
        return
    end
    log.info(recvTag .. ".subscribe", "订阅SUCCESS")

    if not recvClient:unsubscribe(topicList) then
        log.error(recvTag .. ".unsubscribe", "取消订阅FAIL")
        recvClient:disconnect()
        sys.publish("MQTTTEST_FINISH")
        return
    end
    log.info(recvTag .. ".unsubscribe", "取消订阅SUCCESS")

    if not recvClient:subscribe({[topic1] = 0, [topic2] = 1, [topic3] = 2}) then
        log.error(recvTag .. ".subscribe", "订阅FAIL")
        recvClient:disconnect()
        sys.publish("MQTTTEST_FINISH")
        return
    end
    log.info(recvTag .. ".subscribe", "订阅SUCCESS")

    for i = 1, 3 do
        local recvResult, data = recvClient:receive(10000)
        if not recvResult then
            log.error(recvTag .. ".receive", "接收FAIL")
            log.error(recvTag .. ".data", data)
            recvClient:disconnect()
            sys.publish("MQTTTEST_FINISH")
            return
        end
        log.info(recvTag .. ".receive", "接收SUCCESS")
        printTable(data)
    end
    log.info(recvTag .. ".disconnect", "断开连接")
    recvClient:disconnect()
    sys.publish("MQTTTEST_FINISH")
end

local function mqttTestTask()
    sys.taskInit(recvTestTask)
    sys.taskInit(pubTestTask)
    sys.waitUntil("MQTTTEST_FINISH")
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Mqtt测试开始")
    testImei = misc.getImei()
    topic1 = "topic1-" .. testImei
    topic2 = "topic2-" .. testImei
    topic3 = "合宙测试-" .. testImei
    topicList = {topic1, topic2, topic3}
    if testConfig.testMode == "single" then
        mqttTestTask()
    elseif testConfig.testMode == "loop" then
        while true do
            mqttTestTask()
            sys.wait(5000)
        end
    end
end)
