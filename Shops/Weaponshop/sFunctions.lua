--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY & Xendom))
--((File: Shops/Weaponshop/sFunctions.lua))

local WeaponshopTable={
	-- Name, Price, Weapon-ID, Ammo, Level, Slot
	["Colt 45"]={75,22,68,1,2},
	["Silenced"]={100,23,68,1,2},
	["Desert Eagle"]={250,24,42,1,2},
	["Shotgun"]={500,25,30,3,3},
	["Sawed-off"]={750,26,18,3,3},
	["Combat Shotgun"]={1250,27,35,4,3},
	["Uzi"]={1500,28,200,6,4},
	["Mp5"]={1800,29,120,6,4},
	["Tec-9"]={2000,32,200,7,4},
	["AK-47"]={2200,30,250,10,5},
	["M4"]={2500,31,300,12,5},
	["Rifle"]={3000,33,50,13,6},
	["Sniper"]={6000,34,25,19,6},
	["Rocket Launcher"]={10000,35,5,25,7},
	["Rocket Launcher HS"]={12500,36,5,25,7},
	["Flamethrower"]={20000,37,250,30,7},
	["Minigun"]={35000,38,1000,46,7},
	["Grenade"]={40000,16,25,50,8},
	["Molotov"]={40000,18,25,50,8},
	["Satchel"]={50000,39,30,75,8},
}

addEvent("buy:weapon",true)
addEventHandler("buy:weapon",root,function(weapon)
	if(tonumber(getData(client,"Level"))>=WeaponshopTable[weapon][4])then
		if(tonumber(getData(client,"Coins"))>=WeaponshopTable[weapon][1])then
			local handWeapon=getPedWeapon(client,WeaponshopTable[weapon][5])
			if(handWeapon and handWeapon~=WeaponshopTable[weapon][2])then
				takeWeapon(client,handWeapon)
			end
			setData(client,"Coins",tonumber(getData(client,"Coins"))-WeaponshopTable[weapon][1])
			giveWeapon(client,WeaponshopTable[weapon][2],WeaponshopTable[weapon][3],true)
			triggerClientEvent(client,"draw:infobox",root,"info","You bought the weapon.")
			triggerClientEvent(client,"refresh:weaponshop",client)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x"..WeaponshopTable[weapon][1]..")")
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","You have to be at least level "..WeaponshopTable[weapon][4].." to buy this weapon!")
	end
end)