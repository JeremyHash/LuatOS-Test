-- bluetoothTest
-- Author:openluat
-- CreateDate:20220127
-- UpdateDate:20220129
module(..., package.seeall)

--[[
蓝牙消息码
[MSG_BLE_DATA_IND] 100
[MSG_BT_AVRCP_DISCONNECT_IND] 27
[MSG_BLE_FIND_SERVICE_IND] 71
[MSG_BLE_SCAN_CNF] 64
[MSG_BLE_FIND_CHARACTERISTIC_IND] 70
[MSG_BLE_CONNECT_IND] 68
[MSG_BLE_SCAN_IND] 66
[MSG_BT_HFP_CALLSETUP_OUTGOING] 22
[MSG_BLE_FIND_CHARACTERISTIC_UUID_IND] 72
[MSG_BLE_DISCONNECT_IND] 69
[MSG_BLE_DISCONNECT_CNF] 57
[MSG_BLE_CONNECT_CNF] 56
[MSG_BT_AVRCP_CONNECT_IND] 26
[MSG_BT_HFP_RING_INDICATION] 25
[MSG_BT_HFP_CALLSETUP_INCOMING] 23
[MSG_BT_HFP_CONNECT_IND] 18
]]

-- 蓝牙选项配置
local masterTest = false
local slaveTest = false
local beaconTest = false
local scanTest = false
local classicBtTest = false

local waitTime = 5000

local slaveStatus = false
local masterStatus = false
local reConnectSlave = false

rtos.on(rtos.MSG_BLUETOOTH, function(msg)
    local tag = "BluetoothTest"
    -- log.info(tag, "rtosMsg", "table_info")
    -- for k, v in pairs(msg) do log.info(k, v) end
    if msg.event == btcore.MSG_OPEN_CNF then
        sys.publish("BT_OPEN", msg.result)
    elseif msg.event == btcore.MSG_BLE_CONNECT_CNF then
        log.info(tag, "连接到从设备成功")
        sys.publish("BT_CONNECT_IND",
                    {["handle"] = msg.handle, ["result"] = msg.result})
        slaveStatus = true
    elseif msg.event == btcore.MSG_BT_AVRCP_CONNECT_IND then
        sys.publish("BT_AVRCP_CONNECT_IND",
                    {["handle"] = msg.handle, ["result"] = msg.result}) -- avrcp连接成功
    elseif msg.event == btcore.MSG_BT_HFP_CONNECT_IND then
        sys.publish("BT_HFP_CONNECT_IND",
                    {["handle"] = msg.handle, ["result"] = msg.result}) -- hfp连接成功
    elseif msg.event == btcore.MSG_BT_HFP_CALLSETUP_INCOMING then
        log.info(tag, "call incoming")
        sys.publish("BT_CALLSETUP_INCOMING", msg.result) -- 呼叫传入   
    elseif msg.event == btcore.MSG_BLE_CONNECT_IND then
        log.info(tag, "msg", "有主设备连接成功")
        sys.publish("BT_CONNECT_IND",
                    {["handle"] = msg.handle, ["result"] = msg.result})
        masterStatus = true
    elseif msg.event == btcore.MSG_BLE_DISCONNECT_CNF then
        log.info(tag, "msg", "从设备掉线")
        slaveStatus = false
    elseif msg.event == btcore.MSG_BLE_DISCONNECT_IND then
        log.info(tag, "msg", "主设备掉线")
        masterStatus = false
    elseif msg.event == btcore.MSG_BLE_DATA_IND then
        sys.publish("BT_DATA_IND", {
            ["data"] = msg.data,
            ["uuid"] = msg.uuid,
            ["len"] = msg.len
        })
    elseif msg.event == btcore.MSG_BLE_SCAN_CNF then
        sys.publish("BT_SCAN_CNF", msg.result)
    elseif msg.event == btcore.MSG_BLE_SCAN_IND then
        sys.publish("BT_SCAN_IND", {
            ["name"] = msg.name,
            ["addr_type"] = msg.addr_type,
            ["addr"] = msg.addr,
            ["manu_data"] = msg.manu_data,
            ["raw_data"] = msg.raw_data,
            ["raw_len"] = msg.raw_len,
            ["rssi"] = msg.rssi
        })
    elseif msg.event == btcore.MSG_BLE_FIND_CHARACTERISTIC_IND then
        sys.publish("BT_FIND_CHARACTERISTIC_IND", msg.result)
    elseif msg.event == btcore.MSG_BLE_FIND_SERVICE_IND then
        log.info(tag, "find service uuid", msg.uuid)
        if msg.uuid == 0x1800 then
            sys.publish("BT_FIND_SERVICE_IND", msg.result)
        end
    elseif msg.event == btcore.MSG_BLE_FIND_CHARACTERISTIC_UUID_IND then
        log.info(tag, "find characteristic uuid", msg.uuid)
    elseif msg.event == btcore.MSG_BLE_READ_VALUE_IND then
        log.info(tag, "read characteristic value", msg.data)
    elseif msg.event == btcore.MSG_CLOSE_CNF then
        log.info(tag, "close")
    elseif msg.event == btcore.MSG_BT_HFP_DISCONNECT_IND then
        log.info(tag, "hfp disconnect")
    elseif msg.event == btcore.MSG_BT_HFP_CALLSETUP_OUTGOING then
        log.info(tag, "call outgoing")
    elseif msg.event == btcore.MSG_BT_HFP_RING_INDICATION then
        log.info(tag, "ring indication")
    elseif msg.event == btcore.MSG_BT_AVRCP_DISCONNECT_IND then
        log.info(tag, "avrcp disconnect")
    end
end)

-- 自定义服务
local function service(uuid, struct)
    btcore.addservice(uuid)
    for i = 1, #struct do
        btcore.addcharacteristic(struct[i][1], struct[i][2], struct[i][3])
        if (type(struct[i][4]) == "table") then
            for j = 1, #struct[i][4] do
                btcore.adddescriptor(struct[i][4][j][1], struct[i][4][j][2])
            end
        end
    end
end

local function BluetoothTest()
    if masterTest == true then
        local tag = "BluetoothTest.masterTest"
        local msgRes, msgData
        assert(btcore.open(1) == 0, tag .. ".open ERROR")
        msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
        assert(msgRes == true and msgData == 0, tag .. ".open ERROR")
        while true do
            assert(btcore.scan(1) == 0, tag .. ".scan open ERROR")
            msgRes, msgData = sys.waitUntil("BT_SCAN_CNF", 50000)
            assert(msgRes ~= false and msgData == 0, tag .. ".scan open ERROR")
            while true do
                if reConnectSlave == true then
                    reConnectSlave = false
                    break
                else
                    msgRes, msgData = sys.waitUntil("BT_SCAN_IND", waitTime)
                    if not msgData and msgRes == false then
                        log.info(tag, "没有扫描到蓝牙设备")
                        break
                    else
                        local deviceJsonInfo = json.encode(msgData)
                        log.info(tag, deviceJsonInfo)
                        if msgData.name == "LuatOSlaveTest" then
                            assert(btcore.scan(0) == 0,
                                   tag .. ".scan close ERROR")
                            assert(btcore.connect(msgData.addr,
                                                  msgData.addr_type) == 0,
                                   tag .. ".connect ERROR")
                            local _, bt_connect =
                                sys.waitUntil("BT_CONNECT_IND")
                            assert(bt_connect.result == 0,
                                   tag .. ".connect ERROR")
                            assert(btcore.findservice() == 0,
                                   tag .. ".findservice ERROR")
                            local _, result = sys.waitUntil(
                                                  "BT_FIND_SERVICE_IND")
                            assert(result == 1, tag .. ".findservice ERROR")
                            -- assert(btcore.findcharacteristic(0xfee0) == 0,
                            --        tag .. ".findcharacteristic ERROR")
                            -- local _, result = sys.waitUntil("BT_FIND_CHARACTERISTIC_IND")
                            assert(btcore.findcharacteristic(
                                       "00000000000000b000405104301100f0") == 0,
                                   tag .. ".findcharacteristic ERROR")
                            local _, result = sys.waitUntil(
                                                  "BT_FIND_CHARACTERISTIC_IND")
                            assert(result == 1,
                                   tag .. ".findcharacteristic ERROR")
                            -- assert(btcore.opennotification(0xfee2) == 0,
                            --        tag .. ".opennotification ERROR")
                            assert(btcore.opennotification(
                                       "9ecadc240ee5a9e093f3a3b50200406e") == 0,
                                   tag .. ".opennotification ERROR")
                            local data = "masterTest"
                            while true do
                                if slaveStatus == false then
                                    log.info(tag, "发起重连")
                                    reConnectSlave = true
                                    break
                                else
                                    -- assert(btcore.readvalue(0xfee2) == 0,
                                    --        tag .. ".readvalue ERROR")
                                    assert(btcore.readvalue(
                                               "00000000000000b000405104311100f0") ==
                                               0, tag .. ".readvalue ERROR")
                                    -- assert(
                                    --     btcore.send(data, 0xfee1,
                                    --                 bt_connect.handle) == 0,
                                    --     tag .. ".send ERROR")
                                    assert(btcore.send(data,
                                                       "9ecadc240ee5a9e093f3a3b50300406e",
                                                       bt_connect.handle) == 0,
                                           tag .. ".send ERROR")
                                    sys.waitUntil("BT_DATA_IND", waitTime)
                                    local data = ""
                                    local len = 0
                                    while true do
                                        local _, recvdata, recvlen =
                                            btcore.recv(3)
                                        if recvlen == 0 then
                                            break
                                        end
                                        len = len + recvlen
                                        data = data .. recvdata
                                    end
                                    if len ~= 0 then
                                        assert(data == "slaveTest",
                                               tag .. ".recvData ERROR")
                                        assert(len == 9,
                                               tag .. ".recvDataLen ERROR")
                                    end
                                    sys.wait(10000)
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif slaveTest == true then
        local tag = "BluetoothTest.slaveTest"
        local msgRes, msgData
        while true do
            assert(btcore.open(0) == 0, tag .. ".open ERROR")
            msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
            assert(msgRes == true and msgData == 0, tag .. ".open ERROR")
            assert(btcore.setname("LuatOSlaveTest") == 0,
                   tag .. ".setname ERROR")
            local struct1 = {
                {0xfee1, 0x0c, 0x0002},
                {0xfee2, 0x12, 0x0001, {{0x2902, 0x0001}, {0x2901, "123456"}}}
            }
            local struct2 = {
                {
                    "9ecadc240ee5a9e093f3a3b50200406e", 0x12, 0x0001,
                    {{0x2902, 0x0001}, {0x2901, "123456"}}
                }, {"9ecadc240ee5a9e093f3a3b50300406e", 0x0c, 0x0002}
            }
            assert(btcore.setadvdata(string.fromHex("02010604ff000203")) == 0,
                   tag .. ".setadvdata ERROR")
            assert(btcore.setscanrspdata(string.fromHex("04ff000203")) == 0,
                   tag .. ".setscanrspdata ERROR")
            -- service(0xfee0, struct1)
            service("9ecadc240ee5a9e093f3a3b50100406e", struct2)
            -- assert(btcore.setvalue("1234567890", 0xfee2) == 0,
            --        tag .. ".setvalue ERROR")
            assert(btcore.setvalue("1234567890",
                                   "9ecadc240ee5a9e093f3a3b50200406e") == 0,
                   tag .. ".setvalue ERROR")
            assert(btcore.setadvparam(0x80, 0xa0, 0, 0, 0x07, 0, 0,
                                      "11:22:33:44:55:66") == 0,
                   tag .. ".setadvparam ERROR")
            -- # 白名单
            -- assert(btcore.setadvparam(0x80, 0xa0, 0, 0, 0x07, 2) == 0,
            --        tag .. ".setadvparam ERROR")
            -- assert(btcore.addwhitelist("77:00:88:99:00:11", 0) == 0,
            --        tag .. ".addwhitelist ERROR")
            -- assert(btcore.addwhitelist("77:00:88:99:00:22", 0) == 0,
            --        tag .. ".addwhitelist ERROR")
            -- assert(btcore.removewhitelist("77:00:88:99:00:22", 0) == 0,
            --        tag .. ".removewhitelist ERROR")
            -- assert(btcore.clearwhitelist() == 0, tag .. ".clearwhitelist ERROR")
            -- assert(btcore.addwhitelist("77:00:88:99:00:11", 0) == 0,
            --        tag .. ".addwhitelist ERROR")
            assert(btcore.advertising(1) == 0, tag .. ".advertising ERROR")
            while true do
                msgRes, msgData = sys.waitUntil("BT_CONNECT_IND")
                assert(msgRes == true and msgData.result == 0,
                       tag .. ".connect ERROR")
                while true do
                    msgRes, msgData = sys.waitUntil("BT_DATA_IND")
                    local data = ""
                    local len = 0
                    while true do
                        local _, recvdata, recvlen = btcore.recv(3)
                        if recvlen == 0 then break end
                        len = len + recvlen
                        data = data .. recvdata
                    end
                    if len ~= 0 then
                        assert(data == "masterTest", tag .. ".recvData ERROR")
                        assert(len == 10, tag .. ".recvDataLen ERROR")
                        local data = "slaveTest"
                        -- assert(btcore.send(data, 0xfee2, msgData.handle) == 0,
                        --        tag .. ".send ERROR")
                        assert(btcore.send(data,
                                           "9ecadc240ee5a9e093f3a3b50200406e",
                                           msgData.handle) == 0,
                               tag .. ".send ERROR")
                    end
                end
            end
        end
    elseif beaconTest == true then
        local tag = "BluetoothTest.beaconTest"
        assert(btcore.open(0) == 0, tag .. ".open ERROR")
        msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
        assert(msgRes == true and msgData == 0, tag .. ".open ERROR")
        log.info(tag, "打开蓝牙SUCCESS")
        assert(btcore.setname("LuatBleSlaveTest") == 0, tag .. ".setname ERROR")
        log.info(tag, "设置名称SUCCESS")
        assert(btcore.setbeacondata("AB8190D5D11E4941ACC442F30510B408", 10107,
                                    50179) == 0, tag .. ".setbeacondata ERROR")
        log.info(tag, "设置数据SUCCESS")
        assert(btcore.advertising(1) == 0, tag .. ".advertising ERROR")
        log.info(tag, "打开广播SUCCESS")
    elseif scanTest == true then
        local tag = "BluetoothTest.scanTest"
        local msgRes, msgData
        assert(btcore.open(1) == 0, tag .. ".open ERROR")
        msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
        assert(msgRes == true and msgData == 0, tag .. ".open ERROR")
        log.info(tag, "打开蓝牙SUCCESS")
        assert(btcore.setscanparam(1, 50 / 0.625, 100 / 0.625, 0, 0) == 0,
               tag .. ".setscanparam ERROR")
        log.info(tag, "设置扫描参数SUCCESS")
        assert(btcore.scan(1) == 0, tag .. ".scan ERROR")
        msgRes, msgData = sys.waitUntil("BT_SCAN_CNF", 50000)
        assert(msgRes == true and msgData == 0, tag .. ".scan ERROR")
        log.info(tag, "打开扫描SUCCESS")
        while true do
            msgRes, msgData = sys.waitUntil("BT_SCAN_IND", waitTime)
            if not msgData then
                log.error(tag, "没有扫描到蓝牙设备")
            else
                local deviceJsonInfo = json.encode(msgData)
                log.info(tag, deviceJsonInfo)
            end
        end
    elseif classicBtTest == true then
        local tag = "BluetoothTest.classicBtTest"
        local msgRes, msgData
        assert(btcore.open(2) == 0, tag .. ".open ERROR")
        msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
        assert(msgRes == true and msgData == 0, tag .. ".open ERROR")
        log.info(tag, "open", "打开经典蓝牙模式SUCCESS")
        assert(btcore.setname("LuatOSTestBtTest") == 0, tag .. ".setname ERROR")
        log.info(tag, "setName", "设置名称SUCCESS")
        assert(btcore.advertising(1) == 0, tag .. ".advertising ERROR")
        log.info(tag, "advertising", "打开广播SUCCESS")
        assert(btcore.setvisibility(0x11) == 0, tag .. ".advertising ERROR")
        log.info(tag, "setvisibility", "打开可见性SUCCESS")
        log.info(tag, "getvisibility", btcore.getvisibility())

        -- 经典蓝牙播放音乐
        msgRes, msgData = sys.waitUntil("BT_AVRCP_CONNECT_IND")
        if msgRes == true and msgData.result == 0 then
            log.info(tag, "connect", "蓝牙连接SUCCESS")
            while true do
                assert(btcore.setavrcpvol(100) == 0, tag .. ".setavrcpvol ERROR")
                log.info(tag, "设置音量SUCCESS")
                sys.wait(waitTime)
                log.info(tag, "avrcp vol", btcore.getavrcpvol())
                assert(btcore.setavrcpsongs(1) == 0,
                       tag .. ".setavrcpsongs ERROR")
                log.info(tag, "播放SUCCESS")
                sys.wait(waitTime)
                assert(btcore.setavrcpsongs(0) == 0,
                       tag .. ".setavrcpsongs ERROR")
                log.info(tag, "暂停SUCCESS")
                sys.wait(waitTime)
                assert(btcore.setavrcpsongs(2) == 0,
                       tag .. ".setavrcpsongs ERROR")
                log.info(tag, "切换上一曲SUCCESS")
                sys.wait(waitTime)
                assert(btcore.setavrcpsongs(3) == 0,
                       tag .. ".setavrcpsongs ERROR")
                log.info(tag, "切换下一曲SUCCESS")
                sys.wait(waitTime)
            end
        else
            log.error(tag .. ".connect", "连接FAIL")
        end

        --[[
        -- 经典蓝牙通话
        msgRes, msgData = sys.waitUntil("BT_HFP_CONNECT_IND")
        if msgRes == true and msgData.result == 0 then
            log.info(tag, "connect", "蓝牙连接SUCCESS")
            while true do
                _, result = sys.waitUntil("BT_CALLSETUP_INCOMING") -- 蓝牙呼叫传入
                if result ~= 0 then return false end
                assert(btcore.sethfpvol(10) == 0, tag .. ".sethfpvol ERROR") -- 设置音量
                log.info(tag, "设置音量SUCCESS")
                assert(btcore.hfpcallanswer() == 0,
                       tag .. ".hfpcallanswer ERROR") -- 接听
                log.info(tag, "接听SUCCESS")
                sys.wait(waitTime)
                assert(btcore.hfpcallhangup() == 0,
                       tag .. ".hfpcallhangup ERROR") -- 挂断
                log.info(tag, "挂断SUCCESS")
                sys.wait(waitTime)
                assert(btcore.hfpcalldial("10086") == 0,
                       tag .. ".hfpcalldial ERROR") -- 拨号
                log.info(tag, "拨号SUCCESS")
                sys.wait(waitTime)
                assert(btcore.hfpcallhangup() == 0,
                       tag .. ".hfpcallhangup ERROR") -- 挂断
                log.info(tag, "挂断SUCCESS")
                sys.wait(waitTime)
                assert(btcore.hfpcallredial() == 0,
                       tag .. ".hfpcallredial ERROR") -- 重拨
                log.info(tag, "重拨SUCCESS")
                sys.wait(waitTime)
                assert(btcore.hfpcallreject() == 0,
                       tag .. ".hfpcallreject ERROR") -- 拒接
                log.info(tag, "拒接SUCCESS")
                sys.wait(waitTime)
            end
        else
            log.error(tag .. ".connect", "连接FAIL")
        end
        ]]
    end
end

sys.taskInit(function() BluetoothTest() end)
