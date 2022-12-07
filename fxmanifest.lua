fx_version 'cerulean'
game 'gta5'

description 'Да махнем стреса...'
version '1.0'

shared_scripts {
    '@nd-core/shared/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config.lua'
}

client_script {
    'client.lua'
}

server_script {
    'server.lua'
}
