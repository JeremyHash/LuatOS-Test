PROJECT = "LuatOS-SoC-Test"
VERSION = "1.0.0"
MOD_TYPE = rtos.bsp()
log.info("MOD_TYPE", MOD_TYPE)

sys = require("sys")
adcTest = require("adcTest")
cryptoTest = require("cryptoTest")
fdbTest = require("fdbTest")
i2cTest = require("i2cTest")
fsTest = require("fsTest")
gpioTest = require("gpioTest")
jsonTest = require("jsonTest")
pwmTest = require("pwmTest")
mcuTest = require("mcuTest")

mcu.setClk(240)

adcTest.test()
cryptoTest.test()
fdbTest.test()
i2cTest.test()
fsTest.test()
gpioTest.test()
jsonTest.test()
pwmTest.test()
mcuTest.test()

sys.run()
