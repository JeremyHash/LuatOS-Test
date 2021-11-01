-- alarmTest
-- Author:openluat
-- CreateDate:20211021
-- UpdateDate:20211029
PROJECT = "alarmTest"
VERSION = "1.0.0"

require "ntp"
require "sys"
require "misc"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "alarmTest"
sys.taskInit(function()
    sys.wait(10000)
    log.info(tag .. ".start")
    misc.setClock({
        year = 2020,
        month = 5,
        day = 1,
        hour = 12,
        min = 12,
        sec = 12
    })
    sys.wait(2000)
    local onTimet = os.date("*t", os.time() + 60) -- 下次要开机的时间为60秒后
    log.info(tag .. ".restart time", 60)
    rtos.set_alarm(1, onTimet.year, onTimet.month, onTimet.day, onTimet.hour,
                   onTimet.min, onTimet.sec) -- 设定闹铃
    -- 如果要测试关机闹钟，打开下面这2行代码
    sys.wait(2000)
    rtos.poweroff()
end)

-- 功能  ：开机闹钟事件的处理函数
local function alarMsg() print("alarMsg") end

-- 如果是关机闹钟开机，则需要软件主动重启一次，才能启动GSM协议栈
if rtos.poweron_reason() == rtos.POWERON_ALARM then sys.restart("ALARM") end

-- 注册闹钟模块
rtos.init_module(rtos.MOD_ALARM)
-- 注册闹钟消息的处理函数（如果是开机闹钟，闹钟事件到来时会调用alarmsg）
rtos.on(rtos.MSG_ALARM, alarMsg)

sys.init(0, 0)
sys.run()
