local packTest = {}

local tag = "packTest"

function packTest.test()
    if pack == nil then
        log.error(tag, "this fireware is not support pack")
        return
    end
    log.info(tag, "START")

    log.info(tag, "DONE")
end

return packTest
