local spiTest = {}

local tag = "spiTest"

function sendAndRecv(spiID, CSPin, data, len)
    CSPin(0)
    spi.send(spiID, data)
    if len then
        local res = spi.recv(spiID, len)
        CSPin(1)
        return res
    end
    CSPin(1)
end

function spiTest.test()
    if spi == nil then
        log.error(tag, "this fireware is not support spi")
        return
    end
    log.info(tag, "START")
    local spiID, CS_GPIO
    if MOD_TYPE == "AIR101" then
        spiID = 0
        CS_GPIO = 17
    elseif MOD_TYPE == "AIR105" then
        spiID = 5
        CS_GPIO = 46
    elseif MOD_TYPE == "ESP32C3" then
        spiID = 2
        CS_GPIO = 7
    end
    assert(spi.setup(spiID, 255, 0, 0, 8, 1 * 1000 * 1000) == 0, tag .. ".setup ERROR")
    local CS = gpio.setup(CS_GPIO, 1)
    CS(0)
    log.info(tag .. ".transfer", string.toHex(spi.transfer(spiID, string.char(0x90, 0, 0, 0), 4, 2)))
    CS(1)
    log.info(tag .. ".CHIP_ID_90H", string.toHex(sendAndRecv(spiID, CS, string.char(0x90, 0, 0, 0), 2)))
    -- C84017
    log.info(tag .. ".CHIP_ID_9FH", string.toHex(sendAndRecv(spiID, CS, string.char(0x9f), 3)))
    sendAndRecv(spiID, CS, string.char(0x06))
    sys.wait(100)
    sendAndRecv(spiID, CS, string.char(0x20, 0x00, 0x00, 0x01))
    sys.wait(1000)
    sendAndRecv(spiID, CS, string.char(0x06))
    sys.wait(100)
    sendAndRecv(spiID, CS, string.char(0x02, 0x00, 0x00, 0x01) .. tag)
    sys.wait(100)
    local readRes = sendAndRecv(spiID, CS, string.char(0x03, 0x00, 0x00, 0x01), string.len(tag))
    log.info(tag .. ".sendAndRecv", readRes)
    assert(readRes == tag, tag .. ".sendAndRecv ERROR")
    sendAndRecv(spiID, CS, string.char(0x04))
    spi.close(spiID)
    local spiFlash = spi.deviceSetup(spiID, CS_GPIO, 0, 0, 8, 24 * 1000 * 1000, spi.MSB, 1, 1)
    log.info(tag .. ".device_transfer", string.toHex(spiFlash:transfer(string.char(0x90, 0, 0, 0), 4, 2)))
    spiFlash:send(string.char(0x06))
    sys.wait(100)
    spiFlash:send(string.char(0x20, 0x00, 0x00, 0x01))
    sys.wait(1000)
    spiFlash:send(string.char(0x06))
    sys.wait(100)
    spiFlash:send(string.char(0x02, 0x00, 0x00, 0x01) .. PROJECT)
    sys.wait(100)
    local readRes = spiFlash:transfer(string.char(0x03, 0x00, 0x00, 0x01), 4, string.len(PROJECT))
    log.info(tag .. ".sendAndRecv", readRes)
    assert(readRes == PROJECT, tag .. ".sendAndRecv ERROR")
    spiFlash:send(string.char(0x04))
    log.info(tag .. ".device_close", spiFlash:close())
    log.info(tag, "DONE")
end

return spiTest
