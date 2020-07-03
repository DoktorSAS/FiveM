local display = false
local logged = false
function setLogged()
    logged = true
end
local pin = 0

AddEventHandler('playerSpawned', function (spawn)
    if not logged then
        SetDisplay(not display)
    end
end)

-- PIN Check
RegisterNetEvent('SX:PIN')
AddEventHandler("SX:PIN", function()
    Citizen.Wait(150)
    if Config.PINEnable then
        nuiMessage(true, "pin", true, true)
    else
        setLogged()
        notification("Welcome Back to the Server")
        nuiMessage(false, "end_login", false, false)
    end
end)
RegisterNetEvent('SX:SetPIN', pin_from_db)
AddEventHandler("SX:SetPIN", function( pin_from_db)
    pin = pin_from_db
end)
RegisterNUICallback("pin", function(data)
    if Config.PINEnable then
        notification("Validating PIN...")
        if data.pin == pin then
            Citizen.Wait(150)
            SendNUIMessage({
                type = "correct",
                dots = data.d,
                index = data.i
            })
            Citizen.Wait(150)
            setLogged()
            notification("Welcome Back to the Server")
            nuiMessage(false, "end_login", false, false)
        else 
            Citizen.Wait(150)
            SendNUIMessage({
                type = "wrong",
                dots = data.d,
                index = data.i
            })
            notification("Wrong PIN")
            Citizen.Wait(150)
            nuiMessage(true, "pin", true, true)
        end
    else
        print ("no pin")
        setLogged()
        notification("Welcome Back to the Server")
        nuiMessage(false, "end_login", false, false)
    end
end)
-- çogin 
RegisterNetEvent('SX:GoBackToLogin')
AddEventHandler('SX:GoBackToLogin', function()
    Citizen.Wait(150)
    nuiMessage(true, "loginreload", true, true)
end)
RegisterNUICallback("login", function(data)
    notification("Validating Username and Password")
    TriggerServerEvent("SX:Login", data.u, data.p)
end)
-- Register
RegisterNetEvent('SX:GoBackToRegister')
AddEventHandler('SX:GoBackToRegister', function()
    Citizen.Wait(150)
    nuiMessage(true, "regreload", true, true)
end)
RegisterNUICallback("register", function(data)
    notification("Register Account...")
    TriggerServerEvent("SX:Register", data.u, data.p, data.e, data.l)
end)
-- Error
RegisterNUICallback("error", function(data)
    Citizen.Wait(150)
    if data.type then
        nuiMessage(true, "regreload", true, true)
    else
        nuiMessage(true, "loginreload", true, true)
    end
    SendNUIMessage({
        type = "wrong",
        dots = data.d,
        index = data.i
    })
end)
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end
Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        print (display)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

-- Utilities
function nuiMessage(focus, type, status, buttons)
    display = buttons
    SetNuiFocus(focus, focus)
    SendNUIMessage({
        type = type,
        status = statust
    })
end

function notification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end
RegisterNetEvent('SX:NotificationClient')
AddEventHandler("SX:NotificationClient", function(text)
    notification(text)
end)

