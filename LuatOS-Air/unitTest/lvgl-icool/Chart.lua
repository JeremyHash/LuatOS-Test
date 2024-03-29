function ChartInit()
    Chart1 = lvgl.chart_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Chart1,300,150)
    lvgl.obj_align(Chart1,Father,lvgl.ALIGN_IN_TOP_MID,0,50)
    lvgl.obj_add_style(Chart1,lvgl.CHART_PART_BG, demo_ThemeStyle_Bg)
    Red  = lvgl.chart_add_series(Chart1,lvgl.color_hex(0xFF0000))
    Blue = lvgl.chart_add_series(Chart1,lvgl.color_hex(0x0000FF))
    Green = lvgl.chart_add_series(Chart1,lvgl.color_hex(0x00FF00))
    lvgl.chart_set_div_line_count(Chart1,10,10)
    lvgl.chart_set_type(Chart1,lvgl.CHART_TYPE_LINE)
    -- lvgl.chart_set_point_count(Chart,10)
    lvgl.chart_set_next(Chart1,Blue, 20)
    lvgl.chart_set_next(Chart1,Blue, 20)
    lvgl.chart_set_next(Chart1,Blue, 20)
    lvgl.chart_set_next(Chart1,Blue, 20)
    lvgl.chart_set_next(Chart1,Blue, 30)
    lvgl.chart_set_next(Chart1,Blue, 40)
    lvgl.chart_set_next(Chart1,Blue, 60)
    lvgl.chart_set_next(Chart1,Blue, 60)
    lvgl.chart_set_next(Chart1,Blue, 55)
    lvgl.chart_set_next(Chart1,Blue, 50)
    lvgl.chart_set_next(Chart1,Red, 20)
    lvgl.chart_set_next(Chart1,Red, 50)
    lvgl.chart_set_next(Chart1,Red, 40)
    lvgl.chart_set_next(Chart1,Red, 30)
    lvgl.chart_set_next(Chart1,Red, 40)
    lvgl.chart_set_next(Chart1,Red, 35)
    lvgl.chart_set_next(Chart1,Red, 50)
    lvgl.chart_set_next(Chart1,Red, 30)
    lvgl.chart_set_next(Chart1,Red, 70)
    lvgl.chart_set_next(Chart1,Red, 50)
    lvgl.chart_set_next(Chart1,Green, 40)
    lvgl.chart_set_next(Chart1,Green, 60)
    lvgl.chart_set_next(Chart1,Green, 60)
    lvgl.chart_set_next(Chart1,Green, 50)
    lvgl.chart_set_next(Chart1,Green, 40)
    lvgl.chart_set_next(Chart1,Green, 35)
    lvgl.chart_set_next(Chart1,Green, 30)
    lvgl.chart_set_next(Chart1,Green, 30)
    lvgl.chart_set_next(Chart1,Green, 40)
    lvgl.chart_set_next(Chart1,Green, 10)
    lvgl.chart_remove_series(Chart1,Red)

    Chart2 = lvgl.chart_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Chart2,300,150)
    lvgl.obj_align(Chart2,Father,lvgl.ALIGN_IN_TOP_MID,0,240)
    lvgl.obj_add_style(Chart2,lvgl.CHART_PART_BG, demo_ThemeStyle_Bg)
    Red  = lvgl.chart_add_series(Chart2,lvgl.color_hex(0xFF0000))
    Blue = lvgl.chart_add_series(Chart2,lvgl.color_hex(0x0000FF))
    Green = lvgl.chart_add_series(Chart2,lvgl.color_hex(0x00FF00))
    Yellow =lvgl.chart_add_series(Chart2,lvgl.color_hex(0xFFFF00))
    lvgl.chart_set_div_line_count(Chart2,5,5)
    lvgl.chart_set_type(Chart2,lvgl.CHART_TYPE_LINE)
    -- lvgl.chart_set_point_count(Chart,10)
    lvgl.chart_set_next(Chart2,Blue, 20)
    lvgl.chart_set_next(Chart2,Blue, 20)
    lvgl.chart_set_next(Chart2,Blue, 20)
    lvgl.chart_set_next(Chart2,Blue, 20)
    lvgl.chart_set_next(Chart2,Blue, 30)
    lvgl.chart_set_next(Chart2,Blue, 40)
    lvgl.chart_set_next(Chart2,Blue, 60)
    lvgl.chart_set_next(Chart2,Blue, 60)
    lvgl.chart_set_next(Chart2,Blue, 55)
    lvgl.chart_set_next(Chart2,Blue, 50)
    lvgl.chart_set_next(Chart2,Red, 90)
    lvgl.chart_set_next(Chart2,Red, 80)
    lvgl.chart_set_next(Chart2,Red, 70)
    lvgl.chart_set_next(Chart2,Red, 60)
    lvgl.chart_set_next(Chart2,Red, 50)
    lvgl.chart_set_next(Chart2,Red, 40)
    lvgl.chart_set_next(Chart2,Red, 30)
    lvgl.chart_set_next(Chart2,Red, 20)
    lvgl.chart_set_next(Chart2,Red, 10)
    lvgl.chart_set_next(Chart2,Red, 10)
    lvgl.chart_set_next(Chart2,Green, 40)
    lvgl.chart_set_next(Chart2,Green, 60)
    lvgl.chart_set_next(Chart2,Green, 60)
    lvgl.chart_set_next(Chart2,Green, 50)
    lvgl.chart_set_next(Chart2,Green, 40)
    lvgl.chart_set_next(Chart2,Green, 35)
    lvgl.chart_set_next(Chart2,Green, 30)
    lvgl.chart_set_next(Chart2,Green, 30)
    lvgl.chart_set_next(Chart2,Green, 40)
    lvgl.chart_set_next(Chart2,Green, 10)
    lvgl.chart_set_next(Chart2,Yellow, 10)
    lvgl.chart_set_next(Chart2,Yellow, 20)
    lvgl.chart_set_next(Chart2,Yellow, 30)
    lvgl.chart_set_next(Chart2,Yellow, 40)
    lvgl.chart_set_next(Chart2,Yellow, 50)
    lvgl.chart_set_next(Chart2,Yellow, 60)
    lvgl.chart_set_next(Chart2,Yellow, 70)
    lvgl.chart_set_next(Chart2,Yellow, 80)
    lvgl.chart_set_next(Chart2,Yellow, 90)
    lvgl.chart_set_next(Chart2,Yellow, 100)
    lvgl.chart_clear_series(Chart2,Green)
    lvgl.chart_hide_series(Chart2,Yellow,true)
    --辅助线
    -- lvgl.chart_set_y_range(Chart2,lvgl.CHART_AXIS_SECONDARY_Y,-20,20)

    Chart3 = lvgl.chart_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Chart3,300,150)
    lvgl.obj_align(Chart3,Father,lvgl.ALIGN_IN_TOP_MID,0,440)
    lvgl.obj_add_style(Chart3,lvgl.CHART_PART_BG, demo_ThemeStyle_Bg)
    Red  = lvgl.chart_add_series(Chart3,lvgl.color_hex(0xFF0000))
    Blue = lvgl.chart_add_series(Chart3,lvgl.color_hex(0x0000FF))
    Green = lvgl.chart_add_series(Chart3,lvgl.color_hex(0x00FF00))
    Yellow =lvgl.chart_add_series(Chart3,lvgl.color_hex(0xFFFF00))
    lvgl.chart_set_type(Chart3,lvgl.CHART_TYPE_COLUMN)
    lvgl.chart_set_next(Chart3,Blue, 20)
    lvgl.chart_set_next(Chart3,Blue, 20)
    lvgl.chart_set_next(Chart3,Blue, 20)
    lvgl.chart_set_next(Chart3,Blue, 20)
    lvgl.chart_set_next(Chart3,Blue, 30)
    lvgl.chart_set_next(Chart3,Blue, 40)
    lvgl.chart_set_next(Chart3,Blue, 60)
    lvgl.chart_set_next(Chart3,Blue, 60)
    lvgl.chart_set_next(Chart3,Blue, 55)
    lvgl.chart_set_next(Chart3,Blue, 50)
    lvgl.chart_set_point_count(Chart3,8)
    lvgl.chart_init_points(Chart3,Blue,20)
    array = {10,20,30,40,50,60,70,80}
    lvgl.chart_set_points(Chart3,Red,array)
    lvgl.chart_set_next(Chart3,Red,20)
    -- 光标
    a = lvgl.point_t()
    a.x = 60
    a.y = 60
    b = lvgl.point_t()
    b.x = 20
    b.y = 20
    c = {a,b}
    cursor = lvgl.chart_add_cursor(Chart3,lvgl.color_hex(0x00FF00),lvgl.CHART_CURSOR_LEFT)
    lvgl.chart_set_cursor_point(Chart3,cursor,c[2])

    Chart4 = lvgl.chart_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Chart4,300,150)
    lvgl.obj_align(Chart4,Father,lvgl.ALIGN_IN_TOP_MID,0,640)
    lvgl.obj_add_style(Chart4,lvgl.CHART_PART_BG, demo_ThemeStyle_Bg)
    --y轴刻度线设置
    -- lvgl.chart_set_y_tick_length(Chart4,10,10)
    -- zifuchuan ={"jj","ass","asss","asd"}
    -- lvgl.chart_set_y_tick_texts(Chart4,zifuchuan,50,lvgl.chart_axis_options_t)
    Red  = lvgl.chart_add_series(Chart4,lvgl.color_hex(0xFF0000))
    Blue = lvgl.chart_add_series(Chart4,lvgl.color_hex(0x0000FF))
    Green = lvgl.chart_add_series(Chart4,lvgl.color_hex(0x00FF00))
    Yellow =lvgl.chart_add_series(Chart4,lvgl.color_hex(0xFFFF00))
    lvgl.chart_set_type(Chart4,lvgl.CHART_TYPE_LINE)
    lvgl.chart_set_next(Chart4,Blue, 60)
    lvgl.chart_set_next(Chart4,Blue, 40)
    lvgl.chart_set_next(Chart4,Blue, 60)
    lvgl.chart_set_next(Chart4,Blue, 50)
    lvgl.chart_set_next(Chart4,Blue, 60)
    lvgl.chart_set_update_mode(Chart4,lvgl.CHART_UPDATE_MODE_CIRCULAR)

end 


