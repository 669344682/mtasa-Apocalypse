--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Weapon/cFunctions.lua))

function reloadCustomWeapon(weapon,ammo,ammoclip) 
	if(weapon==33 or weapon==34 and ammoclip==0)then 
		triggerServerEvent("reload:rifle",lp)
	end 
end 
addEventHandler("onClientPlayerWeaponFire",lp,reloadCustomWeapon) 