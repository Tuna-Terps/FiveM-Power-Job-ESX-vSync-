Thanks for checking out my first FiveM resource ! I hope you enjoy <3

No POWER no LIGHTS - An ESX job that must be maintained by the players ! 

** REQUIREMENTS ** 

1.) vSync Weather Mod - https://forum.cfx.re/t/vsync-v1-4-0-simple-weather-and-time-sync/49710
2.) mythic progbars -https://github.com/HalCroves/mythic_progbar

** TO GET STARTED **
1.) Once downloaded, simply upload the TunasPowerJob folder into your /resource folder 

2.) In server.cfg add ensure TunasPowerJob (VSYNC MUST START BEFORE POWERJOB; SO PLACE POWERJOB BELOW IT)

3.) In your vSync mod we will make 2 additions, one in vs_server.lua & the fxmanifest.lua files (will work if youre using older __resource.lua)

3a.) add -- TunasPowerJob - Add this to vs_server.lua ------------------------------

exports('weatherCb', function(cB)
    cB = CurrentWeather
    return cB
end)

------------------------------------------------------------------------
 => to vs_server.lua

3b.) add server_export 'weatherCb'
=> to fxmanifest.lua

4.) import importthis.sql to your database

5.) add explosive.png to your esx_inventoryhud resource /html/img/

6.) Adjust the uniforms in job.lua to match desired look (refer to video to honor my existance) 
 
If done correctly; your Power Grid will be up and running !!

-
** Features **
1.) Power Job creates a grid that controls the city's power; As the power drains blackouts will become more frequent, until the grid collapses completely !
-
2.) The Power Grid must be maintained by players; there is 2 jobs set up for all players to contribute **NO JOB REQUIRED** (My reasoning is due to its importance, it should be something that everyone can contribute to without needing to switch jobs) *Doing the jobs adds to the grid's power level
-
3.) Local Grid Work - A very short job that allows players to contribute a small amount towards the grid
-
4.) Travel Grid Work - A short traveling job that allows players to contribute a larger amount towards the grid while receiving a larger payout
-
5.) The grid can also be SABOTAGED (Because why not ??) with an item called "explosive" (You will need to either add this to stores manually, or choose to spawn it etc)
-
6.) Manually add/subtract from the grid with a whitelisted command /power [add/sub] [amount]
-
**Important Locations **
1.) Grid pos - 
2.) Sabotage pos - 


Credits to https://github.com/utkuali/pacificheist-ESX- for the bomb animation Networking <3
