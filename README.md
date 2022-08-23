# LuatOS_TEST

## 简介

LuatOS_Test是针对合宙LuatOS的自动化测试工程，包含了测试用例测试，测试结果输出以及压力测试

## 结构

LuatOS_Test包含LuatOS-Air和LuatOS-Soc两部分的测试代码
对应目录下src下全部文件就是测试代码及资源文件

## 使用方法

### LuatOS-Air

LuatOS-Air的测试需要先配置testConfig

```lua
-- 测试配置 设置为true代表开启此项测试
testConfig = {
    -- 8910 1603S 1603E
    modType = "8910",
    -- single loop
    testMode = "loop",
    SDCARD_EXIST = true,
    netLed = true,
    adcTest = true,
    i2cTest = true,
    spiTest = true,
    bitTest = true,
    cryptoTest = true,
    packTest = true,
    stringTest = true,
    commonTest = true,
    ntpTest = true,
    tableTest = true,
    uartTest = true,
    simTest = true,
    jsonTest = true,
    mathTest = true,
    rtosTest = true,
    ioTest = true,
    lbsLocTest = true,
    bluetoothTest = true,
    consoleTest = false,
    socketTest = true,
    httpTest = true,
    mqttTest = false,
    zipTest = true
}
```

testMode设置为"single"，模块会进行单次的测试用例测试，并将结果从uart.USB即USB虚拟出的AT端口输出（输出格式例子：HttpTest.getTest PASS）
设置为"loop"代表循环压力测试

### LuatOS-Soc

LuatOS-Soc的测试项如下，如果没有对应的库会自动跳过

```lua
require("adcTest").test()
require("cameraTest").test()
require("cryptoTest").test()
require("dispTest").test()
require("einkTest").test()
require("fdbTest").test()
require("fsTest").test()
require("gpioTest").test()
require("i2cTest").test()
require("jsonTest").test()
require("keyboardTest").test()
require("lcdTest").test()
require("lvglTest").test()
require("mcuTest").test()
require("packTest").test()
require("pinTest").test()
require("pwmTest").test()
require("rtcTest").test()
require("rtosTest").test()
require("sdioTest").test()
require("sfdTest").test()
require("socketTest").test()
require("spiTest").test()
require("statemTest").test()
require("stringTest").test()
require("sysTest").test()
require("touchkeyTest").test()
require("u8g2Test").test()
require("uartTest").test()
require("wdtTest").test()
require("zbuffTest").test()
require("zlibTest").test()
require("wlanTest").test()
require("esphttpTest").test()
require("mqttTest").test()
require("bleTest").test()
require("esp32Test").test()
require("espnowTest").test()
```

## 烧录方法

参考LuaTools使用方法烧录
