--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Inventory/sFunctions.lua))

local ItemTimerTable={}
local destroyItemPlaceTimer={}

addEvent("use:invitem",true)
addEventHandler("use:invitem",root,function(item)
	if(getElementData(client,"Loggedin")==1)then
		if(item=="Coins")then
			if(getData(client,item)>=1)then
				triggerClientEvent(client,"draw:infobox",root,"info","Coins is a currency!")
			end
		elseif(item=="FirstAidKit")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					if(getElementHealth(client)<100)then
						setData(client,item,getData(client,item)-1)
						setElementHealth(client,100)
						triggerClientEvent(client,"draw:infobox",root,"info","You used a First Aid Kit!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Pizza")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					setData(client,item,getData(client,item)-1)
					setData(client,"Hunger",tonumber(getData(client,"Hunger"))+18)
					setElementHealth(client,getElementHealth(client)+13)
					triggerClientEvent(client,"draw:infobox",root,"info","You eating a "..item.."!")
					
					if(tonumber(getData(client,"Hunger"))>=100)then
						setData(client,"Hunger",100)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Pastacan")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					setData(client,item,getData(client,item)-1)
					setData(client,"Hunger",tonumber(getData(client,"Hunger"))+24)
					setElementHealth(client,getElementHealth(client)+17)
					triggerClientEvent(client,"draw:infobox",root,"info","You eating a "..item.."!")
					
					if(tonumber(getData(client,"Hunger"))>=100)then
						setData(client,"Hunger",100)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Ravioli")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					setData(client,item,getData(client,item)-1)
					setData(client,"Hunger",tonumber(getData(client,"Hunger"))+22)
					setElementHealth(client,getElementHealth(client)+19)
					triggerClientEvent(client,"draw:infobox",root,"info","You eating a "..item.."!")
					
					if(tonumber(getData(client,"Hunger"))>=100)then
						setData(client,"Hunger",100)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Cola")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					setData(client,item,getData(client,item)-1)
					setData(client,"Thirst",tonumber(getData(client,"Thirst"))+11)
					setElementHealth(client,getElementHealth(client)+13)
					triggerClientEvent(client,"draw:infobox",root,"info","You drink a "..item.."!")
					
					if(tonumber(getData(client,"Thirst"))>=100)then
						setData(client,"Thirst",100)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Pepsi")then
			if(getData(client,item)>=1)then
				if(not gotLastHit[client]or gotLastHit[client]+settings.generel.lastHitTimer<=getTickCount())then
					setData(client,item,getData(client,item)-1)
					setData(client,"Thirst",tonumber(getData(client,"Thirst"))+13)
					setElementHealth(client,getElementHealth(client)+15)
					triggerClientEvent(client,"draw:infobox",root,"info","You drink a "..item.."!")
					
					if(tonumber(getData(client,"Thirst"))>=100)then
						setData(client,"Thirst",100)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"warning","Wait 1 minute after the last punch/shot!")
				end
			end
		elseif(item=="Bottle")then
			if(getData(client,item)>=1)then
				setData(client,item,getData(client,item)-1)
				setData(client,"Emptybottle",getData(client,"Emptybottle")+1)
				setData(client,"Thirst",tonumber(getData(client,"Thirst"))+11)
				setElementHealth(client,getElementHealth(client)+13)
				triggerClientEvent(client,"draw:infobox",root,"info","You drink a "..item.."!")
				
				if(tonumber(getData(client,"Thirst"))>=100)then
					setData(client,"Thirst",100)
				end
			end
		elseif(item=="Emptybottle")then
			if(getData(client,item)>=1)then
				if(isElementInWater(client))then
					setData(client,item,getData(client,item)-1)
					setData(client,"Bottle",getData(client,"Bottle")+1)
					triggerClientEvent(client,"draw:infobox",root,"info","You filled a Empty bottle!")
				end
			end
		elseif(item=="Jerrycan")then
			if(getData(client,item)>=1)then
				if(isPedInVehicle(client))then
					local veh=getPedOccupiedVehicle(client)
					if(tonumber(getElementData(veh,"Fuel"))<100)then
						if(not(isTimer(ItemTimerTable[client])))then
							triggerClientEvent(client,"playSound_mp3",client,"Refuel","ogg",false,0.5)
							ItemTimerTable[client]=setTimer(function(client)
								if(isPedInVehicle(client))then
									setElementData(veh,"Fuel",tonumber(getElementData(veh,"Fuel"))+25)
									setData(client,item,getData(client,item)-1)
									triggerClientEvent(client,"draw:infobox",root,"info","Vehicle successfully refueled!")
									
									if(tonumber(getElementData(veh,"Fuel"))>=100)then
										setElementData(veh,"Fuel",100)
									end
								end
							end,6*1000,1,client)
						end
					end
				end
			end
		elseif(item=="Repairkit")then
			if(getData(client,item)>=1)then
				if(not(isPedInVehicle(client)))then
					for _,v in pairs(getElementsByType("vehicle"))do
						local x,y,z=getElementPosition(v)
						local px,py,pz=getElementPosition(client)
						
						if(getDistanceBetweenPoints3D(x,y,z,px,py,pz)<=3)then
							setPedAnimation(client,"graffiti","spraycan_fire")
							setElementFrozen(v,true)
							if(not(isTimer(ItemTimerTable[client])))then
								triggerClientEvent(client,"playSound_mp3",client,"RepairVehicle","mp3",false,0.5)
								ItemTimerTable[client]=setTimer(function(client)
									setData(client,item,getData(client,item)-1)
									setPedAnimation(client)
									fixVehicle(v)
									setElementFrozen(v,false)
									triggerClientEvent(client,"draw:infobox",root,"success","Vehicle successfully repaired!")
								end,5*1000,1,client)
							end
						end
					end
				end
			end
		elseif(item=="Itemdepot")then
			if(getData(client,item)>=1)then
				if(not(isPedInVehicle(client)))then
					if(isPedOnGround(client))then
						for _,v in pairs(getElementsByType("object"))do
							if(getElementModel(v)==1271 and getElementData(v,"itemdepot"))then
								local x,y,z=getElementPosition(v)
								if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=1.5)then
									triggerClientEvent(client,"draw:infobox",root,"error","you have to keep moving away\nfrom the other itemdepot!")
									return
								end
							end
						end
						if(not(isTimer(destroyItemPlaceTimer[client])))then
							toggleAllControls(client,false)
							setElementFrozen(client,true)
							setPedAnimation(client,"BOMBER","BOM_Plant_Loop")
							destroyItemPlaceTimer[client]=setTimer(function(client)
								if(isElement(client))then
									setPedAnimation(client)
									setElementFrozen(client,false)
									toggleAllControls(client,true)
									
									local x,y,z=getElementPosition(client)
									local rx,ry,rz=getElementRotation(client)
									
									local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE Itemdepot=Itemdepot","Itemdepot","Counter"),-1)[1]["Itemdepot"]
									dbExec(handler,"UPDATE ?? SET ??=?","Counter","Itemdepot",IDcounter+1)
									
									Itemdepots[IDcounter]=createObject(1271,x,y,z-0.5,0,0,rz)
									setElementData(Itemdepots[IDcounter],"itemdepot",true)
									setElementData(Itemdepots[IDcounter],"itemdepotOWNER",getPlayerName(client))
									setElementData(Itemdepots[IDcounter],"itemdepotID",IDcounter)
									setData(client,item,getData(client,item)-1)
									
									dbExec(handler,"INSERT INTO Itemdepots (ID,Owner,SpawnX,SpawnY,SpawnZ,RotZ,Coins,Pizza) VALUES (?,?,?,?,?,?,?,?)",IDcounter,getPlayerName(client),x,y,z,rz,"0","0")
								end
							end,30*1000,1,client)
						end
					end
				end
			end
		elseif(item=="Keycard")then
			if(getData(client,item)>=1)then
				triggerClientEvent(client,"draw:infobox",root,"info","You can open special-gates with a Keycard!")
			end
			
		elseif(item=="Skin_1")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=1)then
					setData(client,"SkinID",1)
					setElementModel(client,1)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_2")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=2)then
					setData(client,"SkinID",2)
					setElementModel(client,2)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_7")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=7)then
					setData(client,"SkinID",7)
					setElementModel(client,7)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_11")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=11)then
					setData(client,"SkinID",11)
					setElementModel(client,11)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_12")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=12)then
					setData(client,"SkinID",12)
					setElementModel(client,12)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_40")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=40)then
					setData(client,"SkinID",40)
					setElementModel(client,40)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_55")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=55)then
					setData(client,"SkinID",55)
					setElementModel(client,55)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_63")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=63)then
					setData(client,"SkinID",63)
					setElementModel(client,63)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_76")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=76)then
					setData(client,"SkinID",76)
					setElementModel(client,76)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_83")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=83)then
					setData(client,"SkinID",83)
					setElementModel(client,83)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_93")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=93)then
					setData(client,"SkinID",93)
					setElementModel(client,93)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_297")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=297)then
					setData(client,"SkinID",297)
					setElementModel(client,297)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_298")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=298)then
					setData(client,"SkinID",298)
					setElementModel(client,298)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_305")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=305)then
					setData(client,"SkinID",305)
					setElementModel(client,305)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		elseif(item=="Skin_312")then
			if(getData(client,item)>=1)then
				if(getElementModel(client)~=312)then
					setData(client,"SkinID",312)
					setElementModel(client,312)
					triggerClientEvent(client,"draw:infobox",root,"info","Skin selected!")
				end
			end
		end
		triggerClientEvent(client,"refresh:inventory",client)
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(destroyItemPlaceTimer[source]))then
		destroyElement(destroyItemPlaceTimer[source])
	end
	if(isTimer(ItemTimerTable[source]))then
		destroyElement(ItemTimerTable[source])
	end
end)
addEventHandler("onPlayerWasted",root,function()
	if(isTimer(destroyItemPlaceTimer[source]))then
		destroyElement(destroyItemPlaceTimer[source])
	end
	if(isTimer(ItemTimerTable[source]))then
		destroyElement(ItemTimerTable[source])
	end
end)