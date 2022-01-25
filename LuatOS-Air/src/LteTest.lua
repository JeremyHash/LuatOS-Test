-- LteTest
-- Author:openluat
-- CreateDate:20211025
-- UpdateDate:20211025
module(..., package.seeall)

local function lteTestTask()
    local tag

    

    tag = "LteTest.SimTest"
    if sim.getIccid() == nil then
        log.error("SimTest.GetIccid", "FAIL", "查询失败")
        outPutTestRes("LteTest.SimTest.getIccid   FAIL")
    else
        log.info("SimTest.GetIccid", "SUCCESS", sim.getIccid())
        outPutTestRes("LteTest.SimTest.getIccid   PASS")
    end

    if sim.getImsi() == nil then
        log.error("SimTest.GetImsi", "FAIL")
        outPutTestRes("LteTest.SimTest.getImsi   FAIL")
    else
        log.info("SimTest.GetIccid", "SUCCESS", sim.getIccid())
        outPutTestRes("LteTest.SimTest.getImsi   PASS")
    end

    if sim.getMcc() == "" then
        log.error("SimTest.GetMcc", "FAIL")
        outPutTestRes("LteTest.SimTest.getMcc   FAIL")
    else
        log.info("SimTest.GetIccid", "SUCCESS", sim.getIccid())
        outPutTestRes("LteTest.SimTest.getMcc   PASS")
    end

    if sim.getMnc() == "" then
        log.error("SimTest.GetMnc", "FAIL")
        outPutTestRes("LteTest.SimTest.getMnc   FAIL")
    else
        log.info("SimTest.GetIccid", "SUCCESS", sim.getIccid())
        outPutTestRes("LteTest.SimTest.getMnc   PASS")
    end

    if sim.getMnc() == "" then
        log.error("SimTest.GetMnc", "FAIL")
        outPutTestRes("LteTest.SimTest.getMnc   FAIL")
    else
        log.info("SimTest.GetIccid", "SUCCESS", sim.getIccid())
        outPutTestRes("LteTest.SimTest.getMnc   PASS")
    end

    tag = "LteTest.JsonTest"

    local torigin = {
        KEY1 = "VALUE1",
        KEY2 = "VALUE2",
        KEY3 = "VALUE3",
        KEY4 = "VALUE4",
        KEY5 = {KEY5_1 = "VALUE5_1", KEY5_2 = "VALUE5_2"},
        KEY6 = {1, 2, 3}
    }
    local jsondata = json.encode(torigin)
    if type(jsondata) == "string" then
        log.info("LteTest.JsonTest.encode", "SUCCESS")
        outPutTestRes("LteTest.JsonTest.encode   PASS")
    else
        log.error("LteTest.JsonTest.encode", "FAIL")
        outPutTestRes("LteTest.JsonTest.encode   FAIL")
    end
    local origin =
        "{\"KEY3\":\"VALUE3\",\"KEY4\":\"VALUE4\",\"KEY2\":\"VALUE2\",\"KEY1\":\"VALUE1\",\"KEY5\":{\"KEY5_2\":\"VALUE5_2\",\"KEY5_1\":\"VALUE5_1\"},\"KEY6\":[1,2,3]}"
    local tjsondata, result, errinfo = json.decode(origin)
    if result and type(tjsondata) == "table" then
        log.info("LteTest.JsonTest.decode", "SUCCESS")
        outPutTestRes("LteTest.JsonTest.decode   PASS")
    else
        log.error("LteTest.JsonTest.decode", "FAIL")
        outPutTestRes("LteTest.JsonTest.decode   FAIL")
    end

    tag = "LteTest.RtosTest"

    local testPath = "/RtosTestPath"
    if rtos.make_dir(testPath) then
        log.info("LteTest.RtosTest.MakeDir", "SUCCESS")
        outPutTestRes("LteTest.RtosTest.MakeDir   PASS")
    else
        log.error("LteTest.RtosTest.MakeDir", "FAIL")
        outPutTestRes("LteTest.RtosTest.MakeDir   FAIL")
    end
    if rtos.remove_dir(testPath) then
        log.info("LteTest.RtosTest.RemoveDir", "SUCCESS")
        outPutTestRes("LteTest.RtosTest.RemoveDir   PASS")
    else
        log.error("LteTest.RtosTest.RemoveDir", "FAIL")
        outPutTestRes("LteTest.RtosTest.RemoveDir   FAIL")
    end
    local res1, res2 = string.toHex(rtos.toint64("12345678", "little"))
    if res1 == "4E61BC0000000000" and res2 == 8 then
        log.info("LteTest.RtosTest.Toint64.little", "SUCCESS")
        outPutTestRes("LteTest.RtosTest.Toint64.little  PASS")
    else
        log.error("LteTest.RtosTest.Toint64.little", "FAIL")
        outPutTestRes("LteTest.RtosTest.Toint64.little   FAIL")
    end
    res1, res2 = string.toHex(rtos.toint64("12345678", "big"))
    if res1 == "0000000000BC614E" and res2 == 8 then
        log.info("LteTest.RtosTest.Toint64.big", "SUCCESS")
        outPutTestRes("LteTest.RtosTest.Toint64.big  PASS")
    else
        log.error("LteTest.RtosTest.Toint64.big", "FAIL")
        outPutTestRes("LteTest.RtosTest.Toint64.big   FAIL")
    end

    tag = "LteTest.MathTest"

    if math.abs(-10086) == 10086 then
        log.info("LteTest.MathTest.Abs", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Abs  PASS")
    else
        log.error("LteTest.MathTest.Abs", "FAIL")
        outPutTestRes("LteTest.MathTest.Abs   FAIL")
    end
    if math.fmod(10, 3) == 1 then
        log.info("LteTest.MathTest.Fmod", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Fmod  PASS")
    else
        log.error("LteTest.MathTest.Fmod", "FAIL")
        outPutTestRes("LteTest.MathTest.Fmod   FAIL")
    end
    if type(math.huge) == "number" then
        log.info("LteTest.MathTest.Huge", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Huge  PASS")
    else
        log.error("LteTest.MathTest.Huge", "FAIL")
        outPutTestRes("LteTest.MathTest.Huge   FAIL")
    end
    if type(math.pi) == "number" then
        log.info("LteTest.MathTest.Pi", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Pi  PASS")
    else
        log.error("LteTest.MathTest.Pi", "FAIL")
        outPutTestRes("LteTest.MathTest.Pi   FAIL")
    end
    if math.sqrt(9) == 3 then
        log.info("LteTest.MathTest.Sqrt", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Sqrt  PASS")
    else
        log.error("LteTest.MathTest.Sqrt", "FAIL")
        outPutTestRes("LteTest.MathTest.Sqrt   FAIL")
    end
    if math.ceil(101.456) == 102 then
        log.info("LteTest.MathTest.Ceil", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Ceil  PASS")
    else
        log.error("LteTest.MathTest.Ceil", "FAIL")
        outPutTestRes("LteTest.MathTest.Ceil   FAIL")
    end
    if math.floor(101.456) == 101 then
        log.info("LteTest.MathTest.Floor", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Floor  PASS")
    else
        log.error("LteTest.MathTest.Floor", "FAIL")
        outPutTestRes("LteTest.MathTest.Floor   FAIL")
    end
    if math.max(1, 2, 3, 4.15, 5.78) == 5.78 then
        log.info("LteTest.MathTest.Max", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Max  PASS")
    else
        log.error("LteTest.MathTest.Max", "FAIL")
        outPutTestRes("LteTest.MathTest.Max   FAIL")
    end
    if math.min(1, 2, 3, 4.15, 5.78) == 1 then
        log.info("LteTest.MathTest.Min", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Min  PASS")
    else
        log.error("LteTest.MathTest.Min", "FAIL")
        outPutTestRes("LteTest.MathTest.Min   FAIL")
    end
    res1, res2 = math.modf(1.15)
    if res1 == 1 then
        log.info("LteTest.MathTest.Modf", "SUCCESS")
        outPutTestRes("LteTest.MathTest.Modf  PASS")
    else
        log.error("LteTest.MathTest.Modf", "FAIL")
        outPutTestRes("LteTest.MathTest.Modf   FAIL")
    end

end

sys.taskInit(function()
    local tag = "LteTest"
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Lte测试开始")
    if testConfig.testMode == "single" then
        lteTestTask()
    elseif testConfig.testMode == "loop" then
        while true do
            lteTestTask()
            sys.wait(10)
        end
    end
end)
