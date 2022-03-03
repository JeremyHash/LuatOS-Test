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
    if MOD_TYPE == "air101" then
        spiID = 0
        CS_GPIO = 17
    elseif MOD_TYPE == "ESP32C3" then
        spiID = 2
        CS_GPIO = 6
    end
    local CS = gpio.setup(CS_GPIO, 1)
    assert(spi.setup(spiID, CS_GPIO, 0, 0, 8, 100000) == 0,
           tag .. ".setup ERROR")
    log.info(tag .. "CHIP_ID", string.toHex(
                 sendAndRecv(spiID, CS, string.char(0x90, 0, 0, 0), 2)))

    sendAndRecv(spiID, CS, string.char(0x02, 0x00, 0x00, 0x01) .. tag)

    sys.wait(80)

    assert(sendAndRecv(spiID, CS, string.char(0x03, 0x00, 0x00, 0x01),
                       string.len(tag)) == tag, tag .. ".sendAndRecv ERROR")

    sendAndRecv(spiID, CS, string.char(0x04))

    spi.close(spiID)
    log.info(tag, "DONE")
end

return spiTest
