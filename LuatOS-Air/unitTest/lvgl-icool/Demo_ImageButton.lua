---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个ImageButton----------------------------------------------------
想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/widgets/imgbtn.html
]]
local demo_ImgBtnHandleVar = nil
demo_ImgBtnInchange = false

function demo_ImageButtonInit()
    --创建一个 Image
    demo_ImageButton = lvgl.imgbtn_create(lvgl.scr_act(), nil)
    --设置 Image 的内容
    lvgl.imgbtn_set_src(demo_ImageButton, lvgl.BTN_STATE_RELEASED, "/lua/Demo_ImgBtn.jpg")
    lvgl.imgbtn_set_src(demo_ImageButton, lvgl.BTN_STATE_PRESSED, "/lua/Demo_ImgBtn.jpg")
    --设置 Image 的大小(也可以不设置,则显示图片本来的大小)
    lvgl.obj_set_size(demo_ImageButton, 150, 150)
    --设置 Image 的位置
    lvgl.obj_align(demo_ImageButton, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
    --添加事件
    lvgl.obj_set_event_cb(demo_ImageButton, demo_ImgBtnHandleVar)

    demo_ImageButtonLabel = lvgl.label_create(lvgl.scr_act(), nil)
    lvgl.label_set_text(demo_ImageButtonLabel, "快速点击")
    lvgl.obj_align(demo_ImageButtonLabel,  DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 100)
    lvgl.obj_add_style(demo_ImageButtonLabel, lvgl.LABEL_PART_MAIN, demo_ThemeFontStyle)
end

local function demo_ImgBtnHandle(obj, e)
    if (e == lvgl.EVENT_RELEASED)then
        if (demo_ImgBtnInchange)then
            lvgl.obj_align(demo_ImageButton, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, 0)
            demo_ImgBtnInchange = false
        else
            lvgl.obj_align(demo_ImageButton, DEMO_BASE_CONT, lvgl.ALIGN_CENTER, 0, -10)
            demo_ImgBtnInchange = true
        end
    end
end

demo_ImgBtnHandleVar = demo_ImgBtnHandle