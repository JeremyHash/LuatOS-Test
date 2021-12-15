PROJECT = "LuatOS-SoC-Test"
VERSION = "1.0.0"
MOD_TYPE = "air101"

sys = require("sys")
adcTest = require("adcTest")
cryptoTest = require("cryptoTest")
fdbTest = require("fdbTest")
i2cTest = require("i2cTest")

mcu.setClk(240)

adcTest.test()
cryptoTest.test()
fdbTest.test()
i2cTest.test()

sys.run()
