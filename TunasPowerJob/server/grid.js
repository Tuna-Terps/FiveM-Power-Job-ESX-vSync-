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

let ESX = null;
let powerGrid = 1000;
let blackout = false;
Wait = (ms) => new Promise(r => setTimeout(r, ms))

//emit("esx:getSharedObject", (obj) => ESX = obj);

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
    amount > 999 ? emitNet('esx:showNotification', -1, `💡💀 The Power Grid has been sabotaged !! 💀💡`) : emitNet('esx:showNotification', -1, `💡 The Power Grid is rapidly losing power 💡`);
})
// ---------------------------------//loop for electric grid//--------------------------------------------------// 

setTick(async() => {
    emitNet('esx:showNotification', -1, `💡🔋 ${powerGrid} 🔋💡`);
    await Wait(20000);
    powerGrid--
    let cW = exports.vSync.weatherCb()
    //console.log(`${cW} is the current weather ....`)
    //console.log(` Percentage: ${powerGrid} %`)
    await Wait(10)
    if (powerGrid >= 999){
        emitNet('esx:showNotification', -1, `💡🔋 The Power Grid is at full capacity !! 🔋💡`);
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, false)})   
    }
    else if (powerGrid <= 700 && powerGrid >= 600 ){
        emitNet('esx:showNotification', -1, `💡🔌 The Power Grid is unstable, power surges are common !! 🔌💡`);
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, true)})
        await Wait(5000)
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, false)})  
    }
    else if (powerGrid <= 500 && powerGrid >= 510) {     
        emitNet('esx:showNotification', -1, `💡🔌 The city is experiencing rolling blackouts !! 🔌💡`);
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, true)})
        await Wait(30000)
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, false)}) 
        await Wait(15000)
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, true)})
        await Wait(20000)
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, false)})  
    }
    else if (powerGrid <= 400 && powerGrid >= 100) {
        emitNet('esx:showNotification', -1, `💡🔌 The Power Grid is failing !!🔌💡`);
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, true) })  
        await Wait(30000)
        setImmediate(() => {emitNet('vSync:updateWeather', -1, cW, false) })  
    }
    else if (powerGrid <= 99) {
        emitNet('esx:showNotification', -1, `💡🕯️ The Power Grid has ~r~collapsed ~w~!!🕯️💡`);
        setImmediate(() => { emitNet('vSync:updateWeather', -1, cW, true) })
    }
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

RegisterCommand('power', function(source, args, a){
    a = parseInt(args[1], 10)
    if (!args[0]) return;
    if (isNaN(a)) return print('invalid argument, must be a number ....')
    if (IsPlayerAceAllowed(source, "mod")) {
        emit('esx:showNotification', source, 'Adjusting power grid levels ....')
        if (args[0] == 'add') {
            emit('grid:add', a);
            emitNet('esx:showNotification', source, 'Adjusting power grid levels ....');
        }
        else if (args[0] == 'sub') {
            emit('grid:sub', a);
            emitNet('esx:showNotification', source, 'Adjusting power grid levels ....');
        }
    else return print('you do not have the required permission ....');
    }
});

