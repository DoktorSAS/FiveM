resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_script {
    'config.lua',
    '/server/server.lua',
    '@mysql-async/lib/MySQL.lua'
}
client_script {
    'config.lua',
    '/client/spawnmanager.lua',
    '/client/client_hub_manager.lua',
    '/client/client_commands.lua',
    '/client/sxblips.lua',
    '/client/client.lua'
}

