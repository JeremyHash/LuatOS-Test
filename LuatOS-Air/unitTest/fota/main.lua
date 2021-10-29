-- fotaTest
-- Author:openluat
-- CreateDate:20211022
-- UpdateDate:20211029
PROJECT = "fotaTest"
VERSION = "1.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

require "update"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "fotaTest"

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag,
             "成功访问网络, FOTA升级测试开始，当前版本 : " ..
                 rtos.get_version() .. " VERSION : " .. VERSION)
    -- IOT平台
    update.request()
    -- 自定义服务器
    -- update.request(nil, "http://wiki.airm2m.com:48000/fota.bin")
    sys.timerLoopStart(log.info, 1000, tag .. ".version", rtos.get_version(),
                       _G.VERSION)
end)

sys.init(0, 0)
sys.run()
