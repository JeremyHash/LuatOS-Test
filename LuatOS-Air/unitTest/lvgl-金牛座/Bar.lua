function BarInit()
    Bar = lvgl.bar_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Bar, 400, 40)
    lvgl.obj_align(Bar, Father, lvgl.ALIGN_CENTER, 0, 0)
    lvgl.bar_set_anim_time(Bar, 1000)
    lvgl.bar_set_value(Bar, 100, lvgl.ANIM_ON)
    lvgl.bar_set_start_value(Bar, 25, lvgl.ANIM_OFF)
    lvgl.obj_add_style(Bar, lvgl.BAR_PART_INDIC, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(Bar, lvgl.BAR_PART_BG, demo_ThemeStyle_Bg)
end

