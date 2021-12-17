mcuTest = {}

local tag = "mcuTest"

if MOD_TYPE == "air101" then clkList = {2, 80, 240} end

function mcuTest.test()
    log.info(tag, "START")
    for _, v in pairs(clkList) do
        assert(mcu.setClk(v) == true, tag .. ".setClk ERROR")
        assert(mcu.getClk(v) == v, tag .. ".getClk ERROR")
    end
    log.info(tag .. ".unique_id", string.toHex(mcu.unique_id()))
    log.info(tag .. ".ticks", mcu.ticks())
    log.info(tag, "DONE")
end

return mcuTest