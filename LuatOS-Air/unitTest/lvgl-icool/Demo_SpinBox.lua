---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个SpinBox----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/spinbox.html
]]
local demo_SpinBoxAddVar = nil
local demo_SpinBoxDivVar = nil

function demo_SpinBoxInit()
    --创建一个 SpinBox
    demo_SpinBox = lvgl.spinbox_create(lvgl.scr_act(), nil)
    --设置 SpinBox 取值范围
    lvgl.spinbox_set_range(demo_SpinBox, -1000, 90000)
    --设置 SpinBox 的显示位数
    lvgl.spinbox_set_digit_format(demo_SpinBox, 6, 3)
    --设置 SpinBox 的显示大小
    lvgl.obj_set_width(demo_SpinBox, 100)
    --设置 SpinBox 的位置
    lvgl.obj_align(demo_SpinBox, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加样式
    lvgl.obj_add_style(demo_SpinBox, lvgl.SPINBOX_PART_BG, demo_ThemeStyle_Bg)

    demo_SpinBoxBtn1 = lvgl.btn_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_SpinBoxBtn1, 60, 60)
    lvgl.obj_align(demo_SpinBoxBtn1, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, -150, 0)
    lvgl.obj_add_style(demo_SpinBoxBtn1, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.obj_set_event_cb(demo_SpinBoxBtn1, demo_SpinBoxAddVar)
    
    demo_SpinBoxBtn2 = lvgl.btn_create(lvgl.scr_act(), nil)
    lvgl.obj_set_size(demo_SpinBoxBtn2, 60, 60)
    lvgl.obj_align(demo_SpinBoxBtn2, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 150, 0)
    lvgl.obj_add_style(demo_SpinBoxBtn2, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
    lvgl.obj_set_event_cb(demo_SpinBoxBtn2, demo_SpinBoxDivVar)
end

local function demo_SpinBoxAdd(obj, e)
    if (e == lvgl.EVENT_CLICKED)then
        --使 SpinBox 数值递增
        lvgl.spinbox_increment(demo_SpinBox)
    end
end

local function demo_SpinBoxDiv(obj, e)
    if (e == lvgl.EVENT_CLICKED)then
        --使 SpinBox 数值递减
        lvgl.spinbox_decrement(demo_SpinBox)
    end
end

demo_SpinBoxAddVar = demo_SpinBoxAdd
demo_SpinBoxDivVar = demo_SpinBoxDiv