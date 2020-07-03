local display = false

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)
RegisterNUICallback("loadsubmenu", function(data)
    if  data.submenu == "tempban_menu" or data.submenu == "owner_menu" then
        TriggerServerEvent("SX:getDataDB", data.submenu)
    else
        TriggerServerEvent("SX:getData", data.submenu)
    end
end)
RegisterNUICallback("reloadlist", function(data)
    if  data.submenu == "player_menu" then
        TriggerServerEvent("SX:getDataSR", data.submenu, data.username)
    else
        TriggerServerEvent("SX:getDataSRDB", data.submenu, data.username)
    end
end)
RegisterNUICallback("error", function(data)
    notification(data.text)
end)
RegisterNetEvent('SX:setData', submenu, html)
AddEventHandler('SX:setData', function( submenu, html )
    SendNUIMessage({
        type = submenu, 
        html = html
    })
end)
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "adminmenu",
        status = bool
    })
end
-- Execute Command
RegisterNUICallback("commands", function(data)
    if data.command == "KICK" then
        TriggerServerEvent('SX:kick', data.target, data.reason)
        notification("Execute KICK")
    elseif  data.command == "WARN" then
        TriggerServerEvent('SX:WarnServer', data.target, data.reason)
        notification("Execute WARN")
    elseif  data.command == "TPTO" then
        TriggerServerEvent('SX:TPTO', data.target) 
        notification("Execute TPTO")
    elseif  data.command == "TPME" then
        TriggerServerEvent('SX:TPME', data.target)
        notification("Execute TPME")
    elseif  data.command == "TEMPBANNAME" then
        TriggerServerEvent('SX:TempBan', data.target, data.time, data.type, data.reason)
        notification("Execute TEMPBAN with in game Data")
    elseif  data.command == "TEMPBANID" then
        TriggerServerEvent('SX:TempBanID', data.target, data.time, data.type, data.reason)
        notification("Execute TEMPBAN with DATABASE ID")
    elseif  data.command == "SETRANK" then
        TriggerServerEvent('SX:LevelSetID', data.target, data.level)
        notification("Execute SETLEVEL with DATABASE ID")
    elseif  data.command == "UNBAN" then
        TriggerServerEvent('SX:unbanID', data.target)
        notification("Execute UNBAN with DATABASE ID")
    elseif  data.command == "BAN" then
        TriggerServerEvent('SX:banID', data.target)
        notification("Execute BAN with DATABASE ID")
    else
        notification("Cooming soon")
    end

end)
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

-- Menu Button Monitor
local spawned = true
AddEventHandler('playerSpawned', function (spawn)
    if spawned then
        TriggerServerEvent("SX:isModeratorCheck")
    end
end)
RegisterNetEvent("SX:isModerator" )
AddEventHandler("SX:isModerator", function()
Citizen.CreateThread(function()
        while true do
            Citizen.Wait (0)
            if IsControlJustPressed(0, Config.button) then 
                SetDisplay(not display)
            end
        end
    end)
end)
function setSpawned()
    spawned = false
end
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

