-- LteTest
-- Author:openluat
-- CreateDate:20211025
-- UpdateDate:20211025
module(..., package.seeall)

local function lteTestTask()
    local tag

    tag = "LteTest.CommonTest"
    if common.ucs2ToAscii("0030003100320033003400350036003700380039") ==
        "0123456789" then
        log.info("CommonTest.ucs2ToAscii", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.ucs2ToAscii PASS")
    else
        log.error("CommonTest.ucs2ToAscii", "FAIL")
        outPutTestRes("LteTest.CommonTest.ucs2ToAscii FAIL")
    end

    if common.nstrToUcs2Hex(
        "+0123456789+0123456789+0123456789+0123456789+0123456789") ==
        "002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039" then
        log.info("CommonTest.nstrToUcs2Hex", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.nstrToUcs2Hex PASS")
    else
        log.error("CommonTest.nstrToUcs2Hex", "FAIL")
        outPutTestRes("LteTest.CommonTest.nstrToUcs2Hex FAIL")
    end

    res1, res2 = string.toHex(common.numToBcdNum("8618126324567F"))
    if res1 == "688121364265F7" and res2 == 7 then
        log.info("CommonTest.numToBcdNum", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.numToBcdNum PASS")
    else
        log.error("CommonTest.numToBcdNum", "FAIL")
        outPutTestRes("LteTest.CommonTest.numToBcdNum FAIL")
    end

    if common.bcdNumToNum(string.fromHex("688121364265F7")) == "8618126324567" then
        log.info("CommonTest.bcdNumToNum", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.bcdNumToNum PASS")
    else
        log.error("CommonTest.bcdNumToNum", "FAIL")
        outPutTestRes("LteTest.CommonTest.bcdNumToNum FAIL")
    end

    -- if common.ucs2ToGb2312(string.fromHex("xd98f2f66004e616755004300530032000f5cef7a167f017884768551b95b6c8f62633a4e470042003200330031003200167f017884764b6dd58b8551b95b")) == "fȡߡѴߡ" then
    --     log.info("CommonTest.ucs2ToGb2312", "SUCCESS")
    --     outPutTestRes("LteTest.CommonTest.ucs2ToGb2312 PASS")
    -- else
    --     log.error("CommonTest.ucs2ToGb2312", "FAIL")
    --     log.info("CommonTest.ucs2ToGb2312",common.ucs2ToGb2312(string.fromHex("xd98f2f66004e616755004300530032000f5cef7a167f017884768551b95b6c8f62633a4e470042003200330031003200167f017884764b6dd58b8551b95b")))
    --     outPutTestRes("LteTest.CommonTest.ucs2ToGb2312 FAIL")
    -- end

    res1, res2 = string.toHex(common.gb2312ToUcs2(string.fromHex(
                                                      "D5E2CAC7D2BBCCF555544638B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55435332B1E0C2EBB5C4B2E2CAD4C4DAC8DD")))
    if res1 ==
        "D98F2F66004E61675500540046003800167F017884768551B95B6C8F62633A4E5500430053003200167F017884764B6DD58B8551B95B" and
        res2 == 54 then
        log.info("CommonTest.gb2312ToUcs2", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.gb2312ToUcs2 PASS")
    else
        log.error("CommonTest.gb2312ToUcs2", "FAIL")
        outPutTestRes("LteTest.CommonTest.gb2312ToUcs2 FAIL")
    end

    -- if common.ucs2beToGb2312(string.fromHex("8fd9662f4e006761005500430053003259277aef7f167801768451855bb98f6c63624e3a0047004200320033003100327f16780176846d4b8bd551855bb9")) == "这是一条UCS2大端编码的内容转换为GB2312编码的测试内容" then
    --     log.info("CommonTest.ucs2beToGb2312", "SUCCESS")
    --     outPutTestRes("LteTest.CommonTest.ucs2beToGb2312 PASS")
    -- else
    --     log.error("CommonTest.ucs2beToGb2312", "FAIL")
    --     log.info("CommonTest.ucs2beToGb2312",common.ucs2beToGb2312(string.fromHex("8fd9662f4e006761005500430053003259277aef7f167801768451855bb98f6c63624e3a0047004200320033003100327f16780176846d4b8bd551855bb9")) )
    --     outPutTestRes("LteTest.CommonTest.ucs2beToGb2312 FAIL")
    -- end

    res1, res2 = string.toHex(common.gb2312ToUcs2be(string.fromHex(
                                                        "D5E2CAC7D2BBCCF555544638B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55435332B1E0C2EBB5C4B2E2CAD4C4DAC8DD")))
    if res1 ==
        "8FD9662F4E00676100550054004600387F167801768451855BB98F6C63624E3A00550043005300327F16780176846D4B8BD551855BB9" and
        res2 == 54 then
        log.info("CommonTest.gb2312ToUcs2be", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.gb2312ToUcs2be PASS")
    else
        log.error("CommonTest.gb2312ToUcs2be", "FAIL")
        outPutTestRes("LteTest.CommonTest.gb2312ToUcs2be FAIL")
    end

    if common.ucs2ToUtf8(string.fromHex(
                             "d98f2f66004e61675500430053003200167f017884768551b95b6c8f62633a4e5500540046003800167f017884764b6dd58b8551b95b")) ==
        "这是一条UCS2编码的内容转换为UTF8编码的测试内容" then
        log.info("CommonTest.ucs2ToUtf8", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.ucs2ToUtf8 PASS")
    else
        log.error("CommonTest.ucs2ToUtf8", "FAIL")
        outPutTestRes("LteTest.CommonTest.ucs2ToUtf8 FAIL")
    end

    res1, res2 = string.toHex(common.utf8ToUcs2(
                                  "这是一条UTF8编码的内容转换为UCS2编码的测试内容"))
    if res1 ==
        "D98F2F66004E61675500540046003800167F017884768551B95B6C8F62633A4E5500430053003200167F017884764B6DD58B8551B95B" and
        res2 == 54 then
        log.info("CommonTest.utf8ToUcs2", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.utf8ToUcs2 PASS")
    else
        log.error("CommonTest.utf8ToUcs2", "FAIL")
        outPutTestRes("LteTest.CommonTest.utf8ToUcs2 FAIL")
    end

    if common.ucs2beToUtf8(string.fromHex(
                               "8fd9662f4e00676100550043005300327f167801768451855bb98f6c63624e3a00550054004600387f16780176846d4b8bd551855bb9")) ==
        "这是一条UCS2编码的内容转换为UTF8编码的测试内容" then
        log.info("CommonTest.ucs2beToUtf8", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.ucs2beToUtf8 PASS")
    else
        log.error("CommonTest.ucs2beToUtf8", "FAIL")
        outPutTestRes("LteTest.CommonTest.ucs2beToUtf8 FAIL")
    end

    res1, res2 = string.toHex(common.utf8ToUcs2be(
                                  "这是一条UTF8编码的内容转换为UCS2大端编码的测试内容"))
    if res1 ==
        "8FD9662F4E00676100550054004600387F167801768451855BB98F6C63624E3A005500430053003259277AEF7F16780176846D4B8BD551855BB9" and
        res2 == 58 then
        log.info("CommonTest.utf8ToUcs2be", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.utf8ToUcs2be PASS")
    else
        log.error("CommonTest.utf8ToUcs2be", "FAIL")
        outPutTestRes("LteTest.CommonTest.utf8ToUcs2be FAIL")
    end

    if common.utf8ToGb2312("utf8s") == "utf8s" then
        log.info("CommonTest.utf8ToGb2312", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.utf8ToGb2312 PASS")
    else
        log.error("CommonTest.utf8ToGb2312", "FAIL")
        outPutTestRes("LteTest.CommonTest.utf8ToGb2312 FAIL")
    end

    if common.gb2312ToUtf8(string.fromHex(
                               "D5E2CAC7D2BBCCF5474232333132B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55544638B1E0C2EBB5C4B2E2CAD4C4DAC8DD")) ==
        "这是一条GB2312编码的内容转换为UTF8编码的测试内容" then
        log.info("CommonTest.gb2312ToUtf8", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.gb2312ToUtf8 PASS")
    else
        log.error("CommonTest.gb2312ToUtf8", "FAIL")
        outPutTestRes("LteTest.CommonTest.gb2312ToUtf8 FAIL")
    end

    table1 = common.timeZoneConvert(2020, 10, 14, 11, 24, 25, 8, 8)
    if table1["min"] == 24 and table1["day"] == 14 and table1["month"] == 10 and
        table1["sec"] == 25 and table1["hour"] == 11 and table1["year"] == 2020 then
        log.info("CommonTest.timeZoneConvert", "SUCCESS")
        outPutTestRes("LteTest.CommonTest.timeZoneConvert PASS")
    else
        log.error("CommonTest.timeZoneConvert", "FAIL")
        outPutTestRes("LteTest.CommonTest.timeZoneConvert FAIL")
    end

    tag = "LteTest.NtpTest"

    ntp.setServers({"www.baidu.com", "www.sina.com"})
    local ntpServers = ntp.getServers()
    if ntpServers[1] == "www.baidu.com" and ntpServers[2] == "www.sina.com" then
        log.info("NtpTest.Servers  SUCCESS")
        outPutTestRes("LteTest.NtpTest.servers  PASS")
    else
        log.info("NtpTest.Servers  FAIL")
        outPutTestRes("LteTest.NtpTest.servers  FAIL")
    end

    tag = "LteTest.TableTest"
    local fruits = {"banana", "orange", "apple"}
    log.info("TableTest.Concat", table.concat(fruits))
    if table.concat(fruits) == "bananaorangeapple" then
        log.info("TableTest.concat1  SUCCESS")
        outPutTestRes("LteTest.TableTest.concat1  PASS")
    else
        log.info("TableTest.concat1  FAIL")
        outPutTestRes("LteTest.TableTest.concat1  FAIL")
    end

    if table.concat(fruits, ", ") == "banana, orange, apple" then
        log.info("TableTest.concat2  SUCCESS")
        outPutTestRes("LteTest.TableTest.concat2  PASS")
    else
        log.info("TableTest.concat2  FAIL")
        outPutTestRes("LteTest.TableTest.concat2  FAIL")
    end

    if table.concat(fruits, ", ", 2, 3) == "orange, apple" then
        log.info("TableTest.concat3  SUCCESS")
        outPutTestRes("LteTest.TableTest.concat3  PASS")
    else
        log.info("TableTest.concat3  FAIL")
        outPutTestRes("LteTest.TableTest.concat3  FAIL")
    end

    table.insert(fruits, "mango")
    if fruits[4] == "mango" then
        log.info("TableTest.insert1  SUCCESS")
        outPutTestRes("LteTest.TableTest.insert1  PASS")
    else
        log.info("TableTest.insert1  FAIL")
        outPutTestRes("LteTest.TableTest.insert1  FAIL")
    end

    table.insert(fruits, 2, "grapes")
    if fruits[2] == "grapes" then
        log.info("TableTest.insert2  SUCCESS")
        outPutTestRes("LteTest.TableTest.insert2  PASS")
    else
        log.info("TableTest.insert2  FAIL")
        outPutTestRes("LteTest.TableTest.insert2  FAIL")
    end

    lastest = table.remove(fruits)
    if fruits[5] == nil then
        log.info("TableTest.remove1  SUCCESS")
        outPutTestRes("LteTest.TableTest.remov1  PASS")
    else
        log.info("TableTest.remove1  FAIL")
        outPutTestRes("LteTest.TableTest.remove1  FAIL")
    end

    firstest = table.remove(fruits, 1)
    if fruits[1] == "grapes" then
        log.info("TableTest.remove2  SUCCESS")
        outPutTestRes("LteTest.TableTest.remove2  PASS")
    else
        log.info("TableTest.remove2  FAIL")
        outPutTestRes("LteTest.TableTest.remove2   FAIL")
    end

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
