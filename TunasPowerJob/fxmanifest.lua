fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Tuna Terps'
description 'No POWER ? No lights !! An ESX job that requires players to maintain a power grid for the city !'
version '1.0.0'

-- What to run
client_scripts {
    'client.lua',
    'client_two.lua'
}

client_script 'job.lua'

server_scripts {
    'grid.js',
    'payment.lua'
}