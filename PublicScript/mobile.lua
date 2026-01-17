if not _G.SESSION_TOKEN then
    game:GetService("Players").LocalPlayer:Kick("Tampering")
    return
end

_G.SESSION_TOKEN = _G.SESSION_TOKEN + 1 

warn("Loading mobile..")



warn("Loaded mobile!")
