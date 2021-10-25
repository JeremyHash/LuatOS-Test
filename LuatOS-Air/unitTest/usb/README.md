# USB测试
## 网卡
### 1.1 ecm/rndis切换
    AT+SETUSB=2 设置成ECM网卡
    AT+SETUSB=2 设置成RNDIS网卡
### 1.2 up/down
    up
        (1) testserver服务器 /home/testserver/文档 路径下
        (2) 选择合适的文件直接拖拽上传
    down
        (1) testserver服务器 /home/testserver/Jeremy/tcp 路径下开启服务 python3 -m http.server 8000
        (2) wget http://wiki.airm2m.com:48000/xx  选择需要的文件下载
### 1.3 mac设置
    待补充
## 2、USB驱动 Linux
### 2.1 枚举测试
    (1) 选择一台编译好内核的Linux电脑，接上模块，查询端口 ls /dev/ttyUSB*
    (2) 重复上面的步骤100次
### 2.2 suspend/resume测试
    待补充
### 2.3 at控制usb打开和关闭
    AT+USBSWITCH=0 关闭
    AT+USBSWITCH=1 打开
