---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Label----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/label.html
]]
function demo_LabelInit()
    --创建一个 Label
    demo_Label = lvgl.label_create(lvgl.scr_act(), nil)
    --设置 Label 的长屏滚动显示
    lvgl.label_set_long_mode(demo_Label, lvgl.LABEL_LONG_SROLL_CIRC)
    --设置 Label 的显示长度(若设置了显示方式，则需要在其后设置才会有效)
    lvgl.obj_set_width(demo_Label, 250)
    --设置 Label 的内容
    lvgl.label_set_text(demo_Label, "To be or not to be, That's a question!")
    --设置 Label 的位置
    lvgl.obj_align(demo_Label, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Label, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)
end