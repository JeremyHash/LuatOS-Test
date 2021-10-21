PROJECT = "keypadTest"
VERSION = "1.0.0"

require "sys"
require "common"
require "misc"
require "pins"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local function keyMsg(msg)

    log.info("keyMsg",msg.key_matrix_row,msg.key_matrix_col,msg.pressed)
end


--注册按键消息处理函数
rtos.on(rtos.MSG_KEYPAD,keyMsg)
rtos.init_module(rtos.MOD_KEYPAD,0,0x0F,0x0F)




sys.init(0, 0)
sys.run()