print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end


local _R = request or http_request or (syn and syn.request)
local _VAL = _G.BZAGZFIG
local _OK = false

-- Try the check up to 3 times before giving up
for i = 1, 3 do
    if _R and _VAL then
        local success, r = pcall(function() 
            return _R({Url = "https://opiloi.github.io/WEBSITE/", Method = "GET", Timeout = 5}) 
        end)
        
        if success and r and r.Body then
            local code = r.Body:match('id="codebox"%s+value="(.-)"')
            if code and code == _VAL then
                _OK = true
                break -- Success! Exit the loop.
            end
        end
    end
    task.wait(1) -- Wait 1 second before retrying
end

if not _OK then
    game:GetService("Players").LocalPlayer:Kick("Security Validation Failed (Site Timeout)")
    return
end

print("Validation Successful")
