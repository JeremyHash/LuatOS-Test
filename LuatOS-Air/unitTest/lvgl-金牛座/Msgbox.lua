function MsgboxInit()
     Msgbox1 = lvgl.msgbox_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Msgbox1,200,200)
	 lvgl.obj_align(Msgbox1,Father,lvgl.ALIGN_CENTER, 0, -200)
     lvgl.msgbox_set_text(Msgbox1,"中午吃什么")
	 lvgl.msgbox_start_auto_close(Msgbox1,5000)


	Msgbox2 = lvgl.msgbox_create(lvgl.scr_act(),nil)
	lvgl.obj_set_size(Msgbox2,200,200)
	lvgl.obj_align(Msgbox2,Father,lvgl.ALIGN_CENTER, 0, 100)
	lvgl.msgbox_set_text(Msgbox2,"中午吃什么")
	lvgl.msgbox_stop_auto_close(Msgbox2)
    -- btn = {"ok","not","haha",""}
	-- lvgl.msgbox_add_btns(Msgbox1,"ok")
	-- lvgl.msgbox_set_recolor(Msgbox2,true)
	lvgl.msgbox_start_auto_close(Msgbox2,5000)
	 lvgl.msgbox_stop_auto_close(Msgbox2)



end