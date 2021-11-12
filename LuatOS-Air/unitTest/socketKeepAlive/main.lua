-- socketKeepAlive
-- Author:openluat
-- CreateDate:20211112
-- UpdateDate:20211112
PROJECT = "socketKeepAlive"
VERSION = "1.0.0"
PRODUCT_KEY = "LMe0gb26NhPbBZ7t3mSk3dxA8f4ZZmM1"

require "sys"
require "net"
require "log"
require "common"
require "utils"
require "patch"
require "socket"

LOG_LEVEL = log.LOGLEVEL_TRACE

local tag = "socketKeepAlive"

sys.taskInit(function()

    sys.waitUntil("IP_READY_IND")

    local socketClient = socket.tcp()
    local result, id = socketClient:connect("112.125.89.8", "33211")
    if result then
        log.info(tag .. ".connect", "SUCCESS")
        sys.subscribe("SOCKET_RECV", function(id)
            if socketClient.id == id then
                local data = socketClient:asyncRecv()
                log.info(tag .. ".receiveDataLen", #data)
                log.info(tag .. ".receiveData", data)
            end
        end)
        -- 开启保活功能
        socketcore.sock_setopt(id, socketcore.SOL_SOCKET,
                               socketcore.SO_KEEPALIVE, 1)
        -- 在sendtime秒内，链接上无任何数据交互，则发送初始保活探针
        socketcore.sock_setopt(id, socketcore.IPPROTO_TCP,
                               socketcore.TCP_KEEPIDLE, 150)
        -- 如果保活探针发送失败，timeout秒再次重传
        socketcore.sock_setopt(id, socketcore.IPPROTO_TCP,
                               socketcore.TCP_KEEPINTVL, 60)
        -- 保活探针的最大重传数量为retrans
        socketcore.sock_setopt(id, socketcore.IPPROTO_TCP,
                               socketcore.TCP_KEEPCNT, 3)
    else
        log.error(tag .. ".connect", "FAIL")
        socketClient:close()
    end
end)

-- 死机断言
ril.request("AT*EXASSERT=1")

-- 开启APTRACE
-- ril.request("AT^TRACECTRL=0,1,1")

-- 默认关闭RNDIS网卡
ril.request("AT+RNDISCALL=0,1")

-- 启动系统框架
sys.init(0, 0)
sys.run()
