-- rtosTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "rtosTest"

function test()
    if rtos == nil then
        log.error(tag, "this fireware is not support rtos")
        return
    end
    log.info(tag, "START")

    local testPath = "/RtosTestPath"
    assert(rtos.make_dir(testPath) == true, tag .. ".make_dir ERROR")

    assert(rtos.remove_dir(testPath) == true, tag .. ".remove_dir ERROR")

    local res1, res2 = string.toHex(rtos.toint64("12345678", "little"))
    assert(res1 == "4E61BC0000000000" and res2 == 8,
           tag .. ".toint64.little ERROR")

    local res1, res2 = string.toHex(rtos.toint64("12345678", "big"))
    assert(res1 == "0000000000BC614E" and res2 == 8, tag .. ".toint64.big ERROR")

    log.info(tag, "DONE")
end
