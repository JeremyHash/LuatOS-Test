-- LbsLocTest
-- Author:openluat
-- CreateDate:20211018
-- UpdateDate:20211018
module(..., package.seeall)

local tag = "LbsLocTest"

local function getWiFiLocCb(result, lat, lng)
    log.info(tag .. ".wifiTest.result", result)
    log.info(tag .. ".wifiTest.lat", lat)
    log.info(tag .. ".wifiTest.lng", lng)
    if result == 0 then
        log.info(tag .. ".wifiTest.getWiFiLocCb", "SUCCESS")
        outPutTestRes("LbsLocTest.wifiTest PASS")
    else
        log.info(tag .. ".wifiTest.getWiFiLocCb", "FAIL")
        outPutTestRes("LbsLocTest.wifiTest FAIL")
    end
    sys.publish("wifiTestFinished")
end

local function getCellLocCb(result, lat, lng)
    log.info("CellLocTest.getCellLocCb.result", result)
    log.info("CellLocTest.getCellLocCb.lat", lat)
    log.info("CellLocTest.getCellLocCb.lng", lng)
    if result == 0 then
        log.info(tag.. ".cellLocTest.getCellLocCb", "SUCCESS")
        outPutTestRes("LbsLocTest.cellTest PASS")
    else
        log.info(tag.. ".cellLocTest.getCellLocCb", "FAIL")
        outPutTestRes("LbsLocTest.cellTest FAIL")
    end
    sys.publish("cellTestFinished")
end

local function lbsLocTestTask()
    sys.wait(5000)
    wifiScan.request(function(result, cnt, apInfo)
        if result then
            log.info(tag .. ".wifiTest.scan", "SUCCESS")
            printTable(apInfo)
            log.info(tag, "开始WiFi定位")
            sys.publish("wifiTestFinished")
            lbsLoc.request(getWiFiLocCb, false, false, false, false, false,
                           false, apInfo)
        else
            log.info(tag .. ".wifiTest.scan", "FAIL")
            outPutTestRes("LbsLocTest.wifiTest FAIL")
            sys.publish("wifiTestFinished")
        end
    end, 30000)
    sys.waitUntil("wifiTestFinished")

    log.info("CellLocTest", "开始基站定位")
    lbsLoc.request(getCellLocCb)
    sys.waitUntil("cellTestFinished")


end

sys.taskInit(function()
    -- sys.waitUntil("IP_READY_IND")
    -- log.info(tag, "成功访问网络, LbsLoc测试开始")
    if testConfig.testMode == "single" then
        lbsLocTestTask()
    elseif testConfig.testMode == "loop" then
        while true do lbsLocTestTask() end
    end
end)
