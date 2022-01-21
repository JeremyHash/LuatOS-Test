-- adcTest
-- Author:openluat
-- CreateDate:20220121
-- UpdateDate:20220121
module(..., package.seeall)

local ADC0, ADC1
local tag = "adcTest"
local adcList = {}

if testConfig.modType == "8910" then
    adcList = {2, 3}
elseif testConfig.modType == "1603E" or testConfig.modType == "1603S" then
    adcList = {1, 2}
end

function test()
    if adc == nil then
        log.error(tag, "this fireware is not support adc")
        return
    end
    log.info(tag, "START")
    for _, v in pairs(adcList) do
        assert(adc.open(v) == 1, tag .. ".open ERROR")
        local adcval, voltval = adc.read(v)
        log.info(tag .. ".read-" .. v, adcval, voltval)
        assert(adc.close(v) == 1, tag .. ".close ERROR")
    end
    log.info(tag, "DONE")
end
