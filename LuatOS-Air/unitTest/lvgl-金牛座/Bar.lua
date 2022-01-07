function BarInit()
    Bar1 = lvgl.bar_create(lvgl.scr_act(), nil)   
    lvgl.bar_set_anim_time(Bar1, 1000)
    lvgl.bar_set_value(Bar1, 80, lvgl.ANIM_ON)
    -- lvgl.bar_set_start_value(Bar1, 25, lvgl.ANIM_OFF)
    lvgl.bar_set_range(Bar1, 0 , 240)
    lvgl.bar_set_type(Bar1,lvgl.BAR_TYPE_NORMAL)
    lvgl.obj_add_style(Bar1, lvgl.BAR_PART_INDIC, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(Bar1, lvgl.BAR_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_set_size(Bar1, 400, 40)
    lvgl.obj_align(Bar1, Father, lvgl.ALIGN_IN_TOP_MID, 0, 0)

    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"条形的值 : "..lvgl.bar_get_value(Bar1).."\n条形的起始值 : "..lvgl.bar_get_start_value(Bar1).."\n条形的最小值 : "..lvgl.bar_get_min_value(Bar1).."\n条形的最大值 : "..lvgl.bar_get_max_value(Bar1).."\n条形的类型 : "..lvgl.bar_get_type(Bar1).."\n条形的动画时间 : "..lvgl.bar_get_anim_time(Bar1))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-300)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Bar2 = lvgl.bar_create(lvgl.scr_act(), nil)
    lvgl.bar_set_anim_time(Bar2, 1000)
    lvgl.bar_set_value(Bar2, 100, lvgl.ANIM_ON)
    lvgl.bar_set_start_value(Bar2, 25, lvgl.ANIM_OFF)
    -- lvgl.bar_set_range(Bar2, 10 , 110 )
    lvgl.bar_set_type(Bar2,lvgl.BAR_TYPE_SYMMETRICAL)
    lvgl.obj_add_style(Bar2, lvgl.BAR_PART_INDIC, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(Bar2, lvgl.BAR_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_set_size(Bar2, 400, 40)
    lvgl.obj_align(Bar2, Father, lvgl.ALIGN_CENTER, 0, -150)

    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"条形的值 : "..lvgl.bar_get_value(Bar2).."\n条形的起始值 : "..lvgl.bar_get_start_value(Bar2).."\n条形的最小值 : "..lvgl.bar_get_min_value(Bar2).."\n条形的最大值 : "..lvgl.bar_get_max_value(Bar2).."\n条形的类型 : "..lvgl.bar_get_type(Bar2).."\n条形的动画时间 : "..lvgl.bar_get_anim_time(Bar2))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,-20)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Bar3 = lvgl.bar_create(lvgl.scr_act(), nil)
    lvgl.bar_set_anim_time(Bar3, 2000)
    lvgl.bar_set_value(Bar3, 100, lvgl.ANIM_ON)
    lvgl.bar_set_type(Bar3,lvgl.BAR_TYPE_CUSTOM)
    lvgl.bar_set_start_value(Bar3, 25, lvgl.ANIM_OFF)
    lvgl.obj_add_style(Bar3, lvgl.BAR_PART_INDIC, demo_ThemeStyle_IndicAndFont)
    lvgl.obj_add_style(Bar3, lvgl.BAR_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_set_size(Bar3, 400, 40)
    lvgl.obj_align(Bar3, Father, lvgl.ALIGN_IN_BOTTOM_MID, 0, -250)

    Label3 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label3,"条形的值 : "..lvgl.bar_get_value(Bar3).."\n条形的起始值 : "..lvgl.bar_get_start_value(Bar3).."\n条形的最小值 : "..lvgl.bar_get_min_value(Bar3).."\n条形的最大值 : "..lvgl.bar_get_max_value(Bar3).."\n条形的类型 : "..lvgl.bar_get_type(Bar3).."\n条形的动画时间 : "..lvgl.bar_get_anim_time(Bar3))
    lvgl.obj_align(Label3,nil,lvgl.ALIGN_CENTER,0,270)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    event_handler = function(obj, event)
        if event == lvgl.EVENT_VALUE_CHANGED then
            lvgl.label_set_text(Label1,"圆弧的值 : "..lvgl.arc_get_value(obj))
        end
    end 

end

