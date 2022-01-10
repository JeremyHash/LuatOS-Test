function ImgbtnInit()
    Imgbtn1 = lvgl.imgbtn_create(lvgl.scr_act(),nil)
    lvgl.imgbtn_set_src(Imgbtn1, lvgl.BTN_STATE_RELEASED, "/lua/ImgBtn.jpg")
    lvgl.imgbtn_set_src(Imgbtn1, lvgl.BTN_STATE_PRESSED, "/lua/Img_Big.jpg")
    lvgl.obj_set_size(Imgbtn1, 150, 150)
    lvgl.obj_align(Imgbtn1,Father, lvgl.ALIGN_IN_TOP_LEFT, 0, 0)

    Label1 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label1,"给定状态的图片:".. tostring(lvgl.imgbtn_get_src(Imgbtn1)).."\n获取图片按钮的当前状态:"..lvgl.imgbtn_get_state(Imgbtn1).."\n图片按钮的toggle enable属性:"..tostring(lvgl.imgbtn_get_checkable(Imgbtn1)))
    lvgl.obj_align(Label1,nil,lvgl.ALIGN_IN_TOP_RIGHT,-10,50)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Imgbtn2 = lvgl.imgbtn_create(lvgl.scr_act(),nil)
    lvgl.imgbtn_set_src(Imgbtn2, lvgl.BTN_STATE_RELEASED, "/lua/ImgBtn.jpg")
    lvgl.imgbtn_set_src(Imgbtn2, lvgl.BTN_STATE_PRESSED, "/lua/Img_Big.jpg")
    lvgl.obj_set_size(Imgbtn2, 150, 150)
    lvgl.obj_align(Imgbtn2,Father, lvgl.ALIGN_IN_LEFT_MID, 0, 0)
    lvgl.imgbtn_set_state(Imgbtn2,lvgl.BTN_STATE_RELEASED)
    -- 没有这个接口
    -- lvgl.imgbtn_set_src_tiled(Imgbtn2,lvgl.BTN_STATE_RELEASED,"/lua/ImgBtn.jpg","/lua/Img_Big.jpg","/lua/Img_Big.jpg")
    -- lvgl.imgbtn_toggle(Imgbtn2)
    lvgl.imgbtn_set_checkable(Imgbtn2,true)

    Label2 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label2,"给定状态的图片:".. tostring(lvgl.imgbtn_get_src(Imgbtn2)).."\n获取图片按钮的当前状态:"..lvgl.imgbtn_get_state(Imgbtn2).."\n图片按钮的toggle enable属性:"..tostring(lvgl.imgbtn_get_checkable(Imgbtn2)))
    lvgl.obj_align(Label2,nil,lvgl.ALIGN_IN_RIGHT_MID,-10,0)
    lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

    Imgbtn3 = lvgl.imgbtn_create(lvgl.scr_act(), nil)
    --设置 Image 的内容
    -- lvgl.imgbtn_set_src(Imgbtn3, lvgl.BTN_STATE_PRESSED, "/lua/air.png")
    lvgl.imgbtn_set_src(Imgbtn3, lvgl.BTN_STATE_RELEASED, "/lua/air.png")
    lvgl.imgbtn_set_src(Imgbtn3, lvgl.BTN_STATE_PRESSED, "/lua/air.png")
    --设置 Image 的大小(也可以不设置,则显示图片本来的大小)
    lvgl.obj_set_size(Imgbtn3, 150, 150)
    --设置 Image 的位置
    lvgl.obj_align(Imgbtn3, nil, lvgl.ALIGN_IN_BOTTOM_LEFT, 0, 0)

    --添加事件
    -- lvgl.obj_set_event_cb(Imgbtn3, demo_ImgBtnHandleVar)

    Label3 = lvgl.label_create(lvgl.scr_act(),nil)
    lvgl.label_set_text(Label3,"给定状态的图片:".. tostring(lvgl.imgbtn_get_src(Imgbtn3)).."\n获取图片按钮的当前状态:"..lvgl.imgbtn_get_state(Imgbtn3).."\n图片按钮的toggle enable属性:"..tostring(lvgl.imgbtn_get_checkable(Imgbtn3)))
    lvgl.obj_align(Label3,nil,lvgl.ALIGN_IN_BOTTOM_RIGHT,-10,-50)
    lvgl.obj_add_style(Label3, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end

