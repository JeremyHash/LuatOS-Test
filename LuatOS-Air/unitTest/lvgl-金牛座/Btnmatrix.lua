function BtnmatrixInit()
  
    -- 控件Btnmatrix1
    local tb1 = {"1", "2", "3", "4", "5", "\n", "测试1", "测试2", ""}
    Btnmatrix1 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix1, 400, 150)
    lvgl.obj_align(Btnmatrix1, Father, lvgl.ALIGN_IN_TOP_MID, 0, 0)
    lvgl.btnmatrix_set_map(Btnmatrix1, tb1)
    lvgl.btnmatrix_set_btn_ctrl_all(Btnmatrix1,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_width(Btnmatrix1, 6, 2)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix1,6,lvgl.BTNMATRIX_CTRL_HIDDEN)
    lvgl.btnmatrix_set_one_check(Btnmatrix1, true)
    lvgl.btnmatrix_clear_btn_ctrl(Btnmatrix1,6,lvgl.BTNMATRIX_CTRL_HIDDEN)
    
    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"是否可以使用重新着色 : "..tostring(lvgl.btnmatrix_get_recolor(Btnmatrix1)).."\n焦点按钮的索引 : "..lvgl.btnmatrix_get_focused_btn(Btnmatrix1).."\n按钮的文本 : "..lvgl.btnmatrix_get_btn_text(Btnmatrix1).."\n按钮矩阵的按钮是否启用或禁用控件值 : "..tostring(lvgl.btnmatrix_get_btn_ctrl(Btnmatrix1,5,lvgl.BTNMATRIX_CTRL_HIDDEN)).."\n是否启用了“one toggle”模式 : "..tostring(lvgl.btnmatrix_get_one_check(Btnmatrix1)).."\n获取对齐属性 : "..lvgl.btnmatrix_get_align(Btnmatrix1))
    lvgl.obj_align(Label1,Father,lvgl.ALIGN_IN_TOP_MID,0,160)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    -- 控件Btnmatrix2
    local tb2 = {"q", "w", "e", "r", "t", "\n", "测试1", "测试2", ""}
    Btnmatrix2 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix2, 400, 150)
    lvgl.obj_align(Btnmatrix2, Father, lvgl.ALIGN_IN_TOP_MID, 0, 270)
    lvgl.btnmatrix_set_map(Btnmatrix2, tb2)
    lvgl.btnmatrix_set_btn_ctrl_all(Btnmatrix2,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_width(Btnmatrix2, 6, 2)
    lvgl.btnmatrix_set_one_check(Btnmatrix2, false)
    lvgl.btnmatrix_clear_btn_ctrl_all(Btnmatrix2,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    
    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"是否可以使用重新着色 : "..tostring(lvgl.btnmatrix_get_recolor(Btnmatrix2)).."\n焦点按钮的索引 : "..lvgl.btnmatrix_get_focused_btn(Btnmatrix2).."\n按钮的文本 : "..lvgl.btnmatrix_get_btn_text(Btnmatrix2).."\n按钮矩阵的按钮是否启用或禁用控件值 : "..tostring(lvgl.btnmatrix_get_btn_ctrl(Btnmatrix2,5,lvgl.BTNMATRIX_CTRL_HIDDEN)).."\n是否启用了“one toggle”模式 : "..tostring(lvgl.btnmatrix_get_one_check(Btnmatrix2)).."\n获取对齐属性 : "..lvgl.btnmatrix_get_align(Btnmatrix2))
    lvgl.obj_align(Label2,Father,lvgl.ALIGN_IN_TOP_MID,0,430)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


    -- 控件Btnmatrix3
    local tb3 = {"!", "@", "#", "$", "&", "\n", "测试1", "测试2", ""}
    Btnmatrix3 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix3, 400, 150)
    lvgl.obj_align(Btnmatrix3, Father, lvgl.ALIGN_IN_TOP_MID, 0, 540)
    lvgl.btnmatrix_set_map(Btnmatrix3, tb3)
    lvgl.btnmatrix_set_align(Btnmatrix3,lvgl.LABEL_ALIGN_RIGHT)
    lvgl.btnmatrix_set_focused_btn(Btnmatrix3, 1)
    lvgl.btnmatrix_set_recolor(Btnmatrix3, true)
    lvgl.btnmatrix_set_align(Btnmatrix3,lvgl.LABEL_ALIGN_LEFT)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 2, lvgl.BTNMATRIX_CTRL_DISABLED)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 3, lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 4, lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 4, lvgl.BTNMATRIX_CTRL_CHECK_STATE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 5, lvgl.BTNMATRIX_CTRL_HIDDEN)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 6, lvgl.BTNMATRIX_CTRL_CHECK_STATE)

    Label3 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label3,"是否可以使用重新着色 : "..tostring(lvgl.btnmatrix_get_recolor(Btnmatrix3)).."\n焦点按钮的索引 : "..lvgl.btnmatrix_get_focused_btn(Btnmatrix3).."\n按钮的文本 : "..lvgl.btnmatrix_get_btn_text(Btnmatrix3).."\n按钮矩阵的按钮是否启用或禁用控件值 : "..tostring(lvgl.btnmatrix_get_btn_ctrl(Btnmatrix3,5,lvgl.BTNMATRIX_CTRL_HIDDEN)).."\n是否启用了“one toggle”模式 : "..tostring(lvgl.btnmatrix_get_one_check(Btnmatrix3)).."\n获取对齐属性 : "..lvgl.btnmatrix_get_align(Btnmatrix3))
    lvgl.obj_align(Label3,Father,lvgl.ALIGN_IN_TOP_MID,0,700)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end

