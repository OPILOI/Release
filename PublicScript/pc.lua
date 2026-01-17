if not (_G.SESSION_TOKEN and _G.Processor) or 
   type(_G.SESSION_TOKEN) ~= "number" or 
   type(_G.Processor) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

warn("Loading pc..")



warn("Loaded pc!")
