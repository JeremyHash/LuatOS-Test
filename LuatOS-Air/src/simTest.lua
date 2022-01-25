-- simTest
-- Author:openluat
-- CreateDate:20220125
-- UpdateDate:20220125
module(..., package.seeall)

local tag = "simTest"

function test()
    if sim == nil then
        log.error(tag, "this fireware is not support sim")
        return
    end
    log.info(tag, "START")
    assert(sim.getIccid() ~= nil, tag .. ".getIccid ERROR")

    assert(sim.getImsi() ~= nil, tag .. ".getImsi ERROR")

    assert(sim.getMcc() ~= "", tag .. ".getMcc ERROR")

    assert(sim.getMnc() ~= "", tag .. ".getMnc ERROR")
    
    log.info(tag, "DONE")
end
