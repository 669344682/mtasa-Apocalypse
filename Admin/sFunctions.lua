--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Admin/sFunctions.lua))

function getAdminLevel(player)
	local plevel=getData(player,"AdminLvL")
	if(not plevel or plevel==nil)then
		return 0
	end	
	return tonumber(plevel)
end



function saveUserdata_Func(player)
local onlineplayercount=0
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=4)then
			for _,v in ipairs(getElementsByType("player"))do
				savePlayerData(v)
				onlineplayercount=onlineplayercount+1
			end
			triggerClientEvent(player,"draw:infobox",root,"info","Saved player data! ("..onlineplayercount.." players)")
		end
	end
end
addCommandHandler("sud",saveUserdata_Func)

local function gotoXYZ_Func(player,cmd,x,y,z)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=4)then
			if(x and y and z)then
				setElementPosition(player,tonumber(x),tonumber(y),tonumber(z))
			end
		end
	end
end
addCommandHandler("xyz",gotoXYZ_Func)


function adminList(player)
	if(getElementData(player,"Loggedin")==1)then
		for i,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"Loggedin")==1)then
				if(tonumber(getData(v,"AdminLvL"))>=1)then
					outputChatBox(getPlayerName(v)..", "..settings.admin.colorToHASH[getData(v,"AdminLvL")]..""..settings.admin.levelnames[getData(v,"AdminLvL")],player,255,255,255,true)
				end
			end
		end
	end
end
addCommandHandler("admins",adminList)
addCommandHandler("team",adminList)


function createLootBox(player,cmd,priority)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=4 and(not client or client==player))then
			if(priority)then
				local x,y,z=getElementPosition(player)
				local rx,ry,rz=getElementRotation(player)
				local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE Lootbox=Lootbox","Lootbox","Counter"),-1)[1]["Lootbox"]
				dbExec(handler,"UPDATE ?? SET ??=?","Counter","Lootbox",IDcounter+1)
				
				Loot[IDcounter]=createObject(2969,x,y,z-0.9,0,0,rz)
				setElementData(Loot[IDcounter],"loot",true)
				setElementData(Loot[IDcounter],"lootID",IDcounter)
				
				dbExec(handler,"INSERT INTO Lootitems (ID,SpawnX,SpawnY,SpawnZ,RotZ,LootPriority) VALUES (?,?,?,?,?,?)",IDcounter,x,y,z-0.9,rz,priority)
			end
		end
	end
end
addCommandHandler("createlootbox",createLootBox)

function createVehicleOnMap(player,cmd,vehid,fuel)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=4 and(not client or client==player))then
			if(vehid)then
				if(fuel)then
					local x,y,z=getElementPosition(player)
					local rx,ry,rz=getElementRotation(player)
					if(x and y and z)then
						local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE Vehicle=Vehicle","Vehicle","Counter"),-1)[1]["Vehicle"]
						dbExec(handler,"UPDATE ?? SET ??=?","Counter","Vehicle",IDcounter+1)
						
						Vehicles[IDcounter]=createVehicle(vehid,x,y,z,rx,ry,rz,"")
						setElementData(Vehicles[IDcounter],"VehicleID",IDcounter)
						setElementData(Vehicles[IDcounter],"Fuel",fuel)
						setElementHealth(Vehicles[IDcounter],1000)
						setVehicleOverrideLights(Vehicles[IDcounter],1)
						
						dbExec(handler,"INSERT INTO Vehicles (ID,VehID,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,Fuel,Health) VALUES ('"..IDcounter.."','"..vehid.."','"..x.."','"..y.."','"..z.."','"..rx.."','"..ry.."','"..rz.."','"..fuel.."','1000')")
					end
				end
			end
		end
	end
end
addCommandHandler("createveh",createVehicleOnMap)




function giveLevel(player,cmd,kplayer,typ,amount)
	if(getElementData(player,"Loggedin")==1)then
		if(kplayer)then
			if(tonumber(getData(player,"AdminLvL"))>=4 and(not client or client==player))then
				local target=getPlayerFromName(kplayer)
				if(isElement(target)and getElementData(target,"Loggedin")==1)then
					if(#amount>=1)then
						if(typ=="admin")then
							triggerClientEvent(player,"draw:infobox",root,"success","You gave "..getPlayerName(target).." adminlevel "..amount..".")
							
							setData(target,"AdminLvL",amount)
						elseif(typ=="premium")then
							--if(not(isPremium(target)))then
								triggerClientEvent(player,"draw:infobox",root,"success","You gave "..getPlayerName(target).." premiumhours "..amount..".")
								
								setData(target,"AdminLvL",amount)
								dbExec(handler,"INSERT INTO ?? (Username,STime) VALUES ('"..getPlayerName(target).."','"..getSecTime(amount).."')","Userpremium")
							--end
						end
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","The target player is offline!")
				end
			end
		end
	end
end
addCommandHandler("level",giveLevel)

function rKick(player,cmd,kplayer,...)
	if(getElementData(player,"Loggedin")==1)then
		if(kplayer)then
			if(...)then
				if(tonumber(getData(player,"AdminLvL"))>=1 and(not client or client==player))then
					local target=getPlayerFromName(kplayer)
					if(isElement(target)and getElementData(target,"Loggedin")==1)then
						if(getAdminLevel(player)<getAdminLevel(target))then
							triggerClientEvent(player,"draw:infobox",root,"error","This player has higher rank than you!")
							return
						end
						outputChatBox("[INFO]: The player "..getPlayerName(target).." was kicked by "..getPlayerName(player).."! Reason: "..stringTextWithAllParameters(...).."",root,255,0,0)
						takeAllWeapons(target)
						kickPlayer(target,player,stringTextWithAllParameters(...))
					else
						triggerClientEvent(player,"draw:infobox",root,"error","The target player is offline!")
					end
				end
			end
		end
	end
end
addCommandHandler("rkick",rKick)

function rBan(player,cmd,kplayer,...)
	if(getElementData(player,"Loggedin")==1)then
		if(kplayer)then
			if(...)then
				if(tonumber(getData(player,"AdminLvL"))>=2 and(not client or client==player))then
					local target=getPlayerFromName(kplayer)
					if(isElement(target)and getElementData(target,"Loggedin")==1)then
						if(getAdminLevel(player)<getAdminLevel(target))then
							triggerClientEvent(player,"draw:infobox",root,"error","This player has higher rank than you!")
							return
						end
						outputChatBox("[INFO]: The player "..getPlayerName(target).." was banned by "..getPlayerName(player).."! Reason: "..stringTextWithAllParameters(...).." Time: Permanently",root,255,0,0)
						dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","Bans","Target","Admin","Reason","Serial",getPlayerName(target),getPlayerName(player),stringTextWithAllParameters(...),getPlayerSerial(target))
						takeAllWeapons(target)
						kickPlayer(target,player,stringTextWithAllParameters(...).." (banned!)" )
					else
						local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Userdata","Username",kplayer),-1)
						if(result and result[1])then
							local serial=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","Userdata","Username",kplayer),-1)[1]["Serial"]
							dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","Bans","Target","Admin","Reason","Serial",kplayer,getPlayerName(player),stringTextWithAllParameters(...),serial)
							outputChatBox("The player has been banned! (offline)",player,255,0,0)
						else
							triggerClientEvent(player,"draw:infobox",root,"error","The player does not exist!")
						end
					end
				end
			end
		end
	end
end
addCommandHandler("rban",rBan)

function unBan(player,cdm,kplayer)
	if(getElementData(player,"Loggedin")==1)then
		if(kplayer)then
			if(tonumber(getData(player,"AdminLvL"))>=3 and(not client or client==player))then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Bans","Target",kplayer),-1)
				if(result and result[1])then
					dbExec(handler,"DELETE FROM ?? WHERE ??=?","Bans","Target",kplayer)
					outputChatBox(getPlayerName(player).." has ".. kplayer.." unbanned!",root,255,0,0)
				else
					triggerClientEvent(player,"draw:infobox",root,"error","The player is not banned!")
				end
			end
		end
	end
end
addCommandHandler("unban",unBan)