---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Roller----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/roller.html
]]
function demo_RollerInit()
    --创建一个 Roller
    demo_Roller = lvgl.roller_create(lvgl.scr_act(), nil)
    --设置 Roller 的显示大小
    lvgl.obj_set_size(demo_Roller, 400, 250)
    --设置 Roller 的内容及滚动方式
    lvgl.roller_set_options(demo_Roller, "东皇钟\n轩辕剑\n盘古斧\n炼妖壶\n昊天塔\n伏羲琴\n神农鼎\n崆峒印\n昆仑镜\n女娲石", lvgl.ROLLER_MODE_INFINITE)
    --设置 Roller 的位置
    lvgl.obj_align(demo_Roller, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Roller, lvgl.ROLLER_PART_BG, demo_ThemeStyle_Bg)
end