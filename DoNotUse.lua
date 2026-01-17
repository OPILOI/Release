-- 1. Token Verification (The Handshake)
if not (_G.SESSION_TOKEN or shared.SESSION_TOKEN) then
    game.Players.LocalPlayer:Kick("Tampering (Step 5 Error)")
    return
end

if not _G.SESSION_TOKEN and shared.SESSION_TOKEN then
    _G.SESSION_TOKEN = shared.SESSION_TOKEN
    _G.Processor = shared.Processor
end

-- 2. Sync Token Loop (The Timing Guard)
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

-- 3. Device and Capability Detection
local _R = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
local _TARGET = tostring(_G.BZAGZFIG or ""):lower():gsub("%s+", "")
local UserInputService = game:GetService("UserInputService")
local isMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)
local _OK = false

-- 4. Website Validation Logic
if _R then
    local _VStart = tick()
    while (tick() - _VStart) < 12 do
        local success, r = pcall(function()
            -- Cache buster added to URL to force fresh data
            return _R({
                Url = "https://opiloi.github.io/WEBSITE/?t=" .. math.random(1, 999999), 
                Method = "GET", 
                Timeout = 8
            })
        end)
        
        if success and r and r.Body then
            -- Flexible regex to find value regardless of quotes or spaces
            local foundCode = r.Body:match('value%s*=%s*"%s*(.-)%s*"') or r.Body:match("value%s*=%s*'%s*(.-)%s*'")
            
            if foundCode then
                foundCode = tostring(foundCode):lower():gsub("%s+", "")
                if _TARGET ~= "" and foundCode == _TARGET then 
                    _OK = true 
                    break 
                end
            end
        end
        task.wait(1)
    end
end

-- 5. Final Gateway
if not _OK and isMobile then
    warn("Mobile Safety Bypass Engaged (Validation Timeout)")
    _OK = true
end

if not _OK then
    game.Players.LocalPlayer:Kick("Validation Failed (Check Website Code)")
    return
end

-- 6. Redirection with Flag System
warn("Validated session..")
if isMobile then
    _G.MOBILE_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    _G.PC_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end

-- 7. Delayed Memory Cleanup
task.delay(10, function()
    _G.SESSION_TOKEN = nil
    _G.Processor = nil
    _G.PC_VALIDATED = nil
    _G.MOBILE_VALIDATED = nil
    _G.BZAGZFIG = nil
    shared.SESSION_TOKEN = nil
    shared.Processor = nil
end)
