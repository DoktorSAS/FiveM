-- Help Command
RegisterCommand('help', function()
    msg("/kick {playername or ID} {reason} | /announce {message} | /ban {playername or ID} {reason} | /spawn | /suicide | /unban {playername or ID} | /tempban {playername or ID} {time} {type} {reason} | /warn {playername or ID} {reason}")
end, false)
TriggerEvent('chat:addSuggestion', '/help', 'This command is to see all commands of the SxAdminTool', {
})
function msg(text)
    -- TriggerEvent will send a chat message to the client in the prefix as red
    TriggerEvent("chatMessage", "^7[^5SXAdmin^7]", {255,0,0}, text)
end
-- Announce -> Make public announce
RegisterCommand("announce", function(source, args)
    TriggerServerEvent('announce', table.concat(args, " "))
end)
TriggerEvent('chat:addSuggestion', '/announce', 'This command is to make an announce', {
    { name="announce", help="Insert the announce text" }
})
-- Kick -> This command is to kick players
RegisterCommand("kick", function(source, args)
    if args[2] == nil then
        TriggerServerEvent('SX:kick', args[1], nil)
    else
        TriggerServerEvent('SX:kick', args[1], table.concat(args, " ", 2))
    end
end)
TriggerEvent('chat:addSuggestion', '/kick', 'You can kick player with the name, id or part of the name', {
    { name="player to kick", help="Insert player name, id or part of the name" },
    { name="reason", help="Insert the reason why you want kick him" },
})
-- ban -> This command is to ban players
RegisterCommand("ban", function(source, args)
    if args[2] == nil then
        TriggerServerEvent('SX:ban', args[1], nil)
    else
        TriggerServerEvent('SX:ban', args[1], table.concat(args, " ", 2))
    end
end)
TriggerEvent('chat:addSuggestion', '/ban', 'You can ban player with the name, id or part of the name', {
    { name="player to ban", help="Insert player name, id or part of the name" },
    { name="reason", help="Insert the reason why you want ban him" },
})
-- Warn -> This command is to warn players
RegisterCommand("warn", function(source, args)
    TriggerServerEvent('SX:WarnServer', args[1], table.concat(args, " ", 2))
end)
TriggerEvent('chat:addSuggestion', '/warn', 'You can warn player with the name, id or part of the name', {
    { name="player to warn", help="Insert player name, id or part of the name" },
    { name="reason", help="Insert the reason why you want warn him" },
})
-- Unban -> This command is to unban players
RegisterCommand("unban", function(source, args)
    TriggerServerEvent('SX:unban', args[1])
end)
TriggerEvent('chat:addSuggestion', '/unban', 'Insert the complete name of the player to unban', {
    { name="Complete player name", help="Insert  complete player name" },
})
RegisterCommand("unbanid", function(source, args)
    TriggerServerEvent('SX:unbanID', args[1])
end)
TriggerEvent('chat:addSuggestion', '/unbanid', 'Insert the Database ID of the player to unban', {
    { name="Database ID", help="Insert Database ID" },
})

-- tempban -> you can ban user for like a few days, months, week, hours or minutes
RegisterCommand("tempban", function(source, args)
    if args[2] == nil then
        TriggerServerEvent('SX:TempBan', nil, nil, nil, nil)
    elseif args[2] == nil then
        TriggerServerEvent('SX:TempBan', args[1], nil, nil, nil)
    elseif args[3] == nil then
        TriggerServerEvent('SX:TempBan', args[1], args[2], nil, nil)
    elseif args[4] == nil then
        TriggerServerEvent('SX:TempBan', args[1], args[2], args[3], nil)
    else
        TriggerServerEvent('SX:TempBan', args[1], args[2], args[3], table.concat(args, " ", 4))
    end
end)
RegisterCommand("tempbanid", function(source, args)
    if args[2] == nil then
        TriggerServerEvent('SX:TempBanID', nil, nil, nil, nil)
    elseif args[2] == nil then
        TriggerServerEvent('SX:TempBanID', args[1], nil, nil, nil)
    elseif args[3] == nil then
        TriggerServerEvent('SX:TempBanID', args[1], args[2], nil, nil)
    elseif args[4] == nil then
        TriggerServerEvent('SX:TempBanID', args[1], args[2], args[3], nil)
    else
        TriggerServerEvent('SX:TempBanID', args[1], args[2], args[3], table.concat(args, " ", 4))
    end
end)
TriggerEvent('chat:addSuggestion', '/tempban', 'You can tempban player usinf ID of the Database', {
    { name="player to ban", help="Insert player name, id or part of the name" },
    { name="time", help="Insert the number of day, week, month, hours, minutes" },
    { name="type", help="Insert the type of the ban -> d = day, w = week, m = month, h = hours, m = minutes" },
    { name="reason", help="Insert the reason why you want tempban him" },
})
-- Set level -> Set level of an user
RegisterCommand("setlevel", function(source, args)
    TriggerServerEvent('SX:LevelSet', args[1], args[2])
end)
TriggerEvent('chat:addSuggestion', '/setlevel', 'You can set player level, you can change the rabk of an user', {
    { name="username", help="Insert player name, id or part of the name" },
    { name="number from 1 to 6", help="Insert value of the rank" },
})
RegisterCommand("setlevelid", function(source, args)
    TriggerServerEvent('SX:LevelSetID', args[1], args[2])
end)
TriggerEvent('chat:addSuggestion', '/setlevelid', 'You can set player level, you can change the rabk of an user', {
    { name="ID", help="Insert player id on the database" },
    { name="number from 1 to 6", help="Insert value of the rank" },
})
-- Suicide -> Kill yourself
RegisterCommand("suicide", function(source, args)
    Citizen.CreateThread(function(source)
        SetEntityHealth(PlayerPedId(), 0)
    end)
end)
TriggerEvent('chat:addSuggestion', '/suicide', 'This command is to kill your self', {
})
-- Spawn -> Teleport to the spawn
RegisterCommand("spawn", function(source, args)
    Citizen.CreateThread(function(source)
        notification("~w~Teleported to the ~B~"..Config.ServerName.." ~w~Spawn")
        SetEntityCoords(GetPlayerPed(-1), Config.FristSpawnLocation.x, Config.FristSpawnLocation.y, Config.FristSpawnLocation.z)
    end)

end)
TriggerEvent('chat:addSuggestion', '/spawn', 'This command is to teleport player to the frist spawn area', {
})
-- Print Cord
RegisterCommand("cords", function(source, args)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
    TriggerEvent("chatMessage",  "[^5SXAdmin^7]", {255,255,255}, "X: " .. playerCoords.x .. " Y:" .. playerCoords.y .. " Z:" .. playerCoords.z)
end)
TriggerEvent('chat:addSuggestion', '/cords', 'This command is to see your cords (For DEV)', {
})
-- Show all admins online 
RegisterCommand("admins", function(source, args)
    TriggerServerEvent("SX:Admins")
end)
TriggerEvent('chat:addSuggestion', '/admins', 'This command is to see if there moderators online', {
})
-- Change Languages
RegisterCommand("setlanguage", function(source, args)
    TriggerServerEvent("SX:LanguageSet", args[1])
end)
TriggerEvent('chat:addSuggestion', '/setlanguage', 'Insert the language of blips', {
    { name="languagese", help="it = italian , gr = german, esp = spanish, du = dutch, fr = franch, ru = russian, na = neapolitan" },
})
-- mybike -> Spawn a bike if there no Veichle in the area
RegisterCommand("mybike", function(source)
    local bike = GetHashKey("BMX")
    RequestModel(bike)
    while not HasModelLoaded(bike) do
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(bike, x + 2, y + 2, z + 1, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    notification("Bike has been spawned")
end)
TriggerEvent('chat:addSuggestion', '/mybike', 'Use it to spawn a bike if there no veichle in the area', {
})

-- Utilities
function notification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end
