# socketKeepAlive

## 测试功能
socket的长连接保活测试，通过以下代码设置socket的保活探针
```lua
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
```

## 测试方法
设置需要连接的服务器ip和端口
```lua
local result, id = socketClient:connect("112.125.89.8", "33211")
```
观察到连接成功日志后模块放置30分钟请勿操作，30分钟后从socket服务器向模块发送数据，观察模块是否能收到数据

## 预期结果
放置30分钟后，模块依然可以正常收到socket服务器下发的数据，说明socket保活设置成功