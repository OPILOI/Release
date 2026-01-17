-- Bridge Script (Step 5)
local session = _G.SESSION_TOKEN or shared.SESSION_TOKEN

-- Processor and G_Token are now optional, so we don't check them here
if not session then
    game.Players.LocalPlayer:Kick("Initialization Error: Session Missing")
    return
end

local UIS = game:GetService("UserInputService")
local isMobile = (UIS.TouchEnabled and not UIS.KeyboardEnabled)

if isMobile then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end
