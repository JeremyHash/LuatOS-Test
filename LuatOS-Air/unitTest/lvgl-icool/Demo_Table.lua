---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个Table---------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/table.html
]]
function demo_TableInit()
    --创建一个 Table
    demo_Table = lvgl.table_create(lvgl.scr_act(), nil)
    --设置 Table 的行数
    lvgl.table_set_row_cnt(demo_Table, 3)
    --设置 Table 的列数
    lvgl.table_set_col_cnt(demo_Table, 2)

    --设置 Table 的内容
    lvgl.table_set_cell_value(demo_Table, 0, 0, "阵营")
    lvgl.table_set_cell_value(demo_Table, 1, 0, "博派")
    lvgl.table_set_cell_value(demo_Table, 2, 0, "狂派")
    
    lvgl.table_set_cell_value(demo_Table, 0, 1, "首领")
    lvgl.table_set_cell_value(demo_Table, 1, 1, "擎天柱")
    lvgl.table_set_cell_value(demo_Table, 2, 1, "威震天")

    --设置 Table 的显示大小
    lvgl.obj_set_size(demo_Table, 150, 60)
    --设置 Table 的位置
    lvgl.obj_align(demo_Table, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, -50, -50)
    --添加样式
    lvgl.obj_add_style(demo_Table, lvgl.TABLE_PART_BG, demo_ThemeStyle_Bg)
end