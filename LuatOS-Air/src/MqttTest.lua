-- MqttTest
-- Author:LuatTest
-- CreateDate:20211019
-- UpdateDate:20211019
module(..., package.seeall)

local tag = "MqttTest"

local ip = "114.55.242.59"
-- 普通MQTT端口
local port1 = 1883
-- 单双向认证的MQTT端口
local port2 = 8883

local function mqttPubTask(ip, port, transport)
    local tag = "MqttTest.pubClient"
    local client
    local testImei = misc.getImei()
    local topicList = {
        "topic1-" .. testImei, "topic2-" .. testImei,
        "合宙测试-" .. testImei
    }

    client = mqtt.client(tag .. "-" .. misc.getImei(), 60)
    log.info(tag .. ".connect", "开始连接")

    if not client:connect(ip, port, transport) then
        log.info(tag .. ".connect", "连接FAIL")
        client:disconnect()
        outPutTestRes("MqttTest FAIL")
        return
    end

    log.info(tag .. ".connect", "连接SUCCESS")

    sys.waitUntil("readyToReceive")
    for k, v in pairs(topicList) do
        if client:publish(v, tostring(os.time()), k - 1, 0) then
            log.info(tag .. ".publish." .. v, "发布SUCCESS")
        else
            log.error(tag .. ".publish." .. v, "发布FAIL")
            client:disconnect()
            outPutTestRes("MqttTest FAIL")
            return
        end
    end
    client:disconnect()

end

local function mqttRecTask(ip, port, transport)
    local tag = "MqttTest.recvClient"
    local client
    local testImei = misc.getImei()
    local topic1 = "topic1-" .. testImei
    local topic2 = "topic2-" .. testImei
    local topic3 = "合宙测试-" .. testImei
    client = mqtt.client(tag .. "-" .. misc.getImei(), 60)
    log.info(tag .. ".connect", "开始连接")
    if not client:connect(ip, port, transport) then
        log.info(tag .. ".connect", "连接FAIL")
        client:disconnect()
        outPutTestRes("MqttTest FAIL")
        return
    end

    log.info(tag .. ".connect", "连接SUCCESS")

    if client:subscribe({[topic1] = 0, [topic2] = 1, [topic3] = 2}) then
        log.info(tag .. ".subscribe", "订阅SUCCESS")
        if client:unsubscribe({topic1, topic2, topic3}) then
            log.info(tag .. ".unsubscribe", "取消订阅SUCCESS")
            if client:subscribe({[topic1] = 0, [topic2] = 1, [topic3] = 2}) then
                log.info(tag .. ".subscribe", "订阅SUCCESS")
            else
                log.error(tag .. ".subscribe", "订阅FAIL")
                client:disconnect()
                outPutTestRes("MqttTest FAIL")
                return
            end
        else
            log.error(tag .. ".unsubscribe", "取消订阅FAIL")
            client:disconnect()
            outPutTestRes("MqttTest FAIL")
            return
        end
    else
        log.error(tag .. ".subscribe", "订阅FAIL")
        client:disconnect()
        outPutTestRes("MqttTest FAIL")
        return
    end

    sys.publish("readyToReceive")
    for i = 1, 3 do
        local result, data = client:receive(10000)
        if result then
            log.info(tag .. ".receive", "接收SUCCESS")
            printTable(data)
        else
            log.info(tag .. ".receive", "接收FAIL")
            log.error("data", data)
            client:disconnect()
            outPutTestRes("MqttTest FAIL")
            sys.publish("MqttTestFinish")
            return
        end
    end
    client:disconnect()
    outPutTestRes("MqttTest PASS")
    sys.publish("MqttTestFinish")

end

local function mqttTestTask()
    sys.taskInit(function() mqttRecTask(ip, port1, "tcp") end)
    sys.taskInit(function() mqttPubTask(ip, port1, "tcp") end)
    sys.waitUntil("MqttTestFinish")
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Mqtt测试开始")
    if testConfig.testMode == "single" then
        mqttTestTask()
    elseif testConfig.testMode == "loop" then
        while true do mqttTestTask() end
    end
end)
