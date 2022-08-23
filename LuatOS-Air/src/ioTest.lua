-- ioTest
-- Author:openluat
-- CreateDate:20220127
-- UpdateDate:20220127
module(..., package.seeall)

local tag = "ioTest"

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

local function writeFileA(filename, data)
    local file = io.open(filename, "a+")
    if file then
        file:write(data)
        file:close()
        return true
    else
        log.error(tag .. ".writeFileA." .. filename, "文件不存在")
        return false
    end
end

local function writeFileW(filename, data)
    local file = io.open(filename, "w")
    if file then
        file:write(data)
        file:close()
        return true
    else
        log.error(tag .. ".writeFileW." .. filename, "文件不存在")
        return false
    end
end

local function deleteFile(filename) return os.remove(filename) end

local getDirContent
getDirContent = function(dirPath, level)
    local ftb = {}
    local dtb = {}
    level = level or "    "
    local tag = " "
    if io.opendir(dirPath) == 0 then
        log.error(tag .. ".getDirContent",
                  "无法打开目标文件夹\"" .. dirPath .. "\"")
        return
    end
    while true do
        local fType, fName, fSize = io.readdir()
        if fName == "." or fName == ".." then
            continue
        end
        if fType == 32 then
            table.insert(ftb, {name = fName, size = fSize})
        elseif fType == 16 then
            table.insert(dtb, {name = fName, path = dirPath .. "/" .. fName})
        else
            break
        end
    end
    io.closedir(dirPath)
    for i = 1, #ftb do
        if i == #ftb then
            log.info(tag, level .. "└─", ftb[i].name,
                     "[" .. ftb[i].size .. " Bytes]")
        else
            log.info(tag, level .. "├─", ftb[i].name,
                     "[" .. ftb[i].size .. " Bytes]")
        end
    end
    for i = 1, #dtb do
        if i == #dtb then
            log.info(tag, level .. "└─", dtb[i].name)
            getDirContent(dtb[i].path, level .. "  ")
        else
            log.info(tag, level .. "├─", dtb[i].name)
            getDirContent(dtb[i].path, level .. "│ ")
        end
    end
end

local function fsTest(testPath)
    rtos.remove_dir(testPath)
    assert(rtos.make_dir(testPath) == true, tag .. ".make_dir ERROR")
    while true do
        assert(writeFileA(testPath .. "/FsWriteTest1.txt",
                          "This is a FsWriteATest") == true,
               tag .. ".writeFileA ERROR")
        assert(writeFileW(testPath .. "/FsWriteTest2.txt",
                          "This is a FsWriteWTest") == true,
               tag .. ".writeFileW ERROR")
        assert(readFile(testPath .. "/FsWriteTest2.txt") ==
                   "This is a FsWriteWTest", tag .. ".readFile ERROR")
        if io.fileSize(testPath .. "/FsWriteTest1.txt") > 200 then
            assert(io.fileSize(testPath .. "/FsWriteTest1.txt") == 220,
                   tag .. ".fileSize ERROR")
            assert(deleteFile(testPath .. "/FsWriteTest1.txt") == true,
                   tag .. ".deleteFile ERROR")
            break
        end
    end
    local pathTable = io.pathInfo(testPath .. "/FsWriteTest2.txt")
    printTable(pathTable)
    writeFileW("/FileSeekTest.txt", "FileSeekTest")
    local file = io.open("/FileSeekTest.txt", "r")
    assert(file:seek("end") == 12, tag .. ".seek ERROR")
    assert(file:seek("set") == 0, tag .. ".seek ERROR")
    assert(file:seek() == 0, tag .. ".seek ERROR")
    assert(file:seek("cur", 10) == 10, tag .. ".seek ERROR")
    assert(file:seek("cur") == 10, tag .. ".seek ERROR")
    assert(file:read(1) == "s", tag .. ".seek ERROR")
    assert(file:seek("cur") == 11, tag .. ".seek ERROR")
    file:close()
    assert(io.readStream("/FileSeekTest.txt", 3, 5) == "eSeek",
           tag .. ".readStream ERROR")
end

-- rtos.remove_dir 可以删除非空目录，os.remove 只能删除空目录
function test()
    if io == nil then
        log.error(tag, "this fireware is not support io")
        return
    end
    log.info(tag, "START")
    if testConfig.SDCARD_EXIST == true then
        local sdcardPath = "/sdcard0"
        assert(io.mount(io.SDCARD) == 1, tag .. ".mount ERROR")
        log.info(tag .. ".totalSize", rtos.get_fs_total_size(1, 1) .. " KB")
        log.info(tag .. ".freeSize", rtos.get_fs_free_size(1, 1) .. " KB")
        log.info(tag .. ".getDirContent", sdcardPath)
        getDirContent(sdcardPath)
        local testPath = sdcardPath .. "/FsTestPath"
        fsTest(testPath)
        assert(io.unmount(io.SDCARD) == 1, tag .. ".unmount ERROR")
    end
    log.info(tag .. ".getDirContent", "/")
    getDirContent("/")
    local testPath = "/FsTestPath"
    fsTest(testPath)
    local dirTable = {"/", "/nvm", "/openDirTest"}
    for k, v in pairs(dirTable) do
        log.info(tag, v)
        getDirContent(v)
    end
    log.info(tag, "DONE")
end
