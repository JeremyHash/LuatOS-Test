-- uartTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "uartTest"

local uartList = {}

if testConfig.modType == "8910" then
    uartList = {1, 2, 3}
elseif testConfig.modType == "1603S" or testConfig.modType == "1603E" then
    uartList = {1, 2, 3, 4}
end

local receiveBuff = {}
local testData = string.rep(tag, 10)

local function getSerialData(id)
    local tmp = receiveBuff[id]
    receiveBuff[id] = ""
    return tmp
end

function test()
    if uart == nil then
        log.error(tag, "this fireware is not support uart")
        return
    end
    log.info(tag, "START")
    receiveBuff = {}
    for _, v in pairs(uartList) do
        receiveBuff[v] = ""
        assert(uart.setup(v, 115200, 8, uart.PAR_NONE, uart.STOP_1) == 115200,
               tag .. ".setup ERROR")
        uart.on(v, "receive", function()
            -- log.info("uart", "receie_" .. v)
            local uartData = ""
            while true do
                local tmp = uart.read(v, "*l")
                if not tmp or string.len(tmp) == 0 then break end
                uartData = uartData .. tmp
            end
            receiveBuff[v] = receiveBuff[v] .. uartData
            sys.publish("UART_RECEIVE_" .. v)
        end)
        uart.write(v, testData)
        -- sys.waitUntil("UART_RECEIVE_" .. v)
        sys.wait(500)
        printTable(receiveBuff)
        assert(receiveBuff[v] == testData)
        uart.close(v)
    end
    log.info(tag, "DONE")
end
