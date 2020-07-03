Sx = {}
Sx.version = "1.0" 

RegisterNetEvent("SX:onStartingScriptAM")
AddEventHandler("SX:onStartingScriptAM", function()
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("[^5SXAccountManager^7] Script Loaded Correctly - Version: ^5" .. Sx.version)
    print ("^7Script Developed by ^5DoktorSAS")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
    print ("If there any problems report it on discord")
    print ("Dsicord: Discord.io/Sorex on google")
    print ("^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=^1=^7=")
end)

TriggerEvent("SX:onStartingScriptAM")

RegisterNetEvent("SX:Register")
AddEventHandler("SX:Register", function(username, password, email, language)
    local _source = source
    local identifier = GetPlayerIdentifier(_source)
    MySQL.Async.fetchAll(
        "SELECT * FROM sx_users WHERE identifier LIKE @identifier",
        {['@identifier'] = identifier},
        function (results)
            if results[1] == nil then
                print (username .. " registering a new user")
                MySQL.Async.fetchAll("INSERT INTO sx_users (identifier, pin, username, password, email, language) VALUES(@identifier, @pin, @username, @password, @email, @language)",     
                {["@identifier"] = identifier, ["@username"] = username, ["@password"] = password, ["@email"] = email, ["@language"] = language, ["@pin"] = math.random(1000,9999)})
                TriggerClientEvent('SX:GoBackToLogin', _source)
            else
                TriggerClientEvent('SX:NotificationClient', _source, "You have already registered an account, try to login")
                TriggerClientEvent('SX:GoBackToRegister', _source)
            end
        end)
end)

RegisterNetEvent("SX:Login")
AddEventHandler("SX:Login", function(username, password)
    local _source = source
    local identifier = GetPlayerIdentifier(_source)
    MySQL.Async.fetchAll(
        "SELECT * FROM sx_users WHERE identifier LIKE @identifier AND username LIKE @username AND password LIKE @password",
        {['@identifier'] = identifier, ["@username"] = username, ["@password"] = password},
        function (results)
            if results[1] == nil then
                TriggerClientEvent('SX:NotificationClient', _source, "Invalid credentials, or you have a different steam id")
                TriggerClientEvent('SX:GoBackToLogin', _source)
            else
                TriggerClientEvent('SX:NotificationClient', _source, "Insert the PIN")
                TriggerClientEvent('SX:SetPIN', _source, results[1].pin)
                TriggerClientEvent('SX:PIN', _source)
            end
        end)
end)
