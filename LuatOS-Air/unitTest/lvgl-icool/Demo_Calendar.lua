---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Calendar----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/calendar.html
]]
function demo_CalendarInit()
    --创建一个 Calendar
    demo_Calendar = lvgl.calendar_create(lvgl.scr_act(), nil)
    --设置 Calendar 的大小
    lvgl.obj_set_size(demo_Calendar, 440, 320)
    --设置 Calendar 的位置
    lvgl.obj_align(demo_Calendar, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Calendar, lvgl.CALENDAR_PART_BG, demo_ThemeStyle_Bg)
    --设置当前的日期
    demo_today = lvgl.calendar_date_t()
    demo_today.year = 2030
    demo_today.month = 10
    demo_today.day = 1
    lvgl.calendar_set_today_date(demo_Calendar, demo_today)
    lvgl.calendar_set_showed_date(demo_Calendar, demo_today)
    --设置高亮的日期
	demo_highlightDate = lvgl.calendar_date_t()
    demo_highlightDate.year = 2030
    demo_highlightDate.month = 10
    demo_highlightDate.day = 16
	lvgl.calendar_set_highlighted_dates(demo_Calendar, demo_highlightDate, 1)
end