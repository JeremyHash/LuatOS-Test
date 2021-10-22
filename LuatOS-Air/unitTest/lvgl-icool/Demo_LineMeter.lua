---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个LineMeter----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/linemeter.html
]]
function demo_LineMeterInit()
    --创建一个 LineMeter
    demo_LineMeter = lvgl.linemeter_create(lvgl.scr_act(), nil)
    --设置 LineMeter 的大小
    lvgl.obj_set_size(demo_LineMeter, 440, 440)
    --设置 LineMeter 的角度(0-360)和线条数
    lvgl.linemeter_set_scale(demo_LineMeter, 360, 60)

    lvgl.linemeter_set_range(demo_LineMeter, 0, 360)
    lvgl.linemeter_set_value(demo_LineMeter, 180)
    --设置 LineMeter 的位置
    lvgl.obj_align(demo_LineMeter, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_LineMeter, lvgl.LINEMETER_PART_MAIN, demo_LineMeterStyle)
end