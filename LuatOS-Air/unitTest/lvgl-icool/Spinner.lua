function SpinnerInit()
     Spinner1 = lvgl.spinner_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Spinner1,200,200)
	 lvgl.obj_align(Spinner1,Father,lvgl.ALIGN_CENTER,0,-300)
     lvgl.spinner_set_dir(Spinner1,lvgl.SPINNER_DIR_BACKWARD)

     Spinner2 = lvgl.spinner_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Spinner2,200,200)
	 lvgl.obj_align(Spinner2,Father,lvgl.ALIGN_CENTER,0,0)
	 lvgl.spinner_set_dir(Spinner2,lvgl.SPINNER_DIR_FORWARD)


	 Spinner3 = lvgl.spinner_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Spinner3,200,200)
	  lvgl.spinner_set_type(Spinner3,lvgl.SPINNER_TYPE_FILLSPIN_ARC)
	 lvgl.obj_align(Spinner3,Father,lvgl.ALIGN_CENTER,0,300)
	 lvgl.spinner_set_arc_length(Spinner3,280)
     lvgl.spinner_set_spin_time(Spinner3,3000)
	
end