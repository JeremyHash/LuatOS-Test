---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Button----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/btn.html
]]
function demo_BtnInit()
    --创建一个 Button
    demo_Btn = lvgl.btn_create(lvgl.scr_act(), nil)
    --设置 Button 的大小
    lvgl.obj_set_size(demo_Btn, 200, 80)
    --设置 Button 的位置
    lvgl.obj_align(demo_Btn, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Btn, lvgl.BTN_PART_MAIN, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(demo_Btn, lvgl.BTN_PART_MAIN, demo_ThemeStyle_IndicAndFont)
end