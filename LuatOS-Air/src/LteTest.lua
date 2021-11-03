-- LteTest
-- Author:openluat
-- CreateDate:20211025
-- UpdateDate:20211025
module(..., package.seeall)

local function lteTestTask()
    local tag
    tag = "LteTest.BitTest"
    -- 左移运算
    -- 0001 -> 0100 
    for i = 0, 31 do
        local res = bit.bit(i)
        if res == 2 ^ i then
            log.info("BitTest.bit", "SUCCESS")
            outPutTestRes("LteTest.BitTest.left PASS")
        else
            log.info("BitTest.bit", "FAIL")
            outPutTestRes("LteTest.BitTest.left FAIL")
        end
    end

    -- 测试位数是否被置1
    -- 第一个参数是是测试数字，第二个是测试位置。从右向左数0到7。是1返回true，否则返回false
    -- 0101
    for i = 0, 31 do
        if bit.isset(0xFFFFFFFF, i) == true then
            log.info("BitTest.isset", "SUCCESS")
            outPutTestRes("LteTest.BitTest.isset1 PASS")
        else
            log.error("BitTest.isset", "FAIL")
            outPutTestRes("LteTest.BitTest.isset1 FAIL")
        end
        if bit.isset(0x00000000, i) == false then
            log.info("BitTest.isset", "SUCCESS")
            outPutTestRes("LteTest.BitTest.isset2 PASS")
        else
            log.error("BitTest.isset", "FAIL")
            outPutTestRes("LteTest.BitTest.isset2 FAIL")
        end
    end

    -- 测试位数是否被置0
    for i = 0, 31 do
        if bit.isclear(0xFFFFFFFF, i) == false then
            log.info("BitTest.isclear", "SUCCESS")
            outPutTestRes("LteTest.BitTest.isclear1 PASS")
        else
            log.error("BitTest.isclear", "FAIL")
            outPutTestRes("LteTest.BitTest.isclear1 FAIL")
        end
        if bit.isclear(0x00000000, i) == true then
            log.info("BitTest.isclear", "SUCCESS")
            outPutTestRes("LteTest.BitTest.isclear2 PASS")
        else
            log.error("BitTest.isclear", "FAIL")
            outPutTestRes("LteTest.BitTest.isclear2 FAIL")
        end
    end

    -- 在相应的位数置1
    -- 0000 -> 1111
    if bit.set(0, 0, 1, 2, 3, 4, 5, 6, 7) == 255 then
        log.info("BitTest.set", "SUCCESS")
        outPutTestRes("LteTest.BitTest.set1 PASS")
    else
        log.error("BitTest.set", "FAIL")
        outPutTestRes("LteTest.BitTest.set1 FAIL")
    end

    if bit.set(0, 6, 3, 2, 1, 7, 5, 0, 4) == 255 then
        log.info("BitTest.set", "SUCCESS")
        outPutTestRes("LteTest.BitTest.set2 PASS")
    else
        log.error("BitTest.set", "FAIL")
        outPutTestRes("LteTest.BitTest.set2 FAIL")
    end

    -- 在相应的位置置0
    -- 0101 -> 0000
    if bit.clear(0xFF, 0, 1, 2, 3, 4, 5, 6, 7) == 0 then
        log.info("BitTest.clear", "SUCCESS")
        outPutTestRes("LteTest.BitTest.clear1 PASS")
    else
        log.error("BitTest.clear", "FAIL")
        outPutTestRes("LteTest.BitTest.clear1 FAIL")
    end

    if bit.clear(0xFF, 6, 3, 2, 1, 7, 5, 0, 4) == 0 then
        log.info("BitTest.clear", "SUCCESS")
        outPutTestRes("LteTest.BitTest.clear2 PASS")
    else
        log.error("BitTest.clear", "FAIL")
        outPutTestRes("LteTest.BitTest.clear2 FAIL")
    end

    -- 按位取反
    -- 0101 -> 1010
    if bit.bnot(0xFFFFFFFF) == 0 then
        log.info("BitTest.bnot", "SUCCESS")
        outPutTestRes("LteTest.BitTest.bnot1 PASS")
    else
        log.error("BitTest.bnot", "FAIL")
        outPutTestRes("LteTest.BitTest.bnot1 FAIL")
    end
    if bit.bnot(0x00000000) == 0xFFFFFFFF then
        log.info("BitTest.bnot", "SUCCESS")
        outPutTestRes("LteTest.BitTest.bnot2 PASS")
    else
        log.error("BitTest.bnot", "FAIL")
        outPutTestRes("LteTest.BitTest.bnot2 FAIL")
    end
    if bit.bnot(0xF0F0F0F0) == 0x0F0F0F0F then
        log.info("BitTest.bnot", "SUCCESS")
        outPutTestRes("LteTest.BitTest.bnot3 PASS")
    else
        log.error("BitTest.bnot", "FAIL")
        outPutTestRes("LteTest.BitTest.bnot3 FAIL")
    end

    -- 与
    -- 0001 && 0001 -> 0001
    if bit.band(0xAAA, 0xAA0, 0xA00) == 0xA00 then
        log.info("BitTest.band", "SUCCESS")
        outPutTestRes("LteTest.BitTest.band PASS")
    else
        log.error("BitTest.band", "FAIL")
        outPutTestRes("LteTest.BitTest.band FAIL")
    end

    -- 或
    -- 0001 | 0010 -> 0011
    if bit.bor(0xA00, 0x0A0, 0x00A) == 0xAAA then
        log.info("BitTest.bor", "SUCCESS")
        outPutTestRes("LteTest.BitTest.bor PASS")
    else
        log.error("BitTest.bor", "FAIL")
        outPutTestRes("LteTest.BitTest.bor FAIL")
    end

    -- 异或,相同为0，不同为1
    -- 0001 ⊕ 0010 -> 0011
    if bit.bxor(0x01, 0x02, 0x04, 0x08) == 0x0F then
        log.info("BitTest.bxor", "SUCCESS")
        outPutTestRes("LteTest.BitTest.bxor PASS")
    else
        log.error("BitTest.bxor", "FAIL")
        outPutTestRes("LteTest.BitTest.bxor FAIL")
    end

    -- 逻辑左移
    -- 0001 -> 0100
    if bit.lshift(0xFFFFFFFF, 1) == -2 then
        log.info("BitTest.lshift", "SUCCESS")
        outPutTestRes("LteTest.BitTest.lshift PASS")
    else
        log.error("BitTest.lshift", "FAIL")
        outPutTestRes("LteTest.BitTest.lshift FAIL")
    end

    -- 逻辑右移，“001”
    -- 0100 -> 0001
    if bit.rshift(0xFFFFFFFF, 1) == 0x7FFFFFFF then
        log.info("BitTest.rshift", "SUCCESS")
        outPutTestRes("LteTest.BitTest.rshift PASS")
    else
        log.error("BitTest.rshift", "FAIL")
        outPutTestRes("LteTest.BitTest.rshift FAIL")
    end

    -- 算数右移，左边添加的数与符号有关
    -- 0010 -> 0000
    if bit.arshift(0xFFFFFFFF, 1) == -1 then
        log.info("BitTest.arshift", "SUCCESS")
        outPutTestRes("LteTest.BitTest.arshift PASS")
    else
        log.error("BitTest.arshift", "FAIL")
        outPutTestRes("LteTest.BitTest.arshift FAIL")
    end

    tag = "LteTest.PackTest"
    local res1, res2 = string.toHex(pack.pack(">H", 0x3234))
    if res1 == "3234" and res2 == 2 then
        log.info("PackTest1", "SUCCESS")
        outPutTestRes("LteTest.PackTest1 PASS")
    else
        log.info("PackTest1", "FAIL")
        outPutTestRes("LteTest.PackTest1 FAIL")
    end

    local res1, res2 = string.toHex(pack.pack("<H", 0x3234))
    if res1 == "3432" and res2 == 2 then
        log.info("PackTest2", "SUCCESS")
        outPutTestRes("LteTest.PackTest2 PASS")
    else
        log.info("PackTest2", "FAIL")
        outPutTestRes("LteTest.PackTest2 FAIL")
    end

    local res1, res2 = string.toHex(pack.pack(">AHb", "LUAT", 100, 10))
    if res1 == "4C55415400640A" and res2 == 7 then
        log.info("PackTest3", "SUCCESS")
        outPutTestRes("LteTest.PackTest3 PASS")
    else
        log.info("PackTest3", "FAIL")
        outPutTestRes("LteTest.PackTest3 FAIL")
    end

    local stringtest = pack.pack(">AHb", "luat", 999, 10)
    local res1, res2, res3 = pack.unpack(string.sub(stringtest, 5, -1), ">Hb")
    if res1 == 4 and res2 == 999 and res3 == 10 then
        log.info("PackTest4", "SUCCESS")
        outPutTestRes("LteTest.PackTest4 PASS")
    else
        log.info("PackTest4", "FAIL")
        outPutTestRes("LteTest.PackTest4 FAIL")
    end

    tag = "LteTest.StringTest"
    local testStr = "Luat is very NB,NB (10086)"

    if string.upper(testStr) == "LUAT IS VERY NB,NB (10086)" then
        log.info("StringTest.upper", "SUCCESS")
        outPutTestRes("LteTest.StringTest.upper PASS")
    else
        log.error("StringTest.upper", "FAIL")
        outPutTestRes("LteTest.StringTest.upper FAIL")
    end

    if string.lower(testStr) == "luat is very nb,nb (10086)" then
        log.info("StringTest.lower", "SUCCESS")
        outPutTestRes("LteTest.StringTest.lower PASS")
    else
        log.error("StringTest.lower", "FAIL")
        outPutTestRes("LteTest.StringTest.lower FAIL")
    end

    local res1, res2 = string.gsub(testStr, "L%w%w%w", "AirM2M")
    if res1 == "AirM2M is very NB,NB (10086)" then
        log.info("StringTest.gsub", "SUCCESS")
        outPutTestRes("LteTest.StringTest.gsub PASS")
    else
        log.error("StringTest.gsub", "FAIL")
        outPutTestRes("LteTest.StringTest.gsub FAIL")
    end

    local res1, res2 = string.find(testStr, "NB", 1, true)
    if res1 == 14 and res2 == 15 then
        log.info("StringTest.find1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.find1 PASS")
    else
        log.error("StringTest.find1", "FAIL")
        outPutTestRes("LteTest.StringTest.find1 FAIL")
    end

    local res1, res2 = string.find(testStr, "N%w", 16, false)
    if res1 == 17 and res2 == 18 then
        log.info("StringTest.find2", "SUCCESS")
        outPutTestRes("LteTest.StringTest.find2 PASS")
    else
        log.error("StringTest.find2", "FAIL")
        outPutTestRes("LteTest.StringTest.find2 FAIL")
    end

    if string.reverse(testStr) == ")68001( BN,BN yrev si tauL" then
        log.info("StringTest.reverse", "SUCCESS")
        outPutTestRes("LteTest.StringTest.reverse PASS")
    else
        log.error("StringTest.reverse", "FAIL")
        outPutTestRes("LteTest.StringTest.reverse FAIL")
    end

    local i = 43981
    if string.format("This is %d test string : %s", i, testStr) ==
        "This is 43981 test string : Luat is very NB,NB (10086)" then
        log.info("StringTest.format1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.format1 PASS")
    else
        log.error("StringTest.format1", "FAIL")
        outPutTestRes("LteTest.StringTest.format1 FAIL")
    end

    if string.format("%d(Hex) = %x / %X", i, i, i) == "43981(Hex) = abcd / ABCD" then
        log.info("StringTest.format2", "SUCCESS")
        outPutTestRes("LteTest.StringTest.format2 PASS")
    else
        log.error("StringTest.format2", "FAIL")
        outPutTestRes("LteTest.StringTest.format2 FAIL")
    end

    if string.char(33, 48, 49, 50, 97, 98, 99) == "!012abc" then
        log.info("StringTest.Char", "SUCCESS")
        outPutTestRes("LteTest.StringTest.Char PASS")
    else
        log.error("StringTest.Char", "FAIL")
        outPutTestRes("LteTest.StringTest.Char FAIL")
    end

    if string.byte("abc", 1) == 97 then
        log.info("StringTest.Byte1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.Byte1 PASS")
    else
        log.error("StringTest.Byte1", "FAIL")
        outPutTestRes("LteTest.StringTest.Byte1 FAIL")
    end

    if string.byte("abc", 2) == 98 then
        log.info("StringTest.Byte2", "SUCCESS")
        outPutTestRes("LteTest.StringTest.Byte2 PASS")
    else
        log.error("StringTest.Byte2", "FAIL")
        outPutTestRes("LteTest.StringTest.Byte2 FAIL")
    end

    if string.byte("abc", 3) == 99 then
        log.info("StringTest.Byte3", "SUCCESS")
        outPutTestRes("LteTest.StringTest.Byte3 PASS")
    else
        log.error("StringTest.Byte3", "FAIL")
        outPutTestRes("LteTest.StringTest.Byte3 FAIL")
    end

    if string.len(testStr) == 26 then
        log.info("StringTest.len", "SUCCESS")
        outPutTestRes("LteTest.StringTest.len PASS")
    else
        log.error("StringTest.len", "FAIL")
        outPutTestRes("LteTest.StringTest.len FAIL")
    end

    if string.rep(testStr, 2) ==
        "Luat is very NB,NB (10086)Luat is very NB,NB (10086)" then
        log.info("StringTest.rep", "SUCCESS")
        outPutTestRes("LteTest.StringTest.rep PASS")
    else
        log.error("StringTest.rep", "FAIL")
        outPutTestRes("LteTest.StringTest.rep FAIL")
    end

    if string.match(testStr, "Luat (..) very NB") == "is" then
        log.info("StringTest.match", "SUCCESS")
        outPutTestRes("LteTest.StringTest.match PASS")
    else
        log.error("StringTest.match", "FAIL")
        outPutTestRes("LteTest.StringTest.match FAIL")
    end

    if string.sub(testStr, 1, 4) == "Luat" then
        log.info("StringTest.sub", "SUCCESS")
        outPutTestRes("LteTest.StringTest.sub PASS")
    else
        log.error("StringTest.sub", "FAIL")
        outPutTestRes("LteTest.StringTest.sub FAIL")
    end

    local res1, res2 = string.toHex(testStr)
    if res1 == "4C7561742069732076657279204E422C4E422028313030383629" and res2 ==
        26 then
        log.info("StringTest.toHex1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.toHex1 PASS")
    else
        log.error("StringTest.toHex1", "FAIL")
        outPutTestRes("LteTest.StringTest.toHex1 FAIL")
    end

    local res1, res2 = string.toHex(testStr, ",")
    if res1 ==
        "4C,75,61,74,20,69,73,20,76,65,72,79,20,4E,42,2C,4E,42,20,28,31,30,30,38,36,29," and
        res2 == 26 then
        log.info("StringTest.toHex2", "SUCCESS")
        outPutTestRes("LteTest.StringTest.toHex2 PASS")
    else
        log.error("StringTest.toHex2", "FAIL")
        outPutTestRes("LteTest.StringTest.toHex2 FAIL")
    end

    local res1, res2 = string.fromHex("313233616263")
    if res1 == "123abc" and res2 == 6 then
        log.info("StringTest.fromHex", "SUCCESS")
        outPutTestRes("LteTest.StringTest.fromHex PASS")
    else
        log.error("StringTest.fromHex", "FAIL")
        outPutTestRes("LteTest.StringTest.fromHex FAIL")
    end

    if string.utf8Len("Luat中国こにちはПривет🤣❤💚☢") == 20 then
        log.info("StringTest.utf8Len", "SUCCESS")
        outPutTestRes("LteTest.StringTest.utf8Len PASS")
    else
        log.error("StringTest.utf8Len", "FAIL")
        outPutTestRes("LteTest.StringTest.utf8Len FAIL")
    end

    if string.rawurlEncode(
        "####133Luat中国こにちはПривет🤣❤💚☢") ==
        "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2" then
        log.info("StringTest.rawurlEncode", "SUCCESS")
        outPutTestRes("LteTest.StringTest.rawurlEncode PASS")
    else
        log.error("StringTest.rawurlEncode", "FAIL")
        outPutTestRes("LteTest.StringTest.rawurlEncode FAIL")
    end

    if string.urlEncode(
        "####133Luat中国こにちはПривет🤣❤💚☢") ==
        "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2" then
        log.info("StringTest.urlEncode", "SUCCESS")
        outPutTestRes("LteTest.StringTest.urlEncode PASS")
    else
        log.error("StringTest.urlEncode", "FAIL")
        outPutTestRes("LteTest.StringTest.urlEncode FAIL")
    end

    if string.formatNumberThousands(1234567890) == "1,234,567,890" then
        log.info("StringTest.formatNumberThousands", "SUCCESS")
        outPutTestRes("LteTest.StringTest.formatNumberThousands PASS")
    else
        log.error("StringTest.formatNumberThousands", "FAIL")
        outPutTestRes("LteTest.StringTest.formatNumberThousands FAIL")
    end

    local splitTable = string.split("Luat,is,very,nb", ",")
    if splitTable[1] == "Luat" and splitTable[2] == "is" and splitTable[3] ==
        "very" and splitTable[4] == "nb" then
        log.info("StringTest.split", "SUCCESS")
        outPutTestRes("LteTest.StringTest.split PASS")
    else
        log.error("StringTest.split", "FAIL")
        outPutTestRes("LteTest.StringTest.split FAIL")
    end

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

    local torigin =
    {
        KEY1 = "VALUE1",
        KEY2 = "VALUE2",
        KEY3 = "VALUE3",
        KEY4 = "VALUE4",
        KEY5 = {KEY5_1 = "VALUE5_1", KEY5_2 = "VALUE5_2"},
        KEY6 = {1, 2, 3},
    }
    local jsondata = json.encode(torigin)
    if type(jsondata) == "string" then
        log.info("LteTest.JsonTest.encode", "SUCCESS")
        outPutTestRes("LteTest.JsonTest.encode   PASS")
    else
        log.error("LteTest.JsonTest.encode", "FAIL")
        outPutTestRes("LteTest.JsonTest.encode   FAIL")
    end
    local origin = "{\"KEY3\":\"VALUE3\",\"KEY4\":\"VALUE4\",\"KEY2\":\"VALUE2\",\"KEY1\":\"VALUE1\",\"KEY5\":{\"KEY5_2\":\"VALUE5_2\",\"KEY5_1\":\"VALUE5_1\"},\"KEY6\":[1,2,3]}"
    local tjsondata, result, errinfo = json.decode(origin)
    if result and type(tjsondata) == "table" then
        log.info("LteTest.JsonTest.decode", "SUCCESS")
        outPutTestRes("LteTest.JsonTest.decode   PASS")
    else
        log.error("LteTest.JsonTest.decode", "FAIL")
        outPutTestRes("LteTest.JsonTest.decode   FAIL")
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
