PROJECT = "adcTest"
VERSION = "1.0.0"

require "sys"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "adcTest"
local modType = "8910"
local testMode = "loop"

-- 8910开发板 I2C通道2/SPI通道1 2/ADC通道2 3
-- 1603开发板 I2C通道1 2 3 4/SPI通道0 1 2/ADC通道1 2
if modType == "8910" then
    ADC0 = 2
    ADC1 = 3
elseif modType == "1603E" or modType == "1603S" then
    ADC0 = 1
    ADC1 = 2
end

local function adcTestTask()
    local adcval, voltval
    adc.open(ADC0)
    adc.open(ADC1)
    log.info(tag .. ".open", "ADC打开")

    adcval, voltval = adc.read(ADC0)
    log.info(tag .. ".ADC0.read", adcval, voltval)

    adcval, voltval = adc.read(ADC1)
    log.info(tag .. ".ADC1.read", adcval, voltval)

    adc.close(ADC0)
    adc.close(ADC1)
    log.info(tag .. ".close", "ADC关闭")
end

sys.taskInit(function()
    sys.wait(5000)
    if testMode == "single" then
        adcTestTask()
    elseif testMode == "loop" then
        while true do
            adcTestTask()
            sys.wait(1000)
        end
    end
end)

sys.init(0, 0)
sys.run()
