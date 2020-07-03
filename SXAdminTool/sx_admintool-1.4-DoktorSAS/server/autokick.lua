RegisterServerEvent("SX:AFK")
AddEventHandler("SX:AFK", function()
	DropPlayer(source, "You were AFK for too long.")
end)
pingLimit = Config.PingLimit
RegisterServerEvent("SX:CheckPing")
AddEventHandler("SX:CheckPing", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Ping is too high (Limit: " .. pingLimit .. " Your Ping: " .. ping .. ")")
	end
end)