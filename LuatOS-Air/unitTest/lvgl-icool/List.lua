function ListInit()
     List1 = lvgl.list_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(List1,150,200)
	 lvgl.obj_align(List1,Father,lvgl.ALIGN_CENTER,0,-260)
     lvgl.list_add_btn(List1,lvgl.SYMBOL_NEW_LINE,"星期一")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_DIRECTORY, "Open")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_CLOSE, "Delete")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_EDIT, "Edit")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_USB, "USB")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_GPS, "GPS")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_STOP, "Stop")
	 lvgl.list_add_btn(List1, lvgl.SYMBOL_VIDEO, "Video")
     
     List2 = lvgl.list_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(List2,150,200)
	 lvgl.obj_align(List2,Father,lvgl.ALIGN_CENTER,0,0)
	 lvgl.list_set_layout(List2,lvgl.LAYOUT_COLUMN_RIGHT)
	 lvgl.list_add_btn(List2,lvgl.SYMBOL_NEW_LINE,"星期一")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_DIRECTORY, "Open")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_CLOSE, "Delete")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_EDIT, "Edit")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_USB, "USB")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_GPS, "GPS")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_STOP, "Stop")
	 lvgl.list_add_btn(List2, lvgl.SYMBOL_VIDEO, "Video")
     lvgl.list_remove(List2,2)
	 lvgl.list_set_scrollbar_mode(List2,lvgl.SCROLLBAR_MODE_OFF)

	 List3 = lvgl.list_create(lvgl.scr_act(),nil)
	 lvgl.obj_set_size(List3,150,200)
	 lvgl.obj_align(List3,Father,lvgl.ALIGN_CENTER,0,260)
	 a = lvgl.list_add_btn(List3,lvgl.SYMBOL_NEW_LINE,"星期一")
	 b = lvgl.list_add_btn(List3, lvgl.SYMBOL_DIRECTORY, "Open")
	 c = lvgl.list_add_btn(List3, lvgl.SYMBOL_CLOSE, "Delete")
	 d = lvgl.list_add_btn(List3, lvgl.SYMBOL_EDIT, "Edit")
	 e = lvgl.list_add_btn(List3, lvgl.SYMBOL_USB, "USB")
	 f = lvgl.list_add_btn(List3, lvgl.SYMBOL_GPS, "GPS")
	 g = lvgl.list_add_btn(List3, lvgl.SYMBOL_STOP, "Stop")
	 h = lvgl.list_add_btn(List3, lvgl.SYMBOL_VIDEO, "Video")
	 lvgl.obj_add_style(List3, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(a, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(b, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(c, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(d, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(e, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(f, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(g, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.obj_add_style(h, lvgl.LIST_PART_BG, demo_ThemeStyle_Bg)
	 lvgl.list_set_scrollbar_mode(List3,lvgl.SCROLLBAR_MODE_ON)
	 lvgl.list_focus_btn(List3,b)
	 lvgl.list_set_edge_flash(List3,true)
	 lvgl.list_set_anim_time(List3,500)
     

end