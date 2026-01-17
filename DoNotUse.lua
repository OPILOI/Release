print("DEBUG")

-- 1. HANDSHAKE VERIFICATION WITH 8s GRACE
local _TOKEN = nil
for i = 1, 80 do -- Check every 0.1s for 8 seconds total
    if _G.SYNX_TOKEN then
        _TOKEN = _G.SYNX_TOKEN
        _G.SYNX_TOKEN = nil
        break
    end
    task.wait(0.1)
end

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end

-- 2. SECURITY VALIDATION (Site Check)
local _R = request or http_request or (syn and syn.request)
local _TARGET = nil
pcall(function() _TARGET = BZAGZFIG end)

local _OK = false
if _R and _TARGET then
    -- Verification loop also respects the 8s maximum timeout window
    for i = 1, 4 do 
        local success, r = pcall(function()
            return _R({
                Url = "https://opiloi.github.io/WEBSITE/?t=" .. tick(),
                Method = "GET",
                Timeout = 8 -- Internal request timeout
            })
        end)
        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if code == _TARGET then _OK = true break end
        end
        task.wait(2) -- Spaced retries totaling 8s
    end
end

if not _OK then
    game.Players.LocalPlayer:Kick("Security Validation Failed (Site Mismatch)")
    return
end

print("Validation Successful - Main Script Active")
-- [[ MAIN CODE HERE ]] --
