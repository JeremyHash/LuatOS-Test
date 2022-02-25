function MsgboxInit()
    Msgbox1 = lvgl.msgbox_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Msgbox1,200,200)
	lvgl.obj_align(Msgbox1,Father,lvgl.ALIGN_CENTER, 0, -200)
    lvgl.msgbox_set_text(Msgbox1,"中午吃什么")
	lvgl.msgbox_set_anim_time(Msgbox1,5000)
	lvgl.msgbox_start_auto_close(Msgbox1,5000)

	Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"获取消息框的文本:"..lvgl.msgbox_get_text(Msgbox1).."\n获取用户最后“激活”按钮的索引:"..lvgl.msgbox_get_active_btn(Msgbox1).."\n获取用户最后“激活”按钮的文本:"..tostring(lvgl.msgbox_get_active_btn_text(Msgbox1)).."\n获取动画时长:"..lvgl.msgbox_get_anim_time(Msgbox1).."\n获取是否启用重新着色:"..tostring(lvgl.msgbox_get_recolor(Msgbox1)))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-100)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	Msgbox2 = lvgl.msgbox_create(lvgl.scr_act(),nil)
	lvgl.obj_set_size(Msgbox2,200,200)
	lvgl.obj_align(Msgbox2,Father,lvgl.ALIGN_CENTER, 0, 100)
	lvgl.msgbox_set_text(Msgbox2,"中午吃什么")
	lvgl.msgbox_stop_auto_close(Msgbox2)
    -- btn = {"ok","not","haha",""}
	-- lvgl.msgbox_add_btns(Msgbox2,btn)
	-- lvgl.msgbox_set_recolor(Msgbox2,true)
	lvgl.msgbox_start_auto_close(Msgbox2,5000)
	lvgl.msgbox_stop_auto_close(Msgbox2)

	Label2 = lvgl.label_create(lvgl.scr_act(),nil)
	lvgl.label_set_text(Label2,"获取消息框的文本:"..lvgl.msgbox_get_text(Msgbox2).."\n获取用户最后“激活”按钮的索引:"..lvgl.msgbox_get_active_btn(Msgbox2).."\n获取用户最后“激活”按钮的文本:"..tostring(lvgl.msgbox_get_active_btn_text(Msgbox2)).."\n获取动画时长:"..lvgl.msgbox_get_anim_time(Msgbox2).."\n获取是否启用重新着色:"..tostring(lvgl.msgbox_get_recolor(Msgbox2)))
	lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,200)
	lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	btns = {"Apple","Close",""}
	Msgbox3 = lvgl.msgbox_create(lvgl.scr_act(),nil)
	lvgl.msgbox_set_text(Msgbox3,"hahaha0")
	lvgl.msgbox_add_btns(Msgbox3,btns)
	lvgl.obj_set_width(Msgbox3,200)
	lvgl.obj_align(Msgbox3,nil,lvgl.ALIGN_CENTER,0,250)

end