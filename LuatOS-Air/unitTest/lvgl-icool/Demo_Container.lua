---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Container----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/cont.html
]]
function demo_ContInit()
    --创建一个 Cont
    demo_Cont = lvgl.cont_create(lvgl.scr_act(), nil)
    --设置 Cont 的大小
    lvgl.obj_set_size(demo_Cont, 460, 600)
    --设置 Cont 的位置
    lvgl.obj_align(demo_Cont, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Cont, lvgl.CONT_PART_MAIN, demo_ThemeStyle_Bg)
end