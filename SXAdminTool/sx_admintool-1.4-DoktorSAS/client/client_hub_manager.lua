-- Change this cord to move Messages                               --
local welcome = {x = 683.430175,  y = 568.2777099, z = 132.46138}  -- Welcome Message
local commands = {x = 697.430175,  y = 574.2777099, z = 132.46138} -- Commands List Message
local buttons = {x = 674.325378,  y = 582.060974, z = 132.46138}   -- Bittons List Message
--                                                                 --


local distance_until_text_disappears = 2500

Citizen.CreateThread(function()
    if Config.SXSpawnBlip then
        local blip = AddBlipForCoord(Config.FristSpawnLocation.x, Config.FristSpawnLocation.y, Config.FristSpawnLocation.z)
        -- sets the blip id (which icon will be desplayed)
        -- https://runtime.fivem.net/doc/natives/#_0xDF735600A4696DAF
        SetBlipSprite(blip, 590)
        -- sets where the blip to be shown on both the minimap and the menu map 
        -- https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
        SetBlipDisplay(blip, 6)
        -- how big the blip will be
        -- https://runtime.fivem.net/doc/natives/#_0xD38744167B2FA257
        SetBlipScale(blip, 0.9)
        -- blip entry type
        BeginTextCommandSetBlipName("STRING");
        -- The title of the blip
        AddTextComponentString("Spawn")
        EndTextCommandSetBlipName(blip)
    end
    local p = PlayerId()
    h = GetEntityMaxHealth(GetPlayerPed(-1))
    while true do
        Citizen.Wait(0)
            cords = GetEntityCoords(GetPlayerPed(-1))
            if Vdist2(cords.x, cords.y, cords.z, welcome.x, welcome.y, welcome.z) < distance_until_text_disappears then
                if GetEntityHealth(GetPlayerPed(-1)) > 0 then
                SetEntityHealth(GetPlayerPed(-1), h) -- This is to make immortal the user near the spawn
                end
                Draw3DText(welcome.x,welcome.y,welcome.z, "Welcome to ~b~"..Config.ServerName.."~w~ RP\nButtons on the Right\nCommands on the Left")
            end
            if Vdist2(cords.x, cords.y, cords.z, commands.x, commands.y, commands.z) < distance_until_text_disappears then
                Draw3DText(commands.x,commands.y,commands.z, "~b~"..Config.ServerName.." ~w~Commands\n~g~/help~w~ to see all commands \n~g~/watchdogreport~w~ to report player \ntest1 \n test2")
            end
            if Vdist2(cords.x, cords.y, cords.z, buttons.x, buttons.y, buttons.z) < distance_until_text_disappears then
                Draw3DText(buttons.x,buttons.y,buttons.z, "~b~"..Config.ServerName.." ~w~Buttons\n Press [~b~ F ~w~] for something")
            end
    end
end)
-- Utilities
function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end