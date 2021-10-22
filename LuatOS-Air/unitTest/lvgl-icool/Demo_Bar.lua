---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Bar----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/bar.html
]]
function demo_BarInit()
    --创建一个 Bar
    demo_Bar = lvgl.bar_create(lvgl.scr_act(), nil)
    --设置 Bar 的大小
    lvgl.obj_set_size(demo_Bar, 400, 40)
    --设置 Bar 的位置
    lvgl.obj_align(demo_Bar, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --设置动画时间
    lvgl.bar_set_anim_time(demo_Bar, 6000)
    --为 Bar 添加动画
    lvgl.bar_set_value(demo_Bar, 100, lvgl.ANIM_ON)
    --添加样式
    lvgl.obj_add_style(demo_Bar, lvgl.BAR_PART_INDIC, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(demo_Bar, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
end