---@diagnostic disable: lowercase-global, undefined-global
module(...,package.seeall)

--LCD
require "LCD"
--触摸屏
require "tp"
--LittleVGL内置SYMBOL
require "lvsym"
--------------------------------------------------LittleVGL所有对象的样式文件--------------------------------------------------
require "DemoStyle"
------------------------------------------------------LittleVGL Demo表--------------------------------------------------------
require "Demo_Arc"
require "Demo_Button"
require "Demo_Bar"
require "Demo_Calendar"
require "Demo_CheckBox"
require "Demo_Chart"
require "Demo_Container"
require "Demo_ColorPicker"
require "Demo_DropDown"
require "Demo_Guage"
require "Demo_Image"
require "Demo_ImageButton"
require "Demo_Label"
require "Demo_LED"
require "Demo_List"
require "Demo_LineMeter"
require "Demo_Page"
require "Demo_Roller"
require "Demo_Slider"
require "Demo_SpinBox"
require "Demo_Spinner"
require "Demo_Switch"
require "Demo_Table"
require "Demo_TabView"
require "Demo_Window"
require "Demo_KeyBoard"
--------------------------------------------------LittleVGL暂时不支持的控件--------------------------------------------------------
-- require "Demo_Line"
-- require "Demo_MessageBox"
-- require "Demo_TileView"

local waitTime = 5000
local count    = 1
DEMO_BASE_CONT = nil

local data = {type = lvgl.INDEV_TYPE_POINTER}
local function input()
	pmd.sleep(100)
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
	--为Demo创建一个共同的父级容器
	DEMO_BASE_CONT = lvgl.cont_create(lvgl.scr_act(), nil)
	--设置父级容器的大小
	lvgl.obj_set_size(DEMO_BASE_CONT, 480, 854)
	--设置父级容器的位置(对齐方式)
	lvgl.obj_align(DEMO_BASE_CONT, nil, lvgl.ALIGN_CENTER, 0, 0)
	--为父级容器添加样式
	lvgl.obj_add_style(DEMO_BASE_CONT, lvgl.CONT_PART_MAIN, demo_BaseContStyle)

    sys.taskInit(function ()
       while true do 	
		    log.info("lvgl-icool测试第"..count.."次")
            demo_ArcInit()
		    sys.wait(waitTime)
		    lvgl.obj_del(demo_Arc)
           	demo_BtnInit()
			sys.wait(waitTime)
		    lvgl.obj_del(demo_Btn)
           	demo_BarInit()
			sys.wait(waitTime)
		    lvgl.obj_del(demo_Bar)
           	demo_CalendarInit()
			sys.wait(waitTime)
		    lvgl.obj_del(demo_Calendar)
           	demo_CheckBoxInit()
		    sys.wait(waitTime)
		    lvgl.obj_del(demo_CheckBox)
           	demo_ChartInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Chart)
           	demo_ContInit()
			sys.wait(waitTime)
		    lvgl.obj_del(demo_Cont)
           	demo_CPickerInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_CPicker)   
           	demo_DropDownInit()
			sys.wait(waitTime)
		    lvgl.obj_del(demo_DropDown)
           	demo_GaugeInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Gauge)
           	demo_ImageInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Image)
           	demo_ImageButtonInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_ImageButton)   
           	demo_LabelInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Label)
           	demo_LEDInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_LED1)
			lvgl.obj_del(demo_LED2)
			lvgl.obj_del(demo_LED3)
           	demo_ListInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_List)
           	demo_LineMeterInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_LineMeter)
           	demo_PageInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Page)
           	demo_RollerInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Roller)
           	demo_SliderInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Slider)
           	demo_SpinBoxInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_SpinBox)
			lvgl.obj_del(demo_SpinBoxBtn1)
			lvgl.obj_del(demo_SpinBoxBtn2)
           	demo_SpinnerInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Spinner)
           	demo_SwitchInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Switch)
           	demo_TableInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Table)
           	demo_TabViewInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_TabView)
           	demo_WindowInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_Window)
           	demo_KeyBoardAndTextAreaInit()
			sys.wait(waitTime)
			lvgl.obj_del(demo_TextArea)
		
			-- count = count + 1
        end
    end)
end

local function init()
	lvgl.init(demoInit, input)
	pmd.ldoset(8,pmd.LDO_VIBR)
end

sys.taskInit(init, nil)