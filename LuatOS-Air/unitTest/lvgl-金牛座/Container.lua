function ContainerInit()
    Container1 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container1,400,150)
    lvgl.obj_align(Container1,Father,lvgl.ALIGN_IN_TOP_MID,0,50)
    lvgl.obj_add_style(Container1, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    label = lvgl.label_create(Container1, nil)
    lvgl.label_set_text(label, "It is a long text")
    label2 = lvgl.label_create(Container1, nil)
    lvgl.label_set_text(label2, "相遇在对的时间和地点，错过的情节却循环上演")
    lvgl.cont_set_layout(Container1,lvgl.LAYOUT_PRETTY_MID)

    Container2 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container2,400,150)
    lvgl.obj_align(Container2,Father,lvgl.ALIGN_IN_TOP_MID,0,250)
    lvgl.obj_add_style(Container2, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    label = lvgl.label_create(Container2, nil)
    lvgl.label_set_text(label, "It is a long text")
    label2 = lvgl.label_create(Container2, nil)
    lvgl.label_set_text(label2, "相遇在对的时间和地点，错过的情节却循环上演")
    lvgl.cont_set_layout(Container2,lvgl.LAYOUT_COLUMN_RIGHT)

    Container3 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container3,400,150)
    lvgl.obj_align(Container3,Father,lvgl.ALIGN_IN_TOP_MID,0,450)
    lvgl.obj_add_style(Container3, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    label = lvgl.label_create(Container3, nil)
    lvgl.label_set_text(label, "It is a long text")
    label2 = lvgl.label_create(Container3, nil)
    lvgl.label_set_text(label2, "相遇在对的时间和地点，错过的情节却循环上演")
    lvgl.cont_set_layout(Container3,lvgl.LAYOUT_COLUMN_LEFT)


    Container4 = lvgl.cont_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Container4,400,150)
    lvgl.obj_align(Container4,Father,lvgl.ALIGN_IN_TOP_MID,0,650)
    lvgl.obj_add_style(Container4, lvgl.CONT_PART_MAIN,demo_ThemeStyle_Bg)
    label2 = lvgl.label_create(Container4, nil)
    lvgl.label_set_text(label2, "It is a long text")
    lvgl.cont_set_fit(Container4,lvgl.LAYOUT_CENTER)

end


