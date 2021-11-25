local SpinBoxAddVar = nil
local SpinBoxDivVar = nil

function SpinboxInit()
     Spinbox1 = lvgl.spinbox_create(lvgl.scr_act(),nil)
	 lvgl.obj_set_width(Spinbox1, 200)
	 lvgl.obj_align(Spinbox1, Father, lvgl.ALIGN_CENTER, 0, -150)
	 lvgl.spinbox_set_value(Spinbox1,90000)

	 Spinbox2 = lvgl.spinbox_create(lvgl.scr_act(),nil)
	 lvgl.obj_set_width(Spinbox2, 200)
	 lvgl.obj_align(Spinbox2, Father, lvgl.ALIGN_CENTER, 0, 150)
	 lvgl.spinbox_set_rollover(Spinbox2,true)
	 lvgl.spinbox_set_range(Spinbox2,-10000,10000)
	 lvgl.spinbox_set_digit_format(Spinbox2,6,3)
	 lvgl.spinbox_set_value(Spinbox2,9997)
	 lvgl.spinbox_set_step(Spinbox2,2)

	 Btn1 = lvgl.btn_create(lvgl.scr_act(), nil)
	 lvgl.obj_set_size(Btn1, 50, 50)
	 lvgl.obj_align(Btn1, Father, lvgl.ALIGN_CENTER, -150, 150)
	 lvgl.obj_add_style(Btn1, lvgl.BTN_PART_MAIN, demo_ThemeStyle_Bg)
	 lvgl.obj_set_event_cb(Btn1, SpinBoxDivVar)
	 
	 Btn2 = lvgl.btn_create(lvgl.scr_act(), nil)
	 lvgl.obj_set_size(Btn2, 50, 50)
	 lvgl.obj_align(Btn2, Father, lvgl.ALIGN_CENTER, 150, 150)
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