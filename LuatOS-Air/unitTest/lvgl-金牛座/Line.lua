function LineInit()

  line1 = lvgl.line_create(lvgl.scr_act())
  lvgl.line_set_points(line1, {
    {
      x = 5,
      y = 5,
    },
    {
      x = 70,
      y = 70,
    },
    {
      x = 120,
      y = 10,
    },
    {
      x = 180,
      y = 60,
    },
    {
      x = 240,
      y = 10,
    },
  })
  lvgl.obj_add_style(line1, lvgl.LINE_PART_MAIN, demo_LineStyle)
  lvgl.obj_align(line1, nil, lvgl.ALIGN_CENTER, 0, -300)

  Label1 = lvgl.label_create(lvgl.scr_act(),nil)
  lvgl.label_set_text(Label1,"获取自动尺寸属性:"..tostring(lvgl.line_get_auto_size(line1)).."\n获取y反转属性:"..tostring(lvgl.line_get_y_invert(line1)))
  lvgl.obj_align(Label1,nil,lvgl.ALIGN_CENTER,0,-200)
  lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

  line2 = lvgl.line_create(lvgl.scr_act())
  lvgl.line_set_points(line2, {
    {
      x = 5,
      y = 5,
    },
    {
      x = 70,
      y = 70,
    },
    {
      x = 120,
      y = 10,
    },
    {
      x = 180,
      y = 60,
    },
    {
      x = 240,
      y = 10,
    },
  })
  lvgl.obj_add_style(line2, lvgl.LINE_PART_MAIN, demo_LineStyle)
  lvgl.line_set_auto_size(line2,true)
  lvgl.line_set_y_invert(line2,true)
  lvgl.obj_align(line2, nil, lvgl.ALIGN_CENTER, 0, 50)

  Label2 = lvgl.label_create(lvgl.scr_act(),nil)
  lvgl.label_set_text(Label2,"获取自动尺寸属性:"..tostring(lvgl.line_get_auto_size(line2)).."\n获取y反转属性:"..tostring(lvgl.line_get_y_invert(line2)))
  lvgl.obj_align(Label2,nil,lvgl.ALIGN_CENTER,0,150)
  lvgl.obj_add_style(Label2, lvgl.LABEL_PART_MAIN, demo_ThemeStyle_IndicAndFont)

end


