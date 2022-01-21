-- bitTest
-- Author:openluat
-- CreateDate:20220121
-- UpdateDate:20220121
module(..., package.seeall)

local tag = "bitTest"

function test()
    if bit == nil then
        log.error(tag, "this fireware is not support bit")
        return
    end
    log.info(tag, "START")
    -- 左移运算
    -- 0001 -> 0100 
    for i = 0, 31 do
        local res = bit.bit(i)
        assert(res == 2 ^ i, tag .. ".bit ERROR")
    end

    -- 测试位数是否被置1
    -- 第一个参数是是测试数字，第二个是测试位置。从右向左数0到7。是1返回true，否则返回false
    -- 0101
    for i = 0, 31 do
        assert(bit.isset(0xFFFFFFFF, i) == true, tag .. ".isset ERROR")
        assert(bit.isset(0x00000000, i) == false, tag .. "isset ERROR")
    end

    -- 测试位数是否被置0
    for i = 0, 31 do
        assert(bit.isclear(0xFFFFFFFF, i) == false, tag .. ".isclear ERROR")
        assert(bit.isclear(0x00000000, i) == true, tag .. ".isclear ERROR")
    end

    -- 在相应的位数置1
    -- 0000 -> 1111
    assert(bit.set(0, 0, 1, 2, 3, 4, 5, 6, 7) == 255, tag .. ".set ERROR")
    assert(bit.set(0, 6, 3, 2, 1, 7, 5, 0, 4) == 255, tag .. ".set ERROR")

    -- 在相应的位置置0
    -- 0101 -> 0000
    assert(bit.clear(0xFF, 0, 1, 2, 3, 4, 5, 6, 7) == 0, tag .. ".clear ERROR")
    assert(bit.clear(0xFF, 6, 3, 2, 1, 7, 5, 0, 4) == 0, tag .. ".clear ERROR")

    -- 按位取反
    -- 0101 -> 1010
    assert(bit.bnot(0xFFFFFFFF) == 0, tag .. ".bnot ERROR")
    assert(bit.bnot(0x00000000) == 0xFFFFFFFF, tag .. ".bnot ERROR")
    assert(bit.bnot(0xF0F0F0F0) == 0x0F0F0F0F, tag .. ".bnot ERROR")

    -- 与
    -- 0001 && 0001 -> 0001
    assert(bit.band(0xAAA, 0xAA0, 0xA00) == 0xA00, tag .. ".band ERROR")

    -- 或
    -- 0001 | 0010 -> 0011
    assert(bit.bor(0xA00, 0x0A0, 0x00A) == 0xAAA, tag .. ".bor ERROR")

    -- 异或,相同为0，不同为1
    -- 0001 ⊕ 0010 -> 0011
    assert(bit.bxor(0x01, 0x02, 0x04, 0x08) == 0x0F, tag .. ".bxor ERROR")

    -- 逻辑左移
    -- 0001 -> 0100
    assert(bit.lshift(0xFFFFFFFF, 1) == -2, tag .. ".lshift ERROR")

    -- 逻辑右移，“001”
    -- 0100 -> 0001
    assert(bit.rshift(0xFFFFFFFF, 1) == 0x7FFFFFFF, tag .. ".rshift ERROR")

    -- 算数右移，左边添加的数与符号有关
    -- 0010 -> 0000
    assert(bit.arshift(0xFFFFFFFF, 1) == -1, tag .. ".arshift ERROR")
    log.info(tag, "DONE")
end
