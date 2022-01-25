-- stringTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "stringTest"

function test()
    if string == nil then
        log.error(tag, "this fireware is not support string")
        return
    end
    log.info(tag, "START")
    local testStr = "Luat is very NB,NB (10086)"

    assert(string.upper(testStr) == "LUAT IS VERY NB,NB (10086)",
           tag .. ".upper ERROR")

    assert(string.lower(testStr) == "luat is very nb,nb (10086)",
           tag .. ".lower ERROR")

    assert(string.gsub(testStr, "L%w%w%w", "AirM2M") ==
               "AirM2M is very NB,NB (10086)", tag .. ".gsub ERROR")

    local res1, res2 = string.find(testStr, "NB", 1, true)
    assert(res1 == 14 and res2 == 15, tag .. ".find ERROR")

    local res1, res2 = string.find(testStr, "N%w", 16, false)
    assert(res1 == 17 and res2 == 18, tag .. ".find ERROR")

    assert(string.reverse(testStr) == ")68001( BN,BN yrev si tauL",
           tag .. "reverse ERROR")

    local i = 43981
    assert(string.format("This is %d test string : %s", i, testStr) ==
               "This is 43981 test string : Luat is very NB,NB (10086)",
           tag .. ".format ERROR")

    assert(string.format("%d(Hex) = %x / %X", i, i, i) ==
               "43981(Hex) = abcd / ABCD", tag .. ".format ERROR")

    assert(string.char(33, 48, 49, 50, 97, 98, 99) == "!012abc",
           tag .. ".char ERROR")

    assert(string.byte("abc", 1) == 97, tag .. ".byte ERROR")

    assert(string.byte("abc", 2) == 98, tag .. ".byte ERROR")

    assert(string.byte("abc", 3) == 99, tag .. ".byte ERROR")

    assert(string.len(testStr) == 26, tag .. ".len ERROR")

    assert(string.rep(testStr, 2) ==
               "Luat is very NB,NB (10086)Luat is very NB,NB (10086)",
           tag .. ".rep ERROR")

    assert(string.match(testStr, "Luat (..) very NB") == "is",
           tag .. ".match ERROR")

    assert(string.sub(testStr, 1, 4) == "Luat", tag .. ".sub ERROR")

    local res1, res2 = string.toHex(testStr)
    assert(res1 == "4C7561742069732076657279204E422C4E422028313030383629" and
               res2 == 26, tag .. ".toHex ERROR")

    local res1, res2 = string.toHex(testStr, ",")
    assert(res1 ==
               "4C,75,61,74,20,69,73,20,76,65,72,79,20,4E,42,2C,4E,42,20,28,31,30,30,38,36,29," and
               res2 == 26, tag .. ".toHex ERROR")

    local res1, res2 = string.fromHex("313233616263")
    assert(res1 == "123abc" and res2 == 6, tag .. ".fromHex ERROR")

    assert(
        string.utf8Len("Luat中国こにちはПривет🤣❤💚☢") == 20,
        tag .. ".utf8Len ERROR")

    assert(string.rawurlEncode(
               "####133Luat中国こにちはПривет🤣❤💚☢") ==
               "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2",
           tag .. ".rawurlEncode ERROR")

    assert(string.urlEncode(
               "####133Luat中国こにちはПривет🤣❤💚☢") ==
               "%23%23%23%23133Luat%E4%B8%AD%E5%9B%BD%E3%81%93%E3%81%AB%E3%81%A1%E3%81%AF%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%F0%9F%A4%A3%E2%9D%A4%F0%9F%92%9A%E2%98%A2",
           tag .. ".urlEncode ERROR")

    assert(string.formatNumberThousands(1234567890) == "1,234,567,890",
           tag .. ".formatNumberThousands ERROR")

    local splitTable = string.split("Luat,is,very,nb", ",")
    assert(
        splitTable[1] == "Luat" and splitTable[2] == "is" and splitTable[3] ==
            "very" and splitTable[4] == "nb", tag .. ".split ERROR")
    log.info(tag, "DONE")
end
