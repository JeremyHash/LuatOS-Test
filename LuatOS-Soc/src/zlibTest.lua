local zlibTest = {}

local tag = "zlibTest"

local function readFile(filename)
    local file = io.open(filename, "r")
    if file then
        local res = file:read("*all")
        file:close()
        return res
    else
        log.error(tag .. ".readFile." .. filename,
                  "文件不存在或文件输入格式不正确")
    end
end

function zlibTest.test()
    if zlib == nil then
        log.error(tag, "this fireware is not support zlib")
        return
    end
    log.info(tag, "START")
    -- 由于内存不足，所以加密在现在的芯片上不太方便测试
    -- assert(zlib.c("/luadb/main.luac", "/main.zlib") == true, tag .. ".c ERROR")
    assert(zlib.d("/luadb/res.zlib", "/res.txt") == true, tag .. ".d ERROR")
    assert(readFile("/res.txt") == "1234567890", tag .. ".d ERROR")
    log.info(tag, "DONE")
end

return zlibTest
