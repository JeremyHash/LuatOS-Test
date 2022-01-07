function DropdownlistInit()
    event_handler = function(obj, event)
        if event == lvgl.EVENT_VALUE_CHANGED then
           if lvgl.obj_get_id(Dropdownlist1) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label1,"获取 ddlist 的文本:"..lvgl.dropdown_get_text(Dropdownlist1).."\n获取下拉列表的选项:\n"..lvgl.dropdown_get_options(Dropdownlist1).."\n获取选中选项:"..lvgl.dropdown_get_selected(Dropdownlist1).."\n获取选项总数:"..lvgl.dropdown_get_option_cnt(Dropdownlist1).."\n获取固定高度值:"..lvgl.dropdown_get_max_height(Dropdownlist1).."\n下拉列表关闭后的符号:"..lvgl.dropdown_get_symbol(Dropdownlist1).."\n获取下拉列表关闭后的符号:"..lvgl.dropdown_get_dir(Dropdownlist1).."\n是否高亮选择的选项:"..tostring(lvgl.dropdown_get_show_selected(Dropdownlist1)))
        end 
           if lvgl.obj_get_id(Dropdownlist2) == lvgl.obj_get_id(obj)  then 
              lvgl.label_set_text(Label2,"获取 ddlist 的文本:"..lvgl.dropdown_get_text(Dropdownlist2).."\n获取下拉列表的选项:\n"..lvgl.dropdown_get_options(Dropdownlist2).."\n获取选中选项:"..lvgl.dropdown_get_selected(Dropdownlist2).."\n获取选项总数:"..lvgl.dropdown_get_option_cnt(Dropdownlist2).."\n获取固定高度值:"..lvgl.dropdown_get_max_height(Dropdownlist2).."\n下拉列表关闭后的符号:"..tostring(lvgl.dropdown_get_symbol(Dropdownlist2)).."\n获取下拉列表关闭后的符号:"..lvgl.dropdown_get_dir(Dropdownlist2).."\n是否高亮选择的选项:"..tostring(lvgl.dropdown_get_show_selected(Dropdownlist2)))
        end 
       end
     end 

    Dropdownlist1 = lvgl.dropdown_create(lvgl.scr_act(),nil)
    lvgl.obj_align(Dropdownlist1, Father, lvgl.ALIGN_CENTER,-150, -300)
    lvgl.dropdown_set_options_static(Dropdownlist1,"一\n二\n三")
    lvgl.dropdown_clear_options(Dropdownlist1)
    lvgl.dropdown_set_options(Dropdownlist1,"鼠\n牛\n虎\n兔\n龙\n蛇\n马\n羊\n猴\n鸡\n狗\n猪")
    lvgl.dropdown_add_option(Dropdownlist1,"小白座",11)
    lvgl.dropdown_set_selected(Dropdownlist1,3)
    lvgl.obj_set_event_cb(Dropdownlist1, event_handler)

    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"获取 ddlist 的文本:"..lvgl.dropdown_get_text(Dropdownlist1).."\n获取下拉列表的选项:\n"..lvgl.dropdown_get_options(Dropdownlist1).."\n获取选中选项:"..lvgl.dropdown_get_selected(Dropdownlist1).."\n获取选项总数:"..lvgl.dropdown_get_option_cnt(Dropdownlist1).."\n获取固定高度值:"..lvgl.dropdown_get_max_height(Dropdownlist1).."\n下拉列表关闭后的符号:"..lvgl.dropdown_get_symbol(Dropdownlist1).."\n获取下拉列表关闭后的符号:"..lvgl.dropdown_get_dir(Dropdownlist1).."\n是否高亮选择的选项:"..tostring(lvgl.dropdown_get_show_selected(Dropdownlist1)))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,100,-200)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
 

    Dropdownlist2 = lvgl.dropdown_create(lvgl.scr_act(),nil)
    lvgl.obj_align(Dropdownlist2, Father, lvgl.ALIGN_CENTER, -150, 100)
    lvgl.dropdown_set_text(Dropdownlist1,"星座书")
    lvgl.dropdown_set_options_static(Dropdownlist2,"狮子座\n白羊座\n射手座\n处女座\n水瓶座\n巨蟹座\n魔羯座\n金牛座\n双子座\n天秤座\n双鱼座\n天蝎座")
    lvgl.dropdown_set_dir(Dropdownlist2,lvgl.DROPDOWN_DIR_RIGHT)
    lvgl.dropdown_set_max_height(Dropdownlist2,300)
    lvgl.dropdown_set_symbol(Dropdownlist2,nil)
    lvgl.dropdown_set_show_selected(Dropdownlist2,false)
    lvgl.dropdown_set_text(Dropdownlist2,"星座书")
    lvgl.obj_set_event_cb(Dropdownlist2, event_handler)

    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"获取 ddlist 的文本:"..lvgl.dropdown_get_text(Dropdownlist2).."\n获取下拉列表的选项:\n"..lvgl.dropdown_get_options(Dropdownlist2).."\n获取选中选项:"..lvgl.dropdown_get_selected(Dropdownlist2).."\n获取选项总数:"..lvgl.dropdown_get_option_cnt(Dropdownlist2).."\n获取固定高度值:"..lvgl.dropdown_get_max_height(Dropdownlist2).."\n下拉列表关闭后的符号:"..tostring(lvgl.dropdown_get_symbol(Dropdownlist2)).."\n获取下拉列表关闭后的符号:"..lvgl.dropdown_get_dir(Dropdownlist2).."\n是否高亮选择的选项:"..tostring(lvgl.dropdown_get_show_selected(Dropdownlist2)))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,100,200)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)
end


