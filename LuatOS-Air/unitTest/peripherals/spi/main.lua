-- spiTest
-- Author:openluat
-- CreateDate:20211104
-- UpdateDate:20211104
PROJECT = "spiTest"
VERSION = "1.0.0"

require "sys"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "spiTest"

local modType = "8910"

local testMode = "loop"

-- 8910开发板 I2C通道2/SPI通道1 2/ADC通道2 3
-- 1603开发板 I2C通道1 2 3 4/SPI通道0 1 2/ADC通道1 2
if modType == "8910" then
    spiId = 0

elseif modType == "1603E" or modType == "1603S" then
    spiId = 1
end

-- SPI型号
local flashList = {
    [0xEF15] = 'w25q32',
    [0xEF16] = 'w25q64',
    [0xEF17] = 'w25q128',
    [0x6815] = 'bh25q32'
}

local function spiTestTask()
    -- SPI外设 使用 W25Qxx
    local spiSetupRes = spi.setup(spiId, 0, 0, 8, 100000, 1)
    if spiSetupRes == 0 then
        log.error(tag .. ".setup", "FAIL")
    elseif spiSetupRes == 1 then
        log.info(tag .. ".setup", "SUCCESS")
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(1000)
        local flashInfo = spi.send_recv(spiId, string.char(0x90, 0, 0, 0, 0, 0))
        log.info(tag .. ".readFlashInfo", string.toHex(flashInfo))
        local manufactureID, deviceID = string.byte(flashInfo, 5, 6)
        log.info(tag .. ".FlashName", flashList[manufactureID * 256 + deviceID])
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x20, 0, 0x10, 0))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x06))
        sys.wait(100)
        spi.send_recv(spiId, string.char(0x02, 0, 0x10, 0) .. "LuaTaskSPITest")
        sys.wait(100)
        log.info(tag .. ".readData",
                 spi.send_recv(spiId, string.char(0x03, 0, 0x10, 0) ..
                                   string.rep("1", 14)):sub(5))
        spi.close(spiId)
        sys.wait(1000)
    end
end

sys.taskInit(function()
    sys.wait(5000)
    pmd.ldoset(15, pmd.LDO_VLCD)
    if testMode == "single" then
        spiTestTask()
    elseif testMode == "loop" then
        while true do
            spiTestTask()
            sys.wait(1000)
        end
    end
end)

sys.init(0, 0)
sys.run()
