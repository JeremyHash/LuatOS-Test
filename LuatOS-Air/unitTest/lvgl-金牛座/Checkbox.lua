function CheckboxInit()
   Checkbox1 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox1,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox1,Father,lvgl.ALIGN_CENTER,0,-300)
   lvgl.obj_add_style(Checkbox1,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)

   Checkbox2 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox2,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox2,Father,lvgl.ALIGN_CENTER,0,-100)
   lvgl.obj_add_style(Checkbox2,lvgl.CHECKBOX_PART_BULLET, demo_ThemeFontStyle)
   lvgl.checkbox_set_checked(Checkbox2,true)

   Checkbox3 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox3,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox3,Father,lvgl.ALIGN_CENTER,0,100)
   lvgl.obj_add_style(Checkbox3,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
   lvgl.checkbox_set_disabled(Checkbox3)

   Checkbox4 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox4,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox4,Father,lvgl.ALIGN_CENTER,0,300)
   lvgl.obj_add_style(Checkbox4,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
   lvgl.checkbox_set_state(Checkbox4,lvgl.BTN_STATE_CHECKED_PRESSED)
   
end


