TPA = {}
TPA.request = {}
TPA.target = {}
i = 0
while i < 65 do
    TPA.request[i] = false
    TPA.target[i] = -2
    i = i +1 
end

RegisterServerEvent('SX:TPA')
AddEventHandler('SX:TPA', function(target)
    print (target)
    print (TPA.request[source])
    if TPA.request[source] == true then
        TPA.request[source] = false
        TriggerClientEvent('chatMessage', source, '^7[^5SXAdmin^7]^2', {0,0,0}, "Last TPA Request has been stopped" .. "^7")
    else
        if string.len(target) < 3 then
            TPA.request[source] = true
            TPA.target[source] = target
            TriggerClientEvent('chatMessage', tonumber(target), '^7[^5SXAdmin^7]^2', {0,0,0}, "^5"..GetPlayerName(target).."^7 send to you a TPA Request - ^2/tpaccept ^7to accept or ^1/tpdeny^7 to refuse" .. "^7")
        end
    end
end)
RegisterServerEvent('SX:TPA_Accept')
AddEventHandler('SX:TPA_Accept', function()
    local _source = source
    WhoTargetMe = -2 
    i = 0
    while i < 65 do
        if TPA.request[i] == true and tonumber(TPA.target[i]) == tonumber(_source) then
            WhoTargetMe = GetPlayerPed(i)
            playerCoords = GetEntityCoords(WhoTargetMe)
            TriggerClientEvent('chatMessage', source, '^7[^5SXAdmin^7]^2', {0,0,0}, "TPA ^2Accepted" .. "^7")
            SetEntityCoords(GetPlayerPed(source), playerCoords.x, playerCoords.y, playerCoords.z)
            TPA.request[i] = false
            TPA.target[i] = -2
        end
        i = i +1 
    end
    if tonumber(WhoTargetMe) == tonumber(-2) then
        TriggerClientEvent('chatMessage', source, '^7[^5SXAdmin^7]^2', {0,0,0}, "There ^1no ^7tpa request " .. "^7")
    end
end)
RegisterServerEvent('SX:TPA_Deny')
AddEventHandler('SX:TPA_Deny', function()
    local _source = source
    WhoTargetMe = -2 
    i = 0
    while i < 65 do
        if TPA.request[i] == true and tonumber(TPA.target[i]) == tonumber(_source) then
            TriggerClientEvent('chatMessage', source, '^7[^5SXAdmin^7]^2', {0,0,0}, "TPA ^1Refused" .. "^7")
            WhoTargetMe = GetPlayerPed(i)
            TPA.request[i] = false
            TPA.target[i] = -2
        end
        i = i +1 
    end
    if tonumber(WhoTargetMe) == tonumber(-2) then
        TriggerClientEvent('chatMessage', source, '^7[^5SXAdmin^7]^2', {0,0,0}, "There ^1no ^7tpa request " .. "^7")
    end
end)
RegisterServerEvent('SX:TPToMarker', ped, x, y, z)
AddEventHandler('SX:TPToMarker', function(ped,x,y,z)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
    function (results)
        if results[1].sx_group < 3 then
            TriggerClientEvent('chatMessage', _source, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
        elseif results[1].sx_group > 3 then
            TriggerClientEvent('SX:Teleport', _source, ped, x, y, z)
        end
    end)
end)
RegisterServerEvent('SX:TPTO', target)
AddEventHandler('SX:TPTO', function(target)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
    function (results)
        if results[1].sx_group < 3 then
            TriggerClientEvent('chatMessage', _source, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
        elseif results[1].sx_group > 3 then
            id = -2
            c = 0
            if string.len(target) > 2 then
            for _, playerId in ipairs(GetPlayers()) do
                local name = GetPlayerName(playerId)
                if string.match(name, target) then
                        c = c + 1
                        id = tonumber(playerId)
                    end
                end
            if id > -1 and c == 1 then
                targetcords = GetEntityCoords(GetPlayerPed(tonumber(id)))
                TriggerClientEvent('SX:Teleport', _source, GetPlayerPed(_source), targetcords.x, targetcords.y, targetcords.z)
                TriggerClientEvent('chatMessage', _source, '^7[^5SXAdmin^7]^2', {0,0,0}, "Teleported to ".. GetPlayerName(GetPlayerPed(tonumber(id))) .. " ^7")
            end
            else
                targetcords = GetEntityCoords(GetPlayerPed(tonumber(target)))
                TriggerClientEvent('SX:Teleport', _source, GetPlayerPed(_source), targetcords.x, targetcords.y, targetcords.z)
                TriggerClientEvent('chatMessage', _source, '^7[^5SXAdmin^7]^2', {0,0,0}, "Teleported to ".. GetPlayerName(target) .. " ^7")
            end
           

        end
    end)
end)

RegisterServerEvent('SX:TPME', target)
AddEventHandler('SX:TPME', function(target)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
    function (results)
        if results[1].sx_group < 3 then
            TriggerClientEvent('chatMessage', _source, '^7[^5SXAdmin^7]^2', {0,0,0}, "You dont have enught permissions" .. "^7")
        elseif results[1].sx_group > 3 then
            id = -2
            c = 0
            if string.len(target) > 2 then
            for _, playerId in ipairs(GetPlayers()) do
                local name = GetPlayerName(playerId)
                if string.match(name, target) then
                        c = c + 1
                        id = tonumber(playerId)
                    end
                end
            if id > -1 and c == 1 then
                targetcords = GetEntityCoords(GetPlayerPed(tonumber(id)))
                TriggerClientEvent('SX:Teleport', _source, GetPlayerPed(_source), targetcords.x, targetcords.y, targetcords.z)
                TriggerClientEvent('chatMessage', tonumber(id), '^7[^5SXAdmin^7]^2', {0,0,0}, "Teleported ".. GetPlayerName(GetPlayerPed(tonumber(id))) .. "to you ^7")
            end
            else
                targetcords = GetEntityCoords(GetPlayerPed(tonumber(target)))
                TriggerClientEvent('SX:Teleport', _source, GetPlayerPed(_source), targetcords.x, targetcords.y, targetcords.z)
                TriggerClientEvent('chatMessage', target, '^7[^5SXAdmin^7]^2', {0,0,0}, "Teleported ".. GetPlayerName(target) .. " to you ^7")
            end
           

        end
    end)
end)