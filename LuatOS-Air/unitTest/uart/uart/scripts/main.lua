-- uartTest
-- Author:openluat
-- CreateDate:20211022
-- UpdateDate:20211029
PROJECT = "uartTest"
VERSION = "1.0.0"

require "sys"
require "pm"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "uartTest"
local modType = "1603"

local uartList = {}

if modType == "8910" then
    uartList = {1, 2, 3}
elseif modType == "1603" then
    uartList = {1, 2, 3, 4}
end

-- 串口配置
local baud = 921600
local databits = 8
local conut1, count2, count3, count4 = 0, 0, 0, 0

local function read1()
    local uartData = ""
    while true do
        local tmp = uart.read(1, "*l")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive1", uartData)
    uart.write(1, uartData)
end
local function read2()
    local uartData = ""
    while true do
        local tmp = uart.read(2, "*l")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive2", uartData)
    uart.write(2, uartData)
end
local function read3()
    local uartData = ""
    while true do
        local tmp = uart.read(3, "*l")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive3", uartData)
    uart.write(3, uartData)
end
local function read4()
    local uartData = ""
    while true do
        local tmp = uart.read(4, "*l")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive4", uartData)
    uart.write(4, uartData)
end
local function sent1()
    conut1 = conut1 + 1
    log.info("conut1", conut1)
end
local function sent2()
    count2 = count2 + 1
    log.info("count2", count2)
end
local function sent3()
    count3 = count3 + 1
    log.info("count3", count3)
end
local function sent4()
    count4 = count4 + 1
    log.info("count4", count4)
end

-- UART相关的测试必须要防止模块休眠，不然会有串口收发数据的问题
pm.wake(tag)

for _, v in pairs(uartList) do
    uart.setup(v, baud, databits, uart.PAR_NONE, uart.STOP_1)
    local readFun
    local sentFun
    if v == 1 then
        readFun = read1
        sentFun = sent1
    elseif v == 2 then
        readFun = read2
        sentFun = sent2
    elseif v == 3 then
        readFun = read3
        sentFun = sent3
    elseif v == 4 then
        readFun = read4
        sentFun = sent4
    end
    uart.on(v, "receive", readFun)
    uart.on(v, "sent", sentFun)
end

sys.init(0, 0)
sys.run()
