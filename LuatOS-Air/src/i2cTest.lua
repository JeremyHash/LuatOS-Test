-- i2cTest
-- Author:openluat
-- CreateDate:20220126
-- UpdateDate:20220126
module(..., package.seeall)

local tag = "i2cTest"
local i2cList = {}

if testConfig.modType == "8910" then
    i2cList = {2}
elseif testConfig.modType == "1603E" or testConfig.modType == "1603S" then
    i2cList = {1, 2, 3, 4}
end

function test()
    if i2c == nil then
        log.error(tag, "this fireware is not support i2c")
        return
    end
    log.info(tag, "START")
    local i2cSlaveAddr
    local i2cSpeed = 100000
    -- AHT10
    i2cSlaveAddr = 0x38
    i2c.setup(1, i2cSpeed)
    i2c.send(1, i2cSlaveAddr, {0xac, 0x22, 0x00})
    local receivedData = i2c.recv(1, i2cSlaveAddr, 6)
    i2c.close(1)

    -- 24C02
    i2cSlaveAddr = 0x50
    i2c.setup(1, i2cSpeed)
    i2c.send(1, i2cSlaveAddr, {0xac, 0x22, 0x00})
    local receivedData = i2c.recv(1, i2cSlaveAddr, 6)
    i2c.close(1)
    for _, v in pairs(i2cList) do
        i2cSlaveAddr = 0x38
        assert(i2c.setup(v, i2cSpeed) == i2cSpeed, tag .. ".setup ERROR")
        assert(i2c.send(v, i2cSlaveAddr, {0xac, 0x22, 0x00}) == 3,
               tag .. ".send ERROR")
        local receivedData = i2c.recv(v, i2cSlaveAddr, 6)
        assert(#receivedData == 6, tag .. ".recv ERROR")
        local tempBit = string.byte(receivedData, 6) + 0x100 *
                            string.byte(receivedData, 5) + 0x10000 *
                            bit.band(string.byte(receivedData, 4), 0x0F)
        local humidityBit =
            bit.band(string.byte(receivedData, 4), 0xF0) + 0x100 *
                string.byte(receivedData, 3) + 0x10000 *
                string.byte(receivedData, 2)
        humidityBit = bit.rshift(humidityBit, 4)
        local calcTemp = (tempBit / 1048576) * 200 - 50
        local calcHum = humidityBit / 1048576
        log.info(tag .. ".当前温度", string.format("%.1f℃", calcTemp))
        log.info(tag .. ".当前湿度", string.format("%.1f%%", calcHum * 100))
        i2c.close(v)

        i2cSlaveAddr = 0x50
        assert(i2c.setup(v, i2cSpeed) == i2cSpeed, tag .. ".setup ERROR")
        local data = {}
        for i = 1, 200 do table.insert(data, i) end
        local pages = math.floor(#data / 16)
        local single = #data % 16
        for i = 1, pages do
            local insertTable = {16 * (i - 1)}
            for j = 1, 16 do
                table.insert(insertTable, data[16 * (i - 1) + j])
            end
            assert(i2c.send(v, i2cSlaveAddr, insertTable) == 17,
                   tag .. ".send ERROR")
            sys.wait(5)
        end
        local insertTable = {16 * pages}
        for i = 1, single do
            table.insert(insertTable, data[pages * 16 + i])
        end
        assert(i2c.send(v, i2cSlaveAddr, insertTable) == 9, tag .. ".send ERROR")
        sys.wait(5)
        local read_res = ""
        for i = 0, 200 - 1 do
            assert(i2c.send(v, i2cSlaveAddr, i) == 1, tag .. ".send ERROR")
            sys.wait(5)
            local recv = i2c.recv(v, i2cSlaveAddr, 1)
            read_res = read_res .. recv
        end

        local matchRes = ""
        for k, v in pairs(data) do
            matchRes = matchRes .. string.format("%02X", v)
        end
        assert(matchRes == string.toHex(read_res), tag .. ".recv ERROR")
        i2c.close(v)
    end

    log.info(tag, "DONE")
end

