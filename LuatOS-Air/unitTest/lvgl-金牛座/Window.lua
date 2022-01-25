function WindowInit()
    Window = lvgl.win_create(lvgl.scr_act(), nil)
    lvgl.obj_align(Window, Fahter, lvgl.ALIGN_IN_TOP_MID, 0, -200)
    lvgl.obj_add_style(Window, lvgl.TABVIEW_PART_BG, demo_ThemeStyle_Bg)
    lvgl.win_set_title(Window, "中单点玩亚索")
    close_btn = lvgl.win_add_btn(Window, lvgl.SYMBOL_CLOSE)
    lvgl.obj_set_event_cb(close_btn, lvgl.win_close_event_cb)
    lvgl.win_add_btn(Window, lvgl.SYMBOL_SETTINGS)
    lvgl.win_add_btn(Window, lvgl.SYMBOL_EDIT)
    lvgl.win_add_btn_right(Window, lvgl.SYMBOL_HOME)
    lvgl.win_add_btn_left(Window, lvgl.SYMBOL_DOWNLOAD)
    lvgl.win_set_header_height(Window, 60)
    lvgl.win_set_btn_width(Window, 60)
    lvgl.win_set_content_size(Window, 400, 400)
    lvgl.obj_align(Window, Father, lvgl.ALIGN_CENTER, 0, 0)
    label = lvgl.label_create(Window, nil)
    lvgl.label_set_text(label,
                        "属于我俩安逸世界\n不用和别人连线\n我不管你来自深渊\n也不在乎身上鳞片\n爱情能超越一切\n只要你在我身边\n所有蜚语流言完全视而不见\n请不要匆匆一面\n一转身就沉入海平线传说中\n你为爱甘心被搁浅\n我也可以为你潜入海里面\n怎么忍心断绝\n\n忘记我不变的誓言\n我眼泪断了线\n现实里有了我对你的眷恋\n我愿意化作雕像等你出现\n再见 再也不见\n心碎了飘荡在海边\n你抬头就看见\n我在沙滩划个圆圈\n属于我俩安逸世界\n不用和别人连线\n Woo我不管你来自深渊\n也不在乎身上鳞片\n爱情能超越一切 \n只要你在我身边\n所有蜚语流言完全视而不见\n请不要匆匆一面\n一转身就沉入海平线\n传说中 你为爱甘心被搁浅\n我也可以为你潜入海里面\n怎么忍心断绝\n忘记我不变的誓言\n我眼泪断了线 \n现实里有了我对你的眷恋\n我愿意化作雕像 等你出现\n再见 再也不见\n心碎了飘荡在海边\n你抬头就看见\n传说中 你为爱甘心被搁浅\n我也可以为你潜入海里面\n怎么忍心断绝\n忘记我不变的誓言\n我眼泪断了线 \n现实里有了我对你的眷恋\n我愿意化作雕像 等你出现\n再见 再也不见\n心碎了飘荡在海边\n你抬头就看见你\n")
    lvgl.win_set_layout(Window, lvgl.LAYOUT_COLUMN_RIGHT)
    lvgl.win_set_scrollbar_mode(Window, lvgl.SCROLLBAR_MODE_DRAG)
    --  lvgl.win_set_anim_time(Window,5000)
    lvgl.win_set_drag(Window, true)

    Label1 = lvgl.label_create(lvgl.scr_act(), nil)
    lvgl.label_set_text(Label1,
                        "获取窗口的标题 : " .. lvgl.win_get_title(Window) ..
                            "\n获取页眉高度: " ..
                            lvgl.win_get_header_height(Window) ..
                            "\n获取表头控制按钮的宽度: " ..
                            lvgl.win_get_btn_width(Window) ..
                            "\n从一个控制按钮获取指针: " ..
                            tostring(lvgl.win_get_from_btn(Window)) ..
                            "\n获取窗口的布局: " ..
                            lvgl.win_get_layout(Window) ..
                            "\n获取窗口的滚动条模式: " ..
                            lvgl.win_get_sb_mode(Window) ..
                            "\n获取焦点动画持续时间: " ..
                            lvgl.win_get_anim_time(Window) ..
                            "\n获取窗口内容区域（页面可滚动）的宽度: " ..
                            lvgl.win_get_width(Window) ..
                            "\n获取窗口的拖动状态: " ..
                            tostring(lvgl.win_get_drag(Window)) ..
                            "\n获取窗口标题中标题文本的当前对齐方式: " ..
                            lvgl.win_title_get_alignment(Window))
    lvgl.obj_align(Label1, nil, lvgl.ALIGN_IN_TOP_MID, 0, 420)
    lvgl.obj_add_style(Label1, lvgl.LABEL_PART_MAIN,
                       demo_ThemeStyle_IndicAndFont)

end
