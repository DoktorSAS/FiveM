-- TPA Commands
RegisterCommand("tpa", function(source, args)
    TriggerServerEvent("SX:TPA", args[1])
end)
TriggerEvent('chat:addSuggestion', '/tpa', 'This command is to send teleport request to another player', {
    { name="player id", help="Insert player id" },
})
RegisterCommand("tpaccept", function(source, args)
    TriggerServerEvent('SX:TPA_Accept')
end)
TriggerEvent('chat:addSuggestion', '/tpaccept', 'This command is to accept teleport request of another player', {
})
RegisterCommand("tpdeny", function(source, args)
    TriggerServerEvent('SX:TPA_Deny')
end)
TriggerEvent('chat:addSuggestion', '/tpdeny', 'This command is to refuse teleport request of another player', {
})
-- MTP -> Tp player to the Marker
RegisterCommand("mtp", function(source)
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        for height = 1, 1000 do
            TriggerServerEvent('SX:TPToMarker',PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                if foundGround then
                    TriggerServerEvent('SX:TPToMarker', PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                    break
                end
            Citizen.Wait(5)
        end
    end
end)
TriggerEvent('chat:addSuggestion', '/mtp', 'Use it to teleport to your marker', {
})

RegisterNetEvent("SX:Teleport")
AddEventHandler('SX:Teleport', function(ped,x,y,z)
    SetPedCoordsKeepVehicle(PlayerPedId(), tonumber(x), tonumber(y), tonumber(z) + 0.0)
end)