function CheckboxInit()
   event_handler = function(obj, event)
      if event == lvgl.EVENT_VALUE_CHANGED then
         if lvgl.obj_get_id(Checkbox1) == lvgl.obj_get_id(obj)  then 
            lvgl.label_set_text(Label1,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox1).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox1)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox1)))  
         end 
         if lvgl.obj_get_id(Checkbox2) == lvgl.obj_get_id(obj)  then 
            lvgl.label_set_text(Label2,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox2).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox2)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox2)))  
         end 
         if lvgl.obj_get_id(Checkbox3) == lvgl.obj_get_id(obj)  then 
            lvgl.label_set_text(Label3,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox3).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox3)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox3)))  
         end 
         if lvgl.obj_get_id(Checkbox4) == lvgl.obj_get_id(obj)  then 
            lvgl.label_set_text(Label4,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox4).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox4)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox4)))  
         end 
     end
   end 


   Checkbox1 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox1,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox1,Father,lvgl.ALIGN_CENTER,0,-300)
   lvgl.obj_add_style(Checkbox1,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
   lvgl.obj_set_event_cb(Checkbox1, event_handler)

   Label1 = lvgl.label_create(lvgl.scr_act(),nil)
   lvgl.label_set_text(Label1,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox1).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox1)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox1)))
   lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-230)
   lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

   Checkbox2 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox2,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox2,Father,lvgl.ALIGN_CENTER,0,-100)
   lvgl.obj_add_style(Checkbox2,lvgl.CHECKBOX_PART_BULLET, demo_ThemeFontStyle)
   lvgl.checkbox_set_checked(Checkbox2,true)
   lvgl.obj_set_event_cb(Checkbox2, event_handler)

   Label2 = lvgl.label_create(lvgl.scr_act(),nil)
   lvgl.label_set_text(Label2,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox2).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox2)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox2)))
   lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,-30)
   lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

   Checkbox3 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox3,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox3,Father,lvgl.ALIGN_CENTER,0,100)
   lvgl.obj_add_style(Checkbox3,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
   lvgl.checkbox_set_disabled(Checkbox3)
   lvgl.obj_set_event_cb(Checkbox3, event_handler)

   Label3 = lvgl.label_create(lvgl.scr_act(),nil)
   lvgl.label_set_text(Label3,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox3).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox3)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox3)))
   lvgl.obj_align(Label3,nil,lvgl.ALIGN_CENTER,0,170)
   lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

   Checkbox4 = lvgl.checkbox_create(lvgl.scr_act(),nil)
   lvgl.checkbox_set_text(Checkbox4,"小白测试123~!@#$%^&*()~！@#￥%……&*haha")
   lvgl.obj_align(Checkbox4,Father,lvgl.ALIGN_CENTER,0,300)
   lvgl.obj_add_style(Checkbox4,lvgl.CHECKBOX_PART_BG, demo_ThemeFontStyle)
   lvgl.checkbox_set_state(Checkbox4,lvgl.BTN_STATE_CHECKED_PRESSED)
   lvgl.obj_set_event_cb(Checkbox4, event_handler)
   
   Label4 = lvgl.label_create(lvgl.scr_act(),nil)
   lvgl.label_set_text(Label4,"获取复选框文本 : "..lvgl.checkbox_get_text(Checkbox4).."\n获取复选框当前的状态 : "..tostring(lvgl.checkbox_is_checked(Checkbox4)).."\n获取复选框当前状态 : "..tostring(lvgl.checkbox_get_state(Checkbox4)))
   lvgl.obj_align(Label4,nil,lvgl.ALIGN_CENTER,0,370)
   lvgl.obj_add_style(Label4, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end


