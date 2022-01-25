-- mathTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "mathTest"

function test()
    if math == nil then
        log.error(tag, "this fireware is not support math")
        return
    end
    log.info(tag, "START")
    assert(math.abs(-10086) == 10086, tag .. ".abs ERROR")

    assert(math.fmod(10, 3) == 1, tag .. ".fmod ERROR")

    assert(type(math.huge) == "number", tag .. ".huge ERROR")

    assert(type(math.pi) == "number", tag .. ".pi ERROR")

    assert(math.sqrt(9) == 3, tag .. ".sqrt ERROR")

    assert(math.ceil(101.456) == 102, tag .. ".ceil ERROR")

    assert(math.floor(101.456) == 101, tag .. ".floor ERROR")

    assert(math.max(1, 2, 3, 4.15, 5.78) == 5.78, tag .. ".max ERROR")

    assert(math.min(1, 2, 3, 4.15, 5.78) == 1, tag .. ".min ERROR")

    local res1, res2 = math.modf(1.15)
    assert(res1 == 1, tag .. ".modf ERROR")

    log.info(tag, "DONE")
end
