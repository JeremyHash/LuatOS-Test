---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Spinner----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/spinner.html
]]
function demo_SpinnerInit()
    --创建一个 Spinner
    demo_Spinner = lvgl.spinner_create(lvgl.scr_act(), nil)
    --设置 Spinner 的显示大小
    lvgl.obj_set_size(demo_Spinner, 400, 400)
    --设置 Spinner 的位置
    lvgl.obj_align(demo_Spinner, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Spinner, lvgl.SPINNER_PART_BG, demo_ThemeStyle_Bg)
end