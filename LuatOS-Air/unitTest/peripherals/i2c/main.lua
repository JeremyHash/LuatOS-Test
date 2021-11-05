-- i2cTest
-- Author:openluat
-- CreateDate:20211104
-- UpdateDate:20211104
PROJECT = "i2cTest"
VERSION = "1.0.0"

require "sys"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "i2cTest"
local modType = "8910"
local testMode = "loop"

-- 8910开发板 I2C通道2/SPI通道1 2/ADC通道2 3
-- 1603开发板 I2C通道1 2 3 4/SPI通道0 1 2/ADC通道1 2
if modType == "8910" then
    i2cId = 2
elseif modType == "1603E" or modType == "1603S" then
    i2cId = 1
end

-- I2C 从设备地址 0x38
local i2cSlaveAddr = 0x38
-- I2C 时钟频率
local i2cSpeed = 100000

local function i2cTestTask()
    -- I2C外设 使用 AHT10 温湿度传感器
    local setupResult = i2c.setup(i2cId, i2cSpeed)
    if setupResult == i2cSpeed then
        log.info(tag .. ".setup", "SUCCESS")
        sys.wait(1000)
        local sentDataSize = i2c.send(i2cId, i2cSlaveAddr, {0xac, 0x22, 0x00})
        if sentDataSize == 3 then
            log.info(tag .. ".成功发送字节数", sentDataSize)
            sys.wait(1000)
            local receivedData = i2c.recv(i2cId, i2cSlaveAddr, 6)
            if #receivedData == 6 then
                log.info(tag .. ".receivedDataHex", receivedData:toHex())
                local tempBit = string.byte(receivedData, 6) + 0x100 *
                                    string.byte(receivedData, 5) + 0x10000 *
                                    bit.band(string.byte(receivedData, 4), 0x0F)
                local humidityBit =
                    bit.band(string.byte(receivedData, 4), 0xF0) + 0x100 *
                        string.byte(receivedData, 3) + 0x10000 *
                        string.byte(receivedData, 2)
                humidityBit = bit.rshift(humidityBit, 4)
                log.info(tag .. ".tempBit", tempBit)
                log.info(tag .. ".humidityBit", humidityBit)
                local calcTemp = (tempBit / 1048576) * 200 - 50
                local calcHum = humidityBit / 1048576
                log.info(tag .. ".当前温度",
                         string.format("%.1f℃", calcTemp))
                log.info(tag .. ".当前湿度",
                         string.format("%.1f%%", calcHum * 100))
                i2c.close(i2cId)
                sys.wait(1000)
            else
                log.error(tag .. ".receive", "FAIL")
                i2c.close(i2cId)
                sys.wait(1000)
            end
        else
            log.error(tag .. ".send", "FAIL")
            i2c.close(i2cId)
            sys.wait(1000)
        end
    else
        log.error(tag .. ".setup", "FAIL")
        i2c.close(i2cId)
        sys.wait(1000)
    end
end

sys.taskInit(function()
    sys.wait(5000)
    if testMode == "single" then
        i2cTestTask()
    elseif testMode == "loop" then
        while true do
            i2cTestTask()
            sys.wait(1000)
        end
    end
end)

sys.init(0, 0)
sys.run()
