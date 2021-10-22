---@diagnostic disable: unbalanced-assignments, undefined-global, lowercase-global
module(..., package.seeall)

require "bit"

local lcd_width = 480
local lcd_height = 854
local ispress = false
local last_x, last_y
x = 0
y = 0

local function tpPrase(data)
    -- 第一个字节头信息为0x52
    if string.byte(data,1) == 0x52 then
        local tmpl,tmph
        
        --第2，3，4，5, 7全是0xff 表示release,其余表示press
        if string.byte(data,2) == 0xff and string.byte(data,3) == 0xff then
            if ispress == false then
                return false, false, -1, -1
            end

            ispress = false
            --log.info("ispress x,y ", ispress, x, y)
            return true, ispress, x, y
        end

        -- x 11位， 第3字节为[0,7] 第2字节的[4,6]为[8,11] 转化坐标需要*width/2048
        tmpl = bit.band(string.byte(data,2), 0xf0)
        tmph = bit.lshift(tmpl, 4) 
        x = tmph + string.byte(data,3) 
        x = x * lcd_width / 2048

        -- y 11位， 第4字节为[0,7] 第2字节的[0,2]为[8,11] 转化坐标需要*height/2048
        tmpl = bit.band(string.byte(data,2), 0x0f)
        tmph = bit.lshift(tmpl, 8) 
        y = tmph + string.byte(data,4) 
        y = y * lcd_height / 2048
        
        if ispress == true and last_x == x and last_y == y then
            return false, false, -1, -1
        end

        ispress = true
        last_x = x
        last_y = y
        --log.info("ispress x,y ", ispress, x, y)
        return true, ispress, x, y
    end

    return false, false, -1, -1
end

local function open(id, speed)
    if i2c.setup(id, speed or i2c.SLOW) ~= i2c.SLOW then
        i2c.close(id)
        return i2c.setup(id, speed or i2c.SLOW)
    end
    return i2c.SLOW
end

local function init()
    --打开电压域
    pmd.ldoset(8,pmd.LDO_VMMC)
    --tp使能管脚
    pins.setup(pio.P0_11,1) 
    --初始化i2c
    if i2c.setup(2, i2c.SLOW) ~= i2c.SLOW then
        log.info("tp init error")
    end
end

local iskeypress = false
local keyid = 0
local keycb = nil
function tpkeyprase(data)
    -- 菜单，home，返回键
    if string.byte(data,1) == 0x52 and string.byte(data,2) == 0xff then
        if string.byte(data,6) == 0x01 or string.byte(data,6) == 0x04 or string.byte(data,6) == 0x02 then
            keyid = string.byte(data,6) 
            if keycb ~= nil and iskeypress == false then
                iskeypress = true
                keycb(keyid, iskeypress)
            end
        end

        if string.byte(data,2) == 0xff and string.byte(data,3) == 0xff and string.byte(data,6) == 0xff then
            if iskeypress then 
                iskeypress = false
                if keycb ~= nil then
                    keycb(keyid, iskeypress)
                end
            end
        end
    end
end

function cb(cb)
    log.info("msg2238 cb ")
    keycb = cb
end

function get()
    --通过I2C读取数据8个字节
    local data = i2c.recv(2, 0x26, 8)
    --解析坐标参数返回valid,ispress,x,y
    tpkeyprase(data)
    return tpPrase(data)
end

init()


