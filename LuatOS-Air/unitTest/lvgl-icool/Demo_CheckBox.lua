---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个CheckBox----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/checkbox.html
]]
function demo_CheckBoxInit()
    --创建一个 CheckBox
    demo_CheckBox = lvgl.checkbox_create(lvgl.scr_act(), nil)
    --设置 CheckBox 的说明文字
    lvgl.checkbox_set_text(demo_CheckBox, "This is a CheckBox")
    --设置 CheckBox 的位置
    lvgl.obj_align(demo_CheckBox, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_CheckBox, lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
    --CheckBox 无法设置大小
    --随着其中的说明文字的大小而自动改变大小
end