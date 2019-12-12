--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Damage/sFunctions.lua))

local gunsPickup={}
local LootRespawnTime=1

local weaponPickupIDS={
[24]=348,
[25]=349,
[27]=351,
[28]=352,
[29]=353,
[30]=355,
[31]=356,
[33]=357,
}

local bodybarts={
[3]="Torso",
[4]="Ass",
[5]="Left Arm",
[6]="Right Arm",
[7]="Left Leg",
[8]="Right Leg",
[9]="Head",
}

function wastedPlayer(ammo,attacker,weapon,bodypart)
	local x,y,z=getElementPosition(source)
	local weapon=getPedWeapon(source)
	local ammo=getPedTotalAmmo(source)
	
	if(weaponPickupIDS[weapon])then
		if(isElement(gunsPickup[source]))then
			destroyElement(gunsPickup[source])
		end
		gunsPickup[source]=createPickup(x,y,z,3,weaponPickupIDS[weapon],50)
		setElementData(gunsPickup[source],"weapon",weapon)
		setElementData(gunsPickup[source],"ammo",ammo)
		
		addEventHandler("onPickupHit",gunsPickup[source],function(player)
			if(not(isPedDead(player)))then
				local waffe=getElementData(source,"weapon")
				local munition=getElementData(source,"ammo")
				giveWeapon(player,waffe,munition,true)
				destroyElement(source)
				triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a gun!")
			end
		end)
	end
	
	local rdmEXP=math.random(30,80)
	if(attacker and attacker~=source and getElementType(attacker)=="player")then
		setData(attacker,"Kills",tonumber(getData(attacker,"Kills"))+1)
		setData(attacker,"EXP",tonumber(getData(attacker,"EXP"))+rdmEXP)
		uLevel(attacker)
		setPlayerAchievment(attacker,"FirstPlayerKill","First Player Kill!",300)
	end
	setData(source,"Deaths",tonumber(getData(source,"Deaths"))+1)
	
	
	if(isPedInVehicle(source))then
		removePedFromVehicle(source)
	end
	setElementDimension(source,0)
	setElementInterior(source,0)
	
	if(tonumber(getData(source,"AdminLvL"))>=1)then
		triggerClientEvent(source,"open:hospitalUI",source,25)
		setData(source,"Hospitaltime",25)
	else
		triggerClientEvent(source,"open:hospitalUI",source,60)
		setData(source,"Hospitaltime",60)
	end
	
	setElementData(source,"adminduty",false)
end
addEventHandler("onPlayerWasted",root,wastedPlayer)


addEvent("trigger:damage",true)
addEventHandler("trigger:damage",root,function(attacker,weapon,bodypart,loss,player)
	if(attacker and weapon and bodypart and loss)then
		if(weapon==34 and bodypart==9)then
			if(getElementData(player,"adminduty")==true)then
				return false
			end
			if(getElementData(player,"Savezone")==1)then
				return false
			end
			if(getElementData(attacker,"Savezone")==1)then
				return false
			end
			gotLastHit[player]=getTickCount()
			gotLastHit[attacker]=getTickCount()
			
			setPedHeadless(player,true)
			killPed(player,attacker,weapon,bodypart)
		else
			if(getElementData(player,"adminduty")==true)then
				return false
			end
			if(getElementData(player,"Savezone")==1)then
				return false
			end
			if(getElementData(attacker,"Savezone")==1)then
				return false
			end
			gotLastHit[player]=getTickCount()
			gotLastHit[attacker]=getTickCount()
			
			local basicDMG=(weaponDamageTable[weapon] and weaponDamageTable[weapon][bodypart]or 1)	
			if(bodypart==9)then
				multiply=1.3
			else
				multiply=1
			end
			
			if(weaponDamageTable[weapon][bodypart])then
				damagePlayer(player,basicDMG*multiply,attacker,weapon)
				setData(attacker,"Damage",tonumber(getData(attacker,"Damage"))+basicDMG)
			else
				damagePlayer(player,loss,attacker,weapon)
			end
		end
		
	end
end)

addEvent("spawn:hospital",true)
addEventHandler("spawn:hospital",root,function()
	setCameraTarget(client,client)
	
	spawnPlayer(client,1-2655.2,638.7,14.5,180,getData(client,"SkinID"),0,0)
	
	gotLastHit[client]=0
	
	setPedHeadless(client,false)
	setElementHealth(client,50)
end)


local pickupDestroyTimer={}
addEventHandler("onPedWasted",root,function(ammo,attacker,weapon,bodypart)
	if(getElementData(source,"zombie")and getElementData(source,"zombie")==true)then
		if(attacker and getData(attacker,"ZombieKills"))then
			local x,y,z=getElementPosition(source)
			local zombCoinsPerKill=math.random(9,20)
			local zombCoinsPerKillPremium=math.random(15,29)
			local zombExpPerKill=math.random(9,20)
			local zombExpPerKillPremium=math.random(15,29)
			
			if(isPremium(attacker))then
				setData(attacker,"Coins",tonumber(getData(attacker,"Coins"))+zombCoinsPerKillPremium)
				setData(attacker,"EXP",tonumber(getData(attacker,"EXP"))+zombExpPerKillPremium)
			else
				setData(attacker,"Coins",tonumber(getData(attacker,"Coins"))+zombCoinsPerKill)
				setData(attacker,"EXP",tonumber(getData(attacker,"EXP"))+zombExpPerKill)
			end
			setData(attacker,"ZombieKills",tonumber(getData(attacker,"ZombieKills"))+1)
			uLevel(attacker)
			
			setPlayerAchievment(attacker,"FirstZombieKill","First Zombie kill!",500)
			if(getData(attacker,"ZombieKills")>=1000)then
				setPlayerAchievment(attacker,"1000ZombieKills","Over 1000 Zombie kills!",2000)
			end
			if(getData(attacker,"ZombieKills")>=10000)then
				setPlayerAchievment(attacker,"10000ZombieKills","Over 10000 Zombie kills!",4500)
			end
			
			
			if(getPedSkin(source)==277)then
				createExplosion(x,y,z,3)
				setData(attacker,"Coins",tonumber(getData(attacker,"Coins"))+11)
				setData(attacker,"EXP",tonumber(getData(attacker,"EXP"))+zombExpPerKill*2)
				uLevel(attacker)
			end
			
			if(getPedSkin(source)==70)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1240,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
								setData(attacker,"FirstAidKit",tonumber(getData(attacker,"FirstAidKit"))+1)
							destroyElement(source)
							triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a First Aid Kit!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==195)then
				local rdm=math.random(1,8)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1279,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local rdmItem=math.random(1,500)
							if(rdmItem>=1 and rdmItem<=130)then
								setData(attacker,"Pizza",tonumber(getData(attacker,"Pizza"))+1)
							elseif(rdmItem>=131 and rdmItem<=180)then
								setData(attacker,"Pepsi",tonumber(getData(attacker,"Pepsi"))+1)
							elseif(rdmItem>=181 and rdmItem<=500)then
							end
							destroyElement(source)
							triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a Item!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==155)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1279,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local rdmItem=math.random(1,500)
							if(rdmItem>=1 and rdmItem<=130)then
								setData(attacker,"Pizza",tonumber(getData(attacker,"Pizza"))+1)
							elseif(rdmItem>=131 and rdmItem<=180)then
								setData(attacker,"Pepsi",tonumber(getData(attacker,"Pepsi"))+1)
							elseif(rdmItem>=181 and rdmItem<=300)then
								setData(attacker,"Repairkit",tonumber(getData(attacker,"Repairkit"))+1)
							end
							destroyElement(source)
							triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a Item!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==287)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					setData(attacker,"Coins",tonumber(getData(attacker,"Coins"))+2)
					local number=math.random(1,999)
					if(number>=1 and number<=400)then--M4
						local rdmAmmo=math.random(200,320)
						weaponID=31
						weaponAmmo=rdmAmmo
						weaponPickupID=356
					elseif(number>=401 and number<=650)then--Rocket
						local rdmAmmo=math.random(8,16)
						weaponID=35
						weaponAmmo=rdmAmmo
						weaponPickupID=359
					elseif(number>=561 and number<=700)then--Minigun
						local rdmAmmo=math.random(40,190)
						weaponID=38
						weaponAmmo=rdmAmmo
						weaponPickupID=362
					elseif(number>=701 and number<=800)then--Deagle
						local rdmAmmo=math.random(40,120)
						weaponID=24
						weaponAmmo=rdmAmmo
						weaponPickupID=348
					elseif(number>=801 and number<=999)then--Colt45
						local rdmAmmo=math.random(70,170)
						weaponID=22
						weaponAmmo=rdmAmmo
						weaponPickupID=346
					end
					
					local pickup=createPickup(x,y,z,3,weaponPickupID,50)
					setElementData(pickup,"weaponID",weaponID)
					setElementData(pickup,"weaponAmmo",weaponAmmo)
					
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local weapon=getElementData(source,"weaponID")
							local ammo=getElementData(source,"weaponAmmo")
							giveWeapon(player,weapon,ammo,true)
							triggerClientEvent(player,"draw:infobox",root,"info","You have picked up a gun\nwith x"..ammo.." Ammo!")
							destroyElement(source)
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
		end
	end
end)