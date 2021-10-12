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
    -- 8910 1603 1802S
    modType = "1603",
    -- single loop
    testMode = "single",
    gpsModType = "GK",
    netLed = false,
    consoleTest = false,
    socketTest = true,
    httpTest = false,
    mqttTest = false,
    ftpTest = false
}
```
testMode设置为"single"，模块会进行单次的测试用例测试，并将结果从uart.USB即USB虚拟出的AT端口输出（输出格式例子：HttpTest.getTest PASS）
设置为"loop"代表循环压力测试

## 烧录方法
参考LuaTools使用方法烧录