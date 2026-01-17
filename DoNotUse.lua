if not (_G.SESSION_TOKEN or shared.SESSION_TOKEN) then
    game.Players.LocalPlayer:Kick("Tampering (Step 5 Error)")
    return
end

if not _G.SESSION_TOKEN and shared.SESSION_TOKEN then
    _G.SESSION_TOKEN = shared.SESSION_TOKEN
    _G.Processor = shared.Processor
end

local _TOKEN = nil
local _Start = tick()
while (tick() - _Start) < 10 do
    local currentToken = _G.SYNX_TOKEN or shared.SYNX_TOKEN
    if currentToken then
        _TOKEN = currentToken
        _G.SYNX_TOKEN = nil
        shared.SYNX_TOKEN = nil
        break
    end
    task.wait(0.2)
end

if not _TOKEN then
    game.Players.LocalPlayer:Kick("Tampering (Sync Failed)")
    return
end

local _R = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
local _TARGET = nil
pcall(function() _TARGET = BZAGZFIG end)

local _OK = false
-- If the executor doesn't support requests, we only let them pass if they are on Mobile
if not _R then
    if game:GetService("UserInputService").TouchEnabled then
        _OK = true 
    end
else
    local _VStart = tick()
    while (tick() - _VStart) < 10 do
        local success, r = pcall(function()
            return _R({Url = "https://opiloi.github.io/WEBSITE/?t="..tick(), Method = "GET", Timeout = 5})
        end)
        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if _TARGET and code == _TARGET then 
                _OK = true 
                break 
            elseif not _TARGET then
                -- If BZAGZFIG is missing, we fail for safety
                _OK = false
                break
            end
        end
        task.wait(1)
    end
end

if not _OK then
    game.Players.LocalPlayer:Kick("Validation Failed")
    return
end

warn("Validated session..")

local UserInputService = game:GetService("UserInputService")
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end

task.delay(5, function()
    _G.SESSION_TOKEN = nil
    _G.Processor = nil
    shared.SESSION_TOKEN = nil
    shared.Processor = nil
end)
