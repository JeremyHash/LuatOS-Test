function SliderInit()
	event_handler = function(obj, event)
		if event == lvgl.EVENT_VALUE_CHANGED then
		   if lvgl.obj_get_id(Slider1) == lvgl.obj_get_id(obj)  then 
			  lvgl.label_set_text(Label1,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider1).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider1).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider1).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider1).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider1).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider1).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider1)))
		end 
		   if lvgl.obj_get_id(Slider2) == lvgl.obj_get_id(obj)  then 
		      lvgl.label_set_text(Label2,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider2).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider2).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider2).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider2).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider2).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider2).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider2)))
		   end 
		   if lvgl.obj_get_id(Slider3) == lvgl.obj_get_id(obj)  then 
			  lvgl.label_set_text(Label3,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider3).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider3).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider3).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider3).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider3).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider3).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider3)))
		   end 
		   if lvgl.obj_get_id(Slider4) == lvgl.obj_get_id(obj)  then 
			  lvgl.label_set_text(Label4,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider4).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider4).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider4).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider4).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider4).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider4).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider4)))
		   end 
	   end
	 end 

     Slider1 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider1,400,20)
	 lvgl.obj_align(Slider1,Father,lvgl.ALIGN_IN_TOP_MID,0,20)
	 lvgl.obj_set_event_cb(Slider1, event_handler)

	 Label1 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label1,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider1).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider1).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider1).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider1).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider1).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider1).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider1)))
	 lvgl.obj_align(Label1,nil,lvgl.ALIGN_IN_TOP_MID,0,70)
	 lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Slider2 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider2,400,20)
	 lvgl.obj_align(Slider2,Father,lvgl.ALIGN_IN_TOP_MID,0,220)
     lvgl.slider_set_anim_time(Slider2,10000)
	 lvgl.slider_set_value(Slider2,60,lvgl.ANIM_ON)
	 lvgl.slider_set_type(Slider2,lvgl.SLIDER_PART_KNOB)
	 lvgl.obj_set_event_cb(Slider2, event_handler)

	 Label2 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label2,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider2).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider2).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider2).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider2).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider2).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider2).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider2)))
	 lvgl.obj_align(Label2,nil,lvgl.ALIGN_IN_TOP_MID,0,270)
	 lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Slider3 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider3,400,20)
	 lvgl.obj_align(Slider3,Father,lvgl.ALIGN_IN_TOP_MID,0,420)
	 lvgl.slider_set_range(Slider3,0,150)
     lvgl.slider_set_value(Slider3,60,lvgl.ANIM_OFF)
	 lvgl.obj_set_event_cb(Slider3, event_handler)

	 Label3 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label3,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider3).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider3).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider3).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider3).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider3).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider3).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider3)))
	 lvgl.obj_align(Label3,nil,lvgl.ALIGN_IN_TOP_MID,0,470)
	 lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Slider4 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider4,400,20)
	 lvgl.obj_align(Slider4,Father,lvgl.ALIGN_IN_TOP_MID,0,620)
     lvgl.slider_set_value(Slider4,60,lvgl.ANIM_ON)
     lvgl.slider_set_left_value(Slider4,30,lvgl.ANIM_ON)
	 lvgl.obj_set_event_cb(Slider4, event_handler)

	 Label4 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label4,"获取滑块主旋扭的值: "..lvgl.slider_get_value(Slider4).."\n获取滑块左侧旋钮的值: "..lvgl.slider_get_left_value(Slider4).."\n获取滑块的最小值: "..lvgl.slider_get_min_value(Slider4).."\n获取滑块的最大值: "..lvgl.slider_get_max_value(Slider4).."\n获取滑块的动画时间: "..lvgl.slider_get_anim_time(Slider4).."\n获取滑块是否对称: "..lvgl.slider_get_type(Slider4).."\n给出滑块是否被拖动"..tostring(lvgl.slider_is_dragged(Slider4)))
	 lvgl.obj_align(Label4,nil,lvgl.ALIGN_IN_TOP_MID,0,670)
	 lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


end