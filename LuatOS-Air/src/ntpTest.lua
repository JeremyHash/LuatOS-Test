-- ntpTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "ntpTest"

function test()
    if ntp == nil then
        log.error(tag, "this fireware is not support ntp")
        return
    end
    log.info(tag, "START")
    ntp.setServers({"www.baidu.com", "www.sina.com"})
    local ntpServers = ntp.getServers()
    assert(ntpServers[1] == "www.baidu.com" and ntpServers[2] == "www.sina.com",
           tag .. ".getServers ERROR")
    log.info(tag, "DONE")
end
