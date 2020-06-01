
local server_name = "SXAdminTool" -- Change This with the name of your server

RegisterNetEvent("SX:onStartingScript")

AddEventHandler("SX:onStartingScript", function()
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("[^5SXAdmin^7] Script Loaded Correctly on ^5" ..  server_name)
    print ("^7Script Developed by ^5DoktorSAS")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("If there any problems report it on discord")
    print ("Dsicord: Discord.io/Sorex on google")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
end)

TriggerEvent("SX:onStartingScript")

-- When Player Connect

local function OnPlayerConnecting(name, setKickReason, deferrals)
    print(name .. " ^3Joined the server^7")
    local _source = source
    local identifier = GetPlayerIdentifier(_source)
    local number_of_user = 1
    deferrals.defer()
    -- mandatory wait!
    Wait(0)
    -- addchatmessage( name .. " Welcome to " .. server_name)
    -- addchatmessage("This server have a total of " .. number_of_user)
    MySQL.Async.fetchAll(
        "SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier",
        {['@identifier'] = identifier},
        function (results)
            MySQL.Async.execute("UPDATE sx_adminclients SET fristtime = @res WHERE identifier LIKE @identifier", {['@res'] = true, ['@identifier'] = identifier})
            if results[1] == nil then
                MySQL.Async.fetchAll("INSERT INTO sx_adminclients (identifier, username) VALUES(@identifier, @username)",     
                {["@identifier"] = identifier, ["@username"] = name})
            end
        end)
    deferrals.done()
end

function addchatmessage(msg)
    TriggerEvent("addMessage",  "[^5SXAdmin^7]", {255,255,255}, msg)
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

-- When player Disconnect

AddEventHandler('playerDropped', function (reason)
    print('^3Player ^5' .. GetPlayerName(source) .. " ^3left the game^7")
	local player_ped =  GetPlayerPed(source)
	local player_pos = GetEntityCoords(player_ped)
	local identifier = GetPlayerIdentifier(source)
	MySQL.Async.execute("UPDATE sx_adminclients SET disconnect_x = @x , disconnect_y = @y , disconnect_z = @z WHERE identifier LIKE @identifier " , {['@identifier'] = identifier , ['@x'] = player_pos.x , ['@y'] = player_pos.y , ['@z'] = player_pos.z})
end)

-- Spawn Manager

RegisterNetEvent('SX:Spawn', name)
AddEventHandler('SX:Spawn', function (name)
    local _source = source
    print("name: ".. name)
    MySQL.Async.fetchAll(
        "SELECT * FROM sx_adminclients WHERE username LIKE @username",
        {['@username'] = name},
        function (results)
            if results[1].frist_connection == false and Config.FristSpawnOnHUB then
                MySQL.Async.execute("UPDATE sx_adminclients SET frist_connection = @res WHERE username LIKE @username", {['@res'] = true, ['@username'] = name})
                print ("Player teleported: " .. GetPlayerName(_source))
                TriggerClientEvent('SX:Teleport_to_spawn', _source)
            end
            if results[1].fristtime == true and Config.SpawnOnDisconnectedPos then
                --print (type(results[1].fristtime))
                MySQL.Async.execute("UPDATE sx_adminclients SET fristtime = @res WHERE username LIKE @username", {['@res'] = false, ['@username'] = name})
                TriggerClientEvent('SX:Teleport_to_cords', _source, results[1].disconnect_x, results[1].disconnect_y, results[1].disconnect_z)
            end
            print (results[1].permanentBan)
            if results[1].permanentBan == true then
                n = -2
                for _, playerId in ipairs(GetPlayers()) do
                    if GetPlayerName(playerId) == results[1].username then
                        n = playerId
                    end
                end 

                DropPlayer(n, results[1].reason)   
            end
		end)
end)

-- Commands Manager
RegisterServerEvent('announce')
AddEventHandler('announce', function( param )
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
        function (results)
            if results[1].sx_group >= 3 then
                print('^7[^1Announcement^7]^5:'.. param)
                TriggerClientEvent('chatMessage', -1, '^7[^1Announcement^7]^2', {0,0,0}, param .. "^7")
            end
            if results[1].sx_group < 3 then
                TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
            end
        end)
end)

RegisterServerEvent('SX:kick')
AddEventHandler('SX:kick', function( player_to_kick , reason)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
        function (results)
            if results[1].sx_group < 3 then
                TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
            end
            if results[1].sx_group > 3 then
                validate = true
                kicked = true
                if string.len(player_to_kick) > 2 then
                    c = 0
                    id = -2
                    print (player_to_kick)
                    for _, playerId in ipairs(GetPlayers()) do
                        local name = GetPlayerName(playerId)
                        if string.match(name, player_to_kick) then
                            c = c + 1
                            id = playerId
                            TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "["..playerId.."]".. name .. "^7")
                        end
                    end
                    if reason == nil then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "Missing reason of the kick")
                        validate = false
                    end
                    if c == 1 and validate then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, GetPlayerName(id) .. " has been kicked for " .. reason)
                        DropPlayer(id, reason)
                        kicked = false
                    end
                else
                    if reason == nil then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "Missing reason of the kick")
                        validate = false
                    end
                    if validate and kicked then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, GetPlayerName(player_to_kick) .. " has been kicked for " .. reason)
                        DropPlayer(player_to_kick, reason)
                    end
                end
            end
        end)
end)

RegisterServerEvent('SX:ban')
AddEventHandler('SX:ban', function( player_to_kick , reason)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
        function (results)
            if results[1].sx_group < 3 then
                TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
            end
            if results[1].sx_group > 3 then
                validate = true
                kicked = true
                --print (reason) 
                if string.len(player_to_kick) > 2 then
                    c = 0
                    id = -2
                    for _, playerId in ipairs(GetPlayers()) do
                        n = ""
                        local name = GetPlayerName(playerId)
                        if string.match(name, player_to_kick) then
                            c = c + 1
                            id = playerId
                            n = name
                            print(('Player %s with id %i is in the server'):format(name, playerId))
                            TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "["..playerId.."]".. name .. "^7")
                        end
                    end
                    if reason == nil then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "Missing reason of the kick")
                        validate = false
                    end
                    if c == 1 and validate then
                        MySQL.Async.execute("UPDATE sx_adminclients SET permanentBan = @res WHERE username LIKE @username", {['@res'] = 1, ['@username'] = n})
                        MySQL.Async.execute("UPDATE sx_adminclients SET reason = @reason WHERE username LIKE @username", {['@reason'] = reason, ['@username'] = n})
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, GetPlayerName(id) .. " has been kicked for " .. reason)
                        DropPlayer(id, reason)
                        kicked = false
                    end
                else
                    if reason == nil then
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, "Missing reason of the kick")
                        validate = false
                    end
                    if validate and kicked then
                        n = ""
                        for _, playerId in ipairs(GetPlayers()) do
                            if playerId == player_to_kick then
                                n = GetPlayerName(playerId)
                            end
                        end 
                        MySQL.Async.execute("UPDATE sx_adminclients SET permanentBan = @res WHERE username LIKE @username", {['@res'] = true, ['@username'] = n})
                        MySQL.Async.execute("UPDATE sx_adminclients SET reason = @reason WHERE username LIKE @username", {['@reason'] = reason, ['@username'] = n})
                        TriggerClientEvent('chatMessage', -1, '^7[^5SXAdmin^7]^7', {0,0,0}, GetPlayerName(player_to_kick) .. " has been kicked for " .. reason)
                        DropPlayer(player_to_kick, reason)
                    end
                end
            end
        end)
end)

RegisterServerEvent('SX:unban')
AddEventHandler('SX:unban', function(player_to_unban)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
        function (results)
            if results[1].sx_group < 3 then
                MySQL.Async.execute("UPDATE sx_adminclients SET permanentBan = @res WHERE username LIKE @username", {['@res'] = false, ['@username'] = player_to_unban})
            end
        end)
end)