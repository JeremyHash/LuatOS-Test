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
    local res1,res2= string.toHex(pack.pack(">H", 0x3234))
    if res1 == "3234" and res2 == 2 then 
        log.info("PackTest1","SUCCESS")
        outPutTestRes("LteTest.PackTest1 PASS")
    else 
        log.info("PackTest1","FAIL")
        outPutTestRes("LteTest.PackTest1 FAIL")
    end

    local res1,res2= string.toHex(pack.pack("<H", 0x3234))
    if res1 == "3432" and res2 == 2 then 
        log.info("PackTest2","SUCCESS")
        outPutTestRes("LteTest.PackTest2 PASS")
    else 
        log.info("PackTest2","FAIL")
        outPutTestRes("LteTest.PackTest2 FAIL")
    end

    local res1,res2= string.toHex(pack.pack(">AHb", "LUAT", 100, 10))
    if res1 == "4C55415400640A" and res2 == 7 then 
        log.info("PackTest3","SUCCESS")
        outPutTestRes("LteTest.PackTest3 PASS")
    else 
        log.info("PackTest3","FAIL")
        outPutTestRes("LteTest.PackTest3 FAIL")
    end
    
    local stringtest = pack.pack(">AHb", "luat", 999, 10)
    local res1,res2,res3= pack.unpack(string.sub(stringtest, 5, -1), ">Hb")
    if res1 == 4 and res2 == 999 and res3 == 10 then 
        log.info("PackTest4","SUCCESS")
        outPutTestRes("LteTest.PackTest4 PASS")
    else 
        log.info("PackTest4","FAIL")
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
    
    local res1,res2 = string.gsub(testStr, "L%w%w%w", "AirM2M")
    if res1 == "AirM2M is very NB,NB (10086)" then
        log.info("StringTest.gsub", "SUCCESS")
        outPutTestRes("LteTest.StringTest.gsub PASS")
    else
        log.error("StringTest.gsub", "FAIL")
        outPutTestRes("LteTest.StringTest.gsub FAIL")
    end

    local res1,res2 = string.find(testStr, "NB", 1, true)
    if res1 == 14 and res2 == 15 then
        log.info("StringTest.find1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.find1 PASS")
    else
        log.error("StringTest.find1", "FAIL")
        outPutTestRes("LteTest.StringTest.find1 FAIL")
    end

    local res1,res2 = string.find(testStr, "N%w", 16, false)
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
    if string.format("This is %d test string : %s", i, testStr) == "This is 43981 test string : Luat is very NB,NB (10086)" then
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

    if string.rep(testStr, 2) == "Luat is very NB,NB (10086)Luat is very NB,NB (10086)" then
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

    local res1,res2 = string.toHex(testStr)
    if res1 == "4C7561742069732076657279204E422C4E422028313030383629" and res2 == 26 then
        log.info("StringTest.toHex1", "SUCCESS")
        outPutTestRes("LteTest.StringTest.toHex1 PASS")
    else
        log.error("StringTest.toHex1", "FAIL")
        outPutTestRes("LteTest.StringTest.toHex1 FAIL")
    end

    local res1,res2 = string.toHex(testStr, ",")
    if res1 == "4C,75,61,74,20,69,73,20,76,65,72,79,20,4E,42,2C,4E,42,20,28,31,30,30,38,36,29," and res2 == 26 then
        log.info("StringTest.toHex2", "SUCCESS")
        outPutTestRes("LteTest.StringTest.toHex2 PASS")
    else
        log.error("StringTest.toHex2", "FAIL")
        outPutTestRes("LteTest.StringTest.toHex2 FAIL")
    end

    local res1,res2 = string.fromHex("313233616263")
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

    if string.rawurlEncode("####133Luat中国こにちはПривет🤣❤💚☢") == "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2" then
        log.info("StringTest.rawurlEncode", "SUCCESS")
        outPutTestRes("LteTest.StringTest.rawurlEncode PASS")
    else
        log.error("StringTest.rawurlEncode", "FAIL")
        outPutTestRes("LteTest.StringTest.rawurlEncode FAIL")
    end

    if string.urlEncode("####133Luat中国こにちはПривет🤣❤💚☢") == "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2" then
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

    local table = string.split("Luat,is,very,nb", ",")
    if table[1] == "Luat" and table[2] == "is" and table[3] == "very" and table[4] == "nb" then
        log.info("StringTest.split", "SUCCESS")
        outPutTestRes("LteTest.StringTest.split PASS")
    else
        log.error("StringTest.split", "FAIL")
        outPutTestRes("LteTest.StringTest.split FAIL")
    end


end

sys.taskInit(function()
    local tag = "LteTest"
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Lte测试开始")
    if testConfig.testMode == "single" then
        lteTestTask()
    elseif testConfig.testMode == "loop" then
        while true do lteTestTask() end
    end
end)
