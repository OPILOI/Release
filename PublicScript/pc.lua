if not (_G.SESSION_TOKEN and _G.Processor) or type(_G.SESSION_TOKEN) ~= "number" or type(_G.Processor) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering (Final PC Check)")
    return
end

_G.SESSION_TOKEN = nil
_G.Processor = nil
shared.SESSION_TOKEN = nil
shared.Processor = nil

warn("Loading pc..")



warn("Loaded pc!")
