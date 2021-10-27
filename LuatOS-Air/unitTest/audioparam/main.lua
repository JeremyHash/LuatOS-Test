PROJECT = "audioparamTest"
VERSION = "1.0.0"

require "sys"
require"utils"
require "log"
LOG_LEVEL = log.LOGLEVEL_INFO

local tag = "AudioParamTest"

sys.taskInit(function()
    while true do
        sys.wait(5000)
        local USERNVM_DIR = "/usernvm"
        local USERNVM_AUDIOCALIB_FILE_PATH = USERNVM_DIR ..
                                                 "/user_audio_calib.bin"
        local USERNVM_AUDIOCALIB_SET_FILE_PATH = USERNVM_DIR ..
                                                     "/user_audio_calib_flag.bin"

        if rtos.make_dir(USERNVM_DIR) then
            if io.exists(USERNVM_AUDIOCALIB_SET_FILE_PATH) then
                if io.exists(USERNVM_AUDIOCALIB_FILE_PATH) then
                    log.error(tag,
                              "audioParam USERNVM_AUDIOCALIB_FILE_PATH FAIL")
                else
                    log.info(tag, "SUCCESS")
                end
            else
                os.remove(USERNVM_AUDIOCALIB_FILE_PATH)
                local userAudioParam = io.readFile("/lua/audio_calib.bin")
                io.writeFile(USERNVM_AUDIOCALIB_FILE_PATH,
                             pack.pack("<i", userAudioParam:len()))
                io.writeFile(USERNVM_AUDIOCALIB_FILE_PATH, userAudioParam, "ab")
                io.writeFile(USERNVM_AUDIOCALIB_SET_FILE_PATH, "1")

                log.info(tag, "audioParam write completed, prepar to restart")
                sys.restart(tag)
            end
        else
            log.error(tag, ".make_dir", "FAIL")
        end
    end
end)

sys.init(0, 0)
sys.run()
