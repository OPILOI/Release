if not (_G.SESSION_TOKEN and _G.Processor) or type(_G.SESSION_TOKEN) ~= "number" or type(_G.Processor) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

local _R = request or http_request or (syn and syn.request)
local _TARGET = nil
pcall(function() _TARGET = BZAGZFIG end)

local _OK = false
if _R and _TARGET then
    local success, r = pcall(function()
        return _R({Url = "https://opiloi.github.io/WEBSITE/?t="..tick(), Method = "GET", Timeout = 5})
    end)
    if success and r and r.Body then
        local code = r.Body:match('id="codebox"%s+value="(.-)"')
        if code == _TARGET then _OK = true end
    end
end

if not _OK then
    game.Players.LocalPlayer:Kick("Validation Failed")
    return
end

_G.SESSION_TOKEN = nil
_G.Processor = nil
shared.SESSION_TOKEN = nil
shared.Processor = nil

local UIS = game:GetService("UserInputService")
if UIS.TouchEnabled and not UIS.KeyboardEnabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end
