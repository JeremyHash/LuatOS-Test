function LinemeterInit()
     Linemeter1 = lvgl.linemeter_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Linemeter1,200,200)
     lvgl.obj_align(Linemeter1,Father,lvgl.ALIGN_CENTER,0,-300)
     lvgl.linemeter_set_value(Linemeter1,40)
     lvgl.linemeter_set_mirror(Linemeter1,true)



     Linemeter2 = lvgl.linemeter_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Linemeter2,200,200)
     lvgl.obj_align(Linemeter2,Father,lvgl.ALIGN_CENTER,0,0)
     lvgl.linemeter_set_value(Linemeter2,40)
     lvgl.linemeter_set_range(Linemeter2,0,140)

     Linemeter3 = lvgl.linemeter_create(lvgl.scr_act(),nil)
     lvgl.obj_set_size(Linemeter3,200,200)
     lvgl.obj_align(Linemeter3,Father,lvgl.ALIGN_CENTER,0,300)
     lvgl.linemeter_set_value(Linemeter3,40)
     lvgl.linemeter_set_scale(Linemeter3,360,10)
     lvgl.linemeter_set_angle_offset(Linemeter3,180)
end