-- jsonTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "jsonTest"

function test()
    if json == nil then
        log.error(tag, "this fireware is not support json")
        return
    end
    log.info(tag, "START")
    local torigin = {
        KEY1 = "VALUE1",
        KEY2 = "VALUE2",
        KEY3 = "VALUE3",
        KEY4 = "VALUE4",
        KEY5 = {KEY5_1 = "VALUE5_1", KEY5_2 = "VALUE5_2"},
        KEY6 = {1, 2, 3}
    }
    local jsondata = json.encode(torigin)
    assert(type(jsondata) == "string", tag .. ".encode ERROR")

    local origin =
        "{\"KEY3\":\"VALUE3\",\"KEY4\":\"VALUE4\",\"KEY2\":\"VALUE2\",\"KEY1\":\"VALUE1\",\"KEY5\":{\"KEY5_2\":\"VALUE5_2\",\"KEY5_1\":\"VALUE5_1\"},\"KEY6\":[1,2,3]}"
    local tjsondata, result, errinfo = json.decode(origin)
    assert(result and type(tjsondata) == "table", tag .. ".decode ERROR")

    log.info(tag, "DONE")
end
