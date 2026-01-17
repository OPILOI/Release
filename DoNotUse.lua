print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end


-- Use a different name for the local request to avoid conflicts
local _R = request or http_request or (syn and syn.request)
local _VAL = _G.BZAGZFIG
local _OK = false

if _R and _VAL then
    local r = _R({Url = "https://opiloi.github.io/WEBSITE/", Method = "GET"})
    if r and r.Body then
        local code = r.Body:match('id="codebox"%s+value="(.-)"')
        if code and code == _VAL then
            _OK = true
        end
    end
end

if not _OK then
    game:GetService("Players").LocalPlayer:Kick("Security Validation Failed")
    return
end

print("1")
