---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Gauge----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/gauge.html
]]
function demo_GaugeInit()
    --创建一个颜色
    green = lvgl.color_make(0, 255, 0)
    --创建一个 Gauge
    demo_Gauge = lvgl.gauge_create(lvgl.scr_act(), nil)
    --设置 gauge 的表盘指针数
    lvgl.gauge_set_needle_count(demo_Gauge, 1, green)
    --设置表针的值
	lvgl.gauge_set_value(demo_Gauge, 0, 50)
    --设置 Gauge 的大小
    lvgl.obj_set_size(demo_Gauge, 440, 440)
    --设置 Gauge 的位置
    lvgl.obj_align(demo_Gauge, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --设置 Gauge 里的刻度的最小最大值
    lvgl.gauge_set_range(demo_Gauge, 0, 300)
    --设置 Gauge 里的填充的面积，360为不填充
    lvgl.gauge_set_critical_value(demo_Gauge, 100)

    --添加样式
    lvgl.obj_add_style(demo_Gauge, lvgl.GAUGE_PART_MAIN, demo_ThemeStyle_Bg)
end