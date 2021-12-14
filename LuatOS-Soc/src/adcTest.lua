adcTest = {}

local tag = "adcTest"

local adcChannels = {}

if MOD_TYPE == "air101" then adcChannels = {0, 1, 10} end

function adcTest.test()
    log.info(tag, "START")

    for k, id in pairs(adcChannels) do
        assert(adc.open(id) == true, tag .. ".open ERROR")
        log.info(tag .. ".read", adc.read(id))
        adc.close(id)
    end
    log.info(tag, "DONE")

end

return adcTest
