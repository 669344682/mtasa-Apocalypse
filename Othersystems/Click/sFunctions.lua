--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Click/sFunctions.lua))

LootDropItemTable={}
local destroyItemTimer={}

addEventHandler("onPlayerClick",root,function(btn,state,elem)
	if(getElementData(source,"Loggedin")==1)then
		if(not isPedDead(source))then
			if(state=="down" and btn=="left")then
				if(elem and isElement(elem))then
					if(getElementData(source,"ElementClicked")==false)then
						local x,y,z=getElementPosition(source)
						local ox,oy,oz=getElementPosition(elem)
						local model=getElementModel(elem)
						if(getElementDimension(source)==getElementDimension(elem))then
							if(getElementType(elem)=="ped")then
								if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.5)then
									if(getElementData(elem,"shop:weaponPED")==true)then
										triggerClientEvent(source,"open:weaponUI",source)
									end
								end
							elseif(getElementType(elem)=="object")then
								local model=getElementModel(elem)
								if(model==2932 and getElementData(elem,"lootdrop")==true)then
									if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3)then
										LootDropItemTable={}
										
										if(getElementData(elem,"lootdropitem:Coins"))then
											table.insert(LootDropItemTable,{"Coins",getElementData(elem,"lootdropitem:Coins")})
										end
										if(getElementData(elem,"lootdropitem:FirstAidKit"))then
											table.insert(LootDropItemTable,{"FirstAidKit",getElementData(elem,"lootdropitem:FirstAidKit")})
										end
										if(getElementData(elem,"lootdropitem:Pizza"))then
											table.insert(LootDropItemTable,{"Pizza",getElementData(elem,"lootdropitem:Pizza")})
										end
										if(getElementData(elem,"lootdropitem:Pastacan"))then
											table.insert(LootDropItemTable,{"Pastacan",getElementData(elem,"lootdropitem:Pastacan")})
										end
										if(getElementData(elem,"lootdropitem:Ravioli"))then
											table.insert(LootDropItemTable,{"Ravioli",getElementData(elem,"lootdropitem:Ravioli")})
										end
										if(getElementData(elem,"lootdropitem:Pepsi"))then
											table.insert(LootDropItemTable,{"Pepsi",getElementData(elem,"lootdropitem:Pepsi")})
										end
										if(getElementData(elem,"lootdropitem:Cola"))then
											table.insert(LootDropItemTable,{"Cola",getElementData(elem,"lootdropitem:Cola")})
										end
										if(getElementData(elem,"lootdropitem:Jerrycan"))then
											table.insert(LootDropItemTable,{"Jerrycan",getElementData(elem,"lootdropitem:Jerrycan")})
										end
										if(getElementData(elem,"lootdropitem:Skin_312"))then
											table.insert(LootDropItemTable,{"Ghilliesuit",getElementData(elem,"lootdropitem:Skin_312")})
										end
										
										triggerClientEvent(source,"open:lootdropUI",source,LootDropItemTable)
									end
								elseif(model==1686 or model==1676)then
									if(tonumber(getData(source,"Coins"))>=150)then
										if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3)then
											setData(source,"Coins",tonumber(getData(source,"Coins"))-150)
											setData(source,"Jerrycan",tonumber(getData(source,"Jerrycan"))+1)
											
											triggerClientEvent(source,"draw:infobox",root,"success","Jerrycans bought successfully!")
										end
									end
								elseif(model==1271 and getElementData(elem,"itemdepot")==true)then
									if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3)then
										setElementData(source,"set:clickeddepot",getElementData(elem,"itemdepotID"))
										loadItemdepotItems(source)
									end
								elseif(model==2969 and getElementData(elem,"loot")==true)then
									if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3)then
										setElementData(source,"set:clickedloot",getElementData(elem,"lootID"))
										loadLootItems(source)
									end
								elseif(model==5020)then
									if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3)then
										if(tonumber(getData(source,"Keycard"))>=1)then
											executeCommandHandler("fusaf6dsdhzsah",source,"area")
											setData(source,"Keycard",tonumber(getData(source,"Keycard"))-1)
											
											triggerClientEvent(source,"draw:infobox",root,"warning","The gate closes again in 10 minutes!")
										end
									end
								end
							end
						end
					end
				end
			elseif(state=="down" and btn=="right")then
				if(elem and isElement(elem))then
					if(getElementData(source,"ElementClicked")==false)then
						local x,y,z=getElementPosition(source)
						local ox,oy,oz=getElementPosition(elem)
						local model=getElementModel(elem)
						if(getElementDimension(source)==getElementDimension(elem))then
							if(getElementType(elem)=="object")then
								local model=getElementModel(elem)
								if(model==1271 and getElementData(elem,"itemdepot")and getElementData(elem,"itemdepot")==true)then
									if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=2.2)then
										setElementData(source,"set:clickeddepot",getElementData(elem,"itemdepotID"))
										if(not(isTimer(destroyItemTimer[source])))then
											if(isElement(source))then
												toggleAllControls(source,false)
												setElementFrozen(source,true)
												setPedAnimation(source,"BOMBER","BOM_Plant_Loop")
												destroyItemTimer[source]=setTimer(function(source)
													if(isElement(Itemdepots[getElementData(source,"set:clickeddepot")]))then
														setPedAnimation(source)
														setElementFrozen(source,false)
														toggleAllControls(source,true)
														triggerClientEvent(source,"draw:infobox",root,"success","You destroyed "..getElementData(elem,"itemdepotOWNER").."'s item depot")
														dbExec(handler,"DELETE FROM ?? WHERE ??=?","Itemdepots","ID",getElementData(elem,"itemdepotID"))
														destroyElement(Itemdepots[getElementData(elem,"itemdepotID")])
														setData(source,"Itemdepot",tonumber(getData(source,"Itemdepot"))+1)
													else
														setPedAnimation(source)
														setElementFrozen(source,false)
														toggleAllControls(source,true)
													end
												end,60*1000,1,source)
											end
										end
									end
								elseif(model==2969 and getElementData(elem,"loot")and getElementData(elem,"loot")==true)then
									if(tonumber(getData(source,"AdminLvL"))>=4)then
										if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=2.2)then
											setElementData(source,"set:clickedloot",getElementData(elem,"lootID"))
											
											dbExec(handler,"DELETE FROM ?? WHERE ??=?","Lootitems","ID",getElementData(source,"set:clickedloot"))
											destroyElement(Loot[getElementData(source,"set:clickedloot")])
											
											triggerClientEvent(source,"draw:infobox",root,"info","You destroyed a Lootbox!")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(destroyItemTimer[source]))then
		destroyElement(destroyItemTimer[source])
	end
end)
addEventHandler("onPlayerWasted",root,function()
	if(isTimer(destroyItemTimer[source]))then
		destroyElement(destroyItemTimer[source])
	end
end)