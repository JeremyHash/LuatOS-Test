function PageInit()
	 Page1 = lvgl.page_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Page1,100,150)
	 lvgl.obj_align(Page1,Father,lvgl.ALIGN_CENTER,0,-300)
     Btn1 = lvgl.btn_create(Page1,nil)
	 lvgl.obj_set_size(Btn1,70,30)
	 lvgl.obj_align(Btn1,Page1,lvgl.ALIGN_IN_TOP_MID,0,10)
	 Btn2 = lvgl.btn_create(Page1,nil)
	 lvgl.obj_set_size(Btn2,70,30)
	 lvgl.obj_align(Btn2,Page1,lvgl.ALIGN_IN_TOP_MID,0,50)
	 Btn3 = lvgl.btn_create(Page1,nil)
	 lvgl.obj_set_size(Btn3,70,30)
	 lvgl.obj_align(Btn3,Page1,lvgl.ALIGN_IN_TOP_MID,0,90)
	 Btn4 = lvgl.btn_create(Page1,nil)
	 lvgl.obj_set_size(Btn4,70,30)
	 lvgl.obj_align(Btn4,Page1,lvgl.ALIGN_IN_TOP_MID,0,130)
	 Btn5 = lvgl.btn_create(Page1,nil)
	 lvgl.obj_set_size(Btn5,70,30)
	 lvgl.obj_align(Btn5,Page1,lvgl.ALIGN_IN_TOP_MID,0,170)
     lvgl.page_set_scrollbar_mode(Page1,lvgl.SCROLLBAR_MODE_OFF)
     
	 Page2 = lvgl.page_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Page2,100,150)
	 lvgl.obj_align(Page2,Father,lvgl.ALIGN_CENTER,0,0)
     Btn1 = lvgl.btn_create(Page2,nil)
	 lvgl.obj_set_size(Btn1,70,30)
	 lvgl.obj_align(Btn1,Page2,lvgl.ALIGN_IN_TOP_MID,0,10)
	 Btn2 = lvgl.btn_create(Page2,nil)
	 lvgl.obj_set_size(Btn2,70,30)
	 lvgl.obj_align(Btn2,Page2,lvgl.ALIGN_IN_TOP_MID,0,50)
	 Btn3 = lvgl.btn_create(Page2,nil)
	 lvgl.obj_set_size(Btn3,70,30)
	 lvgl.obj_align(Btn3,Page2,lvgl.ALIGN_IN_TOP_MID,0,90)
	 Btn4 = lvgl.btn_create(Page2,nil)
	 lvgl.obj_set_size(Btn4,70,30)
	 lvgl.obj_align(Btn4,Page2,lvgl.ALIGN_IN_TOP_MID,0,130)
	 Btn5 = lvgl.btn_create(Page2,nil)
	 lvgl.obj_set_size(Btn5,70,30)
	 lvgl.obj_align(Btn5,Page2,lvgl.ALIGN_IN_TOP_MID,0,170)
     lvgl.page_set_scrollbar_mode(Page2,lvgl.SCROLLBAR_MODE_DRAG)
     lvgl.page_set_edge_flash(Page2,true)
	 lvgl.page_set_anim_time(Page2,500)

	 Page3 = lvgl.page_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Page3,100,150)
	 lvgl.obj_align(Page3,Father,lvgl.ALIGN_CENTER,0,300)
     Btn1 = lvgl.btn_create(Page3,nil)
	 lvgl.obj_set_size(Btn1,70,30)
	 lvgl.obj_align(Btn1,Page3,lvgl.ALIGN_IN_TOP_MID,0,10)
	 lvgl.page_clean(Page3)
	 Btn2 = lvgl.btn_create(Page3,nil)
	 lvgl.obj_set_size(Btn2,50,30)
	 lvgl.obj_align(Btn2,Page3,lvgl.ALIGN_IN_TOP_MID,0,50)
	 Btn3 = lvgl.btn_create(Page3,nil)
	 lvgl.obj_set_size(Btn3,50,30)
	 lvgl.obj_align(Btn3,Page3,lvgl.ALIGN_IN_TOP_MID,0,90)
	 Btn4 = lvgl.btn_create(Page3,nil)
	 lvgl.obj_set_size(Btn4,50,30)
	 lvgl.obj_align(Btn4,Page3,lvgl.ALIGN_IN_TOP_MID,0,130)
	 Btn5 = lvgl.btn_create(Page3,nil)
	 lvgl.obj_set_size(Btn5,50,30)
	 lvgl.obj_align(Btn5,Page3,lvgl.ALIGN_IN_TOP_MID,0,170)
     lvgl.page_set_scrollbar_mode(Page3,lvgl.SCROLLBAR_MODE_ON)
    --  lvgl.page_set_scrollable_fit(Page3,lvgl.LAYOUT_COLUMN_RIGHT)

end