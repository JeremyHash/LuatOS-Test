function ArcInit()
    event_handler = function(obj, event)
        if event == lvgl.EVENT_VALUE_CHANGED then
            lvgl.label_set_text(Label1,"圆弧的起始角度 : "..lvgl.arc_get_angle_start(obj).."\n圆弧的结束角度 : "..lvgl.arc_get_angle_end(obj).."\n圆弧背景的起始角度 : "..lvgl.arc_get_bg_angle_start(obj).."\n圆弧背景的结束角度 : "..lvgl.arc_get_bg_angle_end(obj).."\n圆弧的类型 : "..lvgl.arc_get_type(obj).."\n圆弧的值 : "..lvgl.arc_get_value(obj))
        end
    end 

    Arc1 = lvgl.arc_create(lvgl.scr_act(), nil)
    lvgl.arc_set_type(Arc1,lvgl.ARC_TYPE_NORMAL)
    lvgl.arc_set_bg_angles(Arc1, 135, 45)
    lvgl.arc_set_angles(Arc1, 135, 135)
    lvgl.arc_set_adjustable(Arc1,true)
    lvgl.arc_set_type(Arc1,lvgl.ARC_TYPE_REVERSE)
    lvgl.arc_set_chg_rate(Arc1,300)
    lvgl.obj_set_size(Arc1, 200, 200)
    lvgl.obj_add_style(Arc1, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_align(Arc1, father, lvgl.ALIGN_IN_TOP_LEFT, 0, 0)
    lvgl.obj_set_event_cb(Arc1, event_handler)
    
    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"圆弧的起始角度 : "..lvgl.arc_get_angle_start(Arc1).."\n圆弧的结束角度 : "..lvgl.arc_get_angle_end(Arc1).."\n圆弧背景的起始角度 : "..lvgl.arc_get_bg_angle_start(Arc1).."\n圆弧背景的结束角度 : "..lvgl.arc_get_bg_angle_end(Arc1).."\n圆弧的类型 : "..lvgl.arc_get_type(Arc1).."\n圆弧的值 : "..lvgl.arc_get_value(Arc1))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,-140,-160)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Arc2 = lvgl.arc_create(lvgl.scr_act(), nil)
    lvgl.arc_set_type(Arc2,lvgl.ARC_TYPE_NORMAL)
    lvgl.arc_set_bg_angles(Arc2, 135, 45)
    lvgl.arc_set_angles(Arc2, 180, 45)
    lvgl.arc_set_end_angle(Arc2, 0)
    lvgl.arc_set_rotation(Arc2, 180)
    lvgl.obj_set_size(Arc2, 200, 200)
    lvgl.obj_add_style(Arc2, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_align(Arc2, father, lvgl.ALIGN_IN_TOP_RIGHT, 0, 0)

    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"圆弧的起始角度 : "..lvgl.arc_get_angle_start(Arc2).."\n圆弧的结束角度 : "..lvgl.arc_get_angle_end(Arc2).."\n圆弧背景的起始角度 : "..lvgl.arc_get_bg_angle_start(Arc2).."\n圆弧背景的结束角度 : "..lvgl.arc_get_bg_angle_end(Arc2).."\n圆弧的类型 : "..lvgl.arc_get_type(Arc2).."\n圆弧的值 : "..lvgl.arc_get_value(Arc2))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,140,-160)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
   
    Arc3 = lvgl.arc_create(lvgl.scr_act(), nil)
    lvgl.arc_set_type(Arc3,lvgl.ARC_TYPE_REVERSE)
    lvgl.arc_set_bg_angles(Arc3, 180, 45)
    lvgl.arc_set_angles(Arc3, 180, 45)
    lvgl.obj_set_size(Arc3, 200, 200)
    lvgl.obj_add_style(Arc3, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_align(Arc3, father, lvgl.ALIGN_IN_LEFT_MID, 0, 0)
    lvgl.arc_set_adjustable(Arc3,true)

    Label3 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label3,"圆弧的起始角度 : "..lvgl.arc_get_angle_start(Arc3).."\n圆弧的结束角度 : "..lvgl.arc_get_angle_end(Arc3).."\n圆弧背景的起始角度 : "..lvgl.arc_get_bg_angle_start(Arc3).."\n圆弧背景的结束角度 : "..lvgl.arc_get_bg_angle_end(Arc3).."\n圆弧的类型 : "..lvgl.arc_get_type(Arc3).."\n圆弧的值 : "..lvgl.arc_get_value(Arc3).."\n圆弧的最小值"..lvgl.arc_get_min_value(Arc3).."\n圆弧的最大值"..lvgl.arc_get_max_value(Arc3))
    lvgl.obj_align(Label3,nil,lvgl.ALIGN_CENTER,-140,170)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Arc4 = lvgl.arc_create(lvgl.scr_act(), nil)
    lvgl.arc_set_type(Arc4,lvgl.ARC_TYPE_SYMMETRIC)
    lvgl.arc_set_bg_angles(Arc4, 180, 45)
    lvgl.arc_set_angles(Arc4, 180, 45)
    lvgl.obj_set_size(Arc4, 200, 200)
    lvgl.obj_add_style(Arc4, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_align(Arc4, father, lvgl.ALIGN_IN_RIGHT_MID, 0, 0)

    Label4 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label4,"圆弧的起始角度 : "..lvgl.arc_get_angle_start(Arc4).."\n圆弧的结束角度 : "..lvgl.arc_get_angle_end(Arc4).."\n圆弧背景的起始角度 : "..lvgl.arc_get_bg_angle_start(Arc4).."\n圆弧背景的结束角度 : "..lvgl.arc_get_bg_angle_end(Arc4).."\n圆弧的类型 : "..lvgl.arc_get_type(Arc4).."\n圆弧的值 : "..lvgl.arc_get_value(Arc4).."\n圆弧的最小值"..lvgl.arc_get_min_value(Arc4).."\n圆弧的最大值"..lvgl.arc_get_max_value(Arc4))
    lvgl.obj_align(Label4,nil,lvgl.ALIGN_CENTER,140,170)
    lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


end


