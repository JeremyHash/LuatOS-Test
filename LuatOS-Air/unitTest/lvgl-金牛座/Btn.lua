function BtnInit()
    Btn = lvgl.btn_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btn, 200, 800)
    lvgl.obj_align(Btn, Father, lvgl.ALIGN_CENTER, 0, -200)
    lvgl.btn_set_checkable(Btn, true)
    lvgl.btn_set_state(Btn, lvgl.BTN_STATE_CHECKED_RELEASED)
    lvgl.btn_toggle(Btn)
    lvgl.btn_set_fit2(Btn, lvgl.FIT_NONE, lvgl.FIT_TIGHT)
    label = lvgl.label_create(Btn, nil)
    lvgl.label_set_text(label, "测试按钮")
end

