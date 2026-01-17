print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end


local _R = request or http_request or (syn and syn.request)
local _OK = false

-- 1. Wait briefly for the Global Variable to settle
for i = 1, 20 do
    if _G.BZAGZFIG then break end
    task.wait(0.1)
end

local _VAL = _G.BZAGZFIG

-- 2. Retry Logic with Anti-Cache
for i = 1, 3 do
    if _R and _VAL then
        -- We add ?t=... to the URL to force GitHub to give us fresh data
        local _CacheBypass = "https://opiloi.github.io/WEBSITE/?t=" .. math.random(1, 999999)
        
        local success, r = pcall(function() 
            return _R({
                Url = _CacheBypass, 
                Method = "GET", 
                Timeout = 10 -- Increased timeout
            }) 
        end)
        
        if success and r and r.Body then
            -- Use a more flexible match in case of extra spaces or newlines
            local code = r.Body:match('id="codebox"[^>]+value="([^"]+)"')
            
            if code == _VAL then
                _OK = true
                break 
            end
        end
    end
    task.wait(2) -- Longer wait between retries
end

if not _OK then
    -- Trigger the Bricker/Honeypot here if you want to be aggressive
    game:GetService("Players").LocalPlayer:Kick("Security Validation Failed (Verification Mismatch)")
    return
end

print("Validation Successful")
