print("DEBUG")
local _TOKEN = _G.SYNX_TOKEN
_G.SYNX_TOKEN = nil

if not _TOKEN or type(_TOKEN) ~= "number" then
    game.Players.LocalPlayer:Kick("Connection not secure: Handshake Failed")
    return
end
