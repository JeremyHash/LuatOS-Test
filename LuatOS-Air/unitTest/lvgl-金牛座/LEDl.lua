function LEDInit()
     LED1 = lvgl.led_create(lvgl.scr_act(),nil)
	lvgl.obj_set_size(LED1,150,150)
	lvgl.obj_align(LED1,Father,lvgl.ALIGN_CENTER,0,-300)
     lvgl.led_on(LED1)
     lvgl.led_set_bright(LED1,50)

     LED2 = lvgl.led_create(lvgl.scr_act(),nil)
	lvgl.obj_set_size(LED2,150,150)
	lvgl.obj_align(LED2,Father,lvgl.ALIGN_CENTER,0,0)
     lvgl.led_on(LED2)
     lvgl.led_set_bright(LED2,255)

     LED3 = lvgl.led_create(lvgl.scr_act(),nil)
	lvgl.obj_set_size(LED3,150,150)
	lvgl.obj_align(LED3,Father,lvgl.ALIGN_CENTER,0,300)
     lvgl.led_on(LED3)
     lvgl.led_toggle(LED3)
end