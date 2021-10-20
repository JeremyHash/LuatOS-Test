PROJECT = "gpioTest"
VERSION = "1.0.0"

require "sys"
require "pins"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO


local modType = "1603"
--Type=1 中断模式
--Type=2 输入模式
--Type=3 输出模式
local Type = 2

local gpio_8910_list = {0, 1, 2, 3, 4, 5, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}

local gpio_1603_list = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 29, 30, 31, 32, 33, 34, 35, 36, 45, 46, 47, 49, 50, 51, 52, 53, 54, 69, 70, 77, 78, 121, 122, 123, 124, 125, 126}

local gpio_led_list = {19, 18, 13, 9, 12, 10, 11, 23}

local gpio_in_functions = {}

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

local function gpioIntFnc(msg)
    --上升沿中断
    if msg == cpu.INT_GPIO_POSEDGE then
        log.info("GpioIntTest.msg", "上升")
    --下降沿中断
    else
        log.info("GpioIntTest.msg", "下降")
    end
end

local UP_DOWN_STATUS = pio.PULLUP

if Type == 1 then
    rtos.sleep(8000)
    if modType == "8910" then

        local x = 2
    
        -- pmd.ldoset(x, pmd.VLDO6)
    
        pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 29、30、31
    
        pmd.ldoset(x, pmd.LDO_VLCD) -- GPIO 0、1、2、3、4
    
        pmd.ldoset(x, pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
    elseif modType == "1603" then
        local x = 2
        pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 45、46、47
    end
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
    rtos.sleep(8000)
    if Type == 1 then
        rtos.sleep(8000)
        if modType == "8910" then
    
            local x = 2
        
            -- pmd.ldoset(x, pmd.VLDO6)
        
            pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 29、30、31
        
            pmd.ldoset(x, pmd.LDO_VLCD) -- GPIO 0、1、2、3、4
        
            pmd.ldoset(x, pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
        elseif modType == "1603" then
            local x = 2
            pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 45、46、47
        end
    local tag = "GpioInTest"
    log.info(tag, "初始化GPIO输入模式开始")
    if modType == "8910" then
        for k, v in pairs(gpio_8910_list) do
            log.info(tag, "初始化GPIO" .. v .. "输入模式")
            gpio_in_functions[string.format("%d", v)] = pins.setup(v, nil, UP_DOWN_STATUS)
        end
    elseif modType == "1603" then
        for k, v in pairs(gpio_1603_list) do
            log.info(tag, "初始化GPIO" .. v .. "输入模式")
            gpio_in_functions[string.format("%d", v)] = pins.setup(v, nil, UP_DOWN_STATUS)
        end
    end
    sys.taskInit(
        function()
            while true do
                sys.wait(5000)
                for k, v in pairs(gpio_in_functions) do
                    local res = v()
                    log.info(tag, "获取GPIO" .. k .. "的输入" .. res)
                end
                log.info(tag, "-----------------------")
            end
        end
    )
end

if type == 3 then
    rtos.sleep(8000)
    if Type == 1 then
        rtos.sleep(8000)
        if modType == "8910" then
    
            local x = 2
        
            -- pmd.ldoset(x, pmd.VLDO6)
        
            pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 29、30、31
        
            pmd.ldoset(x, pmd.LDO_VLCD) -- GPIO 0、1、2、3、4
        
            pmd.ldoset(x, pmd.LDO_VMMC) -- GPIO 24、25、26、27、28
        elseif modType == "1603" then
            local x = 2
            pmd.ldoset(x, pmd.LDO_VSIM1) -- GPIO 45、46、47
        end
    sys.taskInit(
        function()
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

                if value == 0 then
                    value = 1
                else
                    value = 0
                end
            end
        end
    )   
end

local function led_shut()
    local x = 0
    gpio19(x)
    gpio18(x)
    gpio13(x)
    gpio9(x)
    gpio12(x)
    gpio10(x)
    gpio11(x)
    gpio23(x)
end

local function led_blink(time)

    local x = 1
    for i = 1, time do
        gpio19(x)
        gpio18(x)
        gpio13(x)
        gpio9(x)
        gpio12(x)
        gpio10(x)
        gpio11(x)
        gpio23(x)
        sys.wait(1000)
        led_shut()
    end
end

local function led_single_switch(gpio, time)
    gpio(1)
    sys.wait(time)
    gpio(0)
end

local function led_liushui(time)
    local lightTime = 1000
    for i = 1, time do
        led_single_switch(gpio19, lightTime)
        led_single_switch(gpio18, lightTime)
        led_single_switch(gpio13, lightTime)
        led_single_switch(gpio9, lightTime)
        led_single_switch(gpio12, lightTime)
        led_single_switch(gpio10, lightTime)
        led_single_switch(gpio11, lightTime)
        led_single_switch(gpio23, lightTime)
    end

end

local function led_leijia(time)
    local waitTime = 1000
    for i = 1, time do
        sys.wait(waitTime)
        gpio23(1)
        sys.wait(waitTime)
        gpio11(1)
        sys.wait(waitTime)
        gpio10(1)
        sys.wait(waitTime)
        gpio12(1)
        sys.wait(waitTime)
        gpio9(1)
        sys.wait(waitTime)
        gpio13(1)
        sys.wait(waitTime)
        gpio18(1)
        sys.wait(waitTime)
        gpio19(1)
        sys.wait(waitTime)
        led_shut()
    end
    
end


-- if LuaTaskTestConfig.gpioTest.ledTest then
--     gpio19 = pins.setup(19)
--     gpio18 = pins.setup(18)
--     gpio13 = pins.setup(13)
--     gpio9 = pins.setup(9)
--     gpio12 = pins.setup(12)
--     gpio10 = pins.setup(10)
--     gpio11 = pins.setup(11)
--     gpio23 = pins.setup(23)

    
--     sys.taskInit(
--         function ()
--             while true do
--                 led_blink(1)
--                 led_leijia(1)
--                 led_liushui(1)
--             end
--         end
--     )

-- end

-- if LuaTaskTestConfig.gpioTest.pwmTest then
--     local tag = "PwmTest"
--     sys.taskInit(
--         function ()
--             while true do
--                 sys.wait(5000)
--                 log.info("pwm1.open",pwm.open(1))
--                 log.info("pwm2.open",pwm.open(2))
--                 log.info("pwm3.open",pwm.open(3))
--                 log.info("pwm4.open",pwm.open(4))
--                 log.info("pwm1.set",pwm.set(1,5000,30))
--                 log.info("pwm2.set",pwm.set(2,1000000,50))
--                 log.info("pwm3.set",pwm.set(3,1000000,70))
--                 log.info("pwm4.set",pwm.set(4,5000,50))
--                 sys.wait(10000)
--                 log.info("pwm1.close",pwm.close(1))
--                 log.info("pwm2.close",pwm.close(2))
--                 log.info("pwm3.close",pwm.close(3))
--                 log.info("pwm4.close",pwm.close(4))
--             end
--         end
--     )
-- end

sys.init(0, 0)
sys.run()