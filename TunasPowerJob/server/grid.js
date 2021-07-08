let ESX = null;
let powerGrid = 1000;
let blackout = false;
Wait = (ms) => new Promise(r => setTimeout(r, ms))

emit("esx:getSharedObject", (obj) => ESX = obj);

//-----------------------------------------------//events//---------------------------------------------------//

RegisterNetEvent("grid:add")
onNet('grid:add', (amount) => {
    powerGrid += amount;
    console.log(`The power grid is now at ${powerGrid} %`);
})
RegisterNetEvent("grid:sub")
onNet('grid:sub', (amount) => {
    powerGrid -= amount;
    console.log(`The power grid is now at ${powerGrid} %`);
    amount > 999 ? emitNet('esx:showNotification', -1, `💡💀 The Power Grid has been sabotaged !! 💀💡`) : emitNet('esx:showNotification', -1, `💡 *-*-The Power Grid is rapidly losing power !! 💡`);
})
// ---------------------------------//loop for electric grid//--------------------------------------------------// 

setTick(async() => {
    emitNet('esx:showNotification', -1, `💡🔋 ${powerGrid} 🔋💡`);
    await Wait(20000);
    powerGrid--
    emit('vSync:requestSync', CurrentWeather)
    let CurrentWeather = CurrentWeather;
    console.log(`${CurrentWeather} is the current weather ....`)

    //console.log(` Percentage: ${powerGrid} %`)
    await Wait(10)
    if (powerGrid >= 999){
        emitNet('esx:showNotification', -1, `💡🔋 The Power Grid is at full capacity !! 🔋💡`);
        //console.log('power grid is at full capacity !')
        var blackout = false;
        var CurrentWeather = "SMOG";
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
     //   return;
    }
    else if (powerGrid <= 700 && powerGrid >= 600 ){
        /*
        emitNet('esx:showNotification', -1, `💡🔌 The Power Grid is unstable, power surges are common !! 🔌💡`);
        blackout = true;
        CurrentWeather = "SMOG";
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        await Wait(5000)
        blackout = false;
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        */
       emitNet('esx:showNotification', -1, `💡🔌 The Power Grid is unstable, power surges are common !! 🔌💡`);
       var blackout = true;
       //CurrentWeather = "SMOG";
       emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
       await Wait(5000)
       var blackout = false;
       emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
     //   return;
    }
    else if (powerGrid <= 500 && powerGrid >= 510) {     
        emitNet('esx:showNotification', -1, `💡🔌 The city is experiencing rolling blackouts !! 🔌💡`);
        var blackout = true;
        var CurrentWeather = "SMOG";
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        await Wait(30000)
        var blackout = false;
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        await Wait(15000)
        var blackout = true;
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        await Wait(20000)
        var blackout = false;
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
     //   return;
    }
    else if (powerGrid <= 400 && powerGrid >= 100) {
        emitNet('esx:showNotification', -1, `💡🔌 The Power Grid is failing !!🔌💡`);
        var blackout = true;
        var CurrentWeather = "SMOG";
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
        await Wait(30000)
        var blackout = false;
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
     //   return;
    }
    else if (powerGrid <= 99) {
        emitNet('esx:showNotification', -1, `💡🕯️ The Power Grid has ~r~collapsed ~w~!!🕯️💡`);
        var blackout = true;
        var CurrentWeather = "SMOG";
        emitNet('vSync:updateWeather', -1, CurrentWeather, blackout)
     //   return;
    }
    //else return;
     await Wait(1000)

})

// ------------------------------------------//end of electric grid//--------------------------------------------------
/*
 ** ADD TO SERVER.CFG TO WHITELIST FOR COMMAND,  
    
    # Add this to your server cfg to allow admins/members to change the grid manually
    add_ace powerAccess mod allow 
    # for each person add this
    add_principle identifier.steam:STEAM_ID_HERE powerAccess #NameOfPerson 

 */
// test the power system

RegisterCommand('power', function(source, args){
	console.log(args[0])
    if (!args[0]) return;
    if (IsPlayerAceAllowed(source, "mod")) {
        emit('esx:showNotification', source, 'Adjusting power grid levels ....')
            if (args[0] == 'add') {
                emit('grid:add', 100);
                emit('esx:showNotification', source, 'Adjusting power grid levels ....');
               // return;
            }
            else if (args[0] == 'sub') {
                emit('grid:sub', 100);
                emit('esx:showNotification', source, 'Adjusting power grid levels ....');
              //  return;
            }
            else if (args[0] == 'sub9') {
                emit('grid:sub', 95);
                emit('esx:showNotification', source, 'Adjusting power grid levels ....');
             //   return;
            }
            /*
            else if (args[0] == 'pay') {
                emitNet('grid:pay', source);
                emit('esx:showNotification', source, 'Adjusting power grid levels ....');
             //   return;
            }
            */

        else print('you do not have the required permission ....');

    }

});

// leave this if you wish to honor my existence <3
console.log(`
:::::::::   ::::::::  :::       ::: :::::::::: :::::::::        :::::::::::  ::::::::  :::::::::                              
:+:    :+: :+:    :+: :+:       :+: :+:        :+:    :+:           :+:     :+:    :+: :+:    :+:                             
+:+    +:+ +:+    +:+ +:+       +:+ +:+        +:+    +:+           +:+     +:+    +:+ +:+    +:+                             
+#++:++#+ +:+     +:+ +#+  +#+  +:+ +#+ +:+    +#++#++:++:          +#+     +#+    +:+ +#++:++#+         
+#+        +#+    +#+ +#+ +#+#+ +#+ +#+        +#+    +#+           +#+     +#+    +#+ +#+    +#+                             
#+#        #+#    #+#  #+#+# #+#+#  #+#        #+#    #+#       #+# #+#     #+#    #+# #+#    #+#                             
###         ########    ###   ###   ########## ###    ###        #####       ########  ########\n
--------------------------------------------------------------------------------------------------------
><> Created by Tuna Terps => If you enjoy the script, go ahead and check out some of my other work <3 !
-------------------------------------------------------------------------------------------------------- 
https://github.com/Tuna-Terps
https://www.youtube.com/channel/UCqoEtIuzJc3PGk9YX6kslNw
--------------------------------------------------------------------------------------------------------`);