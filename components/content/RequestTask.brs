function init()
    m.top.functionName = "GetContent"
end function

function GetContent()
    http = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")

    http.EnablePeerVerification(false)
    http.EnableHostVerification(false)
    
    http.AddHeader("Content-Type", "application/json")
    http.AddHeader("Authorization", "Bearer " + m.global.access_token)

    http.SetUrl(m.top.url)
    http.SetPort(port)
    http.RetainBodyOnError(true)

    started = false

    if m.top.type = "get"
        started = http.AsyncGetToString()
    else
        body = http.Unescape(m.top.other.query)
        started = http.AsyncPostFromString(body)
    end if

    if started
        while true
            msg = wait(0, port)
            if msg <> invalid and type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                dataString = msg.GetString()
                if code = 200
                    m.top.data = dataString
                    m.top.status = "Success"
                else
                    m.top.data = dataString
                    m.top.status = "Failed"
                    print "Failed response: " + m.top.data + " : " + code.toStr()
                end if
                exit while ' Exit after processing the response
            end if
        end while
    else
        m.top.status = "Failed"
        print "Request failed to start"
    end if
end function

