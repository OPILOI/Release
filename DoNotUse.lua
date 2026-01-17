print("DEBUG")
-- Security Handshake
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil -- Instantly wipe it from memory so it's "single use"

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end

-- If the code reaches here, it is verified.
print("Securely Loaded.")
