-- BluetoothTest
-- Author:openluat
-- CreateDate:20211028
-- UpdateDate:20211029
PROJECT = "BluetoothTest"
VERSION = "1.0.0"

require "sys"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- 蓝牙选项配置
local masterTest = true
local slaveTest = false
local beaconTest = false
local classicBtTest = false
local scanTest = false

local waitTime = 5000

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

local slaveStatus = false
local masterStatus = false
local reConnectSlave = false

rtos.on(rtos.MSG_BLUETOOTH, function(msg)
    local tag = "BluetoothTest"
    log.info(tag .. ".rtosMsg", "table_info")
    for k, v in pairs(msg) do log.info(k, v) end
    if msg.event == btcore.MSG_OPEN_CNF then
        sys.publish("BT_OPEN", msg.result)
    elseif msg.event == btcore.MSG_BLE_CONNECT_CNF then
        log.info(tag .. ".msg", "连接到从设备成功")
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
        log.info(tag .. ".call incoming")
        sys.publish("BT_CALLSETUP_INCOMING", msg.result) -- 呼叫传入   
    elseif msg.event == btcore.MSG_BLE_CONNECT_IND then
        log.info(tag .. ".msg", "有主设备连接成功")
        sys.publish("BT_CONNECT_IND",
                    {["handle"] = msg.handle, ["result"] = msg.result})
        masterStatus = true
    elseif msg.event == btcore.MSG_BLE_DISCONNECT_CNF then
        log.info(tag .. ".msg", "从设备掉线")
        slaveStatus = false
    elseif msg.event == btcore.MSG_BLE_DISCONNECT_IND then
        log.info(tag .. ".msg", "主设备掉线")
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
        log.info(tag .. ".find service uuid", msg.uuid)
        if msg.uuid == 0x1800 then
            sys.publish("BT_FIND_SERVICE_IND", msg.result)
        end
    elseif msg.event == btcore.MSG_BLE_FIND_CHARACTERISTIC_UUID_IND then
        log.info(tag .. ".find characteristic uuid", msg.uuid)
    elseif msg.event == btcore.MSG_BLE_READ_VALUE_IND then
        log.info(tag .. ".read characteristic value", msg.data)
    elseif msg.event == btcore.MSG_CLOSE_CNF then
        log.info(tag .. ".close")
    elseif msg.event == btcore.MSG_BT_HFP_DISCONNECT_IND then
        log.info(tag .. ".hfp disconnect")
    elseif msg.event == btcore.MSG_BT_HFP_CALLSETUP_OUTGOING then
        log.info(tag .. ".call outgoing")
    elseif msg.event == btcore.MSG_BT_HFP_RING_INDICATION then
        log.info(tag .. ".ring indication")
    elseif msg.event == btcore.MSG_BT_AVRCP_DISCONNECT_IND then
        log.info(tag .. ".avrcp disconnect")
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

local function BluetoothTestTask()
    if masterTest == true then
        local tag = "BluetoothTest.masterTest"
        local msgRes, msgData
        sys.wait(waitTime)
        log.info(tag .. ".start")
        if btcore.open(1) == 0 then
            msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
            if msgRes == true and msgData == 0 then
                log.info(tag .. ".open", "打开蓝牙SUCCESS")
                log.info("master addr", btcore.getaddr())
                while true do
                    log.info(tag .. ".scan", "开始扫描")
                    if btcore.scan(1) == 0 then
                        msgRes, msgData = sys.waitUntil("BT_SCAN_CNF", 50000)
                        if msgRes == false and msgData ~= 0 then
                            log.error(tag .. ".scan", "打开扫描FAIL")
                        else
                            log.info(tag .. ".scan", "打开扫描SUCCESS")
                            while true do
                                if reConnectSlave == true then
                                    reConnectSlave = false
                                    break
                                else
                                    msgRes, msgData = sys.waitUntil(
                                                          "BT_SCAN_IND",
                                                          waitTime)
                                    if not msgData and msgRes == false then
                                        log.info(tag .. ".scan",
                                                 "没有扫描到蓝牙设备")
                                        break
                                    else
                                        local deviceJsonInfo = json.encode(
                                                                   msgData)
                                        log.info(tag .. ".deviceJsonInfo",
                                                 deviceJsonInfo)
                                        if msgData.name == "LuatBleSlaveTest" then
                                            local slaveName = msgData.name
                                            local slaveAddrType =
                                                msgData.addr_type
                                            local slaveAddr = msgData.addr
                                            local slaveManuData =
                                                msgData.manu_data
                                            local slaveRawData =
                                                msgData.raw_data
                                            btcore.scan(0)
                                            log.info("connect slave addr",
                                                     msgData.addr)
                                            local connectRes = btcore.connect(
                                                                   msgData.addr,
                                                                   msgData.addr_type)
                                            if connectRes == 0 then
                                                log.info(tag .. ".connect",
                                                         "连接从设备SUCCESS")
                                                local _, bt_connect =
                                                    sys.waitUntil(
                                                        "BT_CONNECT_IND")
                                                if bt_connect.result ~= 0 then
                                                    log.error(tag ..
                                                                  ".connectInd",
                                                              "连接FAIL")
                                                else
                                                    log.info(tag ..
                                                                 ".connectInd",
                                                             "连接SUCCESS")
                                                    log.info(tag ..
                                                                 ".开启蓝牙发现服务")
                                                    btcore.findservice()
                                                    local _, result =
                                                        sys.waitUntil(
                                                            "BT_FIND_SERVICE_IND")
                                                    if not result then
                                                        log.error(tag ..
                                                                      ".findServiceInd",
                                                                  "没有发现服务")
                                                    else
                                                        -- btcore.findcharacteristic(0xfee0)
                                                        -- local _, result = sys.waitUntil("BT_FIND_CHARACTERISTIC_IND")
                                                        btcore.findcharacteristic(
                                                            "9ecadc240ee5a9e093f3a3b50100406e")
                                                        local _, result =
                                                            sys.waitUntil(
                                                                "BT_FIND_CHARACTERISTIC_IND")
                                                        if not result then
                                                            log.error(tag ..
                                                                          ".findServiceInd",
                                                                      "没有发现服务")
                                                        else
                                                            -- btcore.opennotification(0xfee2)
                                                            -- btcore.closenotification(0xfee2)
                                                            log.info(
                                                                "打开通知",
                                                                btcore.opennotification(
                                                                    "9ecadc240ee5a9e093f3a3b50200406e"))
                                                            -- btcore.closenotification("9ecadc240ee5a9e093f3a3b50200406e")
                                                            local data =
                                                                "LuaTaskTest.BluetoothTest.masterTest.data"
                                                            while true do
                                                                if slaveStatus ==
                                                                    false then
                                                                    log.info(
                                                                        tag ..
                                                                            ".reConnect",
                                                                        "发起重连")

                                                                    reConnectSlave =
                                                                        true
                                                                    break
                                                                else
                                                                    -- btcore.readvalue(0xfee2)
                                                                    btcore.readvalue(
                                                                        "9ecadc240ee5a9e093f3a3b50200406e")
                                                                    -- local sendRes = btcore.send(data, 0xfee1, bt_connect.handle)
                                                                    local 
                                                                        sendRes =
                                                                        btcore.send(
                                                                            data,
                                                                            "9ecadc240ee5a9e093f3a3b50300406e",
                                                                            bt_connect.handle)
                                                                    if sendRes ==
                                                                        0 then
                                                                        log.info(
                                                                            tag ..
                                                                                ".send",
                                                                            "蓝牙数据发送SUCCESS")

                                                                        sys.waitUntil(
                                                                            "BT_DATA_IND",
                                                                            waitTime)
                                                                        local 
                                                                            data =
                                                                            ""
                                                                        local 
                                                                            len =
                                                                            0
                                                                        local 
                                                                            uuid =
                                                                            ""
                                                                        while true do
                                                                            local 
                                                                                recvuuid,
                                                                                recvdata,
                                                                                recvlen =
                                                                                btcore.recv(
                                                                                    3)
                                                                            if recvlen ==
                                                                                0 then
                                                                                break
                                                                            end
                                                                            uuid =
                                                                                recvuuid
                                                                            len =
                                                                                len +
                                                                                    recvlen
                                                                            data =
                                                                                data ..
                                                                                    recvdata
                                                                        end
                                                                        if len ~=
                                                                            0 then
                                                                            log.info(
                                                                                tag ..
                                                                                    ".recvData",
                                                                                data)
                                                                            log.info(
                                                                                tag ..
                                                                                    ".recvDataLen",
                                                                                len)
                                                                            log.info(
                                                                                tag ..
                                                                                    ".recvUUIDHex",
                                                                                string.toHex(
                                                                                    uuid))
                                                                            log.info(
                                                                                tag ..
                                                                                    ".connectStart",
                                                                                btcore.state())
                                                                        end
                                                                        sys.wait(
                                                                            10000)
                                                                    else
                                                                        log.error(
                                                                            tag ..
                                                                                ".send",
                                                                            "蓝牙数据发送FAIL")
                                                                    end
                                                                end
                                                            end
                                                        end

                                                    end
                                                end
                                            else
                                                log.error(tag .. ".connect",
                                                          "连接从设备FAIL")
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        log.error(tag .. ".scan", "打开扫描FAIL")
                    end
                end
            else
                log.error(tag .. ".open", "打开蓝牙FAIL")
            end
        else
            log.error(tag .. ".open", "打开蓝牙FAIL")
        end
    elseif slaveTest == true then
        local tag = "BluetoothTest.slaveTest"
        local msgRes, msgData
        sys.wait(waitTime)
        while true do
            if btcore.open(0) == 0 then
                msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
                if msgRes == true and msgData == 0 then
                    log.info(tag .. ".open", "打开蓝牙从模式SUCCESS")
                    log.info(tag .. ".addr", btcore.getaddr())
                    if btcore.setname("LuatBleSlaveTest") == 0 then
                        log.info(tag .. ".setName", "设置名称SUCCESS")
                        local struct1 = {
                            {0xfee1, 0x0c, 0x0002},
                            {
                                0xfee2, 0x12, 0x0001,
                                {{0x2902, 0x0001}, {0x2901, "123456"}}
                            }
                        }
                        local struct2 = {
                            {
                                "9ecadc240ee5a9e093f3a3b50200406e", 0x12,
                                0x0001, {{0x2902, 0x0001}, {0x2901, "123456"}}
                            },
                            {"9ecadc240ee5a9e093f3a3b50300406e", 0x0c, 0x0002}
                        }
                        btcore.setadvdata(string.fromHex("02010604ff000203"))
                        btcore.setscanrspdata(string.fromHex("04ff000203"))
                        -- service(0xfee0, struct1)
                        service("9ecadc240ee5a9e093f3a3b50100406e", struct2)
                        -- btcore.setvalue("1234567890", 0xfee2)
                        btcore.setvalue("1234567890",
                                        "9ecadc240ee5a9e093f3a3b50200406e")
                        btcore.setadvparam(0x80, 0xa0, 0, 0, 0x07, 0, 0,
                                           "11:22:33:44:55:66")
                        -- # 白名单
                        -- btcore.setadvparam(0x80, 0xa0, 0, 0, 0x07, 2)
                        -- btcore.addwhitelist("77:00:88:99:00:11", 0)
                        -- btcore.addwhitelist("77:00:88:99:00:22", 0)
                        -- btcore.removewhitelist("77:00:88:99:00:22", 0)
                        -- btcore.clearwhitelist()
                        -- btcore.addwhitelist("77:00:88:99:00:11", 0)
                        if btcore.advertising(1) == 0 then
                            log.info(tag .. ".advertising",
                                     "打开广播SUCCESS")
                            while true do
                                msgRes, msgData =
                                    sys.waitUntil("BT_CONNECT_IND")
                                if msgRes == true and msgData.result == 0 then
                                    log.info(tag .. ".connect",
                                             "蓝牙连接SUCCESS")
                                    while true do
                                        if masterStatus == false then
                                            log.info(tag .. ".reConnect",
                                                     "等待重连")
                                            break
                                        else
                                            msgRes, msgData = sys.waitUntil(
                                                                  "BT_DATA_IND")
                                            if msgRes == true then
                                                local data = ""
                                                local len = 0
                                                local uuid = ""
                                                local recvuuid, recvdata,
                                                      recvlen
                                                while true do
                                                    recvuuid, recvdata, recvlen =
                                                        btcore.recv(3)
                                                    if recvlen == 0 then
                                                        break
                                                    end
                                                    uuid = recvuuid
                                                    len = len + recvlen
                                                    data = data .. recvdata
                                                end
                                                if len ~= 0 then
                                                    log.info(tag .. ".recvData",
                                                             data)
                                                    log.info(tag ..
                                                                 ".recvDataLen",
                                                             len)
                                                    log.info(tag ..
                                                                 ".recvUUIDHex",
                                                             string.toHex(uuid))
                                                    log.info(tag ..
                                                                 ".connectStart",
                                                             btcore.state())
                                                    if data == "close" then
                                                        btcore.disconnect()
                                                    end
                                                    local data =
                                                        "LuaTaskTest.BluetoothTest.slaveTest.data"
                                                    -- btcore.send(data, 0xfee2, msgData.handle)
                                                    btcore.send(data,
                                                                "9ecadc240ee5a9e093f3a3b50200406e",
                                                                msgData.handle)
                                                end
                                            else
                                                log.info(tag .. ".recv",
                                                         "没有接收到数据")
                                            end
                                        end
                                    end
                                else
                                    log.error(tag .. ".connect", "连接FAIL")
                                end
                            end
                        else
                            log.error(tag .. ".advertising", "打开广播FAIL")
                        end
                    else
                        log.error(tag .. ".setName", "设置名称FAIL")
                    end
                else
                    log.error(tag .. ".open", "打开蓝牙从模式FAIL")
                end
            else
                log.error(tag .. ".open", "打开蓝牙从模式FAIL")
            end
            sys.wait(waitTime)
        end
        btcore.close()
    elseif beaconTest == true then
        sys.wait(waitTime)
        local tag = "BluetoothTest.beaconTest"
        if btcore.open(0) == 0 then
            log.info(tag .. ".open", "SUCCESS")
            sys.waitUntil("BT_OPEN", waitTime)
            if btcore.setname("LuatBleSlaveTest") == 0 then
                log.info(tag .. ".setName", "设置名称SUCCESS")
                if btcore.setbeacondata("AB8190D5D11E4941ACC442F30510B408",
                                        10107, 50179) == 0 then
                    log.info(tag .. ".setbeacondata", "SUCCESS")
                    if btcore.advertising(1) == 0 then
                        log.info(tag .. ".advertising", "SUCCESS")
                    else
                        log.error(tag .. ".advertising", "FAIL")
                    end
                else
                    log.error(tag .. ".setbeacondata", "FAIL")
                end
            else
                log.error(tag .. ".setName", "设置名称FAIL")
            end
        else
            log.error(tag .. ".open", "FAIL")
        end
    elseif classicBtTest == true then
        local tag = "BluetoothTest.classicBtTest"
        local msgRes, msgData
        sys.wait(waitTime)
        while true do
            if btcore.open(2) == 0 then
                msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
                if msgRes == true and msgData == 0 then
                    log.info(tag .. ".open", "打开经典蓝牙模式SUCCESS")
                    if btcore.setname("LuaTaskTestBtTest") == 0 then
                        log.info(tag .. ".setName", "设置名称SUCCESS")
                        if btcore.advertising(1) == 0 then
                            btcore.setvisibility(0x11) -- 设置蓝牙可见性
                            log.info(tag .. ".getvisibility",
                                     btcore.getvisibility())
                            log.info(tag .. ".advertising",
                                     "打开广播SUCCESS")

                            -- 经典蓝牙播放音乐
                            msgRes, msgData = sys.waitUntil(
                                                  "BT_AVRCP_CONNECT_IND")
                            if msgRes == true and msgData.result == 0 then
                                log.info(tag .. ".connect",
                                         "蓝牙连接SUCCESS")
                                while true do
                                    btcore.setavrcpvol(100)
                                    sys.wait(waitTime)
                                    log.info(tag .. ".avrcp vol",
                                             btcore.getavrcpvol())
                                    sys.wait(waitTime)
                                    log.info(tag .. ".播放SUCCESS")
                                    btcore.setavrcpsongs(1) -- 播放
                                    sys.wait(waitTime)
                                    log.info(tag .. ".暂停SUCCESS")
                                    btcore.setavrcpsongs(0) -- 暂停
                                    sys.wait(waitTime)
                                    log.info(tag .. ".切换上一曲SUCCESS")
                                    btcore.setavrcpsongs(2) -- 上一曲
                                    sys.wait(waitTime)
                                    log.info(tag .. ".切换下一曲SUCCESS")
                                    btcore.setavrcpsongs(3) -- 下一曲
                                    sys.wait(waitTime)
                                end
                            else
                                log.error(tag .. ".connect", "连接FAIL")
                            end

                            --[[
                            -- 经典蓝牙通话
                            msgRes, msgData = sys.waitUntil("BT_HFP_CONNECT_IND")
                            if msgRes == true and msgData.result == 0 then
                                log.info(tag .. ".connect", "蓝牙连接SUCCESS")
                                while true do
                                    _, result = sys.waitUntil("BT_CALLSETUP_INCOMING")--蓝牙呼叫传入
                                    if result ~= 0 then
                                        return false
                                    end
                                    btcore.hfpcallanswer() --接听
                                    --btcore.hfpcallreject() --拒接
                                    sys.wait(1000)
                                    log.info(tag .. ".设置音量")
                                    btcore.sethfpvol(10) --设置音量
                                    sys.wait(waitTime)
                                    log.info(tag .. ".挂断")
                                    btcore.hfpcallhangup() --挂断
                                    sys.wait(waitTime)
                                    btcore.hfpcalldial("10086") --拨号
                                    sys.wait(waitTime)
                                    btcore.hfpcallhangup() --挂断
                                    sys.wait(waitTime)
                                    btcore.hfpcallredial() --重拨
                                    sys.wait(waitTime)
                                    btcore.hfpcallhangup() --挂断
                                    sys.wait(waitTime)
                                end
                            else
                                log.error(tag .. ".connect", "连接FAIL")
                            ]]
                        else
                            log.error(tag .. ".advertising", "打开广播FAIL")
                        end
                    else
                        log.error(tag .. ".setName", "设置名称FAIL")
                    end
                else
                    log.error(tag .. ".open", "打开经典蓝牙模式FAIL")
                end
            else
                log.error(tag .. ".open", "打开经典蓝牙模式FAIL")
            end
            sys.wait(waitTime)
        end
        btcore.close()
    elseif scanTest == true then
        local tag = "BluetoothTest.scanTest"
        local msgRes, msgData
        sys.wait(waitTime)
        if btcore.open(1) == 0 then
            msgRes, msgData = sys.waitUntil("BT_OPEN", waitTime)
            if msgRes == true and msgData == 0 then
                log.info(tag .. ".open", "打开蓝牙SUCCESS")
                btcore.setscanparam(1, 50 / 0.625, 100 / 0.625, 0, 0)
                if btcore.scan(1) == 0 then
                    msgRes, msgData = sys.waitUntil("BT_SCAN_CNF", 50000)
                    if msgRes == true and msgData == 0 then
                        log.info(tag .. ".scan", "打开扫描SUCCESS")
                        while true do
                            msgRes, msgData =
                                sys.waitUntil("BT_SCAN_IND", waitTime)
                            if not msgData then
                                log.error(tag .. ".scan",
                                          "没有扫描到蓝牙设备")
                            else
                                local deviceJsonInfo = json.encode(msgData)
                                log.info(tag .. ".deviceJsonInfo",
                                         deviceJsonInfo)
                            end
                        end
                    else
                        log.error(tag .. ".scan", "打开扫描FAIL")
                    end
                else
                    log.error(tag .. ".scan", "打开扫描FAIL")
                end
            else
                log.error(tag .. ".open", "打开蓝牙FAIL")
            end
        else
            log.error(tag .. ".open", "打开蓝牙FAIL")
        end
        btcore.scan(0)
        log.info(tag .. ".close", "关闭蓝牙扫描")
        sys.wait(waitTime)
        btcore.close()
        log.info(tag .. ".close", "关闭蓝牙")
        sys.wait(waitTime)
    end
end

sys.taskInit(function()
    sys.wait(waitTime)
    BluetoothTestTask()
end)

sys.init(0, 0)
sys.run()
