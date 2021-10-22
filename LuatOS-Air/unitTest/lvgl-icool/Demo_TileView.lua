---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个TileView----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/tileview.html
]]
function demo_TileViewInit()
    --创建一个 Switch
    demo_TileView = lvgl.tileview_create(lvgl.scr_act(), nil)
    --设置 Switch 的显示大小
    lvgl.obj_set_size(demo_TileView, 150, 60)
    --设置 Switch 的位置
    lvgl.obj_align(demo_TileView, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_TileView, lvgl.SWITCH_PART_BG, demo_ThemeStyle_Bg)
end

-----暂时不支持