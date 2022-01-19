function SpinnerInit()
     Spinner1 = lvgl.spinner_create(lvgl. scr_act(),nil)
     lvgl.obj_set_size(Spinner1,200,200) 
	 lvgl.obj_align(Spinner1,Father,lvgl.ALIGN_IN_TOP_LEFT,0,0)
     lvgl.spinner_set_dir(Spinner1,lvgl.SPINNER_DIR_BACKWARD)

     Label1 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label1,"获取微调器的弧长 [度]: "..lvgl.spinner_get_arc_length(Spinner1).."\n获取圆弧的旋转时间: "..lvgl.spinner_get_spin_time(Spinner1).."\n获取微调器的动画类型: "..lvgl.spinner_get_type(Spinner1).."\n获取微调器的动画方向: "..lvgl.spinner_get_dir(Spinner1))
	 lvgl.obj_align(Label1,nil,lvgl.ALIGN_IN_TOP_RIGHT,-20,50)
	 lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
 
     Spinner2 = lvgl.spinner_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Spinner2,200,200)
	 lvgl.obj_align(Spinner2,Father,lvgl.ALIGN_IN_LEFT_MID,0,0)
	 lvgl.spinner_set_dir(Spinner2,lvgl.SPINNER_DIR_FORWARD)

     Label2 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label2,"获取微调器的弧长 [度]: "..lvgl.spinner_get_arc_length(Spinner2).."\n获取圆弧的旋转时间: "..lvgl.spinner_get_spin_time(Spinner2).."\n获取微调器的动画类型: "..lvgl.spinner_get_type(Spinner2).."\n获取微调器的动画方向: "..lvgl.spinner_get_dir(Spinner2))
	 lvgl.obj_align(Label2,nil,lvgl.ALIGN_IN_RIGHT_MID,-20,0)
	 lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Spinner3 = lvgl.spinner_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Spinner3,200,200)
	 lvgl.spinner_set_type(Spinner3,lvgl.SPINNER_TYPE_FILLSPIN_ARC)
	 lvgl.obj_align(Spinner3,Father,lvgl.ALIGN_IN_BOTTOM_LEFT,0,0)
	 lvgl.spinner_set_arc_length(Spinner3,280)
     lvgl.spinner_set_spin_time(Spinner3,3000)
	
     Label3 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label3,"获取微调器的弧长 [度]: "..lvgl.spinner_get_arc_length(Spinner3).."\n获取圆弧的旋转时间: "..lvgl.spinner_get_spin_time(Spinner3).."\n获取微调器的动画类型: "..lvgl.spinner_get_type(Spinner3).."\n获取微调器的动画方向: "..lvgl.spinner_get_dir(Spinner3))
	 lvgl.obj_align(Label3,nil,lvgl.ALIGN_IN_BOTTOM_RIGHT,-20,-50)
	 lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end