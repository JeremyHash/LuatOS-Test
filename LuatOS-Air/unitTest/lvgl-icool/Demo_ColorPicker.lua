---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个ColorPicker----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/cpicker.html
]]
function demo_CPickerInit()
    --创建一个 ColorPicker
    demo_CPicker = lvgl.cpicker_create(lvgl.scr_act(), nil)
    --设置 ColorPicker 的大小
    lvgl.obj_set_size(demo_CPicker, 380, 380)
    --设置 ColorPicker 的位置
    lvgl.obj_align(demo_CPicker, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_CPicker, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
end