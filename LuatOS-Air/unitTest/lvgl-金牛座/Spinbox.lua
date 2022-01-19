local SpinBoxAddVar = nil
local SpinBoxDivVar = nil

function SpinboxInit()
     Spinbox1 = lvgl.spinbox_create(lvgl.scr_act(),nil)
	 lvgl.obj_set_width(Spinbox1, 200)
	 lvgl.obj_align(Spinbox1, Father, lvgl.ALIGN_CENTER, 0, -200)
	 lvgl.spinbox_set_value(Spinbox1,90000)

	 Label1 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label1,"获取 spinbox 翻转功能状态: "..tostring(lvgl.spinbox_get_rollover(Spinbox1)).."\n获取 spinbox 数值: "..lvgl.spinbox_get_value(Spinbox1).."\n获取 spinbox 步长值: "..lvgl.spinbox_get_step(Spinbox1))
	 lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-140)
	 lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Spinbox2 = lvgl.spinbox_create(lvgl.scr_act(),nil)
	 lvgl.obj_set_width(Spinbox2, 200)
	 lvgl.obj_align(Spinbox2, Father, lvgl.ALIGN_CENTER, 0, 100)
	 lvgl.spinbox_set_rollover(Spinbox2,true)
	 lvgl.spinbox_set_range(Spinbox2,-10000,10000)
	 lvgl.spinbox_set_digit_format(Spinbox2,6,3)
	 lvgl.spinbox_set_value(Spinbox2,9997)
	 lvgl.spinbox_set_step(Spinbox2,2)

	 Label2 = lvgl.label_create(lvgl.scr_act(),nil)
	 lvgl.label_set_text(Label2,"获取 spinbox 翻转功能状态: "..tostring(lvgl.spinbox_get_rollover(Spinbox2)).."\n获取 spinbox 数值: "..lvgl.spinbox_get_value(Spinbox2).."\n获取 spinbox 步长值: "..lvgl.spinbox_get_step(Spinbox2))
	 lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,160)
	 lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

	 Btn1 = lvgl.btn_create(lvgl.scr_act(), nil)
	 lvgl.obj_set_size(Btn1, 50, 50)
	 lvgl.obj_align(Btn1, Father, lvgl.ALIGN_CENTER, -150, 100)
	 lvgl.obj_add_style(Btn1, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
	 lvgl.obj_set_event_cb(Btn1, SpinBoxDivVar)
	 
	 Btn2 = lvgl.btn_create(lvgl.scr_act(), nil)
	 lvgl.obj_set_size(Btn2, 50, 50)
	 lvgl.obj_align(Btn2, Father, lvgl.ALIGN_CENTER, 150, 100)
	 lvgl.obj_add_style(Btn2, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
	 lvgl.obj_set_event_cb(Btn2,SpinBoxAddVar )

end

local function SpinBoxAdd(obj, e)
	if (e == lvgl.EVENT_CLICKED)then
		--使 SpinBox 数值递增
		lvgl.spinbox_increment(Spinbox2)
	end
end

local function SpinBoxDiv(obj, e)
	if (e == lvgl.EVENT_CLICKED)then
		--使 SpinBox 数值递减
		lvgl.spinbox_decrement(Spinbox2)

	end
end

SpinBoxAddVar =  SpinBoxAdd
SpinBoxDivVar =  SpinBoxDiv