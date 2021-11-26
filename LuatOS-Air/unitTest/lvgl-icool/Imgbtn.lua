function ImgbtnInit()
    Imgbtn1 = lvgl.imgbtn_create(lvgl.scr_act(),nil)
    lvgl.imgbtn_set_src(Imgbtn1, lvgl.BTN_STATE_RELEASED, "/lua/ImgBtn.jpg")
    lvgl.imgbtn_set_src(Imgbtn1, lvgl.BTN_STATE_PRESSED, "/lua/Img_Big.jpg")
    lvgl.obj_set_size(Imgbtn1, 150, 150)
    lvgl.obj_align(Imgbtn1,Father, lvgl.ALIGN_CENTER, 0, -200)


    Imgbtn2 = lvgl.imgbtn_create(lvgl.scr_act(),nil)
    lvgl.imgbtn_set_src(Imgbtn2, lvgl.BTN_STATE_RELEASED, "/lua/ImgBtn.jpg")
    lvgl.imgbtn_set_src(Imgbtn2, lvgl.BTN_STATE_PRESSED, "/lua/Img_Big.jpg")
    lvgl.obj_set_size(Imgbtn2, 150, 150)
    lvgl.obj_align(Imgbtn2,Father, lvgl.ALIGN_CENTER, 0, 200)
    lvgl.imgbtn_set_state(Imgbtn2,lvgl.BTN_STATE_RELEASED)
    -- 没有这个接口
    -- lvgl.imgbtn_set_src_tiled(Imgbtn2,lvgl.BTN_STATE_RELEASED,"/lua/ImgBtn.jpg","/lua/Img_Big.jpg","/lua/Img_Big.jpg")
    -- lvgl.imgbtn_toggle(Imgbtn2)
    lvgl.imgbtn_set_checkable(Imgbtn2,true)
end

