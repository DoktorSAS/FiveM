--[[ 
    Code Developed by DoktorSAS - Join in Sorex Discord To Report Any BUGS
    Version 1.4
    Description: This is a simple tool to manage lobby withoy any dependence, you can use it but u have to import the SQL file
                 in your database. There a few simple commands for admin and a few for users. I also made a spawnmanager able to
                 respawn player in his last position and if he joined for the frist time he get teleported to the HUB/Spawn. When
                 player die he  get automaticaly respawned to the hospital.
    How to use it?
    Only the owner can set rank from chat, thats mean to set owner rank you need to change sx_group on the Database

    For any info about SXAdminTool look the website Sor
    Discord: https://discord.io/Sorex on google, Discord.gg/nCP2y4J on discord or https://discord.com/invite/nCP2y4J
    Twitter: @SorexProject -> https://twitter.com/SorexProject
    Instagram: @SorexProject -> https://www.instagram.com/sorexproject/
    Youtube: SorexProject -> https://www.youtube.com/channel/UCP1SC3K8rg3fLAeRFlkM6cg
    
    If you want Donate to the project Donate to https://www.paypal.me/SorexProject 
    
    PS:
    Don't remove credits and don't try to sell the code to someone else, don't be an asshole scammer.
    I made this code to help the others, is a free tool with opensource to all
]]--
Config = {}

Config.ServerName = "SXAdminTool" -- Change it and set your Server Name
Config.FristSpawnLocation = {x = 686.245,  y = 577.950, z = 130.461} -- Chaneg cords ot change Frist Spawn Zone
Config.HospitalRespawn = true -- Spawn on the hospital when player die
Config.SpawnOnDisconnectedPos = true -- When player join in he respawn in his last position
Config.FristSpawnOnHUB = true -- When player join for the frist time he get spawned on HUB Zone
Config.SXSpawnBlip = true -- Set this to false to remove Spawn Blip on the map
Config.ranks = {user = "^7User", vip = "^3VIP", mod = "^4Mod", admin = "^6Admin", senior_admin = "^6Sr.Admin", owner = "^1Owner"} -- Edit the things inside "" to change rank name
Config.SXBlips = true -- Put it to false if you dont want use SXBlips thats mean, the command /setlanguages is off
Config.AutoKickAFK = true -- Put it to false if you dont Kick Automatically AFK Players
Config.AutoKickHighPing = true -- Put it to false if you dont Kick Automatically High Ping Players
Config.PingLimit = 800 -- This is the max ping player can reach
Config.Speedometer = true -- Put it to false dont wan't the default speedometer [Enhanced HUD]
Config.FuelManager = true -- Put it to false dont wan't the default Fuel Manager [Enhanced HUD]
Config.TPA = false -- Put it to false if you want disable the TPA commands
-- Blips Language
Language = {} 
Language.blips ={}
Language.blips['it'] = { hospital = "Ospedale", police_station = "Stazione di Poliza", fire_station = "Stazione dei Pompieri", gas_station = "Benzinaio", medical_center = "Centro Medico", repair_garage = "Meccanico", airport = "Aereoporto", bank = "Banca", shop = "Negozio", cash_machine = "Bancomat", clothing_shop = "Negozio di Vestiti", weapon_shop = "Armeria"}
Language.blips['en'] = { hospital = "Hospital", police_station = "Police Station", fire_station = "Fire Station", gas_station = "Gas Station", medical_center = "Medical Center", repair_garage = "Repair Garage", airport = "Airport", bank = "Bank", shop = "shop", cash_machine = "Cash Machine", clothing_shop = "Clothing Shop", weapon_shop = "Weapon Shop"}
-- Thanks to @Nils for translation
Language.blips['fr'] = { hospital = "Hôpital ", police_station = "Commissariat", fire_station = "Caserne de Pompiers", gas_station = "Station Services", medical_center = "Centre Médical", repair_garage = "Garage Automobile", airport = "Aéroport", bank = "Banque", shop = "Magasin", cash_machine = "Distributeur à Billets", clothing_shop = "Magasin de Vêtements", weapon_shop = "Magasin d’Armes "}
-- Thenks to @MIDARE for translation
Language.blips['gr'] = { hospital = "Krankenhaus", police_station = "Polizeiwache", fire_station = "Feuerwehr", gas_station = "Tankstelle", medical_center = "medizinisches Zentrum", repair_garage = "Autowerkstatt", airport = "Flughafen", bank = "Bank", shop = "Geschäft", cash_machine = "Geldautomat", clothing_shop = "Klamottenladen", weapon_shop = "Waffenladen"}
-- Thanks to @Quxxa for translation
Language.blips['esp'] = { hospital = "Hospital", police_station = "Estacion De Policia", fire_station = "Estacion De Bomberos", gas_station = "Gasolinera", medical_center = "Centro Medico", repair_garage = "Taller De Reparacion", airport = "Aeropuerto", bank = "Banco", shop = "Tienda", cash_machine = "Cajero Automatico", clothing_shop = "Tienda De Ropa", weapon_shop = "Tienda De Armas"}
-- Thenks to @MIDARE for translation
Language.blips['ru'] = { hospital = "больница", police_station = "Полицейский участок", fire_station = "Пожарная часть", gas_station = "Заправка", medical_center = "медицинский центр", repair_garage = "Автосервис", airport = "аэропорт", bank = "банк", shop = "магазин", cash_machine = "банкомат", clothing_shop = "Магазин одежды", weapon_shop = "Оружейный магазин"}
-- Thenks to @wrizh for translation
Language.blips['du'] = { hospital = "Ziekenhuis", police_station = "Politie bureau", fire_station = "Brandweer Kazerne", gas_station = "Tank Station", medical_center = "Ziekenhuis", repair_garage = "Auto Monteur", airport = "Vliegveld", bank = "Bank", shop = "Winkel", cash_machine = "Geld Automaat", clothing_shop = "Kleding Winkel", weapon_shop = "Wapen Winkel"}
-- Thenks to @TheKingDragons for translation
Language.blips['np'] = { hospital = "Spital", police_station = "Stazion e polizì", fire_station = "Pompieri", gas_station = "O Benzinaro", medical_center = "Centro Medico", repair_garage = "O Meccanic", airport = "Aeropuort", bank = "A banc", shop = "A puteca", cash_machine = "O Bancomat", clothing_shop = "A puteca e  Vestit", weapon_shop = "Armeria"}
