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

-- 8910开发板 uart通道1 2 3
-- 1603开发板 uart通道1 2 3 4
-- 串口配置
local uartId = 3
local baud = 921600
local databits = 8

local function read()
    local uartData = ""
    while true do
        log.info(tag, "ready read")
        local tmp = uart.read(uartId, "*l")
        log.info(tag, "finish read")
        if not tmp or string.len(tmp) == 0 then break end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive", uartData)
    uart.write(uartId, uartData)
end

-- UART相关的测试必须要防止模块休眠，不然会有串口收发数据的问题
pm.wake(tag)

uart.setup(uartId, baud, databits, uart.PAR_NONE, uart.STOP_1)
uart.on(uartId, "receive", read)

sys.init(0, 0)
sys.run()
