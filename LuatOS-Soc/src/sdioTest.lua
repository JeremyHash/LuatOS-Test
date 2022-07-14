local sdioTest = {}

local tag = "sdioTest"

local function readFile(filename)
    local file = io.open(filename, "r")
    if file then
        local res = file:read("a")
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

function sdioTest.test()
    if sdio == nil then
        log.error(tag, "this fireware is not support sdio")
        return
    end
    log.info(tag, "START")
    log.info(tag .. ".init", sdio.init(0))
    log.info(tag .. ".sd_mount", sdio.sd_mount(0, "/sd"))
    writeFile("/sd/Test.txt", "TestData", "w")
    local res = readFile("/sd/Test.txt")
    log.info(tag .. ".readFile", res)
    log.info(tag .. ".sd_unmount", sdio.sd_umount(0, "/sd"))
    deleteFile("/sd/Test.txt")
    log.info(tag, "DONE")
end

return sdioTest
