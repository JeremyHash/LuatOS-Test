-- packTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "packTest"

function test()
    if pack == nil then
        log.error(tag, "this fireware is not support pack")
        return
    end
    log.info(tag, "START")
    assert(pack.pack(">H", 0x3234) == "24", tag .. ".pack ERROR")

    assert(pack.pack("<H", 0x3234) == "42", tag .. ".pack ERROR")

    assert(string.toHex(pack.pack(">AHb", "LUAT", 100, 10)) == "4C55415400640A",
           tag .. ".pack ERROR")

    log.info(tag, "DONE")
end
