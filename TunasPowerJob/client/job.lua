--[[
___________                ___________                        
\__    ___/_ __  ____ _____\__    ___/________________  ______
  |    | |  |  \/    \\__  \ |    |_/ __ \_  __ \____ \/  ___/
  |    | |  |  /   |  \/ __ \|    |\  ___/|  | \/  |_> >___ \ 
  |____| |____/|___|  (____  /____| \___  >__|  |   __/____  >
                    \/     \/           \/      |__|       \/

???? PoWeR Job - created by Tuna Terps; If you enjoyed, go ahead and check out some of my other work ! 
https://github.com/Tuna-Terps
https://www.youtube.com/channel/UCqoEtIuzJc3PGk9YX6kslNw
?? ??
]]--

enableBlip = true -- toggle whether youd like to use this blip; or your own :)
canXL = true -- toggle whether youd like to use the third job :)

---------------------------------------------- variables -------------------------------------------
ESX = nil
player = nil
coords = {}
PlayerData = {}
local mB = nil
vC = nil

local onJob = false
local npcJob = false
local onHeist = nil
local xlJob = false

-- ---------------------------------------------- loops --------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
    	end
end)

Citizen.CreateThread(function()
    	while true do
		player = PlayerPedId()
        	coords = GetEntityCoords(player)
        	Citizen.Wait(500)
    	end
end)


if enableBlip then
    Citizen.CreateThread(function()
        local hQ = vector3(537.77, -1651.43, 29.26)
        local hB = AddBlipForCoord(hQ)
            SetBlipSprite(hB,354)
            SetBlipColour(hB,46)
            SetBlipScale(hB,1.7)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("LS D.W.P")
            EndTextCommandSetBlipName(hB)
    end)
end

jobMenu = nil
-- ------------------------------------- job menu thread ----------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local s = true
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 537.77, -1651.43, 29.26, false)
        if jobMenu ~= nil then
            while jobMenu ~= nil and dist > 1.5 do jobMenu = nil Citizen.Wait(1) end
            if jobMenu == nil then ESX.UI.Menu.CloseAll() end
        else
            if dist < 18 then
                s = false
                if dist < 13 then
                    DynaMarker(27,537.77, -1651.43, 28.3, 0.0, 0.0, 600, 100, true)
                    if dist < 1.5 then
                        DrawText3Ds(537.77, -1651.43, 29.26, "~r~[~g~E~r~]".." ~w~Open Job Menu")
                        if IsControlJustPressed(0, 38) then
                            OpenJobMenu()
                        end                          
                    end
                end
            end
        end
        if s then Citizen.Wait(1000) end
    end    
end)

-- ---------------------------------------- functions ----------------------------------------------
function OpenJobMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', TunasPowerJob, 'power_grid_menu', {
        css = 'vestiaire',
        title = 'LS POWER GRID',
        align = 'top-right',
        elements = {
        {label = 'Local Grid Work', value = 'option_grid'},
        {label = 'Travel Grid Work', value = 'option_npc'},
        {label = 'Travel Work XL', value = 'option_xl'},
        {label = 'Exit Menu', value = 'exit'},
    }
        }, function(data, menu)
        if data.current.value == 'option_grid' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJob()
            else
                print('already on the clock ..')
            end
        elseif data.current.value == 'option_npc' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJobNpc()
            	return
            else
                print('already on the clock ..')
		        return
            end
        elseif data.current.value == 'option_xl' then
            menu.close()
            ChangeClothes()
            if onJob == false then
                onJob = true
                startJobXl()
            else
		        print('~r~error: ~w~already on the clock ....')
                return
            end
        elseif data.current.value == 'exit' then
            menu.close()    
        end
	end)
end

function TorchAnim()
    local pIndex = PlayerPedId()
     Citizen.CreateThread(function()
        Wait(1000)
        TaskStartScenarioInPlace(pIndex, "WORLD_HUMAN_WELDING", 0, true)
        FreezeEntityPosition(pIndex, true)
        exports['progressBars']:startUI(15000, 'Repairing the Power Grid')
        Wait(15000)
        FreezeEntityPosition(pIndex, false)
        if onJob then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("grid:add", 5)
            TriggerServerEvent("grid:pay")
            TriggerEvent('esx:showNotification','Job Complete')
            onJob = false
            if npcJob then
                print('this is a npc job')
                TriggerServerEvent("grid:add", 10)
                FinishJob()
                npcJob = false
            end
            if xlJob and canXL then
                TriggerServerEvent("grid:add", 200)
                TriggerServerEvent("grid:pay")
                FinishJob()
                xlJob = false
                return
            end
            return
		else 
			print('youre already on the clock foh ...')
        end
    end)
end

-- -----------------------------------------local grid work----------------------------------------------

function startJob()
    local sC1 = vector3(556.96, -1610.5, 28.03)
    local n1 = false
    mB1 = AddBlipForCoord(sC1)
    SetBlipRoute(mB1, true)
    SetBlipRouteColour(mB1, 46)
    SetBlipColour(mB1, 46)
    Citizen.CreateThread(function()
        local wait = 100
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 556.96, -1610.5, 28.03, false)
            	if tDist < 20 then
                    wait = 5
                    DrawMarker(29, sC1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                    if tDist < 2 then
                    	Citizen.Wait(1000)
                    	SetBlipRoute(mB1, false)
                    	RemoveBlip(mB1)
                        GridJob()
			            n1 = true
                        return
                   end
           	end   
        end
    end)
end

function GridJob()
    local prop = GetClosestObjectOfType(537.77, -1651.43, 28.03, 100.0, GetHashKey("prop_sub_trans_01a"), false)
    local xC = GetEntityCoords(prop)
    local xV = vector3(xC)+vector3(0,0,5)
    while true do
        Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, xC.x,xC.y, xC.z, false)
        if uDist < 20 then
            DrawMarker(29, xV, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            ESX.ShowHelpNotification("Locate the nearby subframes and repair the power grid !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to repair subframe", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    TorchAnim()
                    return
                end
            end
        end
    end  
end


-- ------------------------------------travel grid work ----------------------------------

function startJobNpc()
    local p = PlayerPedId()
    local vC = vector3(571.46,-1653.56,26.85)
    local h = 105.65
    local sC2 = vector3(741.31, -1984.09, 30.05)
    local n2 = false
    ESX.Game.SpawnVehicle("burrito", vC, h , function(veh)
	Citizen.Wait(1000)
        SetVehicleLivery(veh, 4)
        SetPedIntoVehicle(p, veh, -1)
        print(veh)
        mB2 = AddBlipForCoord(sC2)
        SetBlipRoute(mB2, true)
        SetBlipRouteColour(mB2, 46)
        SetBlipColour(mB2, 46)
        Citizen.CreateThread(function()
            local wait = 100
            while not n2 do
                Citizen.Wait(wait)
                local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC2, false)
                if tDist < 20 then
                    wait = 5
                    DrawMarker(29, sC2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                    if tDist < 2 then
                        Citizen.Wait(1000)
                        SetBlipRoute(mB2, false)
                        RemoveBlip(mB2)
                        NpcJob()
			            n2 = true
                        return
                    end
                end   
            end
        end)
    end)
end


function NpcJob()
        local prop = GetClosestObjectOfType(741.31, -1984.09, 30.05, 50.0, GetHashKey("prop_sub_trans_04a"), false)
        local xCoords = GetEntityCoords(prop)
        while true do
        Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, xCoords.x,xCoords.y, xCoords.z, false)
        if uDist < 20 then
            ESX.ShowHelpNotification("Locate the nearby subframes and repair the power grid !", true, true, 5000)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to repair subframe", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    TorchAnim()
                    npcJob = true
                    return
                end
            end
        end
    end  
end

function FinishJob()
    local sC3 = vector3(571.46,-1653.56,26.85)
    local n1 = false
    local mB3 = AddBlipForCoord(sC3)
    SetBlipRoute(mB3, true)
    SetBlipRouteColour(mB3, 46)
    SetBlipColour(mB3, 46)
    Citizen.CreateThread(function()
        local wait = 100
        ESX.ShowHelpNotification("Return the vehicle to recieve an additional payment !", true, true, 5000)
        while not n1 do
            Citizen.Wait(wait)
            local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC3, false)
            if tDist < 20 then
                wait = 5
                DrawMarker(29, sC3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                if tDist < 8 then
                    local p = PlayerPedId()
                    local v = GetVehiclePedIsIn(p)
                    n1 = true
                	Citizen.Wait(1000)
                	SetBlipRoute(mB3, false)
                	RemoveBlip(mB3)
                    ESX.Game.DeleteVehicle(v)
                    TriggerServerEvent('grid:pay')
                    Citizen.Wait(1000)
                    return
                end
           end   
        end
    end)
end
-- ----------------------------------------XL Work -----------------------------------------------

function startJobXl()
    local p = PlayerPedId()
    local vC = vector3(571.46,-1653.56,26.85)
    local h = 105.65
    local sC4 = vector3(742.5, 129.95, 80.05)
    local n2 = false
    ESX.Game.SpawnVehicle("burrito", vC, h , function(veh1)
	Citizen.Wait(500)
        SetVehicleLivery(veh1, 4)
        SetPedIntoVehicle(p, veh1, -1)
        print(veh)
        local mB4 = AddBlipForCoord(sC4)
        SetBlipRoute(mB4, true)
        SetBlipRouteColour(mB4, 46)
        SetBlipColour(mB4, 46)
        Citizen.CreateThread(function()
            local wait = 100
            while not n2 do
                Citizen.Wait(wait)
                local tDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, sC4, false)
                if tDist < 20 then
                    wait = 5
                    DrawMarker(29, sC4, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
                    if tDist < 2 then
                        n2 = true
                        Citizen.Wait(1000)
                        SetBlipRoute(mB4, false)
                        RemoveBlip(mB4)
                        XlJob()
                        return
                    end
                end   
            end
        end)
    end)
end

function XlJob()
    local prop = GetClosestObjectOfType(742.5, 129.95, 80.05, 100.0, GetHashKey("prop_sub_trans_01a"), false)
    local xC3 = GetEntityCoords(prop)
    local xV2 = vector3(xC3)+vector3(0,0,5)
    while true do
        Wait(5)
        local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, xC3.x,xC3.y, xC3.z, false)
        if uDist < 25 then
            ESX.ShowHelpNotification("Locate the nearby subframes and repair the power grid !", true, true, 5000)
            DrawMarker(29, xV2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)
            if uDist < 3 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to repair subframe", true, true, 5000)
                if IsControlJustPressed(0,38) then
                    TorchAnim()
                    xlJob = true
                    return
                end
            end
        end
    end  
end
-- ----------------------------------------END OF XL----------------------------------------------


-- ----------------------------------------SABOTAGE-----------------------------------------------
sMenu = nil
RegisterNetEvent('grid:sabotage')
AddEventHandler('grid:sabotage', function()
	  Sabotage()
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local s2 = true
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 567.17, -1581.83, 28.19, false)
        if sMenu ~= nil then
            dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 567.17, -1581.83, 28.19, false)
            while sMenu ~= nil and dist > 1.5 do sMenu = nil Citizen.Wait(1) end
            if sMenu == nil then ESX.UI.Menu.CloseAll() end
        else
            if dist < 15 then
                s2 = false
                if dist < 5 then
                    if dist < 1.5 then
                        DrawText3Ds(567.17, -1581.83, 28.19, "~r~[~g~E~r~]".." ~w~Begin Sabotage")
                        if IsControlJustPressed(0, 38) then
                            	TriggerServerEvent('grid:verify')
                        end                          
                    end
                end
            end
        end
        if s2 then Citizen.Wait(2000) end
    end    
end)

function Sabotage()
    print(xCoords)
    onHeist = true
    while onHeist do
    	Wait(5)
    	local uDist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z,567.17, -1581.83, 28.19, false)
    	if uDist < 10 then
    	    ESX.ShowHelpNotification("Locate the nearby *electric panel and SABOTAGE the power grid !", true, true, 5000)
        	if uDist < 1.5 then
        		ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to plant bomb!", true, true, 5000)
            	if IsControlJustPressed(0,38) then
            		SabotageAnim()
                    onHeist = false
        		end
        	end
		end
     end    
end

function SabotageAnim()
     Citizen.CreateThread(function()
        local rotplus = 0
        print('beginning sabotage anim ...')
        local pIndex = PlayerPedId()
        RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
        while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
            Citizen.Wait(50)
        end
	    RequestAnimDict("mini@repair")
        while not HasAnimDictLoaded("mini@repair") do
            Citizen.Wait(50)
        end
        local ped = PlayerPedId()
        SetEntityHeading(pIndex, 51.46)
        Citizen.Wait(100)
        local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
        local bagscene = NetworkCreateSynchronisedScene(coords.x, coords.y, coords.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(pIndex, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(pIndex, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(bagscene)
        exports['progressBars']:startUI(4500, 'Preparing to place bomb')
	    TaskPlayAnim(player, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
	    FreezeEntityPosition(pIndex, true)
        Citizen.Wait(1500)
        local x, y, z = table.unpack(GetEntityCoords(pIndex))
        local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
        SetEntityCollision(bomb, false, true)
        AttachEntityToEntity(bomb, pIndex, GetPedBoneIndex(pIndex, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
	    Citizen.Wait(4000)
	    FreezeEntityPosition(pIndex, false)
        exports['progressBars']:startUI(12000, 'Charge has been placed !! - STAND BACK - !!')
        DetachEntity(bomb, 1, 1)
        FreezeEntityPosition(bomb, true)
        NetworkStopSynchronisedScene(bagscene)
        TaskPlayAnim(pIndex, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
        TaskPlayAnim(pIndex, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
        Citizen.Wait(2000)
        ClearPedTasks(pIndex)
        Wait(10000)
        AddExplosion(566.09, -1580.91, 28.19, 6, 10 , false, false, true, false)
        Citizen.Wait(100)
        AddExplosion(566.09, -1580.91, 28.19, 38, 10 , true, false, true, false)
        Citizen.Wait(100)
        AddExplosion(566.09, -1580.91, 28.19, 7, 10 , true, false, true, false)
        Citizen.Wait(100)
        DeleteObject(bomb)
        if onHeist then
            Citizen.Wait(5000)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent("grid:sub", 1000)
            onHeist = false
            return
        else
            ClearPedTasksImmediately(PlayerPedId())
	        TriggerServerEvent("grid:sub", 1000) 
            onHeist = false
            return
        end
        return
    end)
end

-- -------------------------------------utility ------------------------------------------------------

function DynaMarker(type,posX,posY,posZ,r,g,b,a,multi)

    if multi == true then
        -- enter
        DrawMarker(type, posX,posY,posZ, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
       -- dollar sign
        DrawMarker(29, posX,posY,posZ+2.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 500, 0, 200, false, true, 2, false, false, false, false)
    else
        -- entering/exiting zone
        DrawMarker(type, posX, posY,posZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 5.0, r, g, b, a, false, true, 2, false, false, false, false)
    end
end


function DrawMissionText(text)
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(0.5,0.955)
end


function ChangeClothes()
    TriggerEvent('esx_skin:setLastSkin', function(skin)
        LastSkin = skin
        --print(LastSkin)
    end)

    TriggerEvent('skinchanger:getSkin', function(skin)
                        -- MALE
           if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 269,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 50,
                ['pants_1'] = 48,   ['pants_2'] = 3,
                ['shoes_1'] = 66,   ['shoes_2'] = 0,
                ['helmet_1'] = 64,  ['helmet_2'] = 6,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bproof_1'] = 21,  ['bproof_2'] = 1							
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
                        -- FEMALE
            local clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 95,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 11,   ['pants_2'] = 3,
                ['shoes_1'] = 60,   ['shoes_2'] = 4,
                --['helmet_1'] = 0,  ['helmet_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bproof_1'] = 5,     ['bproof_2'] = 2
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end


-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end
-- ---------------------------------------- end of functions ----------------------------------------

