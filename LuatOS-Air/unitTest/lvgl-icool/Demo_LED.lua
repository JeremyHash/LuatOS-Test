---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个LED----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/led.html
]]
function demo_LEDInit()
    --创建一个 LED1
    demo_LED1 = lvgl.led_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_LED1, 80, 80)
    --关闭 LED
    lvgl.led_off(demo_LED1)
    --设置 LED 的位置
    lvgl.obj_align(demo_LED1, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, -140)
--------------------------------------------------------------------------------------
    --创建一个 LED2
    demo_LED2 = lvgl.led_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_LED2, 80, 80)
    --设置 LED 的亮度
    lvgl.led_set_bright(demo_LED2, 200)
    --设置 LED 的位置
    lvgl.obj_align(demo_LED2, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
--------------------------------------------------------------------------------------
    --创建一个 LED3
    demo_LED3 = lvgl.led_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_LED3, 80, 80)
    --打开 LED
    lvgl.led_on(demo_LED3)
    --设置 LED 的位置
    lvgl.obj_align(demo_LED3, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 140)
    --添加样式
    lvgl.obj_add_style(demo_LED1, lvgl.LED_PART_MAIN, demo_LEDStyle_Red)
    lvgl.obj_add_style(demo_LED2, lvgl.LED_PART_MAIN, demo_LEDStyle_Yellow)
    lvgl.obj_add_style(demo_LED3, lvgl.LED_PART_MAIN, demo_LEDStyle_Green)
end