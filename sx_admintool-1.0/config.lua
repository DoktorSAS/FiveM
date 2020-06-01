--[[ 
    Code Developed by DoktorSAS - Join in Sorex Discord To Report Any BUGS
    Version 1.0
    Description: This is a simple tool to manage lobby withoy any dependence, you can use it but u have to import the SQL file
                 in your database. There a few simple commands for admin and a few for users. I also made a spawnmanager able to
                 respawn player in his last position and if he joined for the frist time he get teleported to the HUB/Spawn. When
                 player die he  get automaticaly respawned to the hospital.
    How to use it?
    To give to somone perms for now you have to change sx_group into the DataBase where you see sx_group. To ban player the
    mod have to say in chat /ban {playername or ID} reason ,to kick mod have to say in chat /kick {playername or ID} reason ,to
    make an announce mod have to say in chat /announce message

    PS: This is the Version 1.0 thats why don't have a lot, this is my frist script in lua for FiveM in future i'll update it, to know
    when this mod get updated join in the Discord Server, Follow the YouTube channel or look mine github
    Discord: https://discord.io/Sorex on google, Discord.gg/nCP2y4J on discord or https://discord.com/invite/nCP2y4J
    Twitter: @SorexProject -> https://twitter.com/SorexProject
    Instagram: @SorexProject -> https://www.instagram.com/sorexproject/
    Youtube: SorexProject -> https://www.youtube.com/channel/UCP1SC3K8rg3fLAeRFlkM6cg
    
    If you want Donate to the project Donate to https://www.paypal.me/SorexProject 
]]--
Config = {}

Config.ServerName = "SXAdminTool" -- Change it and set your Server Name
Config.FristSpawnLocation = {x = 686.245,  y = 577.950, z = 130.461} -- Chaneg cords ot change Frist Spawn Zone
Config.HospitalRespawn = true -- Spawn on the hospital when player die
Config.SpawnOnDisconnectedPos = true -- When player join in he respawn in his last position
Config.FristSpawnOnHUB = true -- When player join for the frist time he get spawned on HUB Zone