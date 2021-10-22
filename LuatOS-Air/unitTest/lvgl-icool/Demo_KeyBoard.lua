---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个KeyBoard和TextArea----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/keyboard.html
https://docs.lvgl.io/7.11/widgets/textarea.html

------------------------------------------------由于KeyBoard通常和TextArea搭配使用，所以Demo使其一同演示-----------------------------------
]]
local demo_KeyBoardHandleVar = nil
local demo_TextAreaHandleVar = nil
local demo_CreateKeyBoardVar = nil

function demo_KeyBoardAndTextAreaInit()
    --创建一个 TextArea
    demo_TextArea = lvgl.textarea_create(lvgl.scr_act(), nil)
    --设置 TextArea 的显示大小
    lvgl.obj_set_size(demo_TextArea, 400, 300)
    --设置 TextArea 的初始内容
    lvgl.textarea_set_text(demo_TextArea, "People will dead:")
    --设置 TextArea 的位置
    lvgl.obj_align(demo_TextArea, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, -200)
    --添加样式
    lvgl.obj_add_style(demo_TextArea, lvgl.TEXTAREA_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_set_event_cb(demo_TextArea, demo_TextAreaHandleVar)
end

local function demo_TextAreaHandle(obj, e)
    if (e == lvgl.EVENT_CLICKED)then
        demo_CreateKeyBoardVar()
    end
end

local function demo_CreateKeyBoard()
    --创建一个 KeyBoard
    demo_KeyBoard = lvgl.keyboard_create(lvgl.scr_act(), nil)
    --设置 KeyBoard 的光标是否显示
    lvgl.keyboard_set_cursor_manage(demo_KeyBoard, true)
    --为 KeyBoard 设置一个文本区域
    lvgl.keyboard_set_textarea(demo_KeyBoard, demo_TextArea)
    --添加样式
    lvgl.obj_add_style(demo_KeyBoard, lvgl.KEYBOARD_PART_BG, demo_ThemeStyle_Bg)
    lvgl.obj_add_style(demo_KeyBoard, lvgl.KEYBOARD_PART_BTN, demo_ThemeStyle_Bg)
    lvgl.obj_set_event_cb(demo_KeyBoard, demo_KeyBoardHandleVar)
end

local function demo_KeyBoardHandle(obj, e)
    --为 KeyBoard 声明一个事件
    lvgl.keyboard_def_event_cb(demo_KeyBoard, e)
    if(e == lvgl.EVENT_CANCEL)then
        lvgl.keyboard_set_textarea(demo_KeyBoard, nil)
        --删除 KeyBoard
        lvgl.obj_del(demo_KeyBoard)
        demo_KeyBoard = nil
    end
end

demo_KeyBoardHandleVar = demo_KeyBoardHandle
demo_TextAreaHandleVar = demo_TextAreaHandle
demo_CreateKeyBoardVar = demo_CreateKeyBoard