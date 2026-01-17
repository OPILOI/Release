-- 1. Immediate Token Recovery
local session = _G.SESSION_TOKEN or shared.SESSION_TOKEN
local processor = _G.Processor or shared.Processor

if not (session and processor) then
    game.Players.LocalPlayer:Kick("Initialization Error")
    return
end

-- 2. Fast Sync Check (Reduced from 10s to 2s)
local _TOKEN = _G.SYNX_TOKEN or shared.SYNX_TOKEN
if not _TOKEN then
    local start = tick()
    while tick() - start < 2 do 
        _TOKEN = _G.SYNX_TOKEN or shared.SYNX_TOKEN
        if _TOKEN then break end
        task.wait(0.1)
    end
end

-- 3. Capability Setup
local _R = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
local _TARGET = tostring(_G.BZAGZFIG or ""):lower():gsub("%s+", "")
local UIS = game:GetService("UserInputService")
local isMobile = (UIS.TouchEnabled and not UIS.KeyboardEnabled)

-- 4. Fast Validation Logic
local _OK = false

if isMobile or not _R then
    -- Mobile and weak executors get an instant pass to prevent "Stuck" screen
    _OK = true 
else
    -- PC/High-end executors get one fast attempt (3s timeout)
    local success, r = pcall(function()
        return _R({
            Url = "https://opiloi.github.io/WEBSITE/?t=" .. math.random(1, 999), 
            Method = "GET", 
            Timeout = 3
        })
    end)
    
    if success and r and r.Body then
        local found = r.Body:match('value%s*=%s*"%s*(.-)%s*"') or r.Body:match("value%s*=%s*'%s*(.-)%s*'")
        if found and tostring(found):lower():gsub("%s+", "") == _TARGET then
            _OK = true
        end
    else
        -- If website fails to load on PC, we still allow entry if BZAGZFIG was set
        if _G.BZAGZFIG then _OK = true end 
    end
end

-- 5. Final Gateway (No more long waiting)
if not _OK then
    game.Players.LocalPlayer:Kick("Validation Timeout")
    return
end

-- 6. Direct Load
if isMobile then
    _G.MOBILE_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    _G.PC_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end

-- 7. Cleanup
task.delay(3, function()
    _G.SESSION_TOKEN = nil
    _G.Processor = nil
    _G.SYNX_TOKEN = nil
    _G.BZAGZFIG = nil
    shared.SESSION_TOKEN = nil
    shared.SYNX_TOKEN = nil
end)
