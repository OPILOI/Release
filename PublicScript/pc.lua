if not (_G.SESSION_TOKEN_A and _G.Processor) or 
   type(_G.SESSION_TOKEN_A) ~= "number" or 
   type(_G.Processor) ~= "number" then
    game.Players.LocalPlayer:Kick("Tampering")
    return
end

warn("Loading pc..")



warn("Loaded pc!")
