function ColorpickerInit()
    Colorpicker1 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker1,200,200)
    lvgl.obj_align(Colorpicker1, Father, lvgl.ALIGN_CENTER, -125, -200)
    lvgl.obj_add_style(Colorpicker1, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker1,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_color(Colorpicker1,lvgl.color_hex(0x00FF00))
    -- lvgl.cpicker_set_type(Colorpicker,lvgl.CPICKER_TYPE_RECT)

    Colorpicker2 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker2,200,200)
    lvgl.obj_align(Colorpicker2, Father, lvgl.ALIGN_CENTER, 125, -200)
    lvgl.obj_add_style(Colorpicker2, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker2,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_saturation(Colorpicker2,30)
  

    Colorpicker3 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker3,200,200)
    lvgl.obj_align(Colorpicker3, Father, lvgl.ALIGN_CENTER, -125, 200)
    lvgl.obj_add_style(Colorpicker3, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker3,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_value(Colorpicker3,30)

    Colorpicker4 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker4,200,200)
    lvgl.obj_align(Colorpicker4, Father, lvgl.ALIGN_CENTER, 125, 200)
    lvgl.obj_add_style(Colorpicker4, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker4,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_value(Colorpicker4,75)
    -- lvgl.cpicker_set_hsv(Colorpicker4,)
    lvgl.cpicker_set_color_mode(Colorpicker4,lvgl.CPICKER_COLOR_MODE_VALUE)
    lvgl.cpicker_set_color_mode_fixed(Colorpicker4,true)
    lvgl.cpicker_set_knob_colored(Colorpicker4,false)
end


