-- commonTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "commonTest"

function test()
    if common == nil then
        log.error(tag, "this fireware is not support common")
        return
    end
    log.info(tag, "START")
    assert(common.ucs2ToAscii("0030003100320033003400350036003700380039") ==
               "0123456789", tag .. ".ucs2ToAscii ERROR")

    assert(common.nstrToUcs2Hex(
               "+0123456789+0123456789+0123456789+0123456789+0123456789") ==
               "002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039002B0030003100320033003400350036003700380039",
           tag .. ".nstrToUcs2Hex ERROR")

    res1, res2 = string.toHex(common.numToBcdNum("8618126324567F"))
    assert(res1 == "688121364265F7" and res2 == 7, tag .. ".numToBcdNum ERROR")

    assert(common.bcdNumToNum(string.fromHex("688121364265F7")) ==
               "8618126324567", tag .. ".bcdNumToNum ERROR")

    -- assert( common.ucs2ToGb2312(string.fromHex("xd98f2f66004e616755004300530032000f5cef7a167f017884768551b95b6c8f62633a4e470042003200330031003200167f017884764b6dd58b8551b95b")) == "fȡߡѴߡ" ,tag .. ". ERROR")

    res1, res2 = string.toHex(common.gb2312ToUcs2(string.fromHex(
                                                      "D5E2CAC7D2BBCCF555544638B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55435332B1E0C2EBB5C4B2E2CAD4C4DAC8DD")))
    assert(res1 ==
               "D98F2F66004E61675500540046003800167F017884768551B95B6C8F62633A4E5500430053003200167F017884764B6DD58B8551B95B" and
               res2 == 54, tag .. ".gb2312ToUcs2 ERROR")

    -- assert( common.ucs2beToGb2312(string.fromHex("8fd9662f4e006761005500430053003259277aef7f167801768451855bb98f6c63624e3a0047004200320033003100327f16780176846d4b8bd551855bb9")) == "这是一条UCS2大端编码的内容转换为GB2312编码的测试内容" ,tag .. ". ERROR")

    res1, res2 = string.toHex(common.gb2312ToUcs2be(string.fromHex(
                                                        "D5E2CAC7D2BBCCF555544638B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55435332B1E0C2EBB5C4B2E2CAD4C4DAC8DD")))
    assert(res1 ==
               "8FD9662F4E00676100550054004600387F167801768451855BB98F6C63624E3A00550043005300327F16780176846D4B8BD551855BB9" and
               res2 == 54, tag .. ".gb2312ToUcs2be ERROR")

    assert(common.ucs2ToUtf8(string.fromHex(
                                 "d98f2f66004e61675500430053003200167f017884768551b95b6c8f62633a4e5500540046003800167f017884764b6dd58b8551b95b")) ==
               "这是一条UCS2编码的内容转换为UTF8编码的测试内容",
           tag .. ".ucs2ToUtf8 ERROR")

    res1, res2 = string.toHex(common.utf8ToUcs2(
                                  "这是一条UTF8编码的内容转换为UCS2编码的测试内容"))
    assert(res1 ==
               "D98F2F66004E61675500540046003800167F017884768551B95B6C8F62633A4E5500430053003200167F017884764B6DD58B8551B95B" and
               res2 == 54, tag .. ".utf8ToUcs2 ERROR")

    assert(common.ucs2beToUtf8(string.fromHex(
                                   "8fd9662f4e00676100550043005300327f167801768451855bb98f6c63624e3a00550054004600387f16780176846d4b8bd551855bb9")) ==
               "这是一条UCS2编码的内容转换为UTF8编码的测试内容",
           tag .. ".ucs2beToUtf8 ERROR")

    res1, res2 = string.toHex(common.utf8ToUcs2be(
                                  "这是一条UTF8编码的内容转换为UCS2大端编码的测试内容"))
    assert(res1 ==
               "8FD9662F4E00676100550054004600387F167801768451855BB98F6C63624E3A005500430053003259277AEF7F16780176846D4B8BD551855BB9" and
               res2 == 58, tag .. ".utf8ToUcs2be ERROR")

    assert(common.utf8ToGb2312("utf8s") == "utf8s", tag .. ".utf8ToGb2312 ERROR")

    assert(common.gb2312ToUtf8(string.fromHex(
                                   "D5E2CAC7D2BBCCF5474232333132B1E0C2EBB5C4C4DAC8DDD7AABBBBCEAA55544638B1E0C2EBB5C4B2E2CAD4C4DAC8DD")) ==
               "这是一条GB2312编码的内容转换为UTF8编码的测试内容",
           tag .. ".gb2312ToUtf8 ERROR")

    table1 = common.timeZoneConvert(2020, 10, 14, 11, 24, 25, 8, 8)
    assert(
        table1["min"] == 24 and table1["day"] == 14 and table1["month"] == 10 and
            table1["sec"] == 25 and table1["hour"] == 11 and table1["year"] ==
            2020, tag .. ".timeZoneConvert ERROR")

    log.info(tag, "DONE")
end
