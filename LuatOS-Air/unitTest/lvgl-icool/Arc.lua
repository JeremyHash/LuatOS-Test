function ArcInit()
    Arc = lvgl.arc_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(Arc, 200, 200)
    lvgl.obj_align(Arc, father, lvgl.ALIGN_CENTER, 0, 0)
    lvgl.obj_add_style(Arc, lvgl.ARC_PART_BG, demo_ThemeStyle_Bg)
    lvgl.arc_set_bg_angles(Arc, 315, 225)
    lvgl.arc_set_angles(Arc, 0, 200)
    lvgl.arc_set_rotation(Arc, 180)
    lvgl.arc_set_end_angle(Arc, 180)
end


