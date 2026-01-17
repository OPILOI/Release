print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end


local request=request or http_request or syn.request
local ok=false
if request and BZAGZFIG then
    local r=request({Url="https://opiloi.github.io/WEBSITE/",Method="GET"})
    if r and r.Body then
        local code=r.Body:match('id="codebox"%s+value="(.-)"')
        if code and code==BZAGZFIG then
            ok=true
        end
    end
end
if not ok then
    game:GetService("Players").LocalPlayer:Kick()
end

print("up")
