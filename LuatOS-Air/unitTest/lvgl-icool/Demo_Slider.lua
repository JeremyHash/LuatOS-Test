---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Slider----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/slider.html
]]
function demo_SliderInit()
    --创建一个 Slider
    demo_Slider = lvgl.slider_create(lvgl.scr_act(), nil)
    --设置 Slider 的显示大小
    lvgl.obj_set_size(demo_Slider, 400, 60)
    --设置 Slider 的取值范围
    lvgl.slider_set_range(demo_Slider, 0, 100)
    --设置 Slider 的动画时间
    lvgl.slider_set_anim_time(demo_Slider, 3000)
    --设置 Slider 的值和是否开启动画
    lvgl.slider_set_value(demo_Slider, 100, lvgl.ANIM_ON)
    --设置 Slider 的位置
    lvgl.obj_align(demo_Slider, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Slider, lvgl.SLIDER_PART_BG, demo_ThemeStyle_Bg)
end