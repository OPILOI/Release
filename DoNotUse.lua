print("DEBUG")

-- 1. HANDSHAKE VERIFICATION WITH 10s TIMEOUT
local _TOKEN = nil
local _HandshakeStart = tick()

while (tick() - _HandshakeStart) < 10 do
    if _G.SYNX_TOKEN then
        _TOKEN = _G.SYNX_TOKEN
        _G.SYNX_TOKEN = nil
        break
    end
    task.wait(0.2)
end

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Timeout (10s)")
    return
end

-- 2. SECURITY VALIDATION (Site Check) WITH 10s TIMEOUT
local _R = request or http_request or (syn and syn.request)
local _TARGET = nil
pcall(function() _TARGET = BZAGZFIG end)

local _OK = false
local _ValidationStart = tick()

if _R and _TARGET then
    -- Loop for 10 seconds attempting to verify the website code
    while (tick() - _ValidationStart) < 10 do
        local success, r = pcall(function()
            return _R({
                Url = "https://opiloi.github.io/WEBSITE/?t=" .. tick(),
                Method = "GET",
                Timeout = 5
            })
        end)
        
        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if code == _TARGET then 
                _OK = true 
                break 
            end
        end
        task.wait(1) -- Retry every second until 10s is up
    end
end

if not _OK then
    game.Players.LocalPlayer:Kick("Security Validation Failed: Verfication Timeout (10s)")
    return
end

print("Validation Successful - Main Script Active")
-- [[ MAIN CODE HERE ]] --
