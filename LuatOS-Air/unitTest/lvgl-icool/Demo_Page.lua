---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Page----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/page.html
]]
function demo_PageInit()
    --创建一个 Page
    demo_Page = lvgl.page_create(lvgl.scr_act(), nil)
    --设置 Page 的大小(显示大小)
    lvgl.obj_set_size(demo_Page, 400, 600)
    --设置 Page 的滚动模式
    lvgl.page_set_scrollbar_mode(demo_Page, lvgl.SCROLLBAR_MODE_OFF)
    --设置 Page 的位置
    lvgl.obj_align(demo_Page, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Page, lvgl.PAGE_PART_BG, demo_PageStyle)

    demo_PageBtn1 = lvgl.btn_create(demo_Page, nil)
    lvgl.obj_set_size(demo_PageBtn1, 100, 100)
    lvgl.obj_align(demo_PageBtn1, demo_Page, lvgl.ALIGN_IN_TOP_MID, 0, 50)
    demo_PageBtn2 = lvgl.btn_create(demo_Page, nil)
    lvgl.obj_set_size(demo_PageBtn2, 100, 100)
    lvgl.obj_align(demo_PageBtn2, demo_Page, lvgl.ALIGN_IN_TOP_MID, 0, 300)
    demo_PageBtn3 = lvgl.btn_create(demo_Page, nil)
    lvgl.obj_set_size(demo_PageBtn3, 100, 100)
    lvgl.obj_align(demo_PageBtn3, demo_Page, lvgl.ALIGN_IN_TOP_MID, 0, 550)

    lvgl.obj_add_style(demo_PageBtn1, lvgl.BTN_PART_MAIN, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(demo_PageBtn2, lvgl.BTN_PART_MAIN, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(demo_PageBtn3, lvgl.BTN_PART_MAIN, demo_ThemeStyle_IndicAndFont)
end