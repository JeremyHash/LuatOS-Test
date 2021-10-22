---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Window----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/win.html
]]
function demo_WindowInit()
    --创建一个 Switch
    demo_Window = lvgl.win_create(lvgl.scr_act(), nil)
    --设置 Switch 的显示大小
    lvgl.obj_set_size(demo_Window, 440, 600)
    --设置 Switch 的位置
    lvgl.obj_align(demo_Window, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --设置 Window 的标题
    lvgl.win_set_title(demo_Window, "热点新闻")
    --添加样式
    lvgl.obj_add_style(demo_Window, lvgl.WIN_PART_BG, demo_ThemeStyle_Bg)
end