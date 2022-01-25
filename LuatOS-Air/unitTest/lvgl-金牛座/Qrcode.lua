function QrcodeInit()
    Qrcode = lvgl.qrcode_create(lvgl.scr_act(), nil)
    lvgl.qrcode_set_txt(Qrcode, "luat.com")
    for i = 50,480,20 do
        lvgl.obj_set_size(Qrcode,i,i)
        lvgl.obj_align(Qrcode,Father,lvgl.ALIGN_CENTER,0,0)
        sys.wait(1000)
    end
end