fsTest = {}

local tag = "fsTest"

function fsTest.test()
    log.info(tag, "START")
    log.info(tag .. ".fsstat", fs.fsstat("/"))
    log.info(tag .. ".fsize", fs.fsize("/main.luac"))
    log.info(tag, "DONE")
end

return fsTest
