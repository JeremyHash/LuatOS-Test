-- zipTest
-- Author:openluat
-- CreateDate:20220823
-- UpdateDate:20220823
module(..., package.seeall)

local tag = "zipTest"

function test()
    log.info(tag, "START")
    if zip == nil then
        log.error(tag, "this fireware is not support zip")
        return
    end
    if testConfig.SDCARD_EXIST == true then
        assert(io.mount(io.SDCARD) == 1, tag .. ".mount ERROR")
        local zfile, err = zip.open("/sdcard0/Desktop.zip")
        if zfile == nil then
            print("zfile is nil")
        end
        assert(err == nil, tag .. ".open ERROR " .. (err or ""))
        for file in zfile:files() do
            local fileName = file.filename
            log.info(tag .. ".files.fileName", fileName)
            local resFile, err = zfile:open(fileName)
            assert(err == nil, tag .. ".open ERROR " .. (err or ""))
            local resFileContent = resFile:read("*a")
            log.info(tag .. ".read", resFileContent)
            resFile:close()
        end
        assert(zfile:close() == true, tag .. ".close ERROR")
        assert(io.unmount(io.SDCARD) == 1, tag .. ".unmount ERROR")
    else
        log.error(tag, "need sdcard")
    end
    log.info(tag, "DONE")
end
