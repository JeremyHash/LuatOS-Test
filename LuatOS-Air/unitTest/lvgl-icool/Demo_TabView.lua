---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个TabView----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/tabview.html
]]
function demo_TabViewInit()
    --创建一个 TabView
    demo_TabView = lvgl.tabview_create(lvgl.scr_act(), nil)
    --设置 TabView 的显示大小
    lvgl.obj_set_size(demo_TabView, 440, 600)
    --设置 TabView 的位置
    lvgl.obj_align(demo_TabView, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_TabView, lvgl.TABVIEW_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(demo_TabView, lvgl.TABVIEW_PART_TAB_BG, demo_ThemeStyle_Bg)

    --添加页面
    demo_Tab1 = lvgl.tabview_add_tab(demo_TabView, "电影")
    demo_Tab2 = lvgl.tabview_add_tab(demo_TabView, "电视剧")
end