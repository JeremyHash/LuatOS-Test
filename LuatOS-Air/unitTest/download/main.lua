-- downloadTest
-- Author:openluat
-- CreateDate:20211022
-- UpdateDate:20211029
PROJECT = "downloadTest"
VERSION = "1.0.0"

require "sys"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "FileTest"

-- 擦除文件系统测试
sys.taskInit(function()
    sys.wait(5000)
    local testPath = "/File"
    if io.exists(testPath .. "/Test.txt") then
        log.info(tag .. ".文件存在")
    else
        log.info(tag .. ".文件不存在")
    end
    if rtos.make_dir(testPath) == true then
        log.info(tag .. ".make_dir", "SUCCESS")
        io.writeFile(testPath .. "/Test.txt", "test")
        log.info(tag .. ".filesize",
                 io.fileSize(testPath .. "/Test.txt") .. "Bytes")
        log.info(tag .. ".readfile", io.readFile(testPath .. "/Test.txt"))
    else
        log.error(tag .. ".make_dir", "FAIL")
    end
end)

sys.init(0, 0)
sys.run()
