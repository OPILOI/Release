local session = _G.SESSION_TOKEN or shared.SESSION_TOKEN
local g_token = _G.G_TOKEN or shared.G_TOKEN

-- Check only for these two
if not (session and g_token) then
    game.Players.LocalPlayer:Kick("Initialization Error")
    return
end

local UIS = game:GetService("UserInputService")
local isMobile = (UIS.TouchEnabled and not UIS.KeyboardEnabled)

if isMobile then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end
