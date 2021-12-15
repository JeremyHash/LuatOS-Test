gpioTest = {}

local tag = "gpioTest"
if MOD_TYPE == "air101" then
    gpioList = {0, 1, 4, 7, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27}
end

function gpioTest.test()
    log.info(tag, "START")
    for _, v in pairs(gpioList) do
        assert(gpio.setDefaultPull(1) == true, tag .. ".setDefaultPull ERROR")
        gpio.setup(v, 1)
        assert(gpio.get(v) == 1, tag .. ".get ERROR " .. v)
        gpio.set(v, 0)
        assert(gpio.get(v) == 0, tag .. ".get ERROR " .. v)
        assert(gpio.setDefaultPull(2) == true, tag .. ".setDefaultPull ERROR")
        gpio.setup(v, 0)
        assert(gpio.get(v) == 0, tag .. ".get ERROR " .. v)
        assert(gpio.setDefaultPull(1) == true, tag .. ".setDefaultPull ERROR")
        gpio.setup(v, nil)
        assert(gpio.get(v) == 1, tag .. ".get ERROR " .. v)
        assert(gpio.setDefaultPull(2) == true, tag .. ".setDefaultPull ERROR")
        gpio.setup(v, nil)
        assert(gpio.get(v) == 0, tag .. ".get ERROR " .. v)
        assert(gpio.setDefaultPull(1) == true, tag .. ".setDefaultPull ERROR")
        gpio.setup(v, function()
            log.info(tag .. ".int-" .. v, gpio.get(v))
        end)
        gpio.close(v)
    end
    log.info(tag, "DONE")
end

return gpioTest
