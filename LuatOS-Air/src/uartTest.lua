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
    local receiveBuff = {}
    for _, v in pairs(uartList) do
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
            receiveBuff[v] = uartData
        end)
        uart.write(v, testData)
        sys.wait(1000)
        printTable(receiveBuff)
        assert(receiveBuff[v] == testData, tag .. ".uart" .. v .. " ERROR")
        uart.close(v)
    end
    log.info(tag, "DONE")
end
