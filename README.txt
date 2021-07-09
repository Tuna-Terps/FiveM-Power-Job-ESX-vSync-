# FiveM---Power-Job---ESX---vSync-

No POWER no LIGHTS - An ESX job that must be maintained by the players ! 

** REQUIREMENTS ** 

1.) vSync Weather Mod - https://forum.cfx.re/t/vsync-v1-4-0-simple-weather-and-time-sync/49710
2.) mythic progbars -https://github.com/HalCroves/mythic_progbar

** TO GET STARTED **
1.) Once downloaded, simply upload the TunasPowerJob folder into your /resource folder 

2.) In server.cfg add start TunasPowerJob (VSYNC MUST START BEFORE POWERJOB; SO PLACE POWERJOB BELOW IT)

3.) In your vSync mod we will make 2 additions, one in vs_server.lua & the fxmanifest.lua files (will work if youre using older __resource.lua)
3a.) add -- TunasPowerJob - Add this to vs_server.lua ------------------------------
><>
exports('weatherCb', function(cB)
    cB = CurrentWeather
    return cB
end)

------------------------------------------------------------------------
 => to sv_server.lua

3b.) add server_export 'weatherCb'
=> to fxmanifest.lua

4). Enjoy ! 
 
-
** Features **
1.) Power Job creates a grid that controls the city's power; As the power drains blackouts will become more frequent, until the grid collapses completely !
-
2.) The Power Grid must be maintrained by players; there is 2 jobs set up for all players to contribute **NO JOB REQUIRED** (My reasoning is due to its importance, it should be something that everyone can contribute to without needing to switch jobs)
-
3.) Local Grid Work - A very short job that allows players to contribute a small amount towards the grid
-
4.) Travel Grid Work - A short traveling job that allows players to contribute a larger amount towards the grid while receiving a larger payout
-
5.) The grid can also be SABOTAGED (Because why not ??) with an item called "explosives" (You will need to either add this to stores manually, or choose to spawn it etc)
-
6.) Manually add/subtract from the grid with a whitelisted command /power [add/sub] [amount]
-
**Important Locations **
1.) Grid pos - 
2.) Sabotage pos - 



