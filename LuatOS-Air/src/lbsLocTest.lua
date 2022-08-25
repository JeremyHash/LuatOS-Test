-- LbsLocTest
-- Author:openluat
-- CreateDate:20211018
-- UpdateDate:20220825
module(..., package.seeall)

local tag = "LbsLocTest"

local function getWiFiLocCb(result, lat, lng)
    log.info(tag .. ".wifiLocTest.result", result)
    log.info(tag .. ".wifiLocTest.lat", lat)
    log.info(tag .. ".wifiLocTest.lng", lng)
    if result == 0 then
        log.info(tag .. ".wifiLocTest.getWiFiLocCb", "SUCCESS")
        outPutTestRes("LbsLocTest.wifiLocTest PASS")
    else
        log.info(tag .. ".wifiLocTest.getWiFiLocCb", "FAIL")
        outPutTestRes("LbsLocTest.wifiLocTest FAIL")
    end
    sys.publish("wifiLocTestFinished")
end

local function getCellLocCb(result, lat, lng)
    log.info(tag .. ".CellLocTest.getCellLocCb.result", result)
    log.info(tag .. ".CellLocTest.getCellLocCb.lat", lat)
    log.info(tag .. ".CellLocTest.getCellLocCb.lng", lng)
    if result == 0 then
        log.info(tag .. ".cellLocTest.getCellLocCb", "SUCCESS")
        outPutTestRes("LbsLocTest.cellTest PASS")
    else
        log.info(tag .. ".cellLocTest.getCellLocCb", "FAIL")
        outPutTestRes("LbsLocTest.cellTest FAIL")
    end
    sys.publish("cellLocTestFinished")
end

local function lbsLocTestTask()
    wifiScan.request(function(result, cnt, apInfo)
        if result then
            log.info(tag .. ".wifiLocTest.scan", "SUCCESS")
            printTable(apInfo)
            log.info(tag, "开始WiFi定位")
            lbsLoc.request(getWiFiLocCb, false, false, false, false, false, false, apInfo)
        else
            log.info(tag .. ".wifiLocTest.scan", "FAIL")
            outPutTestRes("LbsLocTest.wifiLocTest FAIL")
            sys.publish("wifiLocTestFinished")
        end
    end, 30000)
    sys.waitUntil("wifiLocTestFinished")

    log.info("CellLocTest", "开始基站定位")
    lbsLoc.request(getCellLocCb)
    sys.waitUntil("cellLocTestFinished")

end

function test()
    if lbsLoc == nil then
        log.error(tag, "this fireware is not support lbsLoc")
        return
    end
    local tag = "lbsLocTest"
    log.info(tag, "START")
    lbsLocTestTask()
    log.info(tag, "DONE")
end
