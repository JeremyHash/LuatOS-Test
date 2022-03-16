local audioTest = {}

local tag = "audioTest"

function audioTest.test()
    if audio == nil then
        log.error(tag, "this fireware is not support audio")
        return
    end
    log.info(tag, "START")
    audio.on(0, function(id, event_id)
        if event_id == audio.MORE_DATA then
            sys.publish("moredata")
        else
            sys.publish("playover")
        end
    end)

    sys.taskInit(function()
        while true do
            local buff = zbuff.create(1024)
            local in_buff = zbuff.create(8 * 1024)
            if buff == nil or in_buff == nil then
                log.info("BUFF", "nil")
                return
            end
            f = io.open("/luadb/sms.mp3", "rb")
            if f then
                log.debug("find mp3")
                data = f:read(4096)
                decoder = decode.create(decode.MP3)
                local result, AudioFormat, NumChannels, SampleRate, BitsPerSample, is_signed = decode.get_audio_info(
                    decoder, data)
                buff:resize(SampleRate)
                in_buff:copy(nil, data)
                result = decode.get_audio_data(decoder, in_buff, buff)
                log.debug("start", audio.start(0, AudioFormat, NumChannels, SampleRate, BitsPerSample, is_signed))
                audio.write(0, buff)
                in_buff:copy(nil, f:read(4096))
                result = decode.get_audio_data(decoder, in_buff, buff)
                audio.write(0, buff)
                data = f:read(4096)
                while data and #data > 0 do
                    sys.waitUntil("moredata", 2000)
                    in_buff:copy(nil, data)
                    result = decode.get_audio_data(decoder, in_buff, buff)
                    audio.write(0, buff)
                    data = f:read(4096)
                end
                sys.waitUntil("playover", 2000)
                decode.release(decoder)
                f:close()
                audio.stop(0)
            end
            data = nil
            sys.wait(2000)
            f = io.open("/luadb/call.wav", "rb")
            if f then
                log.debug("find wav")
                buff:seek(0, zbuff.SEEK_SET)
                buff:copy(0, f:read(12))
                if buff:query(0, 4) == 'RIFF' and buff:query(8, 4) == 'WAVE' then
                    local total = buff:query(4, 4, false)
                    buff:copy(0, f:read(8))
                    if buff:query(0, 4) == 'fmt ' then
                        buff:copy(0, f:read(16))
                        buff:seek(0, zbuff.SEEK_SET)
                        local _, AudioFormat, NumChannels, SampleRate, ByteRate, BlockAlign, BitsPerSample =
                            buff:unpack("<HHIIHH")
                        log.debug("find fmt info", AudioFormat, NumChannels, SampleRate, ByteRate, BlockAlign,
                            BitsPerSample)
                        buff:copy(0, f:read(8))
                        if buff:query(0, 4) ~= 'data' then
                            buff:copy(0, buff:query(4, 4, false))
                            buff:copy(0, f:read(8))
                        end
                        log.debug("start", audio.start(0, AudioFormat, NumChannels, SampleRate, BitsPerSample))
                        ByteRate = ByteRate >> 1
                        data = f:read(ByteRate)
                        audio.write(0, data)
                        data = f:read(ByteRate)
                        audio.write(0, data)
                        data = f:read(ByteRate)
                        while data and #data > 0 do
                            sys.waitUntil("moredata", 2000)
                            audio.write(0, data)
                            data = f:read(ByteRate)
                        end
                        sys.waitUntil("playover", 2000)
                        audio.stop(0)
                    end
                else
                    log.debug(buff:query(0, 4), buff:query(8, 4))
                end
                f:close()
            end
        end
    end)
    log.info(tag, "DONE")
end

return audioTest
