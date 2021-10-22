---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个List----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/list.html
]]
function demo_ListInit()
    --创建一个 List
    demo_List = lvgl.list_create(lvgl.scr_act(), nil)
    --设置 List 的大小
    lvgl.obj_set_height(demo_List, 300)
    --设置 List 的滚动模式
    lvgl.list_set_scrollbar_mode(demo_List, lvgl.SCROLLBAR_MODE_OFF)
    --添加 List 的内容
    --需要添加 lvsym.lua 才可以使用LittleVGL内置的文字图片
    new = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_NEW_LINE, "New")
    open = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_DIRECTORY, "Open")
    delete = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_CLOSE, "Delete")
    edit = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_EDIT, "Edit")
    usb = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_USB, "USB")
    gps = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_GPS, "GPS")
    stop = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_STOP, "Stop")
    video = lvgl.list_add_btn(demo_List, lvgl.SYMBOL_VIDEO, "Video")
    --设置 List 的位置
    lvgl.obj_align(demo_List, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_List, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(new, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(open, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(delete, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(edit, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(usb, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(gps, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(stop, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(video, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
    
end
