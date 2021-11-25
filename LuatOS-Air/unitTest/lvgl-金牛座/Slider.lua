function SliderInit()
     Slider1 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider1,400,20)
	 lvgl.obj_align(Slider1,Father,lvgl.ALIGN_CENTER,0,-300)

	 Slider2 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider2,400,20)
	 lvgl.obj_align(Slider2,Father,lvgl.ALIGN_CENTER,0,-150)
     lvgl.slider_set_anim_time(Slider2,10000)
	 lvgl.slider_set_value(Slider2,60,lvgl.ANIM_ON)
	 lvgl.slider_set_type(Slider2,lvgl.SLIDER_PART_KNOB)

	 Slider3 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider3,400,20)
	 lvgl.obj_align(Slider3,Father,lvgl.ALIGN_CENTER,0,0)
	 lvgl.slider_set_range(Slider3,0,150)
     lvgl.slider_set_value(Slider3,60,lvgl.ANIM_OFF)

	 Slider4 = lvgl.slider_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Slider4,400,20)
	 lvgl.obj_align(Slider4,Father,lvgl.ALIGN_CENTER,0,150)
     lvgl.slider_set_value(Slider4,60,lvgl.ANIM_ON)
     lvgl.slider_set_left_value(Slider4,30,lvgl.ANIM_ON)





end