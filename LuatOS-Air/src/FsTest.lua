-- FsTest
-- Author:openluat
-- CreateDate:20211026
-- UpdateDate:20211104
module(..., package.seeall)

local tag = "FsTest"

local function readFile(filename)
    local filehandle = io.open(filename, "r")
    if filehandle then
        local fileval = filehandle:read("*all")
        filehandle:close()
        return fileval
    else
        log.error(tag .. ".readFile." .. filename,
                  "文件不存在或文件输入格式不正确")
    end
end

local function writeFileA(filename, value)
    local filehandle = io.open(filename, "a+")
    if filehandle then
        filehandle:write(value)
        filehandle:close()
    else
        log.error(tag .. ".writeFileA." .. filename,
                  "文件不存在或文件输入格式不正确")
    end
end

local function writeFileW(filename, value)
    local filehandle = io.open(filename, "w")
    if filehandle then
        filehandle:write(value)
        filehandle:close()
    else
        log.error(tag .. ".writeFileW." .. filename,
                  "文件不存在或文件输入格式不正确")
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

local function fsTestTask()
    local sdcardPath = "/sdcard0"
    log.info(tag .. ".mount", "开始挂载SD卡")
    local mountRes = io.mount(io.SDCARD)
    if mountRes == 1 then
        log.info(tag .. ".mount", "SD卡挂载SUCCESS")
        log.info(tag .. ".totalSize", rtos.get_fs_total_size(1, 1) .. " KB")
        log.info(tag .. ".freeSize", rtos.get_fs_free_size(1, 1) .. " KB")
        log.info(tag .. ".getDirContent", sdcardPath)
        getDirContent(sdcardPath)
        local testPath = sdcardPath .. "/FsTestPath"
        rtos.remove_dir(testPath)
        if rtos.make_dir(testPath) == true then
            log.info(tag .. ".mkdirRes", "SUCCESS")
            while true do
                writeFileA(testPath .. "/FsWriteTest1.txt",
                           "This is a FsWriteATest")
                log.info(tag .. ".fileSize." .. testPath .. "/FsWriteTest1.txt",
                         io.fileSize(testPath .. "/FsWriteTest1.txt"))
                writeFileW(testPath .. "/FsWriteTest2.txt",
                           "This is a FsWriteWTest")
                readFile(testPath .. "/FsWriteTest2.txt")
                if io.fileSize(testPath .. "/FsWriteTest1.txt") > 200 then
                    log.info(tag .. "." .. testPath .. "/FsWriteTest1.txt",
                             "文件大小超过200byte，清空文件内容")
                    deleteFile(testPath .. "/FsWriteTest1.txt")
                    outPutTestRes("FsTest.sdCardTest  PASS")
                    break
                end
            end
        else
            log.error(tag .. ".mkdirRes", "FAIL")
            outPutTestRes("FsTest.sdCardTest  FAIL")
        end
    elseif mountRes == 0 then
        log.error(tag .. ".mount", "SD卡挂载FAIL")
        outPutTestRes("FsTest.sdCardTest  FAIL")
    else
        log.error(tag .. ".mount", "SD卡挂载FAIL,未知错误", mountRes)
        outPutTestRes("FsTest.sdCardTest  FAIL")
    end
    io.unmount(io.SDCARD)

    log.info(tag .. ".getDirContent", "/")
    getDirContent("/")
    local testPath = "/FsTestPath"
    deleteFile(testPath)
    if rtos.make_dir(testPath) == true then
        log.info(tag .. ".make_dir", "SUCCESS")
        while true do
            writeFileA(testPath .. "/FsWriteTest1.txt", "This is a FsWriteATest")
            log.info(tag .. "." .. testPath .. "/FsWriteTest1.txt.fileSize",
                     io.fileSize(testPath .. "/FsWriteTest1.txt") .. "Bytes")
            writeFileW(testPath .. "/FsWriteTest2.txt", "This is a FsWriteWTest")
            log.info(tag .. ".readFile." .. testPath .. "/FsWriteTest2.txt",
                     readFile(testPath .. "/FsWriteTest2.txt"))
            log.info(tag .. ".io.readFile." .. testPath .. "/FsWriteTest2.txt",
                     io.readFile(testPath .. "/FsWriteTest2.txt"))
            if io.fileSize(testPath .. "/FsWriteTest1.txt") > 200 then
                log.info(tag .. "." .. testPath .. "/FsWriteTest1.txt",
                         "文件大小超过200byte，清空文件内容")
                deleteFile(testPath .. "/FsWriteTest1.txt")
                break
            end
        end
        local pathTable = io.pathInfo(testPath .. "/FsWriteTest2.txt")
        log.info(tag, "pathInfo")
        printTable(pathTable)
        local file = io.open("/FileSeekTest.txt", "w")
        file:write("FileSeekTest")
        file:close()
        local file = io.open("/FileSeekTest.txt", "r")
        log.info(tag .. ".seek", file:seek("end"))
        log.info(tag .. ".seek", file:seek("set"))
        log.info(tag .. ".seek", file:seek())
        log.info(tag .. ".seek", file:seek("cur", 10))
        log.info(tag .. ".seek", file:seek("cur"))
        log.info(tag .. ".seek", file:read(1))
        log.info(tag .. ".seek", file:seek("cur"))
        file:close()
        log.info(tag .. "./FileSeekTest.txt.readStream",
                 io.readStream("/FileSeekTest.txt", 3, 5))
    else
        log.error(tag .. ".make_dir", "FAIL")
    end

    local dirTable = {"/", "/nvm", "/openDirTest"}
    for k, v in pairs(dirTable) do
        log.info(tag, v)
        getDirContent(v)
    end
end

sys.taskInit(function()
    sys.wait(5000)
    if testConfig.testMode == "single" then
        fsTestTask()
    elseif testConfig.testMode == "loop" then
        while true do
            fsTestTask()
            sys.wait(1000)
        end
    end
end)
