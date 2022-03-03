local lcdTest = {}

local tag = "lcdTest"

function lcdTest.test()
    if lcd == nil then
        log.error(tag, "this fireware is not support lcd")
        return
    end
    log.info(tag, "START")
    local spi_lcd
    if MOD_TYPE == "air101" then
        spi_lcd = spi.deviceSetup(5, pin.PC14, 0, 0, 8, 96 * 1000 * 1000,
                                  spi.MSB, 1, 1)
    elseif MOD_TYPE == "air105" then
        spi_lcd = spi.deviceSetup(5, pin.PC14, 0, 0, 8, 96 * 1000 * 1000,
                                  spi.MSB, 1, 1)
    elseif MOD_TYPE == "ESP32C3" then
        spi_lcd = spi.deviceSetup(2, 7, 0, 0, 8, 40000000, spi.MSB, 1, 1)
    end
    assert(spi_lcd ~= nil, tag .. ".deviceSetup ERROR")
    if MOD_TYPE == "air101" then
    elseif MOD_TYPE == "air105" then
        assert(lcd.init("gc9306", {
            port = "device",
            pin_dc = pin.PE8,
            pin_rst = pin.PC12,
            pin_pwr = pin.PE9,
            direction = 0,
            w = 240,
            h = 320,
            xoffset = 0,
            yoffset = 0
        }, spi_lcd) == true, tag .. ".lcd.init ERROR")
    elseif MOD_TYPE == "ESP32C3" then
        assert(lcd.init("gc9306", {
            port = "device",
            pin_dc = 6,
            pin_rst = 10,
            pin_pwr = 11,
            direction = 0,
            w = 240,
            h = 320,
            xoffset = 0,
            yoffset = 0
        }, spi_lcd) == true, tag .. ".lcd.init ERROR")
    end
    log.info("lcd.drawLine", lcd.drawLine(20, 20, 150, 20, 0x001F))
    log.info("lcd.drawRectangle", lcd.drawRectangle(20, 40, 120, 70, 0xF800))
    log.info("lcd.drawCircle", lcd.drawCircle(50, 50, 20, 0x0CE0))
    log.info(tag, "DONE")
end

return lcdTest
