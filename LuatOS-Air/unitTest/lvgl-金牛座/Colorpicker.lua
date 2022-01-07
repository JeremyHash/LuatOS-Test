function ColorpickerInit()
    event_handler = function(obj, event)
        if event == lvgl.EVENT_VALUE_CHANGED then
           if lvgl.obj_get_id(Colorpicker1) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label1,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker1).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker1)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker1).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker1).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker1).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker1))) 
           end 
           if lvgl.obj_get_id(Colorpicker2) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label2,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker2).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker2)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker2).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker2).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker2).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker2)))
           end 
           if lvgl.obj_get_id(Colorpicker3) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label3,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker3).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker3)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker3).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker3).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker3).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker3)))  
           end 
           if lvgl.obj_get_id(Colorpicker4) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label4,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker4).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker4)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker4).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker4).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker4).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker4)))
           end 
       end
     end 

    Colorpicker1 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker1,200,200)
    lvgl.obj_align(Colorpicker1, Father, lvgl.ALIGN_CENTER, -125, -300)
    lvgl.obj_add_style(Colorpicker1, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker1,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_color(Colorpicker1,lvgl.color_hex(0x00FF00))
    -- lvgl.cpicker_set_type(Colorpicker,lvgl.CPICKER_TYPE_RECT)
    lvgl.obj_set_event_cb(Colorpicker1, event_handler)

    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker1).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker1)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker1).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker1).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker1).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker1)))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,-125,-130)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


    Colorpicker2 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker2,200,200)
    lvgl.obj_align(Colorpicker2, Father, lvgl.ALIGN_CENTER, 125, -300)
    lvgl.obj_add_style(Colorpicker2, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker2,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_saturation(Colorpicker2,30)
    lvgl.obj_set_event_cb(Colorpicker2, event_handler)
  
    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker2).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker2)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker2).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker2).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker2).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker2)))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,125,-130)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Colorpicker3 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker3,200,200)
    lvgl.obj_align(Colorpicker3, Father, lvgl.ALIGN_CENTER, -125, 100)
    lvgl.obj_add_style(Colorpicker3, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker3,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_value(Colorpicker3,30)
    lvgl.cpicker_set_color_mode(Colorpicker3,lvgl.CPICKER_COLOR_MODE_SATURATION)
    lvgl.obj_set_event_cb(Colorpicker3, event_handler)

    Label3 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label3,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker3).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker3)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker3).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker3).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker3).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker3)))
    lvgl.obj_align(Label3,nil,lvgl.ALIGN_CENTER,-125,270)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Colorpicker4 = lvgl.cpicker_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Colorpicker4,200,200)
    lvgl.obj_align(Colorpicker4, Father, lvgl.ALIGN_CENTER, 125, 100)
    lvgl.obj_add_style(Colorpicker4, lvgl.CPICKER_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.cpicker_set_type(Colorpicker4,lvgl.CPICKER_TYPE_DISC)
    lvgl.cpicker_set_value(Colorpicker4,75)
    -- lvgl.cpicker_set_hsv(Colorpicker4,)
    lvgl.cpicker_set_color_mode(Colorpicker4,lvgl.CPICKER_COLOR_MODE_VALUE)
    lvgl.cpicker_set_color_mode_fixed(Colorpicker4,true)
    lvgl.cpicker_set_knob_colored(Colorpicker4,false)
    lvgl.obj_set_event_cb(Colorpicker4, event_handler)

    Label4 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label4,"当前颜色模式 : "..lvgl.cpicker_get_color_mode(Colorpicker4).."\n长按中心是否更改模式:"..tostring(lvgl.cpicker_get_color_mode_fixed(Colorpicker4)).."\n获取当前色调:"..lvgl.cpicker_get_hue(Colorpicker4).."\n获取当前饱和度:"..lvgl.cpicker_get_saturation(Colorpicker4).."\n获取当前色调的值:".. lvgl.cpicker_get_value(Colorpicker4).."\n旋钮是否按当前颜色着色:"..tostring(lvgl.cpicker_get_knob_colored(Colorpicker4)))
    lvgl.obj_align(Label4,nil,lvgl.ALIGN_CENTER,125,270)
    lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
end


