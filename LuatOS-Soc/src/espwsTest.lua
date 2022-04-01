local espwsTest = {}

local tag = "espwsTest"

function espwsTest.test()
    if espws == nil then
        log.error(tag, "this fireware is not support espws")
        return
    end
    log.info(tag, "START")
    local waitRes, data, client, len
    assert(wlan.init() == 0, tag .. ".init ERROR")
    assert(wlan.setMode(wlan.STATION) == 0, tag .. ".setMode ERROR")
    assert(wlan.connect("XXXXX", "XXXXXXXX") == 0, tag .. ".connect ERROR")
    waitRes, data = sys.waitUntil("WLAN_STA_CONNECTED", 10000)
    log.info(tag .. ".WLAN_STA_CONNECTED", waitRes, data)
    if waitRes == false then
        return
    end
    waitRes, data = sys.waitUntil("IP_READY", 10000)
    log.info(tag .. ".IP_READY", waitRes, data)
    if waitRes == false then
        return
    end
    local wsClient = espws.init("ws://airtest.openluat.com:2900/websocket")
    assert(type(wsClient) == "userdata", tag .. ".init ERROR")
    assert(espws.start(wsClient) == true, tag .. ".start ERROR")
    waitRes, data = sys.waitUntil("WS_CONNECT", 10000)
    log.info(tag .. ".WS_CONNECT", waitRes, data)
    if waitRes == false then
        return
    end
    for i = 1, 100 do
        assert(espws.send(wsClient, tag) == true, tag .. ".send ERROR")
        waitRes, client, data, len = sys.waitUntil("WS_EVENT_DATA")
        log.info(tag .. ".WS_EVENT_DATA", waitRes, client, data, len)
        assert(wsClient == client, tag .. ".client ERROR")
        assert(data == tag, tag .. ".data ERROR")
    end
    assert(espws.close(wsClient) == true, tag .. ".close ERROR")
    assert(espws.destory(wsClient) == true, tag .. ".destory ERROR")
    assert(wlan.disconnect() == 0, tag .. ".disconnect ERROR")
    waitRes, data = sys.waitUntil("WLAN_STA_DISCONNECTED", 10000)
    log.info(tag .. ".WLAN_STA_DISCONNECTED", waitRes, data)
    assert(wlan.stop() == 0, tag .. ".stop ERROR")
    assert(wlan.deinit() == 0, tag .. ".deinit ERROR")
    log.info(tag, "DONE")
end

return espwsTest
