Sx = {}
Sx.version = "1.0" 
Sx.names = {}

RegisterNetEvent("SX:onStartingScriptMenu")
AddEventHandler("SX:onStartingScriptMenu", function()
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("[^5SXAdminMenu^7] Script Loaded Correctly - Version: ^5" .. Sx.version)
    print ("^7Script Developed by ^5DoktorSAS")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("If there any problems report it on discord")
    print ("Dsicord: Discord.io/Sorex on google")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
end)

TriggerEvent("SX:onStartingScriptMenu")

RegisterNetEvent("SX:getData", submenu)
AddEventHandler("SX:getData", function( submenu )
    local _source = source
    local text = ""
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        text = text .. '<tr><td>'..playerId..'</td><td>'.. GetPlayerName(playerId)..'</td></tr>'
    end
    TriggerClientEvent("SX:setData", _source, submenu, text)
end)

RegisterNetEvent("SX:getDataSR", submenu, username)
AddEventHandler("SX:getDataSR", function( submenu ,username)
    local _source = source
    local text = ""
    for _, playerId in ipairs(GetPlayers()) do
        local name = GetPlayerName(playerId)
        if string.match(name, username) then
            text = text .. '<tr><td>'..playerId..'</td><td>'.. GetPlayerName(playerId)..'</td></tr>'
        end
    end
    TriggerClientEvent("SX:setData", _source, submenu, text)
end)

RegisterNetEvent("SX:getDataDB", submenu, username)
AddEventHandler("SX:getDataDB", function( submenu )
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients", {['@table'] = "sx_adminclients"},
    function (results)
        l = tablelength(results)
        i = 1
        local text = ""
        while i <= tonumber(l) do
            text = text .. '<tr><td>'..results[i].ID..'</td><td>'.. results[i].username..'</td></tr>'
            i = i + 1;
        end
        TriggerClientEvent("SX:setData", _source, submenu, text)
    end)
    
end)

RegisterNetEvent("SX:getDataSRDB", submenu, username)
AddEventHandler("SX:getDataSRDB", function( submenu, username)
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients", {['@table'] = "sx_adminclients"},
    function (results)
        l = tablelength(results)
        i = 1
        local text = ""
        while i <= tonumber(l) do
            if string.match(results[i].username, username) then
                text = text .. '<tr><td>'..results[i].ID..'</td><td>'.. results[i].username..'</td></tr>'
            end
            i = i + 1;
        end
        TriggerClientEvent("SX:setData", _source, submenu, text)
    end)
    
end)

RegisterNetEvent("SX:isModeratorCheck" )
AddEventHandler("SX:isModeratorCheck", function()
    local _source = source
    MySQL.Async.fetchAll("SELECT * FROM sx_adminclients WHERE identifier LIKE @identifier", {['@identifier'] = GetPlayerIdentifier(_source)},
    function (results)
        if results[1].sx_group >= 3 then
            TriggerClientEvent("SX:isModerator", _source)
        end
    end)
end)


function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end
