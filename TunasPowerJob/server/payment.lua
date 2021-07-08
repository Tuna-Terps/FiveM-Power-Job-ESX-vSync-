--[[
___________                ___________                        
\__    ___/_ __  ____ _____\__    ___/________________  ______
  |    | |  |  \/    \\__  \ |    |_/ __ \_  __ \____ \/  ___/
  |    | |  |  /   |  \/ __ \|    |\  ___/|  | \/  |_> >___ \ 
  |____| |____/|___|  (____  /____| \___  >__|  |   __/____  >
                    \/     \/           \/      |__|       \/

🐟❤️ PoWeR Job - created by Tuna Terps; If you enjoyed, go ahead and check out some of my other work ! 
https://github.com/Tuna-Terps
https://www.youtube.com/channel/UCqoEtIuzJc3PGk9YX6kslNw
🐟 ❤️
]]--


ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('grid:pay')
AddEventHandler('grid:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            local randomMoney = math.random(3500,7000)
            xPlayer.addMoney(randomMoney)
            local cash = xPlayer.getMoney()
		if randomMoney > 7000 then
			print(source.identifier .. "may be cheating ....")
			return
		end
            TriggerClientEvent('banking:updateCash', _source, cash)
            TriggerClientEvent('esx:showNotification', _source,'You were paid $'.. randomMoney)
        end
end)

RegisterNetEvent('grid:verify')
AddEventHandler('grid:verify', function()
    local _source = source
    local e = "thermal_charge"
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        local item = xPlayer.getInventoryItem(e)["count"]
        if item > 0 then
            TriggerClientEvent('esx:showNotification', _source,'Beginning Sabotage ...')
            xPlayer.removeInventoryItem(e, 1)
	    TriggerClientEvent("grid:sabotage", _source)
            return
        else
            TriggerClientEvent('esx:showNotification', _source,'You need more explosives ...')
            return
        end
    end
end)