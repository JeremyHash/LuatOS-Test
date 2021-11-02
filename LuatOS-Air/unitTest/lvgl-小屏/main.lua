PROJECT = "lvglTest"
VERSION = "1.0.0"

require "sys"
require "common"
require "misc"
require "pins"
require "led"
require "scanCode"
require "uiWin"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local waitTime1 = 2000
local waitTime2 = 5000
require "color_lcd_spi_st7735"
local count = 1

sys.taskInit(function()
    sys.wait(1000)
    while true do   
        log.info("LVGLTest第"..count.."次")
        -- 创建曲线
        arc = lvgl.arc_create(lvgl.scr_act(), nil)
        -- 设置尺寸
        lvgl.obj_set_size(arc, 150, 150)
        -- 设置位置居中
        lvgl.obj_align(arc, nil, lvgl.ALIGN_CENTER, 0, 0)
        -- 绘制弧度
        lvgl.arc_set_end_angle(arc, 200)
        sys.wait(3000)
        lvgl.obj_del(arc)

        -- 按键回调函数
        event_handler = function(obj, event)
            if event == lvgl.EVENT_CLICKED then
                print("Clicked\n")
            elseif event == lvgl.EVENT_VALUE_CHANGED then
                print("Toggled\n")
            end
        end
        -- 按键1
        btn1 = lvgl.btn_create(lvgl.scr_act(), nil)
        lvgl.obj_set_event_cb(btn1, event_handler)
        lvgl.obj_align(btn1, nil, lvgl.ALIGN_CENTER, 0, -40)
        -- 按键1 的文字
        label = lvgl.label_create(btn1, nil)
        lvgl.label_set_text(label, "Button")
        -- 按键2
        btn2 = lvgl.btn_create(lvgl.scr_act(), nil)
        lvgl.obj_set_event_cb(btn2, event_handler)
        lvgl.obj_align(btn2, nil, lvgl.ALIGN_CENTER, 0, 40)
        lvgl.btn_set_checkable(btn2, true)
        lvgl.btn_toggle(btn2)
        lvgl.btn_set_fit2(btn2, lvgl.FIT_NONE, lvgl.FIT_TIGHT)
        -- 按键2 的文字
        label = lvgl.label_create(btn2, nil)
        lvgl.label_set_text(label, "Toggled")
        sys.wait(3000)
        lvgl.obj_del(btn1)
        lvgl.obj_del(btn2)

        -- 创建进度条
        bar = lvgl.bar_create(lvgl.scr_act(), nil)
        -- 设置尺寸
        lvgl.obj_set_size(bar, 100, 10);
        -- 设置位置居中
        lvgl.obj_align(bar, NULL, lvgl.ALIGN_CENTER, 0, 0)
        -- 设置加载完成时间
        lvgl.bar_set_anim_time(bar, 2000)
        -- 设置加载到的值
        lvgl.bar_set_value(bar, 100, lvgl.ANIM_ON)
        sys.wait(3000)
        lvgl.obj_del(bar)



        -- 高亮显示的日期
        highlightDate = lvgl.calendar_date_t() 
        -- 日历点击的回调函数
        -- 将点击日期设置高亮
        function event_handler(obj, event)
            if event == lvgl.EVENT_VALUE_CHANGED then
                date = lvgl.calendar_get_pressed_date(obj)
                if date then
                    print(string.format("Clicked date: %02d.%02d.%d\n", date.day, date.month, date.year))
                    highlightDate.year = date.year
                    highlightDate.month = date.month
                    highlightDate.day = date.day
                    lvgl.calendar_set_highlighted_dates(obj, highlightDate, 1)
                end
            end
        end
        -- 创建日历
        calendar = lvgl.calendar_create(lvgl.scr_act(), nil)
        lvgl.obj_set_size(calendar, 235, 235)
        lvgl.obj_align(calendar, nil, lvgl.ALIGN_CENTER, 0, 0)
        lvgl.obj_set_event_cb(calendar, event_handler)
        
        -- 设置今天日期
        today = lvgl.calendar_date_t()
        today.year = 2018
        today.month = 10
        today.day = 23
        
        lvgl.calendar_set_today_date(calendar, today)
        lvgl.calendar_set_showed_date(calendar, today)
        sys.wait(3000)
        lvgl.obj_del(calendar)

        -- 复选框回调函数
        function event_handler(obj, event)
            if event == lvgl.EVENT_VALUE_CHANGED then
                print("State", lvgl.checkbox_is_checked(obj))
            end
        end
        -- 创建复选框
        cb = lvgl.checkbox_create(lvgl.scr_act(), nil)
        -- 设置标签
        lvgl.checkbox_set_text(cb, "hello")
        -- 设置居中位置
        lvgl.obj_align(cb, nil, lvgl.ALIGN_CENTER, 0, 0)
        -- 设置回调函数
        lvgl.obj_set_event_cb(cb, event_handler)
        sys.wait(3000)
        lvgl.obj_del(cb)

        -- 创建容器
        cont = lvgl.cont_create(lvgl.scr_act(), nil)
        lvgl.obj_set_auto_realign(cont, true)                   
        lvgl.obj_align(cont, nil, lvgl.ALIGN_CENTER, 0, 0) 
        lvgl.cont_set_fit(cont, lvgl.FIT_TIGHT)
        lvgl.cont_set_layout(cont, lvgl.LAYOUT_COLUMN_MID) 
        -- 添加标签
        label = lvgl.label_create(cont, nil)
        lvgl.label_set_text(label, "Short text")
        sys.wait(3000)
        lvgl.obj_del(label)
        lvgl.obj_del(cont)


        -- 创建图表
        chart = lvgl.chart_create(lvgl.scr_act(), nil)
        lvgl.obj_set_size(chart, 200, 150)
        lvgl.obj_align(chart, nil, lvgl.ALIGN_CENTER, 0, 0)
        
        -- 设置 Chart 的显示模式 (折线图)
        lvgl.chart_set_type(chart, lvgl.CHART_TYPE_LINE)  
        
        ser1 = lvgl.chart_add_series(chart, lvgl.color_hex(0xFF0000))
        ser2 = lvgl.chart_add_series(chart, lvgl.color_hex(0x008000))
        
        -- 添加点
        for i=0, 15 do
            lvgl.chart_set_next(chart, ser1, math.random(10, 90))
        end
        
        for i=15, 0, -1 do
            lvgl.chart_set_next(chart, ser2, math.random(10, 90))
        end
        -- 刷新图表
        lvgl.chart_refresh(chart)
        sys.wait(3000)
        lvgl.obj_del(chart)

      
        -- 回调函数
         event_handler = function(obj, event)
             if (event == lvgl.EVENT_VALUE_CHANGED) then
                 print("Option:", lvgl.dropdown_get_symbol(obj))
             end
         end
         -- 创建下拉框
         dd = lvgl.dropdown_create(lvgl.scr_act(), nil)
         lvgl.dropdown_set_options(dd, [[Apple
         Banana
         Orange
         Cherry
         Grape
         Raspberry
         Melon
         Orange
         Lemon
         Nuts]])
         -- 设置对齐
         lvgl.obj_align(dd, nil, lvgl.ALIGN_IN_TOP_MID, 0, 20)
         lvgl.obj_set_event_cb(dd, event_handler)
         sys.wait(5000)
         lvgl.obj_del(dd)

         function keyCb(obj, e)
            -- 默认处理事件
            lvgl.keyboard_def_event_cb(keyBoard, e)
            if(e == lvgl.EVENT_CANCEL)then
                lvgl.keyboard_set_textarea(keyBoard, nil)
                --删除 KeyBoard
                lvgl.obj_del(keyBoard)
                keyBoard = nil
            end
        end
        function textAreaCb(obj, e)
            if (e == lvgl.EVENT_CLICKED) and not keyBoard then
                --创建一个 KeyBoard
                keyBoard = lvgl.keyboard_create(lvgl.scr_act(), nil)
                --设置 KeyBoard 的光标是否显示
                lvgl.keyboard_set_cursor_manage(keyBoard, true)
                --为 KeyBoard 设置一个文本区域
                lvgl.keyboard_set_textarea(keyBoard, textArea)
                lvgl.obj_set_event_cb(keyBoard, keyCb)
            end
        end
        textArea = lvgl.textarea_create(lvgl.scr_act(), nil)
        lvgl.obj_set_size(textArea, 100, 25)
        lvgl.textarea_set_text(textArea, "please input:")
        lvgl.obj_align(textArea, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, -45)
        lvgl.obj_set_event_cb(textArea, textAreaCb)
        sys.wait(3000)
        lvgl.obj_del(textArea)


        label = lvgl.label_create(lvgl.scr_act(), nil)
        lvgl.label_set_recolor(label, true)                     
        lvgl.label_set_text(label, "#0000ff Re-color# #ff00ff words# #ff0000 of\n# align the lines to\n the center and wrap\n long text automatically.")
        lvgl.obj_set_width(label, 100)  
        lvgl.label_set_align(label, lvgl.LABEL_ALIGN_CENTER)
        lvgl.obj_align(label, nil, lvgl.ALIGN_CENTER, 0, -40)
        sys.wait(3000)
        lvgl.obj_del(label)

        spinner = lvgl.spinner_create(lvgl.scr_act(), nil)
        lvgl.obj_set_size(spinner, 100, 100)
        lvgl.obj_align(spinner, nil, lvgl.ALIGN_CENTER, 0, 0) 
        sys.wait(3000)
        lvgl.obj_del(spinner)

        function event_handler(obj, event)
            if event == lvgl.EVENT_VALUE_CHANGED then
                print("State", lvgl.switch_get_state(obj))
            end
        end
        sw1 = lvgl.switch_create(lvgl.scr_act(), nil)
        lvgl.obj_align(sw1, nil, lvgl.ALIGN_CENTER, 0, -50)
        lvgl.obj_set_event_cb(sw1, event_handler)
        sw2 = lvgl.switch_create(lvgl.scr_act(), sw1)
        lvgl.switch_on(sw2, lvgl.ANIM_ON)
        lvgl.obj_align(sw2, nil, lvgl.ALIGN_CENTER, 0, 50)
        sys.wait(3000)
        lvgl.obj_del(sw1)
        lvgl.obj_del(sw2)


        --创建一个颜色
        green = lvgl.color_make(0, 255, 0)
        --创建一个 Gauge
        demo_Gauge = lvgl.gauge_create(lvgl.scr_act(), nil)
        --设置 gauge 的表盘指针数
        lvgl.gauge_set_needle_count(demo_Gauge, 1, green)
        --设置表针的值
        lvgl.gauge_set_value(demo_Gauge, 0, 50)
        --设置 Gauge 的大小
        lvgl.obj_set_size(demo_Gauge, 100, 100)
        --设置 Gauge 的位置
        lvgl.obj_align(demo_Gauge, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
        --设置 Gauge 里的刻度的最小最大值
        lvgl.gauge_set_range(demo_Gauge, 0, 300)
        --设置 Gauge 里的填充的面积，360为不填充
        lvgl.gauge_set_critical_value(demo_Gauge, 100)
    
        --添加样式
        lvgl.obj_add_style(demo_Gauge, lvgl.GAUGE_PART_MAIN, demo_ThemeStyle_Bg)
        sys.wait(3000)
        lvgl.obj_del(demo_Gauge)



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
        lvgl.obj_set_size(demo_Table, 30, 20)
        --设置 Table 的位置
        lvgl.obj_align(demo_Table, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, -50, -50)
        --添加样式
        lvgl.obj_add_style(demo_Table, lvgl.TABLE_PART_BG, demo_ThemeStyle_Bg)
        sys.wait(3000)
        lvgl.obj_del(demo_Table)
        count = count + 1
    end
end)


sys.init(0, 0)
sys.run()