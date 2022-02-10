function CalendarInit()
    Calendar = lvgl.calendar_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Calendar, 420, 320)
    lvgl.obj_align(Calendar, Father, lvgl.ALIGN_CENTER, 0, -100)
    lvgl.obj_add_style(Calendar, lvgl.CALENDAR_PART_BG, demo_ThemeStyle_Bg)
    today = lvgl.calendar_date_t()
    today.year = 2021
    today.month = 11
    today.day = 15
    lvgl.calendar_set_today_date(Calendar, today)
    lvgl.calendar_set_showed_date(Calendar, today)
    lvgl.calendar_set_highlighted_dates(Calendar, {{year = 2021,month = 11,day = 21},{year = 2021,month = 11,day =23},{year = 2021,month = 11,day = 25},{year = 2021,month = 11,day = 29}})
    days = {"#日", "mon", "二", "周三", "四", "星期五", "六"}
    lvgl.calendar_set_day_names(Calendar, days)
    months = {
        "测试一月", "测试二月", "测试三月", "测试四月",
        "测试五月", "测试六月", "测试七月", "测试8月",
        "测试9月", "测试10月", "测试11月", "测试十二月"
    }
    lvgl.calendar_set_month_names(Calendar, months)

    Label1 = lvgl.label_create(lvgl.scr_act(), nil)
    lvgl.label_set_text(Label1,
                        "今天的日期: " ..
                            lvgl.calendar_get_today_date(Calendar).year .. "-" ..
                            lvgl.calendar_get_today_date(Calendar).month .. "-" ..
                            lvgl.calendar_get_today_date(Calendar).day ..
                            "\n当前显示的日期 : " ..
                            lvgl.calendar_get_showed_date(Calendar).year .. "-" ..
                            lvgl.calendar_get_showed_date(Calendar).month .. "-" ..
                            lvgl.calendar_get_showed_date(Calendar).day ..
                            "\n突出显示的日期 : " ..
                            lvgl.calendar_get_highlighted_dates(Calendar).year .."-"..
                            lvgl.calendar_get_highlighted_dates(Calendar).month .."-"..
                            lvgl.calendar_get_highlighted_dates(Calendar).day ..
                            "\n获取突出显示日期的个数 : " ..
                            tostring(
                                lvgl.calendar_get_highlighted_dates_num(Calendar)) ..
                            "\n获取日期名称 : " ..
                            tostring(lvgl.calendar_get_day_names(Calendar)) ..
                            "\n获取月数名称 : " ..
                            tostring(lvgl.calendar_get_month_names(Calendar)) ..
                            "\n2022-1-6是星期几 : " ..
                            lvgl.calendar_get_day_of_week(2022, 1, 6))
    lvgl.obj_align(Label1, Father, lvgl.ALIGN_CENTER, 0, 130)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN,
                       demo_ThemeStyle_IndicAndFont)

end

