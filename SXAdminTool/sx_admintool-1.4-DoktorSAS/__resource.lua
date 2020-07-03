resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_script {
    'config.lua',
    '/server/server.lua',
    '/server/autokick.lua',
    '/server/tpa.lua',
    '@mysql-async/lib/MySQL.lua'
}
client_script {
    'config.lua',
    '/client/spawnmanager.lua',
    '/client/client_hub_manager.lua',
    '/client/client_commands.lua',
    '/client/sxblips.lua',
    '/client/client_tpa.lua',
    '/client/client.lua'
}

-- UI Speedometer - Remove it if you dont want it
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}
