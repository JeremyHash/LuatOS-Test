function SwitchInit()
     Switch1 = lvgl.switch_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Switch1,150,60)
	 lvgl.obj_align(Switch1,Father,lvgl.ALIGN_CENTER,0,-150)
	 lvgl.switch_on(Switch1,lvgl.ANIM_ON)


     Switch2 = lvgl.switch_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Switch2,150,60)
	 lvgl.obj_align(Switch2,Father,lvgl.ALIGN_CENTER,0,150)
	 lvgl.switch_toggle(Switch2,lvgl.ANIM_ON)
	 lvgl.switch_off(Switch2,lvgl.ANIM_ON)
	 lvgl.switch_set_anim_time(Switch2,3000)

end