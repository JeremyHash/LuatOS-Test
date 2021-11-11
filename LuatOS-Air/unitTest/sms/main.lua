-- smsTest
-- Author:openluat
-- CreateDate:20211027
-- UpdateDate:20211111
PROJECT = "smsTest"
VERSION = "1.0.0"

require "sys"
require "sms"
require "pins"
require "ntp"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- 短信接收
local function procnewsms(num, data, datetime)
    log.info("testSms.procnewsms", num, common.gb2312ToUtf8(data), datetime)
end

sms.setNewSmsCb(procnewsms)

-- 短信发送
local function sendtest1(result, num, data)
    log.info("testSms.sendtest1", result, num, data)
end

local function sendtest2(result, num, data)
    log.info("testSms.sendtest2", result, num, data)
end

local function sendtest3(result, num, data)
    log.info("testSms.sendtest3", result, num, data)
end

local function sendtest4(result, num, data)
    log.info("testSms.sendtest4", result, num, data)
end

sys.taskInit(function()
    sys.waitUntil("IP_READY_IND")
    sms.send("10086", "10086", sendtest1)
    -- sms.send("10086", common.utf8ToGb2312("第2条短信"), sendtest2)
    -- sms.send("10086",
    --          "qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432",
    --          sendtest3)
    -- sms.send("10086", common.utf8ToGb2312(
    --              "华康是的撒qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432qeiuqwdsahdkjahdkjahdkja122136489759725923759823hfdskfdkjnbzndkjhfskjdfkjdshfkjdsfks83478648732432"),
    --          sendtest4)
end)

sys.init(0, 0)
sys.run()
