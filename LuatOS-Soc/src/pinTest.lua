pinTest = {}

local tag = "pinTest"

if MOD_TYPE == "air101" then
    pinList = {
        PA00 = 0,
        PA01 = 1,
        PA04 = 4,
        PA07 = 7,
        PB00 = 16,
        PB01 = 17,
        PB02 = 18,
        PB03 = 19,
        PB04 = 20,
        PB05 = 21,
        PB06 = 22,
        PB07 = 23,
        PB08 = 24,
        PB09 = 25,
        PB10 = 26,
        PB11 = 27
    }
end

function pinTest.test()
    log.info(tag, "START")
    for k, v in pairs(pinList) do
        assert(pin.get(k) == v, tag .. ".get ERROR")
    end
    log.info(tag, "DONE")
end

return pinTest
