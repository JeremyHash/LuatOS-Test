--- 模块功能：CH395 数据链路激活、SOCKET管理(创建、连接、数据收发、状态维护)
-- @module socket
-- @author openLuat
-- @license MIT
-- @copyright openLuat
-- @release 2017.9.25
require "link"
require "utils"
module(..., package.seeall)

local sockets = {}
-- 单次发送数据最大值(2k)
local SENDSIZE = 2048
-- 缓冲区最大下标(1k)
local INDEX_MAX = 1024
-- 是否有socket正处在链接
local socketsConnected = 0
-- 模块状态
local ch395State = false
-- 以太网配置参数
local networkDate = nil
-- MAC地址
local CH395MAC = nil
-- 版本号
local CH395VERSION = nil
-- 以太网模块供电设置函数
local powerCbFnc = nil

TCPCLIENT = 0
UDPCLIENT = 1
RAW = 3
TCPSERVER = 4

--- 已连接socket
local socket_connect = {}
---已开启socket数组
local socket_on = {}
---未开启socket数组(索引，{IP，端口}，端口，协议类型,发送缓冲区状态)
local socket_off = {{'\x00', {nil, nil}, nil, nil, true}, {'\x01', {nil, nil}, nil, nil, true},
                    {'\x02', {nil, nil}, nil, nil, true}, {'\x03', {nil, nil}, nil, nil, true},
                    {'\x04', {nil, nil}, nil, nil, true}, {'\x05', {nil, nil}, nil, nil, true},
                    {'\x06', {nil, nil}, nil, nil, true}, {'\x07', {nil, nil}, nil, nil, true}}

local function str2short(str)
    local f, n = pack.unpack(str, '<H')
    return f and f > 0 and n or 0
end

local function shorts(n)
    return pack.pack('<H', n)
end

local function sub_z(data, num)
    return string.sub(data, num + 1, data:len())
end
local function ip2num(str)
    if (not (str and #str == 4)) then
        return ''
    end
    local t = {pack.unpack(str, 'bbbb')}
    return string.format('%d.%d.%d.%d', t[2], t[3], t[4], t[5])
end
local function iptostr(ip)
    local d1, d2, d3, d4 = string.match(ip, '(%d+)%.(%d+)%.(%d+).(%d+)')
    log.info('iptostr', d1, d2, d3, d4, ip, type(ip))
    return {string.sub(shorts(d1), 1, 1), string.sub(shorts(d2), 1, 1), string.sub(shorts(d3), 1, 1),
            string.sub(shorts(d4), 1, 1)}
end

-- 不可达中断处理
local function getUnreachIpport()
    local unr = {'主机不可达', '网络不可达', '协议不可达', '端口不可达'}
    local result = sub_z(spi.send_recv(spi.SPI_1, '\x28\xff\xff\xff\xff\xff\xff\xff\xff'), 1)
    local data = string.sub(result, 1)
    if tonumber(data) < 4 then
        log.info('socketCh395', unr[data + 1])
    end
end

-- 中断处理函数
local function interruptProcess()
    local state = sub_z(spi.send_recv(spi.SPI_1, '\x19\xff\xff'), 1)
    if state  == '\x00\x00' then
        return
    end
    -- log.info('INT', state:toHex())
    state = str2short(state)
    if bit.isset(state, 1) then
        ch395State = false
        log.info("IP", 'IP conflict')
    end
    if bit.isset(state, 0) then
        -- 不可达中断
        ch395State = false
        log.info('socketCh395', 'Unreachable interrupt')
         --getUnreachIpport()
    end
    if bit.isset(state, 2) then
        -- PHY中断
        local a1 = sub_z(spi.send_recv(spi.SPI_1, '\x26\xff'), 1)
        if a1 == '\x01' then
            ch395State = false
            log.info('socketCh395', 'phy false')
        elseif a1 == '\x08' then
            ch395State = true
            log.info('socketCh395', 'phy true')
        end
    end
    if bit.isset(state, 3) then
        -- DHCP中断
        local a1 = sub_z(spi.send_recv(spi.SPI_1, '\x42\xff'), 1)
        if a1 == '\x00' then
            ch395State = true
            log.info('socketCh395', 'DHCP true')
        elseif a1 == '\x01' then
            ch395State = false
            log.info('socketCh395', 'DHCP false')
        end
    else
        for i = 4, 11 do
            if bit.isset(state, i) then
                local data1 = spi.send_recv(spi.SPI_1, string.char(0x30, (i - 4), 0xff, 0xff))
                local data2 = sub_z(data1, 2)
                if string.sub(data1, 3, 3) == '0x00' then
                    data1 = spi.send_recv(spi.SPI_1, string.char(0x30, (i - 4), 0xff, 0xff))
                    data2 = sub_z(data1, 2)
                end
                -- log.info('socketCh395-'..(i-4), 'INT ' .. data2:toHex())
                for q = 0, 6 do
                    if bit.isset(str2short(data2), q) then
                        if q == 0 then
                            for t = 1, #socket_connect do
                                if str2short(socket_connect[t][1] .. '\x00') == i - 4 then
                                    socket_connect[t][5] = true
                                    break
                                end
                            end
                        end
                        if q == 3 then
                            for p = 1, #socket_on do
                                if str2short(socket_on[p][1] .. '\x00') == i - 4 and
                                    (socket_on[p][4] == 1 or socket_on[p][4] == 0) then
                                    table.insert(socket_connect, socket_on[p])
                                    sys.publish('SOCK_CONN_CNF', {
                                        ['socket_index'] = i - 4,
                                        ['id'] = 34,
                                        ['result'] = 0
                                    })
                                elseif str2short(socket_on[p][1] .. '\x00') == i - 4 and socket_on[p][4] == 4 then
                                    local socketId = str2short(socket_on[p][1] .. '\x00')
                                    table.insert(socket_connect, socket_on[p])
                                    local data = string.sub(spi.send_recv(spi.SPI_1, string.char(0x2d, (i - 4), 0xff,
                                        0xff, 0xff, 0xff, 0xff, 0xff)), 3, 8)
                                    -- server
                                    local socketData = {
                                        id = socketId,
                                        ip = ip2num(string.sub(data, 1, 4)),
                                        port = str2short(string.sub(data, 5, 6))

                                    }
                                    sys.publish('tcpServer', socketData)
                                end
                            end
                        end
                        if q == 1 then
                            sys.publish('SOCK_SEND_CNF', {
                                ['socket_index'] = i - 4,
                                ['id'] = 32,
                                ['result'] = 0
                            })
                            spi.send_recv(spi.SPI_1, string.char(0x30, (i - 4), 0xff, 0xff))
                            spi.send_recv(spi.SPI_1, '\x19\xff\xff')
                            spi.send_recv(spi.SPI_1, string.char(0x30, (i - 4), 0xff, 0xff))
                        end
                        if q == 2 then
                            local data_leng = sub_z(spi.send_recv(spi.SPI_1, string.char(0x3b, (i - 4), 0xff, 0xff)), 2)
                            local data = sub_z(spi.send_recv(spi.SPI_1, string.char(0x3c, i - 4) .. data_leng ..
                                string.rep('\xff', str2short(data_leng))), 4)
                            sys.publish('MSG_SOCK_RECV_IND', {
                                ['socket_index'] = i - 4,
                                ['id'] = 31,
                                ['result'] = 0,
                                ['recv_len'] = str2short(data_leng),
                                ['recv_data'] = data
                            })
                            spi.send_recv(spi.SPI_1, '\x19\xff\xff')
                            spi.send_recv(spi.SPI_1, string.char(0x30, (i - 4), 0xff, 0xff))
                        end
                        if q == 4 then
                            for o = 1, #socket_connect do
                                if str2short(socket_connect[o][1] .. '\x00') == i - 4 then
                                    table.remove(socket_connect, o)
                                    for w = 1, #socket_on do
                                        if str2short(socket_on[w][1] .. '\x00') == i - 4 then
                                            log.info('colse', i - 4)
                                            sys.publish('MSG_SOCK_CLOSE_IND', {
                                                ['socket_index'] = i - 4,
                                                ['id'] = 33,
                                                ['result'] = 0
                                            })
                                            table.insert(socket_off, table.remove(socket_on, w))
                                            break
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
-- 中断计数
local number = 0
sys.taskInit(function()
    while true do
        if number > 0 or sys.waitUntil("interruptProcess") then
            interruptProcess()
            number = number - 1
            sys.wait(50)
        end
    end
end)

-- 配置中断检测
local function setInt(state)
    if state then
        pio.pin.setdebounce(5)
        pins.setup(networkDate['intPin'], function(a)
            if a == 2 then
                number = number + 1
                sys.publish("interruptProcess")
            else

            end
        end)
        pio.pin.setdebounce(20)
    else
        pins.close(networkDate['intPin'])
    end

end

local function initServer(port, num)
    num = num + 1
    if num > 8 then
        return
    end
    local serverid = nil
    for i = 1, num do
        spi.send_recv(spi.SPI_1, '\x34' .. socket_off[1][1] .. string.char(3))
        spi.send_recv(spi.SPI_1, '\x33' .. socket_off[1][1] .. shorts(port))
        if i == 1 then
            spi.send_recv(spi.SPI_1, '\x35' .. socket_off[1][1])
            serverid = socket_off[1][1]
            for w = 1, 5 do
                local dat = spi.send_recv(spi.SPI_1, '\x2c\xff')

                if sub_z(dat, 1) == '\x00' then
                    socket_off[1][3] = port
                    socket_off[1][4] = TCPSERVER
                    log.info('进入', socket_off[1][1]:toHex(), socket_off[1][4],
                        ('\x34' .. socket_off[1][1] .. string.char(3)):toHex())
                    table.insert(socket_on, table.remove(socket_off, 1))
                    break
                else
                    if w == 5 then
                        log.info('socket open err', dat:toHex())
                        log.info('socketCh395', 'socket open err')
                    end
                    sys.wait(200)
                end
            end
        else
            if sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1) == '\x00' then
                log.info('socketCh395', 'server open' .. socket_off[1][1]:toHex())
                socket_off[1][3] = port
                socket_off[1][4] = TCPSERVER
                table.insert(socket_on, table.remove(socket_off, 1))
            end
            if i == num then
                spi.send_recv(spi.SPI_1, '\x36' .. serverid)
                if sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1) == '\x00' then
                    return str2short(serverid .. '\x00')
                end
            end
        end
    end

end

-- 配置参数

--- 初始化CG395模块
-- @table para，取值如下：
--               para为table类型，表示以太网的配置参数，参数结构如下：
--                 {
--                     mode = 1,      --1表示客户端；2表示服务器；默认为1
--                     intPin = pio.P0_22,      --以太网芯片中断通知引脚
--                     rstPin = pio.P0_23,      --复位以太网芯片引脚
--                     localAddr = "192.168.1.112",      --本机的地址
--                     localPort = 1888,      --server本机的端口
--                     localGateway = "192.168.1.1",      --本机的网关地址
--                     func=function(id, msg, dat)end,     --中断处理函数，处理server中断事件
--                     powerFunc=function(state) end           --控制以太网模块的供电开关函数，ret为true开启供电，false关闭供电
--                     spi = {spi.SPI_1,0,0,8,800000},      --SPI通道参数，id,cpha,cpol,dataBits,clock，默认spi.SPI_1,0,0,8,800000
--                 }
-- @return result 数据接收结果
--                true表示成功
--                false表示失败
-- @usage
-- socketCh395.open(para)
function open(para)
    -- 复位
    networkDate = para
    powerCbFnc = nil or para['powerFunc']
    if powerCbFnc then
        powerCbFnc(true)
        ch395State = true
    end
    spi.send_recv(spi.SPI_1, '\x05')

    if not spi.setup(para['spi'][1], para['spi'][2], para['spi'][3], para['spi'][4], para['spi'][5], 1) == 1 then
        log.info('socketCh395', 'open spi err')
        return ''
    end
    setInt(true)
    local setGpioFnc_RSTI = pins.setup(para['rstPin'], 0)
    setGpioFnc_RSTI(0)
    sys.wait(600)
    setGpioFnc_RSTI(1)
    sys.wait(650)
    local data = string.sub(spi.send_recv(spi.SPI_1, '\x06\x55\xff'), 3, 3)
    log.info('CH395 state', data == '\xaa')
    if not data == '\xaa' then
        log.info('socketCh395', 'err cannot work')
        return ''
    end
    local num = 0
    CH395MAC = string.sub(spi.send_recv(spi.SPI_1, string.fromHex('40FFFFFFFFFFFF2cff')), 2, 7)
    if CH395MAC == string.char(0, 0, 0, 0, 0, 0) then
        CH395MAC = nil
    end
    CH395VERSION = string.sub(spi.send_recv(spi.SPI_1, '\x01\xff'), 2, 2)
    ch395State = true
    -- 开启多连接server
    if para['mode'] == 2 then
        log.info('open server')
        spi.send_recv(spi.SPI_1, '\x55\x02')
    end
    -- 配置8路缓存
    local b = 0
    for i = 0, 7 do
        spi.send_recv(spi.SPI_1, string.char(0x52, i, b, 4))
        b = b + 4
        spi.send_recv(spi.SPI_1, string.char(0x53, i, b, 2))
        b = b + 2
        sys.wait(500)
    end
    -- 配置本地信息，并初始化
    if para['localAddr'] ~= nil and para['localGateway'] ~= nil then
        -- 配置本地信息
        local gateway = iptostr(para['localGateway'])
        local addr = iptostr(para['localAddr'])

        spi.send_recv(spi.SPI_1, '\x22' .. addr[1] .. addr[2] .. addr[3] .. addr[4])
        spi.send_recv(spi.SPI_1, '\x23' .. gateway[1] .. gateway[2] .. gateway[3] .. gateway[4])
        if para['localSubnetMas'] then
            local subnetMas = iptostr(para['localSubnetMas'])
            spi.send_recv(spi.SPI_1, '\x24' .. subnetMas[1] .. subnetMas[2] .. subnetMas[3] .. subnetMas[4])
        end
    end
    -- 初始化
    -- 判断2c，成功则获取IP 
    -- 获取IP，有则return，无break
    spi.send_recv(spi.SPI_1, '\x27')
    for i = 1, 10 do
        sys.wait(500)
        local data2c = string.sub(spi.send_recv(spi.SPI_1, '\x2c\xff'), 2, -1)
        if data2c == '\x00' then
            log.info('socketCh395', 'INIT true')
            for q = 1, 10 do
                local dataIp = string.sub(spi.send_recv(spi.SPI_1,
                    string.fromHex('43ffffffffffffffffffffffffffffffffffffffff')), 2, -1)
                if link.getNetwork() == link.CH395 and string.sub(dataIp, 1, 4) ~= '\xff\xff\xff\xff' and
                    string.sub(dataIp, 1, 4) ~= '\x00\x00\x00\x00' then
                    local ch395Ip = ip2num(string.sub(dataIp, 1, 4))
                    log.info('ip', ch395Ip)
                    link.setReady(link.CH395, true)
                    sys.publish('IP_READY_IND')
                    return ch395Ip
                end
                sys.wait(500)
                if q == 10 and para['localAddr'] ~= nil and para['localGateway'] ~= nil then
                    return ''
                end
            end
            break
        elseif data2c == '\x13' then
            log.info('socketCh395', 'INIT false TIMEOUT')
            return ''
        else
            log.info('socketCh395', 'INIT ' .. data2c:toHex())
        end
    end
    -- DHCP
    -- 判断2c，成功则获取IP return
    for i = 1, 10 do
        -- DHCP
        spi.send_recv(spi.SPI_1, '\x41\x01')
        sys.wait(100)
        local data2c = string.sub(spi.send_recv(spi.SPI_1, '\x2c\xff'), 2, -1)
        if data2c == '\x00' then
            log.info('socketCh395', 'DHCP true')
            for q = 1, 10 do
                local dataIp = string.sub(spi.send_recv(spi.SPI_1,
                    string.fromHex('43ffffffffffffffffffffffffffffffffffffffff')), 2, -1)
                if link.getNetwork() == link.CH395 and string.sub(dataIp, 1, 4) ~= '\xff\xff\xff\xff' and
                    string.sub(dataIp, 1, 4) ~= '\x00\x00\x00\x00' then
                    local ch395Ip = ip2num(string.sub(dataIp, 1, 4))
                    log.info('ip', ch395Ip)
                    link.setReady(link.CH395, true)
                    sys.publish('IP_READY_IND')
                    return ch395Ip
                end
                sys.wait(500)
                if q == 10 then
                    return ''
                end
            end
        elseif data2c == '\x13' then
            log.info('socketCh395', 'INIT false TIMEOUT')
            return ''
        else
            log.info('socketCh395', 'INIT ' .. data2c:toHex())
        end
        -- 判断2c，成功则获取IP return
    end

    while true do
        if num == 10 then
            return ''
        end
        if para['mode'] == 2 then
            log.info('open server')
            spi.send_recv(spi.SPI_1, '\x55\x02')
        end
        CH395MAC = string.sub(spi.send_recv(spi.SPI_1, string.fromHex('40FFFFFFFFFFFF2cff')), 2, 7)
        if CH395MAC == string.char(0, 0, 0, 0, 0, 0) then
            CH395MAC = nil
        end
        CH395VERSION = string.sub(spi.send_recv(spi.SPI_1, '\x01\xff'), 2, 2)
        local data = {'\x27\xff', '\x41\x01\xff\xff', '\x2c\xff\xff', '\x19\xff\xff', '\x26\xff', '\x42\xff',
                      '\x19\xff\xff', '\x42\xff'}
        if para['mode'] == 2 and para['localAddr'] ~= nil and para['localGateway'] ~= nil then
            local gateway = iptostr(para['localGateway'])
            local addr = iptostr(para['localAddr'])
            data = {'\x22' .. addr[1] .. addr[2] .. addr[3] .. addr[4],
                    '\x23' .. gateway[1] .. gateway[2] .. gateway[3] .. gateway[4], '\x23\xC0\xA8\x01\x01', '\x27',
                    '\x2c\xff\xff', '\x19\xff\xff', '\x26\xff', '\x42\xff', '\x19\xff\xff', '\x42\xff'}
            for i = 1, #data do
                spi.send_recv(spi.SPI_1, data[i])
                sys.wait(500)
            end
        else
            for i = 1, #data do
                spi.send_recv(spi.SPI_1, data[i])
                sys.wait(500)
            end
        end

        sys.wait(3000)
        local dataIp = string.sub(
            spi.send_recv(spi.SPI_1, string.fromHex('43ffffffffffffffffffffffffffffffffffffffff')), 2, 21)
        if link.getNetwork() == link.CH395 and string.sub(dataIp, 1, 4) ~= '\xff\xff\xff\xff' and
            string.sub(dataIp, 1, 4) ~= '\x00\x00\x00\x00' then
            local ch395Ip = ip2num(string.sub(dataIp, 1, 4))
            log.info('ip', ch395Ip)
            local b = 0
            for i = 0, 7 do
                spi.send_recv(spi.SPI_1, string.char(0x52, i, b, 4))
                b = b + 4
                spi.send_recv(spi.SPI_1, string.char(0x53, i, b, 2))
                b = b + 2
                sys.wait(500)
            end
            link.setReady(link.CH395, true)
            sys.publish('IP_READY_IND')
            return ch395Ip
        end
        num = num + 1
    end
end
---  开关模块
function close()
    link.setReady(link.CH395, false)
    sys.publish('IP_ERROR_IND')
    -- 关闭中断检测
    setInt(false)
    -- 关闭SPI
    if not spi.close(networkDate['spi'][1]) == 1 then
        log.info('socketCh395 close spi err', networkDate['spi'][1], networkDate['spi'][2], networkDate['spi'][3],
            networkDate['spi'][4], networkDate['spi'][5], 1)
        return false
    end
    -- 已被连接
    socket_connect = {}
    -- 已开启socket数组
    socket_on = {}
    -- 未开启socket数组(索引，{IP，端口}，端口，协议类型)
    socket_off = {{'\x00', {nil, nil}, nil, nil}, {'\x01', {nil, nil}, nil, nil}, {'\x02', {nil, nil}, nil, nil},
                  {'\x03', {nil, nil}, nil, nil}, {'\x04', {nil, nil}, nil, nil}, {'\x05', {nil, nil}, nil, nil},
                  {'\x06', {nil, nil}, nil, nil}, {'\x07', {nil, nil}, nil, nil}}
    -- 关闭模块
    if powerCbFnc then
        powerCbFnc(false)
        ch395State = false
    end
    return true
end

---  初始化socket
-- @number ty，取值如下：
--              socketCh395.TCPCLIENT：TCP客户端
--              socketCh395.UDPCLIENT：UDP客户端
--              RAW：MAC 原始报文模式
--              TCPSERVER：TCP服务端
-- @string       IP，待连接的IP 
-- @string        port，待连接的端口
-- @string        loclaPort，本地的端口
-- @return result 数据接收结果
--                true表示成功
--                false表示失败
-- @usage
--

local function socketEth(ty, IP, port, rcvBufferSize, localPort)
    log.info('socketEth', ty, IP, port)
    local port1
    if #socket_off == 0 or not (ty < 5) then
        log.info('socketCh395', 'no socket')
        return nil
    end
    if ty == 4 and type(port) ~= nil then
        port1 = port
    elseif type(localPort) == "number" then
        port1 = localPort
    else
        local time = string.sub(rtos.tick(), 3)
        port1 = (str2short(socket_off[1][1] .. '\x00') + time) * 5
    end
    local id = str2short(socket_off[1][1] .. '\x00')
    spi.send_recv(spi.SPI_1, '\x19\xff\xff')
    spi.send_recv(spi.SPI_1, '\x30\xff\xff')
    if ty == 4 then
        local serverid = nil
        -- statements
        for i = 1, 8 do
            spi.send_recv(spi.SPI_1, '\x34' .. socket_off[1][1] .. string.char(3))
            spi.send_recv(spi.SPI_1, '\x33' .. socket_off[1][1] .. shorts(port1))
            if i == 1 then
                spi.send_recv(spi.SPI_1, '\x35' .. socket_off[1][1])
                serverid = socket_off[1][1]
                for w = 1, 5 do
                    local dat = spi.send_recv(spi.SPI_1, '\x2c\xff')

                    if sub_z(dat, 1) == '\x00' then
                        socket_off[1][3] = port1
                        socket_off[1][4] = ty
                        table.insert(socket_on, table.remove(socket_off, 1))
                        break
                    else
                        if w == 5 then
                            log.info('socket open err', dat:toHex())
                            log.info('socketCh395', 'socket open err')
                        end
                        sys.wait(200)
                    end
                end
            else
                if sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1) == '\x00' then
                    log.info('socketCh395', 'server open' .. socket_off[1][1]:toHex())
                    socket_off[1][3] = port1
                    socket_off[1][4] = ty
                    table.insert(socket_on, table.remove(socket_off, 1))
                end
                if i == 8 then
                    spi.send_recv(spi.SPI_1, '\x36' .. serverid)
                    if sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1) == '\x00' then
                        return str2short(serverid .. '\x00')
                    end
                end
            end
        end
    else
        if ty == 0 then
            spi.send_recv(spi.SPI_1, '\x34' .. socket_off[1][1] .. string.char(3))
        elseif ty == 1 then
            spi.send_recv(spi.SPI_1, '\x34' .. socket_off[1][1] .. string.char(2))
        end
        spi.send_recv(spi.SPI_1, '\x33' .. socket_off[1][1] .. shorts(port1))
        if ty == 0 or ty == 1 then
            spi.send_recv(spi.SPI_1, '\x32' .. socket_off[1][1] .. shorts(tonumber(port)))
            local addr = iptostr(IP)
            spi.send_recv(spi.SPI_1, '\x31' .. socket_off[1][1] .. addr[1] .. addr[2] .. addr[3] .. addr[4])
            spi.send_recv(spi.SPI_1, '\x35' .. socket_off[1][1])
            for w = 1, 5 do
                local dat = spi.send_recv(spi.SPI_1, '\x2c\xff')
                if sub_z(dat, 1) == '\x00' then
                    break
                else
                    if w == 5 then
                        log.info('socket open err' .. w .. 'socket' .. socket_off[1][1]:toHex(), dat:toHex())
                        log.info('socketCh395', 'socket open err')
                    end
                    sys.wait(200)
                end
            end
            spi.send_recv(spi.SPI_1, '\x37' .. socket_off[1][1])
            if ty == 1 then
                socket_off[1][3] = port
                socket_off[1][4] = ty
                local socketData = table.remove(socket_off, 1)
                table.insert(socket_on, socketData)
                table.insert(socket_connect, socketData)
                sys.timerStart(function()
                    sys.publish('SOCK_CONN_CNF', {
                        ['socket_index'] = id,
                        ['id'] = 34,
                        ['result'] = 0
                    })
                end, 500)
                return id
            end
        end
        local aa = string.sub(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1, -1)
        if not aa == '\x00' then
            log.info('socketCh395', '2c' .. aa:toHex())
            return nil
        end
        socket_off[1][3] = port
        socket_off[1][4] = ty
        table.insert(socket_on, table.remove(socket_off, 1))
        return id
    end
end

-- 关闭socket，需重重新初始化
local function closeEth(id)
    if sockets[id] and sockets[id].protocol == "TCPSERVER" then
        for i = #socket_on, 1, -1 do
            if socket_on[i][4] == TCPSERVER then
                spi.send_recv(spi.SPI_1, string.char(0x3D, str2short(socket_on[i][1] .. '\x00')))
                log.info('socketCh395', 'close socket ' .. str2short(socket_on[i][1] .. '\x00'))
                local a = sub_z(sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1), 2)
                table.insert(socket_off, table.remove(socket_on, i))
                if a == '\x00' then
                    log.info('close socket true')
                end
            end
        end

        for i = #socket_connect, 1, -1 do
            if socket_connect[i][4] == TCPSERVER then
                table.remove(socket_connect, i)
            end
        end
        return
    elseif not sockets[id] then
        for i = 1, #socket_on do
            if socket_on[i][4] == TCPSERVER then
                spi.send_recv(spi.SPI_1, string.char(0x38, str2short(socket_on[i][1] .. '\x00')))
                log.info('socketCh395', 'close socket ' .. str2short(socket_on[i][1] .. '\x00'))
                local a = sub_z(sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1), 2)
                if a == '\x00' then
                    log.info('close socket true')
                end
            end
        end
    end
    for o = 1, #socket_connect do
        if str2short(socket_connect[o][1] .. '\x00') == id then
            spi.send_recv(spi.SPI_1, string.char(0x3D, id))
            log.info('socketCh395', 'close socket ' .. id)
            local a = sub_z(sub_z(spi.send_recv(spi.SPI_1, '\x2c\xff'), 1), 2)
            if a == '\x00' then
                log.info('close socket true')
            end
            table.remove(socket_connect, o)
            for w = 1, #socket_on do
                if str2short(socket_on[w][1] .. '\x00') == id then
                    sys.publish('SOCK_CLOSE_CNF', {
                        ['socket_index'] = id,
                        ['id'] = 33,
                        ['result'] = 0
                    })
                    table.insert(socket_off, table.remove(socket_on, w))
                    return true
                end
            end
            break
        end
    end
end

-- 发送数据(参数1.socket id 2.数据)
local function sendETH(id, data)
    for i = 1, #socket_connect do
        if str2short(socket_connect[i][1] .. '\x00') == id then
            for q = 1, 5 do
                if socket_connect[i][5] then
                    socket_connect[i][5] = false
                    spi.send_recv(spi.SPI_1, '\x39' .. string.char(id) .. shorts(#data) .. data)
                    break
                end
                sys.wait(200)
            end
            break
        end
    end
end

-- 主动读取CH395缓冲区，缓冲区无数据返回nil,有数据则返回读取的数据
local function recv(id, len)
    local state = sub_z(spi.send_recv(spi.SPI_1, string.char(0x30, id, 0xff, 0xff)), 2)
    if not bit.isset(state, 2) then
        return nil
    end
    local data = spi.send_recv(spi.SPI_1, string.char(0x3c, id) .. len .. string.rep('\xff', shorts(len)))
    return sub_z(data, 4)
end

-- sys.taskInit(function(...)
--     sys.wait(15000)
--     sys.timerLoopStart(function(...)
--         log.info('看看', #socket_off, #socket_on, #socket_connect)
--     end,5000)
-- end)

------------------------------------------------------------------------------------------------------

local function errorInd(error)
    local coSuspended = {}

    for _, c in pairs(sockets) do -- IP状态出错时，通知所有已连接的socket
        c.error = error
        -- 不能打开如下3行代码，IP出错时，会通知每个socket，socket会主动close
        -- 如果设置了connected=false，则主动close时，直接退出，不会执行close动作，导致core中的socket资源没释放
        -- 会引发core中socket耗尽以及socket id重复的问题
        -- c.connected = false
        -- socketsConnected = c.connected or socketsConnected
        -- if error == 'CLOSED' then sys.publish("SOCKET_ACTIVE", socketsConnected) end
        if c.co and coroutine.status(c.co) == "suspended" then
            -- coroutine.resume(c.co, false)
            table.insert(coSuspended, c.co)
        end
    end

    for k, v in pairs(coSuspended) do
        if v and coroutine.status(v) == "suspended" then
            coroutine.resume(v, false, error)
        end
    end
end

sys.subscribe("IPCH395_ERROR_IND", function()
    errorInd('IPCH395_ERROR_IND')
end)
-- sys.subscribe('IP_SHUT_IND', function()errorInd('CLOSED') end)
-- 创建socket函数
local mt = {}
mt.__index = mt
function socket(protocol, cert, tCoreExtPara, port)
    local ssl
    if type(protocol) ~= 'table' then
        ssl = protocol:match("SSL")
    end
    local co = coroutine.running()
    if not co then
        log.warn("socket.socket: socket must be called in coroutine")
        return nil
    end
    -- 实例的属性参数表
    local o = {
        id = nil,
        protocol = protocol,
        tCoreExtPara = tCoreExtPara,
        ssl = ssl,
        cert = cert,
        co = co,
        input = {},
        output = {},
        wait = "",
        connected = false,
        iSubscribe = false,
        subMessage = nil,
        isBlock = false,
        msg = nil,
        rcvProcFnc = nil,
        localport = port
    }
    if protocol == 'TCPSERVER' then
        local id = initServer(networkDate["localPort"], networkDate["clientNum"])
        if not id then
            log.info('socketCh395', 'server socket err')
            return
        end
        o.id = id
        sockets[o.id] = setmetatable(o, mt)
    elseif type(protocol) == 'table' then
        o.id = protocol['id']
        o.address = protocol['ip']
        o.port = protocol['port']
        sockets[o.id] = setmetatable(o, mt)
    end
    return setmetatable(o, mt)
end

--- 创建基于TCP的socket对象
-- 注意：CH395不支持ssl
-- @ ssl，是否为ssl连接，true表示是，其余表示否。number类型代表设定本地端口
-- @table[opt=nil] cert，ssl连接需要的证书配置，只有ssl参数为true时，此参数才有意义，cert格式如下：
-- {
--     caCert = "ca.crt", --CA证书文件(Base64编码 X.509格式)，如果存在此参数，则表示客户端会对服务器的证书进行校验；不存在则不校验
--     clientCert = "client.crt", --客户端证书文件(Base64编码 X.509格式)，服务器对客户端的证书进行校验时会用到此参数
--     clientKey = "client.key", --客户端私钥文件(Base64编码 X.509格式)
--     clientPassword = "123456", --客户端证书文件密码[可选]
-- }
-- @return client，创建成功返回socket客户端对象；创建失败返回nil
-- @usage
-- c = socket.tcp()
-- c = socket.tcp(true)
-- c = socket.tcp(true, {caCert="ca.crt"})
-- c = socket.tcp(true, {caCert="ca.crt", clientCert="client.crt", clientKey="client.key"})
-- c = socket.tcp(true, {caCert="ca.crt", clientCert="client.crt", clientKey="client.key", clientPassword="123456"})
function tcp(ssl, cert, tCoreExtPara)
    if ssl == "TCPSERVER" then
        return socket("TCPSERVER")
    elseif type(ssl) == 'table' then
        return socket(ssl)
    end
    return socket("TCP" .. (ssl == true and "SSL" or ""), (ssl == true) and cert or nil, tCoreExtPara, ssl)
end

-- --- 创建基于UDP的socket对象
-- -- @return client，创建成功返回socket客户端对象；创建失败返回nil
-- -- @usage c = socket.udp()
function udp()
    return socket("UDP")
end

--- 连接服务器
-- @string address 服务器地址，支持ip和域名
-- @param port string或者number类型，服务器端口
-- @number[opt=120] timeout 可选参数，连接超时时间，单位秒
-- @return bool result true - 成功，false - 失败
-- @return string ,id '0' -- '8' ,返回通道ID编号
-- @usage  
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
function mt:connect(address, port, timeout)
    assert(self.co == coroutine.running(), "socket:connect: coroutine mismatch")
    if not link.isReady() then
        log.info("socket.connect: ip not ready")
        return false
    end
    if type(address) == "string" then
        self.address = address
        self.port = port
    end
    local tCoreExtPara = self.tCoreExtPara or {}
    -- 默认缓冲区大小
    local rcvBufferSize = tCoreExtPara.rcvBufferSize or 0
    if self.protocol == 'TCP' then
        local d1, d2, d3, d4 = string.match(address, '(%d+)%.(%d+)%.(%d+).(%d+)')
        if not (d1 == nil or d2 == nil or d3 == nil or d4 == nil) then
            self.id = socketEth(TCPCLIENT, address, port, rcvBufferSize, self.localport)
        else
            self.id = -2
        end
    elseif self.protocol == 'TCPSSL' then
        log.info("socketCh395", "no ssl")
        self.id = nil
    elseif self.protocol == 'TCPSERVER' and type(address) == 'table' then
        self.id = address['id']
        self.address = address['ip']
        self.port = address['port']
        log.info("socket:connect: connect ok")
        sockets[self.id] = self
        return true, self.id
    else
        local d1, d2, d3, d4 = string.match(address, '(%d+)%.(%d+)%.(%d+).(%d+)')
        if not (d1 == nil or d2 == nil or d3 == nil or d4 == nil) then
            self.id = socketEth(UDPCLIENT, address, port, rcvBufferSize, self.localport)
        else
            self.id = -2
        end
    end
    if type(socketEth) == "function" then
        if not self.id or self.id < 0 then
            if self.id == -2 then
                require "http"
                -- 请求腾讯云免费HttpDns解析
                http.request("GET", "119.29.29.29/d?dn=" .. address, nil, nil, nil, 40000,
                    function(result, statusCode, head, body)
                        log.info("socket.httpDnsCb", result, statusCode, head, body)
                        sys.publish("SOCKET_HTTPDNS_RESULT_" .. address .. "_" .. port, result, statusCode, head, body)
                    end)
                local _, result, statusCode, head, body = sys.waitUntil(
                    "SOCKET_HTTPDNS_RESULT_" .. address .. "_" .. port)
                -- DNS解析成功
                if result and statusCode == "200" and body and body:match("^[%d%.]+") then
                    return self:connect(body:match("^([%d%.]+)"), port, timeout)
                end
            end
            self.id = nil
        end
    end
    if not self.id then
        log.info("socket:connect: core sock conn error", self.protocol, address, port, self.cert)
        return false
    end
    log.info("socket:connect-coreid,prot,addr,port,cert,timeout", self.id, self.protocol, address, port, self.cert,
        timeout or 120)
    sockets[self.id] = self
    self.wait = "SOCKET_CONNECT"
    self.timerId = sys.timerStart(coroutine.resume, (timeout or 120) * 1000, self.co, false, "TIMEOUT")
    local result, reason = coroutine.yield()
    if self.timerId and reason ~= "TIMEOUT" then
        sys.timerStop(self.timerId)
    end
    if not result then
        log.info("socket:connect: connect fail", reason)
        if reason == "RESPONSE" then
            sockets[self.id] = nil
            self.id = nil
        end
        sys.publish("LIB_SOCKET_CONNECT_FAIL_IND", self.ssl, self.protocol, address, port)
        return false
    end
    log.info("socket:connect: connect ok")

    if not self.connected then
        self.connected = true
        socketsConnected = socketsConnected + 1
        sys.publish("SOCKET_ACTIVE", socketsConnected > 0)
    end

    return true, self.id
end

--- server发送数据
-- @number[opt=nil] keepAlive,服务器和客户端最大通信间隔时间,也叫心跳包最大时间,单位秒
-- @string[opt=nil] pingreq,心跳包的字符串
-- @return boole,false 失败，true 表示成功
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- while socketClient:serverSelect() do end
function mt:serverSelect(keepAlive, pingreq)
    assert(self.co == coroutine.running(), "socket:asyncSelect: coroutine mismatch")
    if self.error then
        log.warn('socket.client:asyncSelect', 'error', self.error)
        return false
    end
    if not ch395State then
        log.info('socketCh395', 'CH395 err')
        return false
    end
    self.wait = "SOCKET_SEND"
    local dataLen = 0
    -- log.info("socket.asyncSelect #self.output",#self.output)
    while #self.output ~= 0 do
        local data = table.concat(self.output)
        dataLen = string.len(data)
        self.output = {}
        local sendSize = SENDSIZE
        for i = 1, dataLen, sendSize do
            -- 按最大MTU单元对data分包
            sendETH(self.id, data:sub(i, i + sendSize - 1))
            log.info('超时时间', self.timeout)
            if self.timeout then
                self.timerId = sys.timerStart(coroutine.resume, self.timeout * 1000, self.co, false, "TIMEOUT")
            end
            -- log.info("socket.asyncSelect self.timeout",self.timeout)
            local result, reason = coroutine.yield()
            if self.timerId and reason ~= "TIMEOUT" then
                sys.timerStop(self.timerId)
            end
            sys.publish("SOCKET_ASYNC_SEND", result)
            if not result then
                sys.publish("LIB_SOCKET_SEND_FAIL_IND", self.ssl, self.protocol, self.address, self.port)
                log.warn('socket.asyncSelect', 'send error', data:sub(i, i + sendSize - 1))
                return false
            end
        end
    end
    self.wait = "SOCKET_WAIT"
    -- log.info("socket.asyncSelect",dataLen,self.id)
    if dataLen > 0 then
        sys.publish("SOCKET_SEND", self.id, true)
    end
    if keepAlive and keepAlive ~= 0 then
        if type(pingreq) == "function" then
            sys.timerStart(pingreq, keepAlive * 1000)
        else
            sys.timerStart(self.asyncSend, keepAlive * 1000, self, pingreq or "\0")
        end
    end
    return coroutine.yield()
end

--- 异步发送数据
-- @number[opt=nil] keepAlive,服务器和客户端最大通信间隔时间,也叫心跳包最大时间,单位秒
-- @string[opt=nil] pingreq,心跳包的字符串
-- @return boole,false 失败，true 表示成功
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- while socketClient:asyncSelect() do end
function mt:asyncSelect(keepAlive, pingreq)
    assert(self.co == coroutine.running(), "socket:asyncSelect: coroutine mismatch")
    if self.error then
        log.warn('socket.client:asyncSelect', 'error', self.error)
        return false
    end

    self.wait = "SOCKET_SEND"
    local dataLen = 0
    -- log.info("socket.asyncSelect #self.output",#self.output)
    while #self.output ~= 0 do
        local data = table.concat(self.output)
        dataLen = string.len(data)
        self.output = {}
        local sendSize = SENDSIZE
        for i = 1, dataLen, sendSize do
            -- 按最大MTU单元对data分包
            sendETH(self.id, data:sub(i, i + sendSize - 1))
            if self.timeout then
                self.timerId = sys.timerStart(coroutine.resume, self.timeout * 1000, self.co, false, "TIMEOUT")
            end
            -- log.info("socket.asyncSelect self.timeout",self.timeout)
            local result, reason = coroutine.yield()
            if self.timerId and reason ~= "TIMEOUT" then
                sys.timerStop(self.timerId)
            end
            sys.publish("SOCKET_ASYNC_SEND", result)
            if not result then
                sys.publish("LIB_SOCKET_SEND_FAIL_IND", self.ssl, self.protocol, self.address, self.port)
                log.warn('socket.asyncSelect', 'send error', data:sub(i, i + sendSize - 1))
                return false
            end
        end
    end
    self.wait = "SOCKET_WAIT"
    -- log.info("socket.asyncSelect",dataLen,self.id)
    if dataLen > 0 then
        sys.publish("SOCKET_SEND", self.id, true)
    end
    if keepAlive and keepAlive ~= 0 then
        if type(pingreq) == "function" then
            sys.timerStart(pingreq, keepAlive * 1000)
        else
            sys.timerStart(self.asyncSend, keepAlive * 1000, self, pingreq or "\0")
        end
    end
    return coroutine.yield()
end

function mt:getAsyncSend()
    if self.error then
        return 0
    end
    return #(self.output)
end

--- server缓存待发送的数据
-- @string data 数据
-- @number[opt=nil] timeout 可选参数，发送超时时间，单位秒；为nil时表示不支持timeout
-- @return result true - 成功，false - 失败
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- socketClient:serverSend("12345678")
function mt:serverSend(data, timeout)
    if self.error then
        log.warn('socket.client:asyncSend', 'error', self.error)
        return false
    end
    self.timeout = timeout
    table.insert(self.output, data or "")
    -- log.info("socket.asyncSend",self.wait)
    if self.wait == "SOCKET_WAIT" then
        coroutine.resume(self.co, true)
    end
    return true
end
--- server接收数据
-- @return data 表示接收到的数据(如果是UDP，返回最新的一包数据；如果是TCP,返回所有收到的数据)
--              ""表示未收到数据
-- @usage 
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- data = socketClient:serverRecv()
function mt:serverRecv()
    if #self.input == 0 then
        return ""
    end
    if self.protocol == "UDP" then
        return table.remove(self.input)
    else
        local s = table.concat(self.input)
        self.input = {}
        if self.isBlock then
            table.insert(self.input, recv(self.msg.socket_index, self.msg.recv_len))
        end
        return s
    end
end

--- 异步缓存待发送的数据
-- @string data 数据
-- @number[opt=nil] timeout 可选参数，发送超时时间，单位秒；为nil时表示不支持timeout
-- @return result true - 成功，false - 失败
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- socketClient:asyncSend("12345678")
function mt:asyncSend(data, timeout)
    if self.error then
        log.warn('socket.client:asyncSend', 'error', self.error)
        return false
    end
    self.timeout = timeout
    table.insert(self.output, data or "")
    -- log.info("socket.asyncSend",self.wait)
    if self.wait == "SOCKET_WAIT" then
        coroutine.resume(self.co, true)
    end
    return true
end
--- 异步接收数据
-- @return data 表示接收到的数据(如果是UDP，返回最新的一包数据；如果是TCP,返回所有收到的数据)
--              ""表示未收到数据
-- @usage 
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- data = socketClient:asyncRecv()
function mt:asyncRecv()
    if #self.input == 0 then
        return ""
    end
    if self.protocol == "UDP" then
        return table.remove(self.input)
    else
        local s = table.concat(self.input)
        self.input = {}
        if self.isBlock then
            table.insert(self.input, recv(self.msg.socket_index, self.msg.recv_len))
        end
        return s
    end
end

--- 同步发送数据
-- @string data 数据
--              此处传入的数据长度和剩余可用内存有关，只要内存够用，可以随便传入数据
--              虽然说此处的数据长度没有特别限制，但是调用core中的socket发送接口时，每次最多发送11200字节的数据
--              例如此处传入的data长度是112000字节，则在这个send接口中，会循环10次，每次发送11200字节的数据
-- @number[opt=120] timeout 可选参数，发送超时时间，单位秒
-- @return result true - 成功，false - 失败
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- socketClient:send("12345678")
function mt:send(data, timeout)
    assert(self.co == coroutine.running(), "socket:send: coroutine mismatch")
    if self.error then
        log.warn('socket.client:send', 'error', self.error)
        return false
    end
    log.debug("socket.send", "total " .. string.len(data or "") .. " bytes", "first 30 bytes", (data or ""):sub(1, 30))
    local sendSize = SENDSIZE
    for i = 1, string.len(data or ""), sendSize do
        -- 按最大MTU单元对data分包
        self.wait = "SOCKET_SEND"
        sendETH(self.id, data:sub(i, i + sendSize - 1))
        -- socketcore.sock_send(self.id, data:sub(i, i + sendSize - 1))
        self.timerId = sys.timerStart(coroutine.resume, (timeout or 120) * 1000, self.co, false, "TIMEOUT")
        local result, reason = coroutine.yield()
        if self.timerId and reason ~= "TIMEOUT" then
            sys.timerStop(self.timerId)
        end
        if not result then
            log.info("socket:send", "send fail", reason, self.id)
            sys.publish("LIB_SOCKET_SEND_FAIL_IND", self.ssl, self.protocol, self.address, self.port)
            return false
        end
    end
    return true
end

--- 同步接收数据
-- @number[opt=0] timeout 可选参数，接收超时时间，单位毫秒
-- @string[opt=nil] msg 可选参数，控制socket所在的线程退出recv阻塞状态
-- @bool[opt=nil] msgNoResume 可选参数，控制socket所在的线程退出recv阻塞状态
--                false或者nil表示“在recv阻塞状态，收到msg消息，可以退出阻塞状态”，true表示不退出
--                此参数仅lib内部使用，应用脚本不要使用此参数
-- @return result 数据接收结果
--                true表示成功（接收到了数据）
--                false表示失败（没有接收到数据）
-- @return data 
--                如果result为true，data表示接收到的数据(如果是UDP，返回最新的一包数据；如果是TCP,返回所有收到的数据)
--                如果result为false，超时失败，data为"timeout"
--                如果result为false，msg控制退出，data为msg的字符串
--                如果result为false，socket连接被动断开控制退出，data为"CLOSED"
--                如果result为false，PDP断开连接控制退出，data为"IPCH395_ERROR_IND"
-- @return param 如果是msg控制退出，param的值是msg的参数
-- @usage 
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- result,data = socketClient:recv(60000,"APP_SOCKET_SEND_DATA")
function mt:recv(timeout, msg, msgNoResume)
    assert(self.co == coroutine.running(), "socket:recv: coroutine mismatch")
    if self.error then
        log.warn('socket.client:recv', 'error', self.error)
        return false
    end
    self.msgNoResume = msgNoResume
    if msg and not self.iSubscribe then
        self.iSubscribe = msg
        self.subMessage = function(data)
            -- if data then table.insert(self.output, data) end
            if self.wait == "+RECEIVE" and not self.msgNoResume then
                if data then
                    table.insert(self.output, data)
                end
                coroutine.resume(self.co, 0xAA)
            end
        end
        sys.subscribe(msg, self.subMessage)
    end
    if msg and #self.output > 0 then
        sys.publish(msg, false)
    end
    if #self.input == 0 then
        self.wait = "+RECEIVE"
        if timeout and timeout > 0 then
            local r, s = sys.wait(timeout)
            if r == nil then
                return false, "timeout"
            elseif r == 0xAA then
                local dat = table.concat(self.output)
                self.output = {}
                return false, msg, dat
            else
                return r, s
            end
        else
            local r, s = coroutine.yield()
            if r == 0xAA then
                local dat = table.concat(self.output)
                self.output = {}
                return false, msg, dat
            else
                return r, s
            end
        end
    end

    if self.protocol == "UDP" then
        local s = table.remove(self.input)
        return true, s
    else
        log.warn("-------------------使用缓冲区---------------")
        local s = table.concat(self.input)
        self.input = {}
        if self.isBlock then
            table.insert(self.input, recv(self.msg.socket_index, self.msg.recv_len))
        end
        return true, s
    end
end

--- 主动关闭并且销毁一个socket
-- @return nil
-- @usage
-- socketClient = socket.tcp()
-- socketClient:connect("www.baidu.com","80")
-- socketClient:close()
function mt:close()
    assert(self.co == coroutine.running(), "socket:close: coroutine mismatch")
    if self.iSubscribe then
        sys.unsubscribe(self.iSubscribe, self.subMessage)
        self.iSubscribe = false
    end
    -- 此处不要再判断状态，否则在连接超时失败时，conneted状态仍然是未连接，会导致无法close
    -- if self.connected then
    local serverId = {}
    if self.protocol == 'TCPSERVER' and self.id then
        for i = 1, #socket_on do
            log.info('得到的数据', socket_on[i][1]:toHex(), socket_on[i][4])
            if socket_on[i][4] == TCPSERVER then
                table.insert(serverId, str2short(socket_on[i][1] .. '\x00'))
            end

        end

    end
    log.info('得到数据11', #serverId)
    for i = 1, #serverId do
        closeEth(serverId[i])
        if i == #serverId then
            return
        end
    end

    log.info("socket:sock_close", self.id)
    local result, reason
    if self.id then
        closeEth(self.id)
        self.wait = "SOCKET_CLOSE"
        while true do
            result, reason = coroutine.yield()
            if reason == "RESPONSE" then
                break
            end
        end
    end
    if self.connected then
        self.connected = false
        if socketsConnected > 0 then
            socketsConnected = socketsConnected - 1
        end
        sys.publish("SOCKET_ACTIVE", socketsConnected > 0)
    end
    if self.input then
        self.input = {}
    end
    -- end
    if self.id ~= nil then
        sockets[self.id] = nil
    end
end

-- socket接收自定义控制处理
-- @function[opt=nil] rcvCbFnc，socket接收到数据后，执行的回调函数，回调函数的调用形式为：
-- rcvCbFnc(readFnc,socketIndex,rcvDataLen)
-- rcvCbFnc内部，会判断是否读取数据，如果读取，执行readFnc(socketIndex,rcvDataLen)，返回true；否则返回false或者nil
function mt:setRcvProc(rcvCbFnc)
    assert(self.co == coroutine.running(), "socket:setRcvProc: coroutine mismatch")
    self.rcvProcFnc = rcvCbFnc
end

function on_response(msg)
    local t = {
        [rtos.MSG_SOCK_CLOSE_CNF] = 'SOCKET_CLOSE',
        -- 33
        [rtos.MSG_SOCK_SEND_CNF] = 'SOCKET_SEND',
        -- 32
        [rtos.MSG_SOCK_CONN_CNF] = 'SOCKET_CONNECT'
        -- 34
    }
    if not sockets[msg.socket_index] then
        log.warn('response on nil socket', msg.socket_index, t[msg.id], msg.result)
        return
    end
    if sockets[msg.socket_index].wait ~= t[msg.id] then
        log.warn('response on invalid wait', sockets[msg.socket_index].id, sockets[msg.socket_index].wait, t[msg.id],
            msg.socket_index)
        return
    end
    log.info('socket:on_response:', msg.socket_index, t[msg.id], msg.result)
    -- if type(socketcore.sock_destroy) == 'function' then
    --     if (msg.id == rtos.MSG_SOCK_CONN_CNF and msg.result ~= 0) or msg.id == rtos.MSG_SOCK_CLOSE_CNF then
    --         socketcore.sock_destroy(msg.socket_index)
    --     end
    -- end
    coroutine.resume(sockets[msg.socket_index].co, msg.result == 0, 'RESPONSE')
end
sys.subscribe('SOCK_CONN_CNF', on_response)
sys.subscribe('SOCK_CLOSE_CNF', on_response)
sys.subscribe('SOCK_SEND_CNF', on_response)
-- 被动关闭
sys.subscribe('MSG_SOCK_CLOSE_IND', function(msg)
    log.info('socket.rtos.MSG_SOCK_CLOSE_IND')
    if not sockets[msg.socket_index] then
        log.warn('close ind on nil socket', msg.socket_index, msg.id)
        return
    end
    if sockets[msg.socket_index].connected then
        sockets[msg.socket_index].connected = false
        if socketsConnected > 0 then
            socketsConnected = socketsConnected - 1
        end
        sys.publish('SOCKET_ACTIVE', socketsConnected > 0)
    end
    sockets[msg.socket_index].error = 'CLOSED'

    --[[
    if type(socketcore.sock_destroy) == "function" then
        socketcore.sock_destroy(msg.socket_index)
    end]]
    sys.publish('LIB_SOCKET_CLOSE_IND', sockets[msg.socket_index].ssl, sockets[msg.socket_index].protocol,
        sockets[msg.socket_index].address, sockets[msg.socket_index].port)
    coroutine.resume(sockets[msg.socket_index].co, false, 'CLOSED')
end)
sys.subscribe('MSG_SOCK_RECV_IND', function(msg)
    if not sockets[msg.socket_index] then
        log.warn('close ind on nil socket', msg.socket_index, msg.id)
        return
    end
    log.debug('socket.recv', msg.recv_len, sockets[msg.socket_index].rcvProcFnc)
    if sockets[msg.socket_index].rcvProcFnc then
        sockets[msg.socket_index].rcvProcFnc(msg.recv_data)
    else
        if sockets[msg.socket_index].wait == '+RECEIVE' then
            coroutine.resume(sockets[msg.socket_index].co, true, msg.recv_data)
        else -- 数据进缓冲区，缓冲区溢出采用覆盖模式
            if #sockets[msg.socket_index].input > INDEX_MAX then
                log.error('socket recv', 'out of stack', 'block')
                -- sockets[msg.socket_index].input = {}
                sockets[msg.socket_index].isBlock = true
                sockets[msg.socket_index].msg = msg
            else
                sockets[msg.socket_index].isBlock = false
                table.insert(sockets[msg.socket_index].input, msg.recv_data)
            end
            sys.publish('SOCKET_RECV', msg.socket_index)
        end
    end
end)
