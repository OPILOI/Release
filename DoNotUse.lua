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
local _TARGET = tostring(_G.BZAGZFIG or ""):lower()

local _OK = false
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

if not _R and isMobile then
    -- Fallback for weak mobile executors that can't do web requests
    _OK = true 
elseif _R then
    local _VStart = tick()
    while (tick() - _VStart) < 8 do
        local success, r = pcall(function()
            return _R({Url = "https://opiloi.github.io/WEBSITE/?t="..tick(), Method = "GET", Timeout = 5})
        end)
        
        if success and r and r.Body then
            -- Clean the body text to make finding the code easier
            local cleanBody = tostring(r.Body):lower()
            local foundCode = cleanBody:match('id="codebox"%s+value="(.-)"')
            
            if _TARGET ~= "" and foundCode == _TARGET then 
                _OK = true 
                break 
            end
        end
        task.wait(1.5)
    end
end

-- Final check: If it's mobile and the website is just being slow, let them in
if not _OK and isMobile then
    warn("Mobile bypass triggered due to slow validation")
    _OK = true
end

if not _OK then
    game.Players.LocalPlayer:Kick("Validation Failed")
    return
end

warn("Validated session..")

if isMobile then
    _G.MOBILE_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    _G.PC_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end

task.delay(5, function()
    _G.SESSION_TOKEN = nil
    _G.Processor = nil
    _G.PC_VALIDATED = nil
    _G.MOBILE_VALIDATED = nil
    shared.SESSION_TOKEN = nil
    shared.Processor = nil
end)
