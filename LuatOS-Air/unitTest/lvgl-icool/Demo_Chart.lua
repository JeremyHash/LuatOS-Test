---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Chart----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/chart.html
]]
function demo_ChartInit()
    --创建一个 Chart
    demo_Chart = lvgl.chart_create(lvgl.scr_act(), nil)
    --设置 Chart 的大小
    lvgl.obj_set_size(demo_Chart, 460, 400)
    --设置 CheckBox 的位置
    lvgl.obj_align(demo_Chart, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_Chart, lvgl.CHART_PART_BG, demo_ThemeStyle_Bg)

    --显示模式只选其一
    --设置 Chart 的显示模式(线表图)
    -- lvgl.chart_set_type(demo_Chart, lvgl.CHART_TYPE_LINE)
    --设置 Chart 的显示模式(柱状图)
    lvgl.chart_set_type(demo_Chart, lvgl.CHART_TYPE_COLUMN)

    --添加点线颜色
    Demo_Chart_Blue = lvgl.chart_add_series(demo_Chart, lvgl.color_hex(0x0000FF))
    Demo_Chart_Red = lvgl.chart_add_series(demo_Chart, lvgl.color_hex(0xFF0000))

    --添加蓝色点数据
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 20)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 20)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 20)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 20)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 30)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 40)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 60)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 60)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 55)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Blue, 50)
    --添加红色点数据
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 70)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 60)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 60)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 50)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 40)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 35)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 30)
    lvgl.chart_set_next(demo_Chart, Demo_Chart_Red, 30)

end