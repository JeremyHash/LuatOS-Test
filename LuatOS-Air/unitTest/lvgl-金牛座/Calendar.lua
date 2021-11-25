function CalendarInit()
   Calendar = lvgl.calendar_create(lvgl.scr_act(),nil)
   lvgl.obj_set_size(Calendar,420,320)
   lvgl.obj_align(Calendar,Father,lvgl.ALIGN_CENTER,0,0)
   lvgl.obj_add_style(Calendar,lvgl.CALENDAR_PART_BG,demo_ThemeStyle_Bg)
   today = lvgl.calendar_date_t()
   today.year = 2021
   today.month = 11
   today.day = 15
   lvgl.calendar_set_today_date(Calendar,today)
   lvgl.calendar_set_showed_date(Calendar,today)
   highlightDate = lvgl.calendar_date_t()
   highlightDate.year = 2021
   highlightDate.month =11
   highlightDate.day = 21
   lvgl.calendar_set_highlighted_dates(Calendar,highlightDate,1)
   days ={"#日","mon","二","周三","四","星期五","六",""}
   lvgl.calendar_set_day_names(Calendar,days)
   months ={"测试一月","测试二月","测试三月","测试四月","测试五月","测试六月","测试七月","测试8月","测试9月","测试10月","测试11月","测试十二月",""}
   lvgl.calendar_set_month_names(Calendar,months)
end

