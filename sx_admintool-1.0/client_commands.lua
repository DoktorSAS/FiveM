
-- Help Command
RegisterCommand('help', function()
    msg("/kick {playername or ID} reason | /announce {message} | /ban {playername or ID} reason | /spawn | /suicide")
end, false)
function msg(text)
    -- TriggerEvent will send a chat message to the client in the prefix as red
    TriggerEvent("chatMessage",  "^7[^5SXAdmin^7]", {255,0,0}, text)
end

-- Announce -> Make public announce
RegisterCommand("announce", function(source, args)
    TriggerServerEvent('announce', table.concat(args, " "))
end)

RegisterCommand("kick", function(source, args)
    TriggerServerEvent('SX:kick', args[1], args[2])
end)

RegisterCommand("ban", function(source, args)
    TriggerServerEvent('SX:ban', args[1], args[2])
end)

RegisterCommand("unban", function(source)
    TriggerServerEvent('SX:unban')
end)

-- Suicide -> Kill yourself
RegisterCommand("suicide", function(source, args)
    Citizen.CreateThread(function(source)
        SetEntityHealth(PlayerPedId(), 0)
    end)
    
end)

-- Spawn -> Teleport to the spawn
RegisterCommand("spawn", function(source, args)
    Citizen.CreateThread(function(source)
        notification("~w~Teleported to the ~B~"..Config.ServerName.." ~w~Spawn")
        SetEntityCoords(GetPlayerPed(-1), Config.FristSpawnLocation.x, Config.FristSpawnLocation.y, Config.FristSpawnLocation.z)
    end)

end)

-- Print Cord

RegisterCommand("cords", function(source, args)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
    TriggerEvent("chatMessage",  "[^5SXAdmin^7]", {255,255,255}, "X: " .. playerCoords.x .. " Y:" .. playerCoords.y .. " Z:" .. playerCoords.z)
    print(playerCoords)
end)

-- Utilities

function notification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

