zbuffTest = {}

local tag = "zbuffTest"

function zbuffTest.test()
    if zbuff == nil then
        log.error(tag, "this fireware is not support zbuff")
        return
    end
    log.info(tag, "START")
    local buff = zbuff.create(1024, 0xFF)
    print(buff, type(buff))
    log.info(tag, "DONE")
end

return zbuffTest
