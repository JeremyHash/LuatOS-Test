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
