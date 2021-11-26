function BtnmatrixInit()
    -- 控件Btnmatrix1
    local tb1 = {"1", "2", "3", "4", "5", "\n", "测试1", "测试2", ""}
    Btnmatrix1 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix1, 400, 150)
    lvgl.obj_align(Btnmatrix1, Father, lvgl.ALIGN_CENTER, 0, -300)
    lvgl.btnmatrix_set_map(Btnmatrix1, tb1)
    lvgl.btnmatrix_set_btn_ctrl_all(Btnmatrix1,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_width(Btnmatrix1, 6, 2)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix1,6,lvgl.BTNMATRIX_CTRL_HIDDEN)
    lvgl.btnmatrix_set_one_check(Btnmatrix1, true)
    lvgl.btnmatrix_clear_btn_ctrl(Btnmatrix1,6,lvgl.BTNMATRIX_CTRL_HIDDEN)
    
    -- 控件Btnmatrix2
    local tb2 = {"q", "w", "e", "r", "t", "\n", "测试1", "测试2", ""}
    Btnmatrix2 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix2, 400, 150)
    lvgl.obj_align(Btnmatrix2, Father, lvgl.ALIGN_CENTER, 0, 0)
    lvgl.btnmatrix_set_map(Btnmatrix2, tb2)
    lvgl.btnmatrix_set_btn_ctrl_all(Btnmatrix2,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_width(Btnmatrix2, 6, 2)
    lvgl.btnmatrix_set_one_check(Btnmatrix2, true)
    lvgl.btnmatrix_clear_btn_ctrl_all(Btnmatrix2,lvgl.BTNMATRIX_CTRL_CHECKABLE)
    
    -- 控件Btnmatrix3
    local tb3 = {"!", "@", "#", "$", "&", "\n", "测试1", "测试2", ""}
    Btnmatrix3 = lvgl.btnmatrix_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btnmatrix3, 400, 150)
    lvgl.obj_align(Btnmatrix3, Father, lvgl.ALIGN_CENTER, 0, 300)
    lvgl.btnmatrix_set_map(Btnmatrix3, tb3)
    lvgl.btnmatrix_set_align(Btnmatrix3,lvgl.LABEL_ALIGN_RIGHT)
    lvgl.btnmatrix_set_focused_btn(Btnmatrix3, 1)
    -- lvgl.btnmatrix_set_recolor(Btnmatrix3, true)
    -- lvgl.obj_add_style(Btnmatrix3,lvgl.BTNMATRIX_PART_BTN,Style_LvglBtnMatrix1_2)
    lvgl.btnmatrix_set_align(Btnmatrix3,lvgl.LABEL_ALIGN_LEFT)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 2, lvgl.BTNMATRIX_CTRL_DISABLED)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 3, lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 4, lvgl.BTNMATRIX_CTRL_CHECKABLE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 4, lvgl.BTNMATRIX_CTRL_CHECK_STATE)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 5, lvgl.BTNMATRIX_CTRL_HIDDEN)
    lvgl.btnmatrix_set_btn_ctrl(Btnmatrix3, 6, lvgl.BTNMATRIX_CTRL_CHECK_STATE)

end

