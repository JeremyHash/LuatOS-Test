function BtnInit()
    event_handler = function(obj, event)
        if event == lvgl.EVENT_VALUE_CHANGED then
            lvgl.label_set_text(Label1,"按钮当前状态 : "..lvgl.btn_get_state(obj).."\n按钮的切换启用属性 : "..tostring(lvgl.btn_get_checkable(obj)).."\n按钮的布局 : "..lvgl.btn_get_layout(obj))
        end
    end 

    Btn1 = lvgl.btn_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Btn1, 200, 80)
    lvgl.obj_align(Btn1, Father, lvgl.ALIGN_CENTER, 0, -200)
    lvgl.btn_set_checkable(Btn1, true)
    lvgl.btn_set_state(Btn1, lvgl.BTN_STATE_CHECKED_RELEASED)
    -- lvgl.btn_toggle(Btn1)
    lvgl.btn_set_fit2(Btn1, lvgl.FIT_NONE, lvgl.FIT_TIGHT)
    lvgl.obj_set_event_cb(Btn1, event_handler)

    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"按钮当前状态 : "..lvgl.btn_get_state(Btn1).."\n按钮的切换启用属性 : "..tostring(lvgl.btn_get_checkable(Btn1)).."\n按钮的布局 : "..lvgl.btn_get_layout(Btn1))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-100)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Btn2 = lvgl.btn_create(lvgl.scr_act(),nil)
    lvgl.obj_set_size(Btn2, 200, 80)
    lvgl.obj_align(Btn2, Father, lvgl.ALIGN_CENTER, 0, 100)
    lvgl.btn_set_checkable(Btn2, false)
    lvgl.btn_set_layout( Btn2 ,lvgl.LAYOUT_ROW_TOP )
    lvgl.btn_set_state(Btn2, lvgl.BTN_STATE_PRESSED)
    lvgl.btn_set_fit(Btn2 , lvgl.LAYOUT_CENTER)
    lvgl.btn_toggle(Btn2)
    lvgl.btn_set_fit2(Btn2, lvgl.FIT_NONE, lvgl.FIT_TIGHT)

    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"按钮当前状态 : "..lvgl.btn_get_state(Btn2).."\n按钮的切换启用属性 : "..tostring(lvgl.btn_get_checkable(Btn2)).."\n按钮的布局 : "..lvgl.btn_get_layout(Btn2))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,200)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)


end