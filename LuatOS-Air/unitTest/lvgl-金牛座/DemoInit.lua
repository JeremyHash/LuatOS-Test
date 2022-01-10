module(...,package.seeall)

--waitTime : 控件的显示时间
local waitTime = 5000
--type     : 分为循环模式loop和单一控件显示single
local type  =  "loop"


_G.isInSimulator = false
local core = rtos.get_version()
if (core == "LuatOS-Air_V0001_SIMULATOR")then
	print("It's in Simulator", core)
	_G.isInSimulator = true
else
	print("It's not in Simulator", core)
	_G.isInSimulator = false
end

-- require "LCD"
require "mipi_lcd_GC9503"
require "tp"
require "lvsym"
require "DemoStyle"
require "Arc"
require "Bar"
require "Btn"
require "Btnmatrix"
require "Calendar"
require "Checkbox"
require "Chart"
require "Container"
require "Colorpicker"
require "Dropdownlist"
require "Font"
require "Gauge"
require "Img"
require "Imgbtn"
require "Keyboard"
require "Label"
require "LEDl"
require "List"
require "Linemeter"
require "Msgbox"
require "Page"
require "Roller"
require "Slider"
require "Spinbox"
require "Spinner"
require "Switch"
require "Table"
require "Tabview"
require "Textarea"
require "Window"

DEMO_BASE_CONT = nil

local data = {type = lvgl.INDEV_TYPE_POINTER}
local function input()
	if (_G.isInSimulator) then
		if lvgl.indev_get_emu_touch ~= nil then
			return lvgl.indev_get_emu_touch()
		end
	end
	local ret,ispress,px,py = tp.get()
	if ret then
		if lastispress == ispress and lastpx == px and lastpy == py then
			return data
		end
		lastispress = ispress
		lastpx = px
		lastpy = py
		if ispress then
			tpstate = lvgl.INDEV_STATE_PR
		else
			tpstate = lvgl.INDEV_STATE_REL
		end
	else
		return data
	end
	local topoint = {x = px,y = py}
	data.state = tpstate
	data.point = topoint
	return data
end
function demoInit()
	Father = lvgl.cont_create(lvgl.scr_act(), nil)
	lvgl.obj_set_size(Father, 480, 854)
	lvgl.obj_align(Father, nil, lvgl.ALIGN_CENTER, 0, 0)
	lvgl.obj_add_style(Father, lvgl.CONT_PART_MAIN, demo_BaseContStyle)

    if type == "single" then
		-- ArcInit()
		-- BarInit()
		-- BtnInit()
		-- BtnmatrixInit()
		-- CalendarInit()
		-- CheckboxInit()
        -- ChartInit()
		-- ContainerInit()
		-- ColorpickerInit()
		-- DropdownlistInit()
		-- FontInit()
		-- GaugeInit()
		-- ImgInit()
		-- ImgbtnInit()
		-- KeyboardInit()
		-- LabelInit()
		-- LEDInit()
        -- ListInit()
		-- LinemeterInit()
		-- MsgboxInit()
		-- PageInit()
		-- RollerInit()
		-- SliderInit()
        -- SpinboxInit()
		-- SpinnerInit()
		-- SwitchInit()
		-- TableInit()
		-- TabviewInit()
		-- TextareaInit()
		-- WindowInit()
	end
	if type == "loop" then 
	    sys.taskInit(function ()
			local count =  1 
			while true do 	
				 log.info("lvgl-icool测试第"..count.."次")
				 ArcInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Arc1)
				 lvgl.obj_del(Arc2)
				 lvgl.obj_del(Arc3)
				 lvgl.obj_del(Arc4)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 BarInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Bar1)
				 lvgl.obj_del(Bar2)
				 lvgl.obj_del(Bar3)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 BtnInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Btn1)
				 lvgl.obj_del(Btn2)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 BtnmatrixInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Btnmatrix1)
				 lvgl.obj_del(Btnmatrix2)
				 lvgl.obj_del(Btnmatrix3)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 CalendarInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Calendar)
				 lvgl.obj_del(Label1)
				 CheckboxInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Checkbox1)
				 lvgl.obj_del(Checkbox2)
				 lvgl.obj_del(Checkbox3)
				 lvgl.obj_del(Checkbox4)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 ChartInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Chart1)
				 lvgl.obj_del(Chart2)
				 lvgl.obj_del(Chart3)
				 lvgl.obj_del(Chart4)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 ContainerInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Container1)
				 lvgl.obj_del(Container2)
				 lvgl.obj_del(Container3)
				 lvgl.obj_del(Container4)
				 ColorpickerInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Colorpicker1)
				 lvgl.obj_del(Colorpicker2)
				 lvgl.obj_del(Colorpicker3)
				 lvgl.obj_del(Colorpicker4)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 DropdownlistInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Dropdownlist1)
				 lvgl.obj_del(Dropdownlist2)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 GaugeInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Gauge1)
				 lvgl.obj_del(Gauge2)
				 lvgl.obj_del(Gauge3)
				 lvgl.obj_del(Gauge4)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 ImgInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Img1)
				 lvgl.obj_del(Img2)
				 lvgl.obj_del(Img3)
				 ImgbtnInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Imgbtn1)
				 lvgl.obj_del(Imgbtn2)
				 lvgl.obj_del(Imgbtn3)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 KeyboardInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Keyboard1)
				 lvgl.obj_del(Keyboard2)
				 lvgl.obj_del(Keyboard3)
				 lvgl.obj_del(Keyboard4)
				 lvgl.obj_del(demo_TextArea)
				 LabelInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Label1)
				 lvgl.obj_del(Label2)
				 lvgl.obj_del(Label3)
				 lvgl.obj_del(Label4)
				 lvgl.obj_del(Label5)
				 lvgl.obj_del(Label6)
				 lvgl.obj_del(Label7)
				 lvgl.obj_del(Label8)
				 lvgl.obj_del(Label9)
				 lvgl.obj_del(label1)
				 lvgl.obj_del(label2)
				 lvgl.obj_del(label3)
				 lvgl.obj_del(label4)
				 lvgl.obj_del(label5)
				 lvgl.obj_del(label6)
				 lvgl.obj_del(label7)
				 lvgl.obj_del(label8)
				 lvgl.obj_del(label9)
				 LEDInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(LED1)
				 lvgl.obj_del(LED2)
				 lvgl.obj_del(LED3)
				 ListInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(List1)
				 lvgl.obj_del(List2)
				 lvgl.obj_del(List3)
				 LinemeterInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Linemeter1)
				 lvgl.obj_del(Linemeter2)
				 lvgl.obj_del(Linemeter3)
				 MsgboxInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Msgbox1)
				 lvgl.obj_del(Msgbox2)
				 PageInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Page1)
				 lvgl.obj_del(Page2)
				 lvgl.obj_del(Page3)
				 RollerInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Roller1)
				 lvgl.obj_del(Roller2)
				 SliderInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Slider1)
				 lvgl.obj_del(Slider2)
				 lvgl.obj_del(Slider3)
				 lvgl.obj_del(Slider4)
				 SpinboxInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Spinbox1)
				 lvgl.obj_del(Spinbox2)
				 lvgl.obj_del(Btn1)
				 lvgl.obj_del(Btn2)
				 SpinnerInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Spinner1)
				 lvgl.obj_del(Spinner2)
				 lvgl.obj_del(Spinner3)
				 SwitchInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Switch1)
				 lvgl.obj_del(Switch2)
				 TableInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Table1)
				 lvgl.obj_del(Table2)
				 TabviewInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Tabview)
				 TextareaInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Textarea1)
				 lvgl.obj_del(Textarea2)
				 lvgl.obj_del(Textarea3)
				 lvgl.obj_del(Textarea4)
				 WindowInit()
				 sys.wait(waitTime)
				 lvgl.obj_del(Window)
				 count = count + 1
			end
	    end)
	end
end

local function init()
	lvgl.init(demoInit, input)
	pmd.ldoset(8,pmd.LDO_VIBR)
end

init()