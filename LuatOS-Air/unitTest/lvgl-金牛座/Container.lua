function ContainerInit()
    Container1 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container1,400,150)
    lvgl.obj_align(Container1,Father,lvgl.ALIGN_IN_TOP_MID,0,50)
    lvgl.obj_add_style(Container1, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    lvgl.cont_set_fit(Container1,lvgl.LAYOUT_CENTER)
    lvgl.cont_set_layout(Container1,lvgl.LAYOUT_PRETTY_MID)
  
    Label1 = lvgl.label_create(Container1,nil)
    lvgl.label_set_text(Label1,"获取容器布局 : "..lvgl.cont_get_layout(Container1).."\n获取容器左适合模式 : "..lvgl.cont_get_fit_left(Container1).."\n获取容器右适合模式 : "..lvgl.cont_get_fit_right(Container1).."\n获取容器顶部适合模式 : "..lvgl.cont_get_fit_top(Container1).."\n获取容器底部适合模式 : "..lvgl.cont_get_fit_bottom (Container1))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_IN_TOP_RIGHT,-20,70)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
  

    Container2 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container2,400,150)
    lvgl.obj_align(Container2,Father,lvgl.ALIGN_IN_TOP_MID,0,250)
    lvgl.obj_add_style(Container2, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    lvgl.cont_set_layout(Container2,lvgl.LAYOUT_COLUMN_RIGHT)

    Label2 = lvgl.label_create(Container2,nil)
    lvgl.label_set_text(Label2,"获取容器布局 : "..lvgl.cont_get_layout(Container2).."\n获取容器左适合模式 : "..lvgl.cont_get_fit_left(Container2).."\n获取容器右适合模式 : "..lvgl.cont_get_fit_right(Container2).."\n获取容器顶部适合模式 : "..lvgl.cont_get_fit_top(Container2).."\n获取容器底部适合模式 : "..lvgl.cont_get_fit_bottom (Container2))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_IN_TOP_RIGHT,-20,70)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


    Container3 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container3,400,150)
    lvgl.obj_align(Container3,Father,lvgl.ALIGN_IN_TOP_MID,0,450)
    lvgl.obj_add_style(Container3, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    lvgl.cont_set_layout(Container3,lvgl.LAYOUT_COLUMN_LEFT)

    Label3 = lvgl.label_create(Container3,nil)
    lvgl.label_set_text(Label3,"获取容器布局 : "..lvgl.cont_get_layout(Container3).."\n获取容器左适合模式 : "..lvgl.cont_get_fit_left(Container3).."\n获取容器右适合模式 : "..lvgl.cont_get_fit_right(Container3).."\n获取容器顶部适合模式 : "..lvgl.cont_get_fit_top(Container3).."\n获取容器底部适合模式 : "..lvgl.cont_get_fit_bottom (Container3))
    lvgl.obj_align(Label3,nil,lvgl.ALIGN_IN_TOP_RIGHT,-20,70)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Container4 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container4,400,150)
    lvgl.obj_align(Container4,Father,lvgl.ALIGN_IN_TOP_MID,0,650)
    lvgl.obj_add_style(Container4, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    lvgl.cont_set_fit(Container4,lvgl.LAYOUT_CENTER)
    lvgl.cont_set_layout(Container4,lvgl.LAYOUT_COLUMN_LEFT)

    Label4 = lvgl.label_create(Container4,nil)
    lvgl.label_set_text(Label4,"获取容器布局 : "..lvgl.cont_get_layout(Container4).."\n获取容器左适合模式 : "..lvgl.cont_get_fit_left(Container4).."\n获取容器右适合模式 : "..lvgl.cont_get_fit_right(Container4).."\n获取容器顶部适合模式 : "..lvgl.cont_get_fit_top(Container4).."\n获取容器底部适合模式 : "..lvgl.cont_get_fit_bottom (Container4))
    lvgl.obj_align(Label4,nil,lvgl.ALIGN_CENTER,0,350)
    lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end


