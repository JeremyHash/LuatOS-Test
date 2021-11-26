function TableInit()
     Table1 = lvgl.table_create(lvgl.scr_act(),nil)
     lvgl.table_set_row_cnt(Table1,4)
	 lvgl.table_set_col_cnt(Table1,3)
     lvgl.table_set_cell_value(Table1, 0, 0, "狮子座")
     lvgl.table_set_cell_value(Table1, 1, 0, "白羊座")
     lvgl.table_set_cell_value(Table1, 2, 0, "双子座")
	 lvgl.table_set_cell_value(Table1, 3, 0, "双鱼座")
	 lvgl.table_set_cell_value(Table1, 0, 1, "水瓶座")
     lvgl.table_set_cell_value(Table1, 1, 1, "天秤座")
     lvgl.table_set_cell_value(Table1, 2, 1, "射手座")
	 lvgl.table_set_cell_value(Table1, 3, 1, "处女座")
	 lvgl.table_set_cell_value(Table1, 0, 2, "摩羯座")
     lvgl.table_set_cell_value(Table1, 1, 2, "巨蟹座")
     lvgl.table_set_cell_value(Table1, 2, 2, "天蝎座")
	 lvgl.table_set_cell_value(Table1, 3, 2, "金牛座")
	 lvgl.obj_align(Table1,Father,lvgl.ALIGN_CENTER,0,-200)
     lvgl.table_set_cell_align(Table1,0,2,lvgl.LABEL_ALIGN_RIGHT)
	 lvgl.table_set_cell_align(Table1,1,2,lvgl.LABEL_ALIGN_LEFT)
	 lvgl.table_set_cell_align(Table1,2,2,lvgl.LABEL_ALIGN_CENTER)

	 Table2 = lvgl.table_create(lvgl.scr_act(),nil)
     lvgl.table_set_row_cnt(Table2,4)
	 lvgl.table_set_col_cnt(Table2,3)
	 lvgl.table_set_col_width(Table2,1,50)
     lvgl.table_set_cell_value(Table2, 0, 0, "狮子座")
     lvgl.table_set_cell_value(Table2, 1, 0, "白羊座")
     lvgl.table_set_cell_value(Table2, 2, 0, "双子座")
	 lvgl.table_set_cell_value(Table2, 3, 0, "双鱼座")
	 lvgl.table_set_cell_value(Table2, 0, 1, "水瓶座")
     lvgl.table_set_cell_value(Table2, 1, 1, "天秤座")
     lvgl.table_set_cell_value(Table2, 2, 1, "射手座")
	 lvgl.table_set_cell_value(Table2, 3, 1, "处女座")
	 lvgl.table_set_cell_value(Table2, 0, 2, "摩羯座")
     lvgl.table_set_cell_value(Table2, 1, 2, "巨蟹座")
     lvgl.table_set_cell_value(Table2, 2, 2, "天蝎座")
	 lvgl.table_set_cell_value(Table2, 3, 2, "金牛座")
	 lvgl.obj_align(Table2,Father,lvgl.ALIGN_CENTER,0,200)
	 --没什么效果
	 lvgl.table_set_cell_type(Table2,0,2,1)
	 lvgl.table_set_cell_type(Table2,1,2,2)
	 lvgl.table_set_cell_type(Table2,2,2,3)
	 lvgl.table_set_cell_type(Table2,3,2,4)
	 lvgl.table_set_cell_merge_right(Table2,3,0,true)








end