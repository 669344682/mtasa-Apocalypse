--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Weapon/sFunctions.lua))

addEventHandler("onResourceStart",root,function()
	--((Colt))
	setWeaponProperty("colt 45","poor","maximum_clip_ammo",10)
    setWeaponProperty("colt 45","std","maximum_clip_ammo",10)
    setWeaponProperty("colt 45","pro","maximum_clip_ammo",10)
	setWeaponProperty("colt 45","poor","weapon_range",35)
    setWeaponProperty("colt 45","std","weapon_range",35)
    setWeaponProperty("colt 45","pro","weapon_range",35)
	--((Silenced))
	setWeaponProperty("silenced","poor","maximum_clip_ammo",10)
    setWeaponProperty("silenced","std","maximum_clip_ammo",10)
    setWeaponProperty("silenced","pro","maximum_clip_ammo",10)
	setWeaponProperty("silenced","poor","weapon_range",40)
    setWeaponProperty("silenced","std","weapon_range",40)
    setWeaponProperty("silenced","pro","weapon_range",40)
	--((Deagle))
	setWeaponProperty("deagle","poor","maximum_clip_ammo",10)
    setWeaponProperty("deagle","std","maximum_clip_ammo",10)
    setWeaponProperty("deagle","pro","maximum_clip_ammo",10)
	setWeaponProperty("deagle","poor","weapon_range",50)
    setWeaponProperty("deagle","std","weapon_range",50)
    setWeaponProperty("deagle","pro","weapon_range",50)
	--((Shotgun))
	setWeaponProperty("shotgun","poor","weapon_range",35)
    setWeaponProperty("shotgun","std","weapon_range",35)
    setWeaponProperty("shotgun","pro","weapon_range",35)
	--((Sawed-off))
	setWeaponProperty("sawed-off","poor","weapon_range",20)
    setWeaponProperty("sawed-off","std","weapon_range",20)
    setWeaponProperty("sawed-off","pro","weapon_range",20)
	--((Combat Shotgun))
	setWeaponProperty("combat shotgun","poor","maximum_clip_ammo",9)
    setWeaponProperty("combat shotgun","std","maximum_clip_ammo",9)
    setWeaponProperty("combat shotgun","pro","maximum_clip_ammo",9)
	setWeaponProperty("combat shotgun","poor","weapon_range",27)
    setWeaponProperty("combat shotgun","std","weapon_range",27)
    setWeaponProperty("combat shotgun","pro","weapon_range",27)
	--((UZI))
	setWeaponProperty("uzi","poor","maximum_clip_ammo",35)
    setWeaponProperty("uzi","std","maximum_clip_ammo",35)
    setWeaponProperty("uzi","pro","maximum_clip_ammo",35)
	setWeaponProperty("uzi","poor","weapon_range",35)
    setWeaponProperty("uzi","std","weapon_range",35)
    setWeaponProperty("uzi","pro","weapon_range",35)
	--((MP5))
	setWeaponProperty("mp5","poor","maximum_clip_ammo",35)
    setWeaponProperty("mp5","std","maximum_clip_ammo",35)
    setWeaponProperty("mp5","pro","maximum_clip_ammo",35)
	setWeaponProperty("mp5","poor","weapon_range",65)
    setWeaponProperty("mp5","std","weapon_range",65)
    setWeaponProperty("mp5","pro","weapon_range",65)
	--((TEC9))
	setWeaponProperty("tec-9","poor","maximum_clip_ammo",100)
    setWeaponProperty("tec-9","std","maximum_clip_ammo",100)
    setWeaponProperty("tec-9","pro","maximum_clip_ammo",100)
	setWeaponProperty("tec-9","poor","weapon_range",57)
    setWeaponProperty("tec-9","std","weapon_range",57)
    setWeaponProperty("tec-9","pro","weapon_range",57)
	--((AK))
	setWeaponProperty("ak-47","poor","maximum_clip_ammo",35)
    setWeaponProperty("ak-47","std","maximum_clip_ammo",35)
    setWeaponProperty("ak-47","pro","maximum_clip_ammo",35)
	setWeaponProperty("ak-47","poor","weapon_range",200)
    setWeaponProperty("ak-47","std","weapon_range",200)
    setWeaponProperty("ak-47","pro","weapon_range",200)
	--((M4))
	setWeaponProperty("m4","poor","maximum_clip_ammo",55)
    setWeaponProperty("m4","std","maximum_clip_ammo",55)
    setWeaponProperty("m4","pro","maximum_clip_ammo",55)
	setWeaponProperty("m4","poor","weapon_range",235)
    setWeaponProperty("m4","std","weapon_range",235)
    setWeaponProperty("m4","pro","weapon_range",235)
	--((Rifle))
	setWeaponProperty("rifle","poor","maximum_clip_ammo",5)
    setWeaponProperty("rifle","std","maximum_clip_ammo",5)
    setWeaponProperty("rifle","pro","maximum_clip_ammo",5)
	setWeaponProperty("rifle","poor","weapon_range",420)
    setWeaponProperty("rifle","std","weapon_range",420)
    setWeaponProperty("rifle","pro","weapon_range",420)
	--((Sniper))
	setWeaponProperty("sniper","poor","maximum_clip_ammo",8)
    setWeaponProperty("sniper","std","maximum_clip_ammo",8)
    setWeaponProperty("sniper","pro","maximum_clip_ammo",8)
	setWeaponProperty("sniper","poor","weapon_range",450)
    setWeaponProperty("sniper","std","weapon_range",450)
    setWeaponProperty("sniper","pro","weapon_range",450)
end)

function riflereload()
	if(isPedDucked(source))then
		setPedAnimation(source,"RIFLE","RIFLE_crouchload",-1,false,false,false,false)
	else
		setPedAnimation(source,"RIFLE","RIFLE_load",-1,false,false,false,false)
	end
end 
addEvent("reload:rifle",true)
addEventHandler("reload:rifle",root,riflereload)