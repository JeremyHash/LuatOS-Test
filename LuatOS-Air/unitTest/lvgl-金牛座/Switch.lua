function SwitchInit()
	event_handler = function(obj, event)
		if event == lvgl.EVENT_VALUE_CHANGED then
		   if lvgl.obj_get_id(Switch1) == lvgl.obj_get_id(obj)  then 
			  lvgl.label_set_text(Label1,"获取开关的状态: "..tostring(lvgl.switch_get_state(Switch1)).."\n获取开关的动画时间: "..lvgl.switch_get_anim_time(Switch1))
		end 
		   if lvgl.obj_get_id(Switch2) == lvgl.obj_get_id(obj)  then 
		      lvgl.label_set_text(Label2,"获取开关的状态: "..tostring(lvgl.switch_get_state(Switch2)).."\n获取开关的动画时间: "..lvgl.switch_get_anim_time(Switch2))
		end 
	   end
	 end 

     Switch1 = lvgl.switch_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Switch1,150,60)
	 lvgl.obj_align(Switch1,Father,lvgl.ALIGN_CENTER,0,-200)
	 lvgl.switch_on(Switch1,lvgl.ANIM_ON)
	 lvgl.obj_set_event_cb(Switch1, event_handler)

	 Label1 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label1,"获取开关的状态: "..tostring(lvgl.switch_get_state(Switch1)).."\n获取开关的动画时间: "..lvgl.switch_get_anim_time(Switch1))
	 lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-120)
	 lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

     Switch2 = lvgl.switch_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Switch2,150,60)
	 lvgl.obj_align(Switch2,Father,lvgl.ALIGN_CENTER,0,100)
	 lvgl.switch_toggle(Switch2,lvgl.ANIM_ON)
	 lvgl.switch_off(Switch2,lvgl.ANIM_ON)
	 lvgl.switch_set_anim_time(Switch2,3000)
	 lvgl.obj_set_event_cb(Switch2, event_handler)

	 Label2 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label2,"获取开关的状态: "..tostring(lvgl.switch_get_state(Switch2)).."\n获取开关的动画时间: "..lvgl.switch_get_anim_time(Switch2))
	 lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,180)
	 lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end