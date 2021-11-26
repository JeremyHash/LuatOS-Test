function ImgInit()
    Img1 = lvgl.img_create(lvgl.scr_act(),nil)
    lvgl.img_set_src(Img1,"/lua/Img_Big.jpg")
    lvgl.img_set_zoom(Img1,100)
    lvgl.img_set_auto_size(Img1,true)
    lvgl.obj_align(Img1,Father,lvgl.ALIGN_IN_TOP_MID,-100,-220)
  

    Img2 = lvgl.img_create(lvgl.scr_act(),nil)
    lvgl.img_set_src(Img2,"/lua/Img_Big.jpg")
    lvgl.img_set_zoom(Img2,100)
    lvgl.img_set_auto_size(Img2,true)
    lvgl.obj_align(Img2,Father,lvgl.ALIGN_IN_TOP_MID,100,-220)
    lvgl.img_set_offset_x(Img2,10)
    lvgl.img_set_offset_y(Img2,10)
 

    Img3 = lvgl.img_create(lvgl.scr_act(),nil)
    lvgl.img_set_src(Img3,"/lua/Img_Big.jpg")
    lvgl.img_set_zoom(Img3,100)
    lvgl.img_set_auto_size(Img3,true)
    lvgl.obj_align(Img3,Father,lvgl.ALIGN_IN_TOP_MID,-100,220)
    lvgl.img_set_pivot(Img3,300,300)
    lvgl.img_set_angle(Img3,90)
    --减少图片边缘的锯齿
    lvgl.img_set_antialias(Img3,true)
end


