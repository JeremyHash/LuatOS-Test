---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个DropDown----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/dropdown.html
]]
function demo_DropDownInit()
    --创建一个 DropDown
    demo_DropDown = lvgl.dropdown_create(lvgl.scr_act(), nil)
    --添加DropDown的选项
    lvgl.dropdown_set_options(demo_DropDown, "东皇钟\n轩辕剑\n盘古斧\n炼妖壶\n昊天塔\n伏羲琴\n神农鼎\n崆峒印\n昆仑镜\n女娲石")
    --设置 DropDown 的位置
    lvgl.obj_align(demo_DropDown, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, -100, -200)
    --设置 DropDown 的下拉列表方向
    lvgl.dropdown_set_dir(demo_DropDown, lvgl.DROPDOWN_DIR_RIGHT)
    --设置 DropDown 的标志图
    lvgl.dropdown_set_symbol(demo_DropDown, lvgl.SYMBOL_RIGHT)
    --添加样式
    lvgl.obj_add_style(demo_DropDown, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
end