---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Image----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/img.html
]]
function demo_ImageInit()
    --创建一个 Image
    demo_Image = lvgl.img_create(lvgl.scr_act(), nil)
    --设置 Image 的内容
    lvgl.img_set_src(demo_Image, "/lua/Demo_Img_Big.jpg")
    --设置 Image 的大小(也可以不设置,则显示图片本来的大小)
    lvgl.obj_set_size(demo_Image, 480, 854)
    --设置 Image 的位置
    lvgl.obj_align(demo_Image, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Image, lvgl.IMG_PART_MAIN, demo_ThemeStyle_Bg)
end