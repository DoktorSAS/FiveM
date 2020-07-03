-- Respawn on Death to the Hospital

-- 6 Hospitl BLIP
local hospital = {x = -497.389,  y = -336.232, z = 34.501}
local hospital_pillbox  = {x = 361.411,  y = -591.243, z = 28.664}
local hospital_los_santos  = {x = 342.917,  y = -1397.866, z = 32.509}
local hospital_medical_center  = {x = -677.934,  y = 308.519, z = 83.084}
local hospital_st_fiacre  = {x = 1152.722,  y = -1525.368, z = 34.843}
local hospital_sandy_shores  = {x = 1839.321,  y = 3671.834, z = 34.276}

-- Death monitor
Citizen.CreateThread(function()
	-- main loop thing
	death = false
	alreadyDead = false
	while true and Config.HospitalRespawn do
        Citizen.Wait(1)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			death = true
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
			if death then
				death = false
				notification("~w~Now you are at the ~b~Hospital ¦")
				r = math.random(1,6)
				if r == 1 then
					SetEntityCoords(GetPlayerPed(-1), hospital.x, hospital.y, hospital.z)
				elseif r == 2 then
					SetEntityCoords(GetPlayerPed(-1), hospital_pillbox.x, hospital_pillbox.y, hospital_pillbox.z)
				elseif r == 3 then
					SetEntityCoords(GetPlayerPed(-1), hospital_los_santos.x, hospital_los_santos.y, hospital_los_santos.z)
				elseif r == 4 then
					SetEntityCoords(GetPlayerPed(-1), hospital_medical_center.x, hospital_medical_center.y, hospital_medical_center.z)
				elseif r == 5 then
					SetEntityCoords(GetPlayerPed(-1), hospital_st_fiacre.x, hospital_st_fiacre.y, hospital_st_fiacre.z)
				elseif r == 6 then
					SetEntityCoords(GetPlayerPed(-1), hospital_sandy_shores.x, hospital_sandy_shores.y, hospital_sandy_shores.z)
				else
					print("^7[^5SXAdmin^7]^7 Something go wrong with Hospitl Teleport^7")
				end
			end
		end
	end
end)
-- Spawn Monitor
AddEventHandler('playerSpawned', function (spawn)
	local p = PlayerId()
	print("^7[^5SXAdmin^7]^7 "..GetPlayerName(p) .. " ^3spawned^7")
	TriggerServerEvent("SX:Spawn", GetPlayerName(p))
end)
RegisterNetEvent('SX:Teleport_to_spawn')
AddEventHandler('SX:Teleport_to_spawn', function ()
	local p = PlayerId()
	print("^7[^5SXAdmin^7]^7 "..GetPlayerName(p) .. "  ^3Moved to the spawn^7")
	notification("~w~Teleported to the ~B~"..Config.ServerName.." ~w~Spawn")
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), Config.FristSpawnLocation.x, Config.FristSpawnLocation.y, Config.FristSpawnLocation.z + 2)
end)
RegisterNetEvent('SX:Teleport_to_cords', posx, posy ,posz)
AddEventHandler('SX:Teleport_to_cords', function (posx,posy,posz)
	local p = PlayerId()
	print("^7[^5SXAdmin^7]^7 "..GetPlayerName(p).. "  ^3Moved to the last pos^7")
	notification("~w~Teleported to the Last Position")
	Citizen.Wait(1500)
	SetEntityCoords(GetPlayerPed(-1), tonumber(posx), tonumber(posy), tonumber(posz) + 2)
end)
function notification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end