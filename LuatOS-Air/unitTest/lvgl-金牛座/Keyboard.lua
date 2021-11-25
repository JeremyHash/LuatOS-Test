function KeyboardInit()

    --创建一个 TextArea
    demo_TextArea = lvgl.textarea_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_TextArea, 200, 80)
    lvgl.textarea_set_text(demo_TextArea, "People will dead:")
    lvgl.obj_align(demo_TextArea, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, -350)
    lvgl.obj_add_style(demo_TextArea, lvgl.TEXTAREA_PART_BG, demo_ThemeStyle_Bg)
      Keyboard1 = lvgl.keyboard_create(lvgl.scr_act(),nil)
      lvgl.obj_set_size(Keyboard1,300,150)
      lvgl.obj_align(Keyboard1,Father, lvgl.ALIGN_CENTER, 0, -230)
      lvgl.keyboard_set_mode(Keyboard1,lvgl.KEYBOARD_MODE_TEXT_LOWER)
      lvgl.keyboard_set_textarea(Keyboard1,demo_TextArea)
    --   lvgl.keyboard_set_cursor_manage(Keyboard1,true)
    
      Keyboard2 = lvgl.keyboard_create(lvgl.scr_act(),nil)
      lvgl.obj_set_size(Keyboard2,300,150)
      lvgl.obj_align(Keyboard2,Father, lvgl.ALIGN_CENTER, 0, -40)
      lvgl.keyboard_set_mode(Keyboard2,lvgl.KEYBOARD_MODE_TEXT_UPPER)

      Keyboard3 = lvgl.keyboard_create(lvgl.scr_act(),nil)
      lvgl.obj_set_size(Keyboard3,300,150)
      lvgl.obj_align(Keyboard3,Father, lvgl.ALIGN_CENTER, 0, 150)
      lvgl.keyboard_set_mode(Keyboard3,lvgl.KEYBOARD_MODE_SPECIAL)

      Keyboard4 = lvgl.keyboard_create(lvgl.scr_act(),nil)
      lvgl.obj_set_size(Keyboard4,300,150)
      lvgl.obj_align(Keyboard4,Father, lvgl.ALIGN_CENTER, 0, 340)
      lvgl.keyboard_set_mode(Keyboard4,lvgl.KEYBOARD_MODE_NUM)

end


