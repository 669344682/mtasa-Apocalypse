--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Loot/sFunctions.lua))

LootItemTable={}
function refreshLootItems(player)
	LootItemTable={}
		
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pizza"))then
		table.insert(LootItemTable,{"Pizza",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pizza")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pastacan"))then
		table.insert(LootItemTable,{"Pastacan",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pastacan")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Ravioli"))then
		table.insert(LootItemTable,{"Ravioli",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Ravioli")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Cola"))then
		table.insert(LootItemTable,{"Cola",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Cola")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pepsi"))then
		table.insert(LootItemTable,{"Pepsi",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Pepsi")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Emptybottle"))then
		table.insert(LootItemTable,{"Emptybottle",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Emptybottle")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Coins"))then
		table.insert(LootItemTable,{"Coins",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Coins")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Itemdepot"))then
		table.insert(LootItemTable,{"Itemdepot",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Itemdepot")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Jerrycan"))then
		table.insert(LootItemTable,{"Jerrycan",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Jerrycan")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Keycard"))then
		table.insert(LootItemTable,{"Keycard",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Keycard")})
	end
	if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Skin_312"))then
		table.insert(LootItemTable,{"Ghilliesuit",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Skin_312")})
	end
end

function loadLootItems(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Lootitems","ID",getElementData(player,"set:clickedloot")),-1)
	if(result or result[1])then
		refreshLootItems(player)
		
		triggerClientEvent(player,"open:lootUI",player,LootItemTable)
		triggerClientEvent(player,"refresh:lootUI",player,LootItemTable)
	end
end

function getItemFromLoot(player,typ,amount)
	if(typ)then
		if(typ~=nil)then
			if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:"..typ.."")>=amount)then
				setElementData(Loot[getElementData(player,"set:clickedloot")],"loot:"..typ.."",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:"..typ.."")-amount)
				setData(player,typ,tonumber(getData(player,typ))+amount)
				triggerClientEvent(player,"draw:infobox",root,"info","You take "..typ.." x"..amount..".")
			end
			
		elseif(typ=="Ghilliesuit")then
			if(getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Skin_312")>=amount)then
				setElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Skin_312",getElementData(Loot[getElementData(player,"set:clickedloot")],"loot:Skin_312")-amount)
				setData(player,"Skin_312",tonumber(getData(player,"Skin_312"))+amount)
				if(getData(player,"Skin_312")>1)then
					setData(player,"Skin_312",1)
				end
				triggerClientEvent(player,"draw:infobox",root,"info","You take "..typ.." x"..amount..".")
			end
		end
	end
	refreshLootItems(player)
	
	triggerClientEvent(player,"refresh:lootUI",player,LootItemTable)
end
addEvent("get:itemfromlootbox",true)
addEventHandler("get:itemfromlootbox",root,getItemFromLoot)