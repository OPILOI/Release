local session = _G.SESSION_TOKEN or shared.SESSION_TOKEN
local processor = _G.Processor or shared.Processor

if not (session and processor) then
    game.Players.LocalPlayer:Kick("Initialization Error")
    return
end

local _TOKEN = _G.SYNX_TOKEN or shared.SYNX_TOKEN
if not _TOKEN then
    local start = tick()
    while tick() - start < 1.5 do 
        _TOKEN = _G.SYNX_TOKEN or shared.SYNX_TOKEN
        if _TOKEN then break end
        task.wait(0.1)
    end
end

if not _TOKEN then
    game.Players.LocalPlayer:Kick("Sync Failed")
    return
end

local UIS = game:GetService("UserInputService")
local isMobile = (UIS.TouchEnabled and not UIS.KeyboardEnabled)

if isMobile then
    _G.MOBILE_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/mobile.lua"))()
else
    _G.PC_VALIDATED = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OPILOI/Release/refs/heads/main/PublicScript/pc.lua"))()
end

task.delay(3, function()
    _G.SESSION_TOKEN = nil
    _G.Processor = nil
    _G.SYNX_TOKEN = nil
    _G.PC_VALIDATED = nil
    _G.MOBILE_VALIDATED = nil
    shared.SESSION_TOKEN = nil
    shared.Processor = nil
    shared.SYNX_TOKEN = nil
end)
