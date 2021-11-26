function DropdownlistInit()
    Dropdownlist1 = lvgl.dropdown_create(lvgl.scr_act(),nil)
    lvgl.obj_align(Dropdownlist1, Father, lvgl.ALIGN_CENTER, 0, -300)
    lvgl.dropdown_set_options_static(Dropdownlist1,"一\n二\n三")
    lvgl.dropdown_clear_options(Dropdownlist1)
    lvgl.dropdown_set_options(Dropdownlist1,"鼠\n牛\n虎\n兔\n龙\n蛇\n马\n羊\n猴\n鸡\n狗\n猪")
    lvgl.dropdown_add_option(Dropdownlist1,"小白座",11)
    lvgl.dropdown_set_selected(Dropdownlist1,3)

    Dropdownlist2 = lvgl.dropdown_create(lvgl.scr_act(),nil)
    lvgl.obj_align(Dropdownlist2, Father, lvgl.ALIGN_CENTER, 0, 100)
    lvgl.dropdown_set_text(Dropdownlist1,"星座书")
    lvgl.dropdown_set_options_static(Dropdownlist2,"狮子座\n白羊座\n射手座\n处女座\n水瓶座\n巨蟹座\n魔羯座\n金牛座\n双子座\n天秤座\n双鱼座\n天蝎座")
    lvgl.dropdown_set_dir(Dropdownlist2,lvgl.DROPDOWN_DIR_RIGHT)
    lvgl.dropdown_set_max_height(Dropdownlist2,300)
    lvgl.dropdown_set_symbol(Dropdownlist2,nil)
    lvgl.dropdown_set_show_selected(Dropdownlist2,false)
    lvgl.dropdown_set_text(Dropdownlist2,"星座书")
end


