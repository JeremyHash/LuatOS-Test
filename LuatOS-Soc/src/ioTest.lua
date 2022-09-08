local ioTest = {}

local tag = "ioTest"

local function readFile(filename)
    local file = io.open(filename, "r")
    if file then
        local res = file:read("*all")
        file:close()
        return res
    else
        log.error(tag .. ".readFile." .. filename, "文件不存在或文件输入格式不正确")
    end
end

local function writeFile(filename, data, mode)
    local file = io.open(filename, mode)
    if file then
        file:write(data)
        file:close()
        return true
    else
        log.error(tag .. ".writeFile." .. filename, "文件不存在")
        return false
    end
end

local function deleteFile(filename)
    return os.remove(filename)
end

local function fsTest(testPath)
    if string.byte(testPath, -1) ~= 47 then
        testPath = testPath .. "/"
    end
    -- assert(writeFileW(testPath .. "FsWriteTest1.txt", "") == true,
    --        tag .. ".writeFileW ERROR")
    while true do
        assert(writeFile(testPath .. "FsWriteTest1.txt", "This is a FsWriteATest", "a") == true,
            tag .. ".writeFileA ERROR")
        assert(writeFile(testPath .. "FsWriteTest2.txt", "This is a FsWriteWTest", "w") == true,
            tag .. ".writeFileW ERROR")
        assert(readFile(testPath .. "FsWriteTest2.txt") == "This is a FsWriteWTest", tag .. ".readFile ERROR")
        if io.fileSize(testPath .. "FsWriteTest1.txt") > 200 then
            assert(io.fileSize(testPath .. "FsWriteTest1.txt") == 220, tag .. ".fileSize ERROR")
            assert(deleteFile(testPath .. "FsWriteTest1.txt") == true, tag .. ".deleteFile ERROR")
            break
        end
    end
    writeFile(testPath .. "FileSeekTest.txt", "FileSeekTest", "w")
    local file = io.open(testPath .. "FileSeekTest.txt", "r")
    assert(file:seek("end") == 12, tag .. ".seek ERROR")
    assert(file:seek("set") == 0, tag .. ".seek ERROR")
    assert(file:seek() == 0, tag .. ".seek ERROR")
    assert(file:seek("cur", 10) == 10, tag .. ".seek ERROR")
    assert(file:seek("cur") == 10, tag .. ".seek ERROR")
    assert(file:read(1) == "s", tag .. ".seek ERROR")
    assert(file:seek("cur") == 11, tag .. ".seek ERROR")
    file:close()
end

-- os.remove 只能删除空目录
function ioTest.test()
    if io == nil then
        log.error(tag, "this fireware is not support io")
        return
    end
    log.info(tag, "START")
    if MOD_TYPE == "ESP32C3" then
        fsTest("/spiffs")
    elseif MOD_TYPE == "AIR105" then
        fsTest("/")
    end
    log.info(tag, "DONE")
end

return ioTest
