-- AliyunTest
-- Author:openluat
-- CreateDate:20211025
-- UpdateDate:20211126
-- 这个测试代码需要提前在阿里云平台上创建好产品和设备
PROJECT = "LuatOS-Air-Test"
VERSION = "1.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

require "sys"
require "log"
require "aLiYun"
LOG_LEVEL = log.LOGLEVEL_INFO

require "OneDeviceOneSecret"

local tag = "AliyunTest"
local REGION_ID = "cn-shanghai"
local PRODUCT_KEY = OneDeviceOneSecret.AliyunInfo.PRODUCT_KEY
local DEVICE_NAME = OneDeviceOneSecret.AliyunInfo.DEVICE_NAME
local DEVICE_SECRET = OneDeviceOneSecret.AliyunInfo.DEVICE_SECRET

local timerID

local function getDeviceName() return DEVICE_NAME end

local function getDeviceSecret() return DEVICE_SECRET end

local function aliyunPublishTestCb(result, para)
    log.info(tag .. ".aliyunPublishTestCb", result, para)
end

local function aliyunPublishTest()
    aLiYun.publish("/" .. PRODUCT_KEY .. "/" .. getDeviceName() ..
                       "/user/Jeremy", json.encode(
                       {
            ["qos"] = 0,
            ["data"] = "qos0data",
            ["time"] = os.time()
        }), 0, aliyunPublishTestCb)
    aLiYun.publish("/" .. PRODUCT_KEY .. "/" .. getDeviceName() ..
                       "/user/Jeremy", json.encode(
                       {
            ["qos"] = 1,
            ["data"] = "qos1data",
            ["time"] = os.time()
        }), 1, aliyunPublishTestCb)

end

local function receiveCb(topic, qos, payload)
    log.info(tag .. ".receive", topic, qos, payload)
end

local function connectCb(result)
    log.info(tag .. ".connect", result)
    if not result then
        if timerID ~= nil then
            sys.timerStop(timerID)
            timerID = nil
        end
        return
    end
    aLiYun.subscribe({
        ["/" .. PRODUCT_KEY .. "/" .. getDeviceName() .. "/user/get"] = 0,
        ["/" .. PRODUCT_KEY .. "/" .. getDeviceName() .. "/user/Jeremy"] = 1
    })
    timerID = sys.timerLoopStart(aliyunPublishTest, 3000)
end

aLiYun.on("connect", connectCb)
aLiYun.on("receive", receiveCb)
aLiYun.setRegion(REGION_ID)
aLiYun.setConnectMode("direct", PRODUCT_KEY .. ".iot-as-mqtt." .. REGION_ID ..
                          ".aliyuncs.com", 1883)
aLiYun.setup(PRODUCT_KEY, nil, getDeviceName, getDeviceSecret)

sys.init(0, 0)
sys.run()
