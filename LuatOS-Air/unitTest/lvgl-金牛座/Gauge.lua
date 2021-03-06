function GaugeInit()
     Gauge1 = lvgl.gauge_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Gauge1,200,200)
     lvgl.obj_align(Gauge1,Father,lvgl.ALIGN_IN_TOP_LEFT,0,0)
     lvgl.gauge_set_needle_count(Gauge1,1,{lvgl.color_hex(0xFFFF00)})
     lvgl.gauge_set_value(Gauge1,0,30)

     
     Label1 = lvgl.label_create(lvgl.scr_act(),nil)
     lvgl.label_set_text(Label1,"获取针的值:"..lvgl.gauge_get_value(Gauge1).."\n获取针的个数:"..lvgl.gauge_get_needle_count(Gauge1).."\n仪表的最小值:"..lvgl.gauge_get_min_value(Gauge1).."\n仪表的最大值:"..lvgl.gauge_get_max_value(Gauge1).."\n获取临界值:"..lvgl.gauge_get_critical_value(Gauge1).."\n获取标签数量:"..lvgl.gauge_get_label_count(Gauge1).."\n获取仪表刻度线:"..lvgl.gauge_get_line_count(Gauge1).."\n获取仪表的刻度角度:"..lvgl.gauge_get_scale_angle(Gauge1).."\n获取仪表的偏移量:"..lvgl.gauge_get_angle_offset(Gauge1).."\n获取旋转中心的坐标:("..lvgl.gauge_get_needle_img_pivot_x(Gauge1)..","..lvgl.gauge_get_needle_img_pivot_y(Gauge1)..")\n")
     lvgl.obj_align(Label1,nil,lvgl.ALIGN_IN_TOP_LEFT,0,200)
     lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

     Gauge2 = lvgl.gauge_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Gauge2,200,200)
     lvgl.gauge_set_range(Gauge2,0,200)
     lvgl.obj_align(Gauge2,Father,lvgl.ALIGN_IN_TOP_RIGHT,0,0)
     lvgl.gauge_set_needle_count(Gauge2,10,{lvgl.color_hex(0xFFFF00)})
     lvgl.gauge_set_value(Gauge2,0,10)
     lvgl.gauge_set_value(Gauge2,1,30)
     lvgl.gauge_set_value(Gauge2,2,50)
     lvgl.gauge_set_value(Gauge2,3,70)
     lvgl.gauge_set_value(Gauge2,4,90)
     lvgl.gauge_set_value(Gauge2,5,110)
     lvgl.gauge_set_value(Gauge2,6,130)
     lvgl.gauge_set_value(Gauge2,7,150)
     lvgl.gauge_set_value(Gauge2,8,170)
     lvgl.gauge_set_value(Gauge2,9,190)

     Label2 = lvgl.label_create(lvgl.scr_act(),nil)
     lvgl.label_set_text(Label2,"获取针的值:"..lvgl.gauge_get_value(Gauge2).."\n获取针的个数:"..lvgl.gauge_get_needle_count(Gauge2).."\n仪表的最小值:"..lvgl.gauge_get_min_value(Gauge2).."\n仪表的最大值:"..lvgl.gauge_get_max_value(Gauge2).."\n获取临界值:"..lvgl.gauge_get_critical_value(Gauge2).."\n获取标签数量:"..lvgl.gauge_get_label_count(Gauge2).."\n获取仪表刻度线:"..lvgl.gauge_get_line_count(Gauge2).."\n获取仪表的刻度角度:"..lvgl.gauge_get_scale_angle(Gauge2).."\n获取仪表的偏移量:"..lvgl.gauge_get_angle_offset(Gauge2).."\n获取旋转中心的坐标:("..lvgl.gauge_get_needle_img_pivot_x(Gauge2)..","..lvgl.gauge_get_needle_img_pivot_y(Gauge2)..")")
     lvgl.obj_align(Label2,nil,lvgl.ALIGN_IN_TOP_RIGHT,0,200)
     lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

     Gauge3 = lvgl.gauge_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Gauge3,200,200)
     lvgl.gauge_set_range(Gauge3,0,100)
     lvgl.obj_align(Gauge3,Father,lvgl.ALIGN_IN_LEFT_MID,0,75)
     lvgl.gauge_set_needle_count(Gauge3,1,{lvgl.color_hex(0xFFFF00)})
     lvgl.gauge_set_critical_value(Gauge3,90)
     lvgl.gauge_set_value(Gauge3,0,30)
     lvgl.gauge_set_scale(Gauge3,320,51,11)
     
     Label3 = lvgl.label_create(lvgl.scr_act(),nil)
     lvgl.label_set_text(Label3,"获取针的值:"..lvgl.gauge_get_value(Gauge3).."\n获取针的个数:"..lvgl.gauge_get_needle_count(Gauge3).."\n仪表的最小值:"..lvgl.gauge_get_min_value(Gauge3).."\n仪表的最大值:"..lvgl.gauge_get_max_value(Gauge3).."\n获取临界值:"..lvgl.gauge_get_critical_value(Gauge3).."\n获取标签数量:"..lvgl.gauge_get_label_count(Gauge3).."\n获取仪表刻度线:"..lvgl.gauge_get_line_count(Gauge3).."\n获取仪表的刻度角度:"..lvgl.gauge_get_scale_angle(Gauge3).."\n获取仪表的偏移量:"..lvgl.gauge_get_angle_offset(Gauge3).."\n获取旋转中心的坐标:("..lvgl.gauge_get_needle_img_pivot_x(Gauge3)..","..lvgl.gauge_get_needle_img_pivot_y(Gauge3)..")")
     lvgl.obj_align(Label3,nil,lvgl.ALIGN_IN_LEFT_MID,0,275)
     lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

     Gauge4 = lvgl.gauge_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Gauge4,200,200)
     lvgl.gauge_set_range(Gauge3,-100,100)
     lvgl.obj_align(Gauge4,Father,lvgl.ALIGN_IN_RIGHT_MID,0,75)
     lvgl.gauge_set_needle_count(Gauge4,1,{lvgl.color_hex(0x0000FF)})
     lvgl.gauge_set_value(Gauge4,0,30)
     lvgl.gauge_set_angle_offset(Gauge4,90)
    --  lvgl.gauge_set_needle_img(Gauge4,lvgl)
    lvgl.gauge_set_formatter_cb(Gauge4,function(obj,size)
        return "a "..tostring(size).." b"
    end) 

    Label4 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label4,"获取针的值:"..lvgl.gauge_get_value(Gauge4).."\n获取针的个数:"..lvgl.gauge_get_needle_count(Gauge4).."\n仪表的最小值:"..lvgl.gauge_get_min_value(Gauge4).."\n仪表的最大值:"..lvgl.gauge_get_max_value(Gauge4).."\n获取临界值:"..lvgl.gauge_get_critical_value(Gauge4).."\n获取标签数量:"..lvgl.gauge_get_label_count(Gauge4).."\n获取仪表刻度线:"..lvgl.gauge_get_line_count(Gauge4).."\n获取仪表的刻度角度:"..lvgl.gauge_get_scale_angle(Gauge4).."\n获取仪表的偏移量:"..lvgl.gauge_get_angle_offset(Gauge4).."\n获取旋转中心的坐标:("..lvgl.gauge_get_needle_img_pivot_x(Gauge4)..","..lvgl.gauge_get_needle_img_pivot_y(Gauge4)..")")
    lvgl.obj_align(Label4,nil,lvgl.ALIGN_IN_RIGHT_MID,0,275)
    lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end


