if not (_G.SESSION_TOKEN and _G.Processor) or 
   type(_G.SESSION_TOKEN) ~= "number" or 
   type(_G.Processor) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

_G.SESSION_TOKEN_A = _G.SESSION_TOKEN + 152
_G.Processor = (_G.Processor * 2) + 7

local _TOKEN = nil
local _Start = tick()

while (tick() - _Start) < 10 do
    if _G.SYNX_TOKEN then
        _TOKEN = _G.SYNX_TOKEN
        _G.SYNX_TOKEN = nil
        break
    end
    task.wait(0.2)
end

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

local _R = request or http_request or (syn and syn.request)
local _TARGET = nil
pcall(function() _TARGET = BZAGZFIG end)

local _OK = false
local _VStart = tick()

if _R and _TARGET then
    while (tick() - _VStart) < 10 do
        local success, r = pcall(function()
            return _R({Url = "https://opiloi.github.io/WEBSITE/?t="..tick(), Method = "GET", Timeout = 5})
        end)
        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if code == _TARGET then _OK = true break end
        end
        task.wait(1)
    end
end

if not _OK then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

warn("Validated session..")


local UserInputService = game:GetService("UserInputService")

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end
