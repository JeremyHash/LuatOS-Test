---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Arc----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/arc.html
]]
function demo_ArcInit()
    --创建一个 Arc
    demo_Arc = lvgl.arc_create(lvgl.scr_act(), nil)
    --设置 Arc 的大小
    lvgl.obj_set_size(demo_Arc, 200, 200)
    --设置 Arc 的位置
    lvgl.obj_align(demo_Arc, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
	lvgl.obj_add_style(demo_Arc, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    --设置 Arc 的旋转角度
    lvgl.arc_set_angles(demo_Arc, 0, 360)
    lvgl.arc_set_end_angle(demo_Arc, 200)

end

