print("DEBUG")
if not _G.LOADER_VERIFIED then 
    game.Players.LocalPlayer:Kick("Connection not secure") 
    return 
end
