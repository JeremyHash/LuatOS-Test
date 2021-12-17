stringTest = {}

local tag = "stringTest"

function stringTest.test()
    log.info(tag, "START")
    assert(string.toHex("123abc") == "313233616263", tag .. ".toHex ERROR")
    assert(string.fromHex("313233616263") == "123abc", tag .. ".fromHex ERROR")
    -- local splitRes = string.split("ni,hao,a", ",")
    -- print(splitRes)
    -- print(#splitRes)
    -- for k, v in pairs(splitRes) do print(k, v) end
    -- print(json.encode(string.split("11,22,33", ",")))
    -- assert(string.split("1,2,3", ",")[0] == "1", tag .. ".split ERROR")
    assert(string.toHex(string.toValue("0123456789ABCDEF")) ==
               "000102030405060708090A0B0C0D0E0F", tag .. ".toValue ERROR")
    assert(string.urlEncode("四ろく") == "%E5%9B%9B%E3%82%8D%E3%81%8F",
           tag .. ".urlEncode ERROR")
    assert(string.toBase64("12345") == "MTIzNDU=", tag .. ".toBase64 ERROR")
    assert(string.fromBase64("MTIzNDU=") == "12345", tag .. ".fromBase64 ERROR")
    log.info(tag, "DONE")
end

return stringTest
