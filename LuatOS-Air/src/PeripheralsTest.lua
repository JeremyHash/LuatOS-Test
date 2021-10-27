-- PeripheralsTest
-- Author:openluat
-- CreateDate:20211020
-- UpdateDate:20211020
module(..., package.seeall)

local modType = testConfig.modType

-- 8910开发板 I2C通道2/SPI通道1 2/ADC通道2 3
-- 1603开发板 I2C通道1 2 3 4/SPI通道0 1 2/ADC通道1 2
if modType == "8910" then
    i2cId = 2
    spiId = 0
    ADC0 = 2
    ADC1 = 3
elseif modType == "1603E" or modType == "1603S" then
    i2cId = 1
    spiId = 1
    ADC0 = 1
    ADC1 = 2
end

-- I2C 从设备地址 0x38
local i2cSlaveAddr = 0x38
-- I2C 时钟频率
local i2cSpeed = 100000
-- 读取adc
local adcval, voltval

-- SPI型号
local flashList = {
    [0xEF15] = 'w25q32',
    [0xEF16] = 'w25q64',
    [0xEF17] = 'w25q128',
    [0x6815] = 'bh25q32'
}

local tag = "PeripheralsTest"

local function peripheralsTestTask()

    -- ADC
    sys.wait(2000)
    adc.open(ADC0)
    adc.open(ADC1)
    log.info(tag .. ".open", "ADC打开")
    outPutTestRes("PeripheralsTest.ADC.open SUCCESS")

    adcval, voltval = adc.read(ADC0)
    log.info(tag .. ".ADC0.read", adcval, voltval)

    adcval, voltval = adc.read(ADC1)
    log.info(tag .. ".ADC1.read", adcval, voltval)

    adc.close(ADC0)
    adc.close(ADC1)
    log.info(tag .. ".close", "ADC关闭")
    outPutTestRes("PeripheralsTest.ADC.close SUCCESS")

    -- I2C外设 使用 AHT10 温湿度传感器
    local setupResult = i2c.setup(i2cId, i2cSpeed)
    if setupResult == i2cSpeed then
        log.info(tag .. ".I2C.setup", "SUCCESS")
        outPutTestRes("PeripheralsTest.I2C.setup SUCCESS")
        sys.wait(1000)
        local sentDataSize = i2c.send(i2cId, i2cSlaveAddr, {0xac, 0x22, 0x00})
        if sentDataSize == 3 then
            log.info(tag .. ".I2C.成功发送字节数", sentDataSize)
            outPutTestRes("PeripheralsTest.I2C.send SUCCESS")
            sys.wait(1000)
            local receivedData = i2c.recv(i2cId, i2cSlaveAddr, 6)
            if #receivedData == 6 then
                log.info(tag .. ".I2C.receivedDataHex", receivedData:toHex())
                outPutTestRes("PeripheralsTest.I2C.receive SUCCESS")
                local tempBit = string.byte(receivedData, 6) + 0x100 *
                                    string.byte(receivedData, 5) + 0x10000 *
                                    bit.band(string.byte(receivedData, 4), 0x0F)
                local humidityBit =
                    bit.band(string.byte(receivedData, 4), 0xF0) + 0x100 *
                        string.byte(receivedData, 3) + 0x10000 *
                        string.byte(receivedData, 2)
                humidityBit = bit.rshift(humidityBit, 4)
                log.info(tag .. ".I2C.tempBit", tempBit)
                log.info(tag .. ".I2C.humidityBit", humidityBit)
                local calcTemp = (tempBit / 1048576) * 200 - 50
                local calcHum = humidityBit / 1048576
                log.info(tag .. ".I2C.当前温度",
                         string.format("%.1f℃", calcTemp))
                log.info(tag .. ".I2C.当前湿度",
                         string.format("%.1f%%", calcHum * 100))
                i2c.close(i2cId)
                sys.wait(1000)
            else
                log.error(tag .. ".I2C.receive", "FAIL")
                outPutTestRes("PeripheralsTest.I2C.receive FAIL")
                i2c.close(i2cId)
                sys.wait(1000)
            end
        else
            log.error(tag .. ".I2C.send", "FAIL")
            outPutTestRes("PeripheralsTest.I2C.send FAIL")
            i2c.close(i2cId)
            sys.wait(1000)
        end
    else
        log.error(tag .. ".I2C.setup", "FAIL")
        outPutTestRes("PeripheralsTest.I2C.setup FAIL")
        i2c.close(i2cId)
        sys.wait(1000)
    end

    -- SPI外设 使用 W25Qxx
    local spiSetupRes = spi.setup(spiId, 0, 0, 8, 100000, 1)
    if spiSetupRes == 0 then
        log.error(tag .. ".SPI.setup", "FAIL")
        outPutTestRes("PeripheralsTest.SPI.setup FAIL")
        sys.wait(1000)
    elseif spiSetupRes == 1 then
        log.info(tag .. ".SPI.setup", "SUCCESS")
        outPutTestRes("PeripheralsTest.SPI.setup SUCCESS")
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(1000)
        local flashInfo = spi.send_recv(spiId, string.char(0x90, 0, 0, 0, 0, 0))
        log.info(tag .. ".SPI.readFlashInfo", string.toHex(flashInfo))
        local manufactureID, deviceID = string.byte(flashInfo, 5, 6)
        log.info(tag .. ".SPI.FlashName", flashList[manufactureID * 256 + deviceID])
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x20, 0, 0x10, 0))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x02, 0, 0x10, 0) .. "LuaTaskSPITest")
        sys.wait(100)
        log.info(tag .. ".SPI.readData",
                 spi.send_recv(spiId, string.char(0x03, 0, 0x10, 0) ..
                                   string.rep("1", 14)):sub(5))
        spi.close(spiId)
        sys.wait(1000)
    end
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Peripherals测试开始")
    -- pmd.ldoset(15, pmd.LDO_VLCD)
    if testConfig.testMode == "single" then
        peripheralsTestTask()
    elseif testConfig.testMode == "loop" then
        while true do peripheralsTestTask() end
    end
end)
