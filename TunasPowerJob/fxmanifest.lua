fx_version 'cerulean'
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
games { 'rdr3', 'gta5' }

author 'Tuna Terps'
description 'No POWER ? No lights !! An ESX job that requires players to maintain a power grid for the city !'
version '1.0.8'

client_script 'client/job.lua'

server_scripts {
    'server/grid.js',
    'server/payment.lua'
}

dependencies {
    "vSync"
}

server_export 'checkBl'
