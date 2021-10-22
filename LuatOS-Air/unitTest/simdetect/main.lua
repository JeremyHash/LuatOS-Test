PROJECT = "simdetectTest"
VERSION = "1.0.0"

require "sys"
require "common"
require "misc"
require "pins"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "simDetectTest"
local function gpioIntFnc(msg)
    --上升沿中断
    if msg == cpu.INT_GPIO_POSEDGE then
        log.info(tag, "插卡")
        rtos.notify_sim_detect(1,1)
    --下降沿中断
    else
        log.info(tag, "拔卡")
        rtos.notify_sim_detect(1,0)
    end
end

local gpio = 23
local UP_DOWN_STATUS = pio.PULLUP
pins.setup(gpio, gpioIntFnc, UP_DOWN_STATUS)


sys.init(0, 0)
sys.run()