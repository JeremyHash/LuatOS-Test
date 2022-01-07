function FontInit()

    spi.setup(spi.SPI_1, 1, 1, 8, 800000, 1)
    
    f1 = lvgl.font_load(spi.SPI_1, 96, 2)
    label1 = lvgl.label_create(lvgl.scr_act())
    lvgl.obj_set_style_local_text_font(label1, lvgl.LABEL_PART_MAIN,lvgl.STATE_DEFAULT, f1)
    lvgl.label_set_text_sel_start(label1,20)
	lvgl.label_set_text_sel_end(label1,25)
    lvgl.label_set_text(label1, "你好123xxz一二三四五六七八九十一二三四五六七八九十")
    lvgl.label_set_long_mode(label1,lvgl.LABEL_LONG_SROLL_CIRC)
    lvgl.obj_set_width(label1, 400)
    lvgl.obj_align(label1,Father,lvgl.ALIGN_CENTER,0,-300)
    lvgl.obj_add_style(label1, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)

    f2 = lvgl.font_load(spi.SPI_1, 48, 2)
    label2 = lvgl.label_create(lvgl.scr_act())
    lvgl.obj_set_style_local_text_font(label2, lvgl.LABEL_PART_MAIN,lvgl.STATE_DEFAULT, f2)
    lvgl.label_set_text(label2, "你好123xxz")
    lvgl.obj_align(label2,Father,lvgl.ALIGN_CENTER,0,-100)
    lvgl.obj_add_style(label2, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)


    f3 = lvgl.font_load(spi.SPI_1, 48, 4)
    label3 = lvgl.label_create(lvgl.scr_act())
    lvgl.obj_set_style_local_text_font(label3, lvgl.LABEL_PART_MAIN,lvgl.STATE_DEFAULT, f3)
    lvgl.label_set_text(label3, "你好123xxz")
    lvgl.obj_align(label3,Father,lvgl.ALIGN_CENTER,0,100)
    lvgl.obj_add_style(label3, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)

    f4 = lvgl.font_load(spi.SPI_1, 24, 4)
    label4 = lvgl.label_create(lvgl.scr_act())
    lvgl.obj_set_style_local_text_font(label4, lvgl.LABEL_PART_MAIN,lvgl.STATE_DEFAULT, f4)
    lvgl.label_set_text(label4, "你好123xxz")
    lvgl.obj_align(label4,Father,lvgl.ALIGN_CENTER,0,300)
    lvgl.obj_add_style(label4, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)

end

