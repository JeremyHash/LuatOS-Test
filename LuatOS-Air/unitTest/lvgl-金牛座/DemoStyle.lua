---@diagnostic disable: lowercase-global, undefined-global

--[[----------------------------------------------------如何创建一个样式----------------------------------------------------
--1. 创建一个样式
style = lvgl.style_t()
--2. 为样式进行初始化
lvgl.style_init(style)
--3. 添加具体的样式
lvgl.style_set_bg_opa(style, lvgl.STATE_DEFAULT, lvgl.OPA_COVER)
lvgl.style_set_bg_color(style, lvgl.STATE_DEFAULT, lvgl.color_hex(0xFF00FF))

想要了解更多详情，你也可以复制此链接进入官网进行查看
https://docs.lvgl.io/7.11/overview/style.html
]]

--样式：父级容器
demo_BaseContStyle = lvgl.style_t()
lvgl.style_init(demo_BaseContStyle)
lvgl.style_set_radius(demo_BaseContStyle, lvgl.STATE_DEFAULT, 0)
lvgl.style_set_bg_color(demo_BaseContStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x333333))
lvgl.style_set_bg_color(demo_BaseContStyle, (lvgl.STATE_PRESSED or lvgl.STATE_CHECKED), lvgl.color_hex(0x333333))
lvgl.style_set_text_color(demo_BaseContStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0xF5F5F5))
lvgl.style_set_border_opa(demo_BaseContStyle, lvgl.STATE_DEFAULT, lvgl.OPA_0)

--所有Demo的基础样式：填充颜色以及字体说明颜色
demo_ThemeStyle_IndicAndFont = lvgl.style_t()
lvgl.style_init(demo_ThemeStyle_IndicAndFont)
lvgl.style_set_bg_color(demo_ThemeStyle_IndicAndFont, lvgl.STATE_DEFAULT, lvgl.color_hex(0x0A2594))
lvgl.style_set_bg_color(demo_ThemeStyle_IndicAndFont, (lvgl.STATE_PRESSED or lvgl.STATE_CHECKED), lvgl.color_hex(0x0A2594))
lvgl.style_set_text_color(demo_ThemeStyle_IndicAndFont, lvgl.STATE_DEFAULT, lvgl.color_hex(0xF5F5F5))

--所有Demo的基础样式：背景颜色
demo_ThemeStyle_Bg = lvgl.style_t()
lvgl.style_init(demo_ThemeStyle_Bg)
lvgl.style_set_bg_color(demo_ThemeStyle_Bg, lvgl.STATE_DEFAULT, lvgl.color_hex(0x808080))
lvgl.style_set_bg_color(demo_ThemeStyle_Bg, (lvgl.STATE_CHECKED or lvgl.STATE_PRESSED), lvgl.color_hex(0x808080))
lvgl.style_set_bg_color(demo_ThemeStyle_Bg, lvgl.STATE_DISABLED, lvgl.color_hex(0x808080))

--所有Demo的基础样式：字体样式(白色)
demo_ThemeFontStyle = lvgl.style_t()
lvgl.style_init(demo_ThemeFontStyle)
lvgl.style_set_text_color(demo_ThemeFontStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0xF5F5F5))

--LED颜色样式1(红色)
demo_LEDStyle_Red = lvgl.style_t()
lvgl.style_init(demo_LEDStyle_Red)
lvgl.style_set_bg_color(demo_LEDStyle_Red, lvgl.STATE_DEFAULT, lvgl.color_hex(0xFF0000))

--LED颜色样式1(黄色)
demo_LEDStyle_Yellow = lvgl.style_t()
lvgl.style_init(demo_LEDStyle_Yellow)
lvgl.style_set_bg_color(demo_LEDStyle_Yellow, lvgl.STATE_DEFAULT, lvgl.color_hex(0xFFFF00))

--LED颜色样式1(绿色)
demo_LEDStyle_Green = lvgl.style_t()
lvgl.style_init(demo_LEDStyle_Green)
lvgl.style_set_bg_color(demo_LEDStyle_Green, lvgl.STATE_DEFAULT, lvgl.color_hex(0x00FF00))

--Line颜色样式1(绿色)
demo_LineStyle_Green = lvgl.style_t()
lvgl.style_init(demo_LineStyle_Green)
lvgl.style_set_line_color(demo_LineStyle_Green, lvgl.STATE_DEFAULT, lvgl.color_hex(0x00FF00))

--Line的样式
demo_LineStyle = lvgl.style_t()
lvgl.style_init(demo_LineStyle)
lvgl.style_set_line_width(demo_LineStyle, lvgl.STATE_DEFAULT, 4)
lvgl.style_set_line_color(demo_LineStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x0000ff))

--LineMeter样式
demo_LineMeterStyle = lvgl.style_t()
lvgl.style_init(demo_LineMeterStyle)
lvgl.style_set_bg_color(demo_LineMeterStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x808080))
lvgl.style_set_line_color(demo_LineMeterStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x00FF00))
lvgl.style_set_scale_grad_color(demo_LineMeterStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x00FF00))
lvgl.style_set_scale_end_color(demo_LineMeterStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0x00FF00))

--Page的样式
demo_PageStyle = lvgl.style_t()
lvgl.style_init(demo_PageStyle)
lvgl.style_set_bg_color(demo_PageStyle, lvgl.STATE_DEFAULT, lvgl.color_hex(0xA0A0A0))
