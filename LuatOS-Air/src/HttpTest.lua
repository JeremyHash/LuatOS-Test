-- HttpTest
-- Author:openluat
-- CreateDate:20211011
-- UpdateDate:20211011
module(..., package.seeall)

local serverAddress = "114.55.242.59:2900"
local testCookie = string.rep("1234567890asdfghjklp", 50)

-- multipart/form-data封装函数
local function postTestWithMultipartFormData(url, cert, params, timeout, cbFnc,
                                             rcvFileName)
    local boundary, body, k, v, kk, vv =
        "--------------------------" .. os.time() .. rtos.tick(), {}

    for k, v in pairs(params) do
        if k == "texts" then
            local bodyText = ""
            for kk, vv in pairs(v) do
                bodyText = bodyText .. "--" .. boundary ..
                               "\r\nContent-Disposition: form-data; name=\"" ..
                               kk .. "\"\r\n\r\n" .. vv .. "\r\n"
            end
            body[#body + 1] = bodyText
        elseif k == "files" then
            local contentType = {
                jpg = "image/jpeg",
                jpeg = "image/jpeg",
                png = "image/png",
                txt = "text/plain",
                lua = "text/plain"
            }
            for kk, vv in pairs(v) do
                print(kk, vv)
                body[#body + 1] = "--" .. boundary ..
                                      "\r\nContent-Disposition: form-data; name=\"" ..
                                      kk .. "\"; filename=\"" .. kk ..
                                      "\"\r\nContent-Type: " ..
                                      contentType[vv:match("%.(%w+)$")] ..
                                      "\r\n\r\n"
                body[#body + 1] = {file = vv}
                body[#body + 1] = "\r\n"
            end
        end
    end
    body[#body + 1] = "--" .. boundary .. "--\r\n"

    http.request("POST", url, cert, {
        ["Content-Type"] = "multipart/form-data; boundary=" .. boundary,
        ["Connection"] = "keep-alive"
    }, body, timeout, cbFnc, rcvFileName)
end

-- x-www-form-urlencoded转换函数
local function urlencodeTab(params)
    local msg = {}
    for k, v in pairs(params) do
        table.insert(msg, string.urlEncode(k) .. '=' .. string.urlEncode(v))
        table.insert(msg, '&')
    end
    table.remove(msg)
    return table.concat(msg)
end

local function getTestCb(result, prompt, head, body)
    local tag = "HttpTest.GetTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "getTestSuccess" then
                log.info(tag, "getTestSuccess")
                outPutTestRes("HttpTest.GetTest PASS")
            else
                log.error(tag, "getTestFail")
                outPutTestRes("HttpTest.GetTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.GetTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("getTestFinished")
end

local function getWaitTestCb(result, prompt, head, body)
    local tag = "HttpTest.GetWaitTestCb"
    if result then
        log.error(tag, "getWaitTestFail")
        outPutTestRes("HttpTest.GetWaitTest FAIL")
    else
        log.error(tag .. ".result", result)
        log.error(tag .. ".prompt", prompt)
        if prompt == "receive timeout" then
            log.info(tag, "getWaitTestSuccess")
            outPutTestRes("HttpTest.GetWaitTest PASS")
        else
            log.info(tag, "getWaitTestFail")
            outPutTestRes("HttpTest.GetWaitTest FAIL")
        end
    end
    sys.publish("getWaitTestFinished")
end

local function get301TestCb(result, prompt, head, body)
    local tag = "HttpTest.get301TestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            outPutTestRes("HttpTest.get301Test PASS")
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
            outPutTestRes("HttpTest.get301Test FAIL")
        end
    else
        outPutTestRes("HttpTest.get301Test FAIL")
        log.error(tag .. ".result", "FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("get301TestFinished")
end

local function get302TestCb(result, prompt, head, body)
    local tag = "HttpTest.get302TestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            outPutTestRes("HttpTest.get302Test PASS")
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
            outPutTestRes("HttpTest.get302Test FAIL")
        end
    else
        outPutTestRes("HttpTest.get302Test FAIL")
        log.error(tag .. ".result", "FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("get302TestFinished")
end

local function getWithCATestCb(result, prompt, head, body)
    local tag = "HttpTest.getWithCATestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            outPutTestRes("HttpTest.getWithCATest PASS")
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
            outPutTestRes("HttpTest.getWithCATest FAIL")
        end
    else
        outPutTestRes("HttpTest.getWithCATest FAIL")
        log.error(tag .. ".result", "FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("getWithCATestFinished")
end

local function getWithCAAndKeyTestCb(result, prompt, head, body)
    local tag = "HttpTest.getWithCAAndKeyTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            outPutTestRes("HttpTest.getWithCAAndKeyTest PASS")
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
            outPutTestRes("HttpTest.getWithCAAndKeyTest FAIL")
        end
    else
        outPutTestRes("HttpTest.getWithCAAndKeyTest FAIL")
        log.error(tag .. ".result", "FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("getWithCAAndKeyTestFinished")
end

local function getAndSaveToBigFileTestCb(result, prompt, head, filePath)
    local tag = "HttpTest.getAndSaveToBigFileTestCb"
    local MD5Header, fileSize
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
                if k == "MD5" then MD5Header = v end
                if k == "Content-Length" then fileSize = v end
            end
        end
        if filePath then
            log.info(tag .. ".filePath", filePath)
            local size = io.fileSize(filePath)
            log.info(tag .. ".fileSize", size)

            if size <= 4096 then
                log.info(tag .. ".fileContent", io.readFile(filePath))
            else
                log.info(tag .. ".fileContent", filePath .. "文件过大")
            end

            if size == tonumber(fileSize) then
                log.info(tag .. ".fileSize", "fileSize验证SUCCESS")
                local calMD5 = crypto.md5(filePath, "file")
                log.info(tag .. ".CalMD5", calMD5)

                if MD5Header == calMD5 then
                    log.info(tag .. ".CalMD5", "MD5校验SUCCESS")
                    outPutTestRes("HttpTest.getAndSaveToBigFileTest PASS")
                else
                    log.error(tag .. ".CalMD5", "MD5校验FAIL")
                    outPutTestRes("HttpTest.getAndSaveToBigFileTest FAIL")
                end
            else
                log.error(tag .. ".fileSize", "fileSize验证FAIL")
                outPutTestRes("HttpTest.getAndSaveToBigFileTest FAIL")
            end

            log.info(tag .. "保存大文件后可用空间 " ..
                         rtos.get_fs_free_size() .. "Bytes")
            -- os.remove(filePath)
            local remove_dir_res = rtos.remove_dir("/Jeremy")
            if remove_dir_res then
                log.info(tag .. ".fileDelete", filePath .. "删除SUCCESS")
                log.info(tag .. "删除大文件SUCCESS后可用空间 " ..
                             rtos.get_fs_free_size() .. "Bytes")
            else
                log.error(tag .. ".fileDelete", filePath .. "删除FAIL")
                log.info(tag .. "删除大文件FAIL后可用空间 " ..
                             rtos.get_fs_free_size() .. "Bytes")
            end
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.getAndSaveToBigFileTest FAIL")
    end
    sys.publish("getAndSaveToBigFileTestFinished")
end

local function getAndSaveToSmallFileTestCb(result, prompt, head, filePath)
    local tag = "HttpTest.getAndSaveToSmallFileTestCb"
    local MD5Header, fileSize
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
                if k == "MD5" then MD5Header = v end
                if k == "Content-Length" then fileSize = v end
            end
        end
        if filePath then
            log.info(tag .. ".filePath", filePath)
            local size = io.fileSize(filePath)
            log.info(tag .. ".fileSize", size)

            if size <= 4096 then
                log.info(tag .. ".fileContent", io.readFile(filePath))
            else
                log.info(tag .. ".fileContent", filePath .. "文件过大")
            end

            if size == tonumber(fileSize) then
                log.info(tag .. ".fileSize", "fileSize验证SUCCESS")
                local calMD5 = crypto.md5(filePath, "file")
                log.info(tag .. ".CalMD5", calMD5)

                if MD5Header == calMD5 then
                    log.info(tag .. ".CalMD5", "MD5校验SUCCESS")
                    outPutTestRes("HttpTest.getAndSaveToSmallFileTest PASS")
                else
                    log.error(tag .. ".CalMD5", "MD5校验FAIL")
                    outPutTestRes("HttpTest.getAndSaveToSmallFileTest FAIL")
                end
            else
                log.error(tag .. ".fileSize", "fileSize验证FAIL")
                outPutTestRes("HttpTest.getAndSaveToSmallFileTest FAIL")
            end

            log.info(tag .. "保存小文件后可用空间 " ..
                         rtos.get_fs_free_size() .. "Bytes")
            -- os.remove(filePath)
            local remove_dir_res = rtos.remove_dir("/Jeremy")
            if remove_dir_res then
                log.info(tag .. ".fileDelete", filePath .. "删除SUCCESS")
                log.info(tag .. "删除小文件SUCCESS后可用空间 " ..
                             rtos.get_fs_free_size() .. "Bytes")
            else
                log.error(tag .. ".fileDelete", filePath .. "删除FAIL")
                log.info(tag .. "删除小文件FAIL后可用空间 " ..
                             rtos.get_fs_free_size() .. "Bytes")
            end
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.getAndSaveToSmallFileTest FAIL")
    end
    sys.publish("getAndSaveToSmallFileTestFinished")
end

local function postTestCb(result, prompt, head, body)
    local tag = "HttpTest.postTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "postTestSuccess" then
                log.info(tag, "postTestSuccess")
                outPutTestRes("HttpTest.postTest PASS")
            else
                log.error(tag, "postTestFail")
                outPutTestRes("HttpTest.postTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postTestFinished")
end

local function postJsonTestCb(result, prompt, head, body)
    local tag = "HttpTest.postJsonTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "postJsonTestSuccess" then
                log.info(tag, "postTestSuccess")
                outPutTestRes("HttpTest.postJsonTest PASS")
            else
                log.error(tag, "postTestFail")
                outPutTestRes("HttpTest.postJsonTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postJsonTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postJsonTestFinished")
end

local function postWithUserHeadTestCb(result, prompt, head, body)
    local tag = "HttpTest.postWithUserHeadTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "PostTestWithUserHeadPass" then
                log.info(tag, "postWithUserHeadTestSuccess")
                outPutTestRes("HttpTest.postWithUserHeadTest PASS")
            else
                log.error(tag, "postWithUserHeadTestFail")
                outPutTestRes("HttpTest.postWithUserHeadTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postWithUserHeadTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postWithUserHeadTestFinished")
end

local function postWithOctetStreamTestCb(result, prompt, head, body)
    local tag = "HttpTest.postWithOctetStreamTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "PostTestWithOctetStreamSuccess" then
                log.info(tag, "postTestWithOctetStreamTestSuccess")
                outPutTestRes("HttpTest.postWithOctetStreamTest PASS")
            else
                log.error(tag, "postTestWithOctetStreamTestFail")
                outPutTestRes("HttpTest.postWithOctetStreamTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postWithOctetStreamTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postWithOctetStreamTestFinished")
end

local function postWithMultipartFormDataTestCb(result, prompt, head, body)
    local tag = "HttpTest.postWithMultipartFormDataTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "postTestWithMultipartFormDataSuccess" then
                log.info(tag, "postTestWithMultipartFormDataSuccess")
                outPutTestRes("HttpTest.postWithMultipartFormDataTest PASS")
            else
                log.error(tag, "postTestWithMultipartFormDataFail")
                outPutTestRes("HttpTest.postWithMultipartFormDataTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postWithMultipartFormDataTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postWithMultipartFormDataTestFinished")
end

local function postWithXwwwformurlencodedTestCb(result, prompt, head, body)
    local tag = "HttpTest.postWithXwwwformurlencodedTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "postTestWithXwwwformurlencodedSuccess" then
                log.info(tag, "postTestWithXwwwformurlencodedSuccess")
                outPutTestRes("HttpTest.postWithXwwwformurlencodedTest PASS")
            else
                log.error(tag, "postTestWithXwwwformurlencodedFail")
                outPutTestRes("HttpTest.postWithXwwwformurlencodedTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.postWithXwwwformurlencodedTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("postWithXwwwformurlencodedTestFinished")
end

local function headTestCb(result, prompt, head, body)
    local tag = "HttpTest.headTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
            outPutTestRes("HttpTest.headTest PASS")
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
            outPutTestRes("HttpTest.headTest FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.headTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("headTestFinished")
end

local function putTestCb(result, prompt, head, body)
    local tag = "HttpTest.putTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "putTestSuccess" then
                log.info(tag, "putTestSuccess")
                outPutTestRes("HttpTest.putTest PASS")
            else
                log.error(tag, "putTestFail")
                outPutTestRes("HttpTest.putTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.putTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("putTestFinished")
end

local function deleteTestCb(result, prompt, head, body)
    local tag = "HttpTest.deleteTestCb"
    if result then
        log.info(tag .. ".result", "SUCCESS")
        log.info(tag .. ".prompt", "Http状态码:", prompt)
        if head then
            log.info(tag .. ".Head", "遍历响应头")
            for k, v in pairs(head) do
                log.info(tag .. ".Head", k .. " : " .. v)
            end
        else
            log.error(tag .. ".Head", "读取响应头FAIL")
        end

        if body then
            log.info(tag .. ".Body", body)
            log.info(tag .. ".BodyLen", body:len())
            if body == "deleteTestSuccess" then
                log.info(tag, "deleteTestSuccess")
                outPutTestRes("HttpTest.deleteTest PASS")
            else
                log.error(tag, "deleteTestFail")
                outPutTestRes("HttpTest.deleteTest FAIL")
            end
        else
            log.error(tag .. ".Body", "读取响应体FAIL")
        end
    else
        log.error(tag .. ".result", "FAIL")
        outPutTestRes("HttpTest.deleteTest FAIL")
        log.error(tag .. ".prompt", prompt)
    end
    sys.publish("deleteTestFinished")
end

local function httpTestTask()
    http.request("GET",
                 serverAddress .. "/?test1=1&test2=22&test3=333&test4=" ..
                     string.urlEncode("四四四四") ..
                     "&test5=FiveFiveFiveFiveFive&test6=" ..
                     string.rawurlEncode("ろくろくろくろくろくろく"),
                 nil, nil, nil, nil, getTestCb)
    sys.waitUntil("getTestFinished")

    http.request("GET", serverAddress .. "/waitTest", nil, nil, nil, 10000,
                 getWaitTestCb)
    sys.waitUntil("getWaitTestFinished")

    http.request("GET", serverAddress .. "/redirect301", nil, nil, nil, nil,
                 get301TestCb)
    sys.waitUntil("get301TestFinished")

    http.request("GET", serverAddress .. "/redirect302", nil, nil, nil, nil,
                 get302TestCb)
    sys.waitUntil("get302TestFinished")

    http.request("GET", "https://www.baidu.com", {caCert = "ca.cer"}, nil, nil,
                 nil, getWithCATestCb)
    sys.waitUntil("getWithCATestFinished")

    -- http.request("GET", "https://36.7.136.116:4434", {
    --     caCert = "ca.crt",
    --     clientCert = "client.crt",
    --     clientKey = "client.key"
    -- }, nil, nil, nil, getWithCAAndKeyTestCb)
    -- sys.waitUntil("getWithCAAndKeyTestFinished")

    log.info("创建文件前可用空间 " .. rtos.get_fs_free_size() ..
                 " Bytes")
    if rtos.make_dir("/Jeremy") then
        log.info("HttpTest.GetTestAndSaveToBigFile.makeDir", "SUCCESS")
    else
        log.error("HttpTest.GetTestAndSaveToBigFile.makeDir", "FAIL")
    end
    http.request("GET", serverAddress .. "/download/600K", nil, nil, nil, nil,
                 getAndSaveToBigFileTestCb, "/Jeremy/600K")
    sys.waitUntil("getAndSaveToBigFileTestFinished")

    log.info("创建文件前可用空间 " .. rtos.get_fs_free_size() ..
                 " Bytes")
    if rtos.make_dir("/Jeremy") then
        log.info("HttpTest.GetTestAndSaveToSmallFile.makeDir", "SUCCESS")
    else
        log.error("HttpTest.GetTestAndSaveToSmallFile.makeDir", "FAIL")
    end
    http.request("GET", serverAddress .. "/download/2K", nil, nil, nil, nil,
                 getAndSaveToSmallFileTestCb, "/Jeremy/2K")
    sys.waitUntil("getAndSaveToSmallFileTestFinished")

    http.request("POST", serverAddress .. "/", nil, nil, "PostTest", nil,
                 postTestCb)
    sys.waitUntil("postTestFinished")

    local testJson = {
        ["imei"] = "123456789012345",
        ["mcc"] = "460",
        ["mnc"] = "0",
        ["lac"] = "21133",
        ["ci"] = "52365",
        ["hex"] = "10"
    }
    http.request("POST", serverAddress .. "/postJsonTest", nil,
                 {["Content-Type"] = "application/json"}, json.encode(testJson),
                 nil, postJsonTestCb)
    sys.waitUntil("postJsonTestFinished")

    http.request("POST", serverAddress .. "/withUserHead", nil, {
        ["Connection"] = "close",
        ["UserHead"] = "PostTestWithUserHead",
        ["Cookie"] = testCookie,
        ["User-Agent"] = "AirM2M",
        ["Authorization"] = "Basic " ..
            crypto.base64_encode("123:456", ("123:456"):len())
    }, nil, nil, postWithUserHeadTestCb)
    sys.waitUntil("postWithUserHeadTestFinished")

    http.request("POST", serverAddress .. "/withOctetStream", nil, {
        ["Content-Type"] = "application/octet-stream",
        ["Connection"] = "keep-alive",
        ["MD5"] = crypto.md5("/lua/logo_color.png", "file")
    }, {[1] = {["file"] = "/lua/logo_color.png"}}, nil,
                 postWithOctetStreamTestCb)
    sys.waitUntil("postWithOctetStreamTestFinished")

    postTestWithMultipartFormData(serverAddress .. "/uploadFile", nil, {
        texts = {
            ["imei"] = "862991234567890",
            ["time"] = "20180802180345",
            ["md5"] = crypto.md5("/lua/logo_color.png", "file")
        },

        files = {["FormDataUploadFile"] = "/lua/logo_color.png"}
    }, nil, postWithMultipartFormDataTestCb)
    sys.waitUntil("postWithMultipartFormDataTestFinished")

    http.request("POST", serverAddress .. "/withxwwwformurlencoded", nil,
                 {["Content-Type"] = "application/x-www-form-urlencoded"},
                 urlencodeTab({
        content = "x-www-form-urlencoded Test",
        author = "LuatTest",
        email = "yanjunjie@airm2m.com",
        userName = "yanjunjie",
        passwd = "1234567890!@#$%^&*()"
    }), nil, postWithXwwwformurlencodedTestCb)
    sys.waitUntil("postWithXwwwformurlencodedTestFinished")

    http.request("HEAD", serverAddress, nil, nil, nil, nil, headTestCb)
    sys.waitUntil("headTestFinished")

    http.request("PUT", serverAddress, nil, nil, "putTest", nil, putTestCb)
    sys.waitUntil("putTestFinished")

    http.request("DELETE", serverAddress, nil, nil, "deleteTest", nil,
                 deleteTestCb)
    sys.waitUntil("deleteTestFinished")

end

sys.taskInit(function()
    local tag = "HttpTest"
    sys.waitUntil("IP_READY_IND")
    log.info(tag, "成功访问网络, Http测试开始")
    if testConfig.testMode == "single" then
        httpTestTask()
    elseif testConfig.testMode == "loop" then
        while true do httpTestTask() end
    end
end)
