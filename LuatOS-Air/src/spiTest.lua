-- spiTest
-- Author:openluat
-- CreateDate:20220126
-- UpdateDate:20220126
module(..., package.seeall)

local tag = "spiTest"
local spiList = {}

if testConfig.modType == "8910" then
    spiList = {0, 1}
elseif testConfig.modType == "1603E" or testConfig.modType == "1603S" then
    spiList = {0, 1, 2}
end

local flashList = {
    [0xEF15] = 'w25q32',
    [0xEF16] = 'w25q64',
    [0xEF17] = 'w25q128',
    [0x6815] = 'bh25q32'
}

pmd.ldoset(15, pmd.LDO_VLCD)

function test()
    if spi == nil then
        log.error(tag, "this fireware is not support spi")
        return
    end
    log.info(tag, "START")
    for _, v in pairs(spiList) do
        -- w25q128
        assert(spi.setup(v, 0, 0, 8, 100000, 1) == 1, tag .. ".setup ERROR")
        spi.send_recv(v, string.char(0x06))
        local flashInfo = spi.send_recv(v, string.char(0x90, 0, 0, 0, 0, 0))

        log.info(tag .. ".readFlashInfo", string.toHex(flashInfo))
        local manufactureID, deviceID = string.byte(flashInfo, 5, 6)
        log.info(tag .. ".FlashName", flashList[manufactureID * 256 + deviceID])
        spi.send_recv(v, string.char(0x06))
        sys.wait(80)
        spi.send_recv(v, string.char(0x20, 0, 0x10, 0))
        sys.wait(80)
        spi.send_recv(v, string.char(0x06))
        sys.wait(80)
        spi.send_recv(v, string.char(0x02, 0, 0x10, 0) .. "LuatOS_SPITest")
        sys.wait(80)
        assert(spi.send_recv(v, string.char(0x03, 0, 0x10, 0) ..
                                 string.rep("1", 14)):sub(5) == "LuatOS_SPITest",
               tag .. ".send_recv ERROR")
        sys.wait(80)
        assert(spi.close(v) == 1, tag .. ".close ERROR")
    end
    log.info(tag, "DONE")
end

