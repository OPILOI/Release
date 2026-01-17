print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end






local _R = request or http_request or (syn and syn.request)
local _OK = false

-- 1. Explicitly pull the value from the Global table
-- We wait up to 5 seconds to make sure the loader finished writing it
local _TARGET = nil
for i = 1, 50 do
    if _G.BZAGZFIG then
        _TARGET = _G.BZAGZFIG
        break
    end
    task.wait(0.1)
end

-- 2. Validation Logic
if _R and _TARGET then
    for i = 1, 3 do -- 3 attempts to handle lag
        local success, r = pcall(function()
            return _R({
                Url = "https://opiloi.github.io/WEBSITE/",
                Method = "GET",
                Timeout = 10
            })
        end)

        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if code and code == _TARGET then
                _OK = true
                break
            end
        end
        task.wait(1)
    end
end

-- 3. The Result
if not _OK then
    -- Trigger Honeypot/Brick logic if you want, otherwise just kick
    game:GetService("Players").LocalPlayer:Kick("Security Validation Failed")
    return
end

print("Validation Successful - Script Running")
-- YOUR MAIN SCRIPT START HERE
