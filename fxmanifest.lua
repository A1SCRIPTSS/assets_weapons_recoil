fx_version 'bodacious'
game 'gta5'
lua54 'yes'

description 'A highly advanced recoil script for FiveM'

client_scripts {
    'config.lua',
    'client.lua'
}

dependencies {
    'ox_inventory'
}

shared_scripts {
    '@ox_lib/init.lua'
}

server_script '@oxmysql/lib/MySQL.lua'