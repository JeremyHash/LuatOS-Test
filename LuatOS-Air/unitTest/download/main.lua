PROJECT = "downloadTest"
VERSION = "1.0.0"

require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

-- 擦除文件系统测试
sys.taskInit(
    function ()
        local tag = "FileSystemTest"
        sys.wait(5000)
        local testPath = "/FileSystemTest"
        if io.exists(testPath .. "/FsWriteTest.txt") then
            log.info(tag .. ".exists." .. testPath .. "/FsWriteTest.txt", "文件存在,准备删除该文件")
            deleteFile(testPath .. "/FsWriteTest.txt")
        else
            log.info(tag .. ".exists." .. testPath .. "/FsWriteTest.txt", "文件不存在")
        end
        if rtos.make_dir(testPath) == true then
            log.info(tag .. ".make_dir", "SUCCESS")
            io.writeFile(testPath .. "/FsWriteTest.txt", "test")
            log.info(tag .. "." .. testPath .. "/FsWriteTest.txt.fileSize", io.fileSize(testPath .. "/FsWriteTest.txt") .. "Bytes")
            log.info(tag .. ".readFile." .. testPath .. "/FsWriteTest.txt", io.readFile(testPath .. "/FsWriteTest.txt"))
        else
            log.error(tag .. ".make_dir", "FAIL")
        end
    end
)

--[[
DOWNLOAD测试
1、按BOOT键刷版本
    (1) 使用luatools配置好待测试的core和脚本，按BOOT键下载固件和脚本
    (2) 下载完成后，lua脚本打印正常，功能正常
2、不按BOOT键刷版本
    (1) 使用luatools配置好待测试的core和脚本，把模块开机，下载固件和脚本
    (2) 下载完成后，lua脚本打印正常，功能正常
3、刷版本过程中模块断电
    (1) 在模块线刷的各个阶段将模块断电
    (2) 再次线刷版本
    (3) 能够线刷版本成功，重启模块后lua脚本打印正常，功能正常
4、合成的blf/pac文件用客户量产工具下载
    (1) 用luatools_V2合成量产的blf或pac文件
    (2) 用客户量产工具下载这个量产文件
    (3) 下载完成后，lua脚本打印正常，功能正常
]]

sys.init(0, 0)
sys.run()
