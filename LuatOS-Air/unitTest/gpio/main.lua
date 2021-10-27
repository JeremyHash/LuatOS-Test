-- GpioTest
-- Author:openluat
-- CreateDate:20211027
-- UpdateDate:20211027
PROJECT = "gpioTest"
VERSION = "1.0.0"

require "sys"
require "pins"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local modType = "1603"
-- Type=1 中断模式
-- Type=2 输入模式
-- Type=3 输出模式
local Type = 1

local gpio_8910_list = {
    0, 1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23,
    24, 25, 26, 27, 28, 29, 30, 31
}

local gpio_1603_list = {
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    21, 22, 23, 24, 25, 26, 29, 30, 31, 32, 33, 34, 35, 36, 45, 46, 47, 49, 50,
    51, 52, 53, 54, 69, 70, 77, 78, 121, 122, 123, 124, 125, 126
}

local gpio_in_functions = {}

local UP_DOWN_STATUS = pio.DOWN

local function gpioIntFnc(msg)
    -- 上升沿中断
    if msg == cpu.INT_GPIO_POSEDGE then
        log.info("GpioIntTest.msg", "上升")
        -- 下降沿中断
    else
        log.info("GpioIntTest.msg", "下降")
    end
end

sys.taskInit(function()
    sys.wait(8000)
    if modType == "8910" then
        --[[
        有些GPIO需要打开对应的ldo电压域才能正常工作，电压域和对应的GPIO关系如下
        pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 29、30、31
        
        pmd.ldoset(x, pmd.LDO_VLCD) -- GPIO 0、1、2、3、4
        
        pmd.ldoset(x, pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
        x=0时：关闭LDO
        x=1时：LDO输出1.716V
        x=2时：LDO输出1.828V
        x=3时：LDO输出1.939V
        x=4时：LDO输出2.051V
        x=5时：LDO输出2.162V
        x=6时：LDO输出2.271V
        x=7时：LDO输出2.375V
        x=8时：LDO输出2.493V
        x=9时：LDO输出2.607V
        x=10时：LDO输出2.719V
        x=11时：LDO输出2.831V
        x=12时：LDO输出2.942V
        x=13时：LDO输出3.054V
        x=14时：LDO输出3.165V
        x=15时：LDO输出3.177V
        ]]
        local x = 2

        -- pmd.ldoset(x, pmd.VLDO6)

        pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 29、30、31

        pmd.ldoset(x, pmd.LDO_VLCD) -- GPIO 0、1、2、3、4

        pmd.ldoset(x, pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
    elseif modType == "1603" then
        local x = 2
        pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 45、46、47
    end

    if Type == 1 then
        log.info("GpioIntTest", "初始化GPIO中断模式开始")
        if modType == "8910" then
            for k, v in pairs(gpio_8910_list) do
                log.info("GpioIntTest", "初始化GPIO" .. v .. "中断模式")
                pins.setup(v, gpioIntFnc, UP_DOWN_STATUS)
            end
        elseif modType == "1603" then
            for k, v in pairs(gpio_1603_list) do
                log.info("GpioIntTest", "初始化GPIO" .. v .. "中断模式")
                pins.setup(v, gpioIntFnc, UP_DOWN_STATUS)
            end
        end
    end

    if Type == 2 then
        local tag = "GpioInTest"
        log.info(tag, "初始化GPIO输入模式开始")
        if modType == "8910" then
            for k, v in pairs(gpio_8910_list) do
                log.info(tag, "初始化GPIO" .. v .. "输入模式")
                gpio_in_functions[string.format("%d", v)] = pins.setup(v, nil,
                                                                       UP_DOWN_STATUS)
            end
        elseif modType == "1603" then
            for k, v in pairs(gpio_1603_list) do
                log.info(tag, "初始化GPIO" .. v .. "输入模式")
                gpio_in_functions[string.format("%d", v)] = pins.setup(v, nil,
                                                                       UP_DOWN_STATUS)
            end
        end
        sys.taskInit(function()
            while true do
                sys.wait(5000)
                for k, v in pairs(gpio_in_functions) do
                    local res = v()
                    log.info(tag, "获取GPIO" .. k .. "的输入" .. res)
                end
                log.info(tag, "-----------------------")
            end
        end)
    end

    if Type == 3 then
        local tag = "GpioOutTest"
        log.info(tag, "初始化GPIO输出模式开始")
        local value = 0
        while true do
            sys.wait(1000)
            if modType == "8910" then
                for k, v in pairs(gpio_8910_list) do
                    pins.setup(v, value)
                end
            elseif modType == "1603" then
                for k, v in pairs(gpio_1603_list) do
                    pins.setup(v, value)
                end
            end
            log.info(tag, value)
            if value == 0 then
                value = 1
            else
                value = 0
            end
        end

    end
end)

sys.init(0, 0)
sys.run()
