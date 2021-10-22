---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Line----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/line.html
]]
function demo_LineInit()
    demo_lineTabel = {{2, 10}, {50, 60}, {30, 10}, {74, 30}}

    --创建一个 Line
    demo_Line = lvgl.line_create(lvgl.scr_act(), nil)
    --设置 Line 的端点坐标
    lvgl.line_set_points(demo_Line, demo_lineTabel, 4)
    --设置 Label 的位置
    lvgl.obj_align(demo_Label, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Label, lvgl.LINE_PART_MAIN, demo_LineStyle_Green)
end



---暂时不支持