-- CryptoTest
-- Author:openluat
-- CreateDate:20211217
-- UpdateDate:20211217
module(..., package.seeall)

--[[
加解密算法结果，可对照
http://tool.oschina.net/encrypt?type=2
http://www.ip33.com/crc.html
http://tool.chacuo.net/cryptaes
进行测试
]]

local slen = string.len
local tag = "CryptoTest"
local modType = testConfig.modType

-- base64加解密算法测试
local function base64Test()
    local originStr =
        "123456crypto.base64_encodemodule(...,package.seeall)sys.timerStart(test,5000)jdklasdjklaskdjklsa"
    local encodeStr = crypto.base64_encode(originStr, slen(originStr))
    log.info(tag, ...)(tag .. ".base64_encode", encodeStr)
    if crypto.base64_decode(encodeStr, slen(encodeStr)) == originStr then
        log.info(tag .. ".base64_decode", "SUCCESS")
    else
        log.info(tag .. ".base64_decode", "FAIL")
    end
end

-- hmac_md5算法测试
local function hmacMd5Test()
    local originStr = "asdasdsadas"
    local signKey = "123456"
    log.info(tag .. ".hmac_md5", crypto.hmac_md5(originStr, slen(originStr),
                                                 signKey, slen(signKey)))
end

-- xxtea算法测试
local function xxteaTest()
    local text = "Hello World!"
    local key = "07946"
    local encrypt_data = crypto.xxtea_encrypt(text, key)
    log.info(tag .. ".xxtea_encrypt", encrypt_data)
    log.info(tag .. ".xxtea_encrypt.hex", string.toHex(encrypt_data))
    local decrypt_data = crypto.xxtea_decrypt(encrypt_data, key)
    if decrypt_data == text then
        log.info(tag .. ".xxtea_decrypt", "SUCCESS")
    else
        log.info(tag .. ".xxtea_decrypt", "FAIL")
    end
end

-- 流式sm3算法测试
local function flowSm3Test()
    local sm3Obj = crypto.sm3start()
    local testTable = {"abc"}
    for i = 1, #testTable do sm3Obj:sm3update(testTable[i]) end
    log.info(tag .. ".flowSm3Test", sm3Obj:sm3finish())
end

-- 流式md5算法测试
local function flowMd5Test()
    local fmd5Obj = crypto.flow_md5()
    local testTable = {
        "lqlq666lqlq946", "07946lq94607946", "lq54075407540707946"
    }
    for i = 1, #testTable do fmd5Obj:update(testTable[i]) end
    log.info(tag .. ".flow_md5.hexdigest", fmd5Obj:hexdigest())
end

-- md5算法测试
local function md5Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info(tag .. ".md5.text_md5Test", crypto.md5(originStr, slen(originStr)))
    log.info(tag .. ".md5.file_md5Test", crypto.md5("/lua/sys.lua", "file"))
end

-- hmac_sha1算法测试
local function hmacSha1Test()
    local originStr = "asdasdsadasweqcdsjghjvcb"
    local signKey = "12345689012345"
    log.info(tag .. ".hmac_sha1", crypto.hmac_sha1(originStr, slen(originStr),
                                                   signKey, slen(signKey)))
end

-- sha1算法测试
local function sha1Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info(tag .. ".sha1", crypto.sha1(originStr, slen(originStr)))
end

-- sha256算法测试
local function sha256Test()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    log.info(tag .. ".sha256", crypto.sha256(originStr, slen(originStr)))
end

-- hmac_sha256算法测试
local function hmacSha256Test()
    local originStr = "asdasdsadasweqcdsjghjvcb"
    local signKey = "12345689012345"
    log.info(tag .. ".hmac_sha256", crypto.hmac_sha256(originStr, signKey))
end

-- crc算法测试
local function crcTest()
    local originStr = "sdfdsfdsfdsffdsfdsfsdfs1234"
    -- crypto.crc16()第一个参数是校验方法，必须为以下几个；第二个参数为计算校验的字符串
    log.info(tag .. ".crc16_MODBUS",
             string.format("%04X", crypto.crc16("MODBUS", originStr)))
    log.info(tag .. ".crc16_IBM",
             string.format("%04X", crypto.crc16("IBM", originStr)))
    log.info(tag .. ".crc16_X25",
             string.format("%04X", crypto.crc16("X25", originStr)))
    log.info(tag .. ".crc16_MAXIM",
             string.format("%04X", crypto.crc16("MAXIM", originStr)))
    log.info(tag .. ".crc16_USB",
             string.format("%04X", crypto.crc16("USB", originStr)))
    log.info(tag .. ".crc16_CCITT",
             string.format("%04X", crypto.crc16("CCITT", originStr)))
    log.info(tag .. ".crc16_CCITT-FALSE",
             string.format("%04X", crypto.crc16("CCITT-FALSE", originStr)))
    log.info(tag .. ".crc16_XMODEM",
             string.format("%04X", crypto.crc16("XMODEM", originStr)))
    log.info(tag .. ".crc16_DNP",
             string.format("%04X", crypto.crc16("DNP", originStr)))
    log.info(tag .. ".USER-DEFINED",
             string.format("%04X",
                           crypto.crc16("USER-DEFINED", originStr, 0x8005,
                                        0x0000, 0x0000, 0, 0)))
end

-- aes算法测试（参考http://tool.chacuo.net/cryptaes）
local function aesTest()
    local originStr = "AES128 ECB ZeroP"
    -- 加密模式：ECB；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit
    local encodeStr = crypto.aes_encrypt("ECB", "ZERO", originStr,
                                         "1234567890123456")
    if crypto.aes_decrypt("ECB", "ZERO", encodeStr, "1234567890123456") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 ECB ZeroP"
    -- 加密模式：ECB；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit
    encodeStr =
        crypto.aes_encrypt("ECB", "PKCS5", originStr, "1234567890123456")
    if crypto.aes_decrypt("ECB", "PKCS5", encodeStr, "1234567890123456") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 ECB ZeroPt"
    -- 加密模式：ECB；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit
    encodeStr =
        crypto.aes_encrypt("ECB", "PKCS7", originStr, "1234567890123456")
    if crypto.aes_decrypt("ECB", "PKCS7", encodeStr, "1234567890123456") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128  ECB  NonePadding test st"
    -- 加密模式：ECB；填充方式：NonePadding；密钥：1234567890123456；密钥长度：128 bit
    encodeStr = crypto.aes_encrypt("ECB", "NONE", originStr, "1234567890123456")
    if crypto.aes_decrypt("ECB", "NONE", encodeStr, "1234567890123456") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 ECB ZeroPadding test"
    -- 加密模式：ECB；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit
    local encodeStr = crypto.aes_encrypt("ECB", "ZERO", originStr,
                                         "123456789012345678901234")
    if crypto.aes_decrypt("ECB", "ZERO", encodeStr, "123456789012345678901234") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 ECB Pkcs5Padding test"
    -- 加密模式：ECB；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit
    encodeStr = crypto.aes_encrypt("ECB", "PKCS5", originStr,
                                   "123456789012345678901234")
    if crypto.aes_decrypt("ECB", "PKCS5", encodeStr, "123456789012345678901234") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 ECB Pkcs7Padding test"
    -- 加密模式：ECB；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit
    encodeStr = crypto.aes_encrypt("ECB", "PKCS7", originStr,
                                   "123456789012345678901234")
    if crypto.aes_decrypt("ECB", "PKCS7", encodeStr, "123456789012345678901234") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 ECB ZeroPadding test"
    -- 加密模式：ECB；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    local encodeStr = crypto.aes_encrypt("ECB", "ZERO", originStr,
                                         "12345678901234567890123456789012")
    if crypto.aes_decrypt("ECB", "ZERO", encodeStr,
                          "12345678901234567890123456789012") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 ECB Pkcs5Padding test"
    -- 加密模式：ECB；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    encodeStr = crypto.aes_encrypt("ECB", "PKCS5", originStr,
                                   "12345678901234567890123456789012")
    if crypto.aes_decrypt("ECB", "PKCS5", encodeStr,
                          "12345678901234567890123456789012") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 ECB Pkcs7Padding test"
    -- 加密模式：ECB；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit
    encodeStr = crypto.aes_encrypt("ECB", "PKCS7", originStr,
                                   "12345678901234567890123456789012")
    if crypto.aes_decrypt("ECB", "PKCS7", encodeStr,
                          "12345678901234567890123456789012") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CBC ZeroPadding test"
    -- 加密模式：CBC；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC", "ZERO", originStr,
                                         "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CBC", "ZERO", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CBC Pkcs5Padding test"
    -- 加密模式：CBC；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS5", originStr,
                                   "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS5", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CBC Pkcs7Padding test"
    -- 加密模式：CBC；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS7", originStr,
                                   "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS7", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128  CBC  NonePadding test st"
    -- 加密模式：CBC；填充方式：NonePadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "NONE", originStr, "1234567890123456",
                                   "1234567890666666")
    if crypto.aes_decrypt("CBC", "NONE", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CBC ZeroPadding test"
    -- 加密模式：CBC；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC", "ZERO", originStr,
                                         "123456789012345678901234",
                                         "1234567890666666")
    if crypto.aes_decrypt("CBC", "ZERO", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CBC Pkcs5Padding test"
    -- 加密模式：CBC；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS5", originStr,
                                   "123456789012345678901234",
                                   "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS5", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CBC Pkcs7Padding test"
    -- 加密模式：CBC；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS7", originStr,
                                   "123456789012345678901234",
                                   "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS7", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CBC ZeroPadding test"
    -- 加密模式：CBC；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CBC", "ZERO", originStr,
                                         "12345678901234567890123456789012",
                                         "1234567890666666")
    if crypto.aes_decrypt("CBC", "ZERO", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CBC Pkcs5Padding test"
    -- 加密模式：CBC；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS5", originStr,
                                   "12345678901234567890123456789012",
                                   "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS5", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CBC Pkcs7Padding test"
    -- 加密模式：CBC；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CBC", "PKCS7", originStr,
                                   "12345678901234567890123456789012",
                                   "1234567890666666")
    if crypto.aes_decrypt("CBC", "PKCS7", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CTR ZeroPadding test"
    -- 加密模式：CTR；填充方式：ZeroPadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR", "ZERO", originStr,
                                         "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CTR", "ZERO", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CTR Pkcs5Padding test"
    -- 加密模式：CTR；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS5", originStr,
                                   "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS5", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CTR Pkcs7Padding test"
    -- 加密模式：CTR；填充方式：Pkcs7Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS7", originStr,
                                   "1234567890123456", "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS7", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES128 CTR NonePadding test tttt"
    -- 加密模式：CTR；填充方式：NonePadding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "NONE", originStr, "1234567890123456",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "NONE", encodeStr, "1234567890123456",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CTR ZeroPadding test"
    -- 加密模式：CTR；填充方式：ZeroPadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR", "ZERO", originStr,
                                         "123456789012345678901234",
                                         "1234567890666666")
    if crypto.aes_decrypt("CTR", "ZERO", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CTR Pkcs5Padding test"
    -- 加密模式：CTR；填充方式：Pkcs5Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS5", originStr,
                                   "123456789012345678901234",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS5", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CTR Pkcs7Padding test"
    -- 加密模式：CTR；填充方式：Pkcs7Padding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS7", originStr,
                                   "123456789012345678901234",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS7", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES192 CTR NonePadding test tttt"
    -- 加密模式：CTR；填充方式：NonePadding；密钥：123456789012345678901234；密钥长度：192 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "NONE", originStr,
                                   "123456789012345678901234",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "NONE", encodeStr, "123456789012345678901234",
                          "1234567890666666") == originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CTR ZeroPadding test"
    -- 加密模式：CTR；填充方式：ZeroPadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    local encodeStr = crypto.aes_encrypt("CTR", "ZERO", originStr,
                                         "12345678901234567890123456789012",
                                         "1234567890666666")
    if crypto.aes_decrypt("CTR", "ZERO", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CTR Pkcs5Padding test"
    -- 加密模式：CTR；填充方式：Pkcs5Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS5", originStr,
                                   "12345678901234567890123456789012",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS5", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CTR Pkcs7Padding test"
    -- 加密模式：CTR；填充方式：Pkcs7Padding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "PKCS7", originStr,
                                   "12345678901234567890123456789012",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "PKCS7", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end

    originStr = "AES256 CTR NonePadding test tttt"
    -- 加密模式：CTR；填充方式：NonePadding；密钥：12345678901234567890123456789012；密钥长度：256 bit；偏移量：1234567890666666
    encodeStr = crypto.aes_encrypt("CTR", "NONE", originStr,
                                   "12345678901234567890123456789012",
                                   "1234567890666666")
    if crypto.aes_decrypt("CTR", "NONE", encodeStr,
                          "12345678901234567890123456789012", "1234567890666666") ==
        originStr then
        log.info(tag .. ".aes_decrypt", "SUCCESS")
    else
        log.info(tag .. ".aes_decrypt", "FAIL")
    end
end

-- rsa算法测试
local function rsaTest()
    local plainStr =
        "firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0"

    -- 公钥加密(2048bit，这个bit与实际公钥的bit要保持一致)
    local encryptStr = crypto.rsa_encrypt("PUBLIC_KEY",
                                          io.readFile("/lua/public.key"), 2048,
                                          "PUBLIC_CRYPT", plainStr)
    -- 私钥解密(2048bit，这个bit与实际私钥的bit要保持一致)
    local decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",
                                          io.readFile("/lua/private.key"), 2048,
                                          "PRIVATE_CRYPT", encryptStr)
    if decryptStr == plainStr then
        log.info(tag .. ".rsa_decrypt", "SUCCESS")
    else
        log.error(tag .. ".rsa_decrypt", "FAIL")
    end

    -- 私钥签名(2048bit，这个bit与实际私钥的bit要保持一致)
    local signStr = crypto.rsa_sha256_sign("PRIVATE_KEY",
                                           io.readFile("/lua/private.key"),
                                           2048, "PRIVATE_CRYPT", plainStr)
    log.info("rsaTest.signStr", signStr:toHex())
    -- 公钥验签(2048bit，这个bit与实际公钥的bit要保持一致)
    local verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY", io.readFile(
                                                      "/lua/public.key"), 2048,
                                                  "PUBLIC_CRYPT", signStr,
                                                  plainStr)
    log.info("rsaTest.verify", verifyResult)

    -- 私钥解密某个客户的公钥加密密文
    encryptStr = string.fromHex(
                     "af750a8c95f9d973a033686488197cffacb8c1b2b5a15ea8779a48a72a1cdb2f9c948fe5ce0ac231a16de16b5fb609f62ec81c7646c1f018e333860627b5d4853cfe77f71ea7e4573323905faf0a759d59729d2afb80e46ff1f1b715227b599a14f3b9feb676f1feb1c2acd97f4d494124237a720ca781a16a2b600c17e348a5fdd3c374384276147b93ce93cc5a005a0aaf1581cdb7d58bfa84b4e4d7263efc02bf7ad80b15937ce8b37ced4e1ef8899be5c2a7d338cb5c4784c6b8a1cb31e7ecd1ec48597a02050b1190a3e13f2253a35e8cbc094c0af28b968f05a7f946a7a8cf3f9da2013d53ee51ca74279f8f36662e093b37db83caef5b18b666d405d4")
    decryptStr = crypto.rsa_decrypt("PRIVATE_KEY",
                                    io.readFile("/lua/private.key"), 2048,
                                    "PRIVATE_CRYPT", encryptStr)
    log.info("rsaTest.decrypt", decryptStr)

    -- 公钥验签某个客户的私钥签名密文
    signStr = string.fromHex(
                  "7251fd625c01ac41e277d11b5b795962ba42d89a645eb9fe2241b2d8a9b6b5b6ea70e23e6933ef1324495749abde0e31eaf4fefe6d09f9270c0510790bd6075595717522539b7b70b798bdc216dae3873389644d73b04ecaeb01b25831904955a891d2459334a3f9f1e4558f7f99906c35f94c377f7f95cf0d3e062d8eb513fd723ad8b3981027b09126fbeb72d5fe4554a32b9c270f8f46032ede59387769b1fb090f0b4be15aaac2744a666dfbde7c04e02979f1c1b4e4c0f23c6bb9f60941312850caf41442d68ad7c9e939b7305ac6712ad31427f1c1d7b4f68001df9ce03367bd35e401a420f526aee3c96c2caaccb9a8db09b30930172b4c2847725d05")
    verifyResult = crypto.rsa_sha256_verify("PUBLIC_KEY",
                                            io.readFile("/lua/public.key"),
                                            2048, "PUBLIC_CRYPT", signStr,
                                            "firmId=10015&model=zw-sp300&sn=W01201910300000108&version=1.0.0")
    log.info("rsaTest.verifyResult customer", verifyResult)
end

-- des算法（参考http://tool.chacuo.net/cryptdes）
local function desTest()
    local originStr = "DES ECB ZeroPadding test"
    -- 加密模式：ECB；填充方式：ZeroPadding；密钥：12345678；密钥长度：64 bit
    local encodeStr = crypto.des_encrypt("ECB", "ZERO", originStr, "12345678")

    if crypto.des_decrypt("ECB", "ZERO", encodeStr, "12345678") == originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES ECB PKcs5Padding test"
    -- 加密模式：ECB；填充方式：Pkcs5Padding；密钥：12345678；密钥长度：64 bit
    encodeStr = crypto.des_encrypt("ECB", "PKCS5", originStr, "12345678")
    if crypto.des_decrypt("ECB", "PKCS5", encodeStr, "12345678") == originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES ECB PKcs7Padding test"
    -- 加密模式：ECB；填充方式：Pkcs7Padding；密钥：12345678；密钥长度：64 bit
    encodeStr = crypto.des_encrypt("ECB", "PKCS7", originStr, "12345678")
    if crypto.des_decrypt("ECB", "PKCS7", encodeStr, "12345678") == originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES ECB NonePadding test"
    -- 加密模式：ECB；填充方式：NonePadding；密钥：12345678；密钥长度：64 bit
    encodeStr = crypto.des_encrypt("ECB", "NONE", originStr, "12345678")
    if crypto.des_decrypt("ECB", "NONE", encodeStr, "12345678") == originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES CBC ZeroPadding test"
    -- 加密模式：CBC；填充方式：ZeroPadding；密钥：12345678；密钥长度：64 bit；偏移量：12345678
    encodeStr = crypto.des_encrypt("CBC", "ZERO", originStr, "12345678",
                                   "12345678")
    if crypto.des_decrypt("CBC", "ZERO", encodeStr, "12345678", "12345678") ==
        originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES CBC Pkcs5Padding test"
    -- 加密模式：CBC；填充方式：Pkcs5Padding；密钥：12345678；密钥长度：64 bit；偏移量：12345678
    encodeStr = crypto.des_encrypt("CBC", "PKCS5", originStr, "12345678",
                                   "12345678")
    if crypto.des_decrypt("CBC", "PKCS5", encodeStr, "12345678", "12345678") ==
        originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES CBC Pkcs7Padding test"
    -- 加密模式：CBC；填充方式：Pkcs7Padding；密钥：12345678；密钥长度：64 bit；偏移量：12345678
    encodeStr = crypto.des_encrypt("CBC", "PKCS7", originStr, "12345678",
                                   "12345678")
    if crypto.des_decrypt("CBC", "PKCS7", encodeStr, "12345678", "12345678") ==
        originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end

    originStr = "DES CBC NonePadding test"
    -- 加密模式：CBC；填充方式：NonePadding；密钥：12345678；密钥长度：64 bit: 偏移量：12345678
    encodeStr = crypto.des_encrypt("CBC", "NONE", originStr, "12345678",
                                   "12345678")
    if crypto.des_decrypt("CBC", "NONE", encodeStr, "12345678", "12345678") ==
        originStr then
        log.info(tag .. ".des_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des_decrypt", "FAIL")
    end
end

-- DES3算法测试
local function des3Test()
    local originStr = "DES3 ECB ZeroPadding test"
    -- 加密模式：DES3 EBC；填充方式：ZEROPadding；密钥：123456781234567812345678; 偏移：12345678
    encodeStr = crypto.des3_encrypt("ECB", "ZERO", originStr,
                                    "123456781234567812345678", "12345678")
    if crypto.des3_decrypt("ECB", "ZERO", encodeStr, "123456781234567812345678",
                           "12345678") == originStr then
        log.info(tag .. ".des3_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des3_decrypt", "FAIL")
    end

    originStr = "DES3 ECB PKcs5Padding test"
    -- 加密模式：DES3 EBC；填充方式：Pkcs5Padding；密钥：123456781234567812345678; 偏移：12345678
    encodeStr = crypto.des3_encrypt("ECB", "PKCS5", originStr,
                                    "123456781234567812345678", "12345678")
    if crypto.des3_decrypt("ECB", "PKCS5", encodeStr,
                           "123456781234567812345678", "12345678") == originStr then
        log.info(tag .. ".des3_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des3_decrypt", "FAIL")
    end

    originStr = "DES3 ECB PKcs7Padding test"
    -- 加密模式：DES3 ECB；填充方式：Pkcs7Padding；密钥：123456781234567812345678;偏移：123456781234567812345678
    encodeStr = crypto.des3_encrypt("ECB", "PKCS7", originStr,
                                    "123456781234567812345678",
                                    "123456781234567812345678")
    if crypto.des3_decrypt("ECB", "PKCS7", encodeStr, "123456781234567812345678") ==
        originStr then
        log.info(tag .. ".des3_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des3_decrypt", "FAIL")
    end

    originStr = "DES3 ECB NonePadding test succes"
    -- 加密模式：DES3 ECB；填充方式：NonePadding；密钥：123456781234567812345678；密钥长度：64 bit: 偏移量：123456781234567812345678
    encodeStr = crypto.des3_encrypt("ECB", "NONE", originStr,
                                    "123456781234567812345678",
                                    "123456781234567812345678")
    if crypto.des3_decrypt("ECB", "NONE", encodeStr, "123456781234567812345678") ==
        originStr then
        log.info(tag .. ".des3_decrypt", "SUCCESS")
    else
        log.error(tag .. ".des3_decrypt", "FAIL")
    end
end

local function cryptoTestTask()
    base64Test()
    hmacMd5Test()
    xxteaTest()
    if modType == "8910" then flowSm3Test() end
    flowMd5Test()
    md5Test()
    hmacSha1Test()
    sha1Test()
    sha256Test()
    hmacSha256Test()
    crcTest()
    aesTest()
    rsaTest()
    desTest()
    des3Test()
end

sys.taskInit(function()
    log.info(tag, "CryptoTest Start")
    if testConfig.testMode == "single" then
        cryptoTestTask()
    elseif testConfig.testMode == "loop" then
        while true do
            cryptoTestTask()
            sys.wait(100)
        end
    end
end)
