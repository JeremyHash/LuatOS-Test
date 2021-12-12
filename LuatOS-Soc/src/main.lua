PROJECT = "LuatOS-SoC-Test"
VERSION = "1.0.0"
MOD_TYPE = "air101"

sys = require("sys")
adcTest = require("adcTest")
cryptoTest = require("cryptoTest")

adcTest.test()
cryptoTest.test()

sys.run()
