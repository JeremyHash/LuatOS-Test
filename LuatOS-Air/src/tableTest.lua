-- tableTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "tableTest"

function test()
    if table == nil then
        log.error(tag, "this fireware is not support table")
        return
    end
    log.info(tag, "START")
    local fruits = {"banana", "orange", "apple"}
    assert(table.concat(fruits) == "bananaorangeapple", tag .. ".  ERROR")

    assert(table.concat(fruits, ", ") == "banana, orange, apple",
           tag .. ".  ERROR")

    assert(table.concat(fruits, ", ", 2, 3) == "orange, apple",
           tag .. ".  ERROR")

    table.insert(fruits, "mango")
    assert(fruits[4] == "mango", tag .. ".  ERROR")

    table.insert(fruits, 2, "grapes")
    assert(fruits[2] == "grapes", tag .. ".  ERROR")

    lastest = table.remove(fruits)
    assert(fruits[5] == nil, tag .. ".  ERROR")

    firstest = table.remove(fruits, 1)
    assert(fruits[1] == "grapes", tag .. ".  ERROR")

    log.info(tag, "DONE")
end
