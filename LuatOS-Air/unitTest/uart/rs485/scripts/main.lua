-- rs485Test
-- Author:openluat
-- CreateDate:20211103
-- UpdateDate:20211103
PROJECT = "rs485Test"
VERSION = "1.0.0"

require "sys"
require "pm"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "rs485Test"

-- 8910开发板 uart通道1 2 3
-- 1603开发板 uart通道1 2 3 4
-- 串口配置
local uartId = 1
local baud = 115200
local databits = 8

local function read()
    local uartData = ""
    while true do
        local tmp = uart.read(uartId, "*l")
        if not tmp or string.len(tmp) == 0 then
            break
        end
        uartData = uartData .. tmp
    end
    log.info(tag .. ".receive", uartData)
    uart.write(uartId, uartData)
end

-- UART相关的测试必须要防止模块休眠，不然会有串口收发数据的问题
pm.wake(tag)

uart.setup(uartId, baud, databits, uart.PAR_NONE, uart.STOP_1, nil, 1)
uart.set_rs485_oe(uartId, 23, 1, 5)
uart.on(uartId, "receive", read)

sys.init(0, 0)
sys.run()
