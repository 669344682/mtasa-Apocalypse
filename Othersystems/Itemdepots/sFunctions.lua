--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Itemdepots/sFunctions.lua))

function loadItemdepotItems(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Itemdepots","ID",getElementData(player,"set:clickeddepot")),-1)
	if(result or result[1])then
		coins=result[1]["Coins"]
		pizza=result[1]["Pizza"]
		pastacan=result[1]["Pastacan"]
		ravioli=result[1]["Ravioli"]
		cola=result[1]["Cola"]
		pepsi=result[1]["Pepsi"]
		jerrycan=result[1]["Jerrycan"]
		medkit=result[1]["FirstAidKit"]
		repairkit=result[1]["Repairkit"]
		
		triggerClientEvent(player,"open:itemdepotUI",player,coins,pizza,pastacan,ravioli,cola,pepsi,jerrycan,medkit,repairkit)
	end
end

addEvent("payin_payout:itemdepotitems",true)
addEventHandler("payin_payout:itemdepotitems",root,function(typ,item,amount)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Itemdepots","ID",getElementData(client,"set:clickeddepot")),-1)
	if(result or result[1])then
		if(typ=="payin")then
			if(item and item~=nil)then
				if(item=="Coins")then
					if(tonumber(result[1][item])+amount<=tonumber(5000))then
						if(tonumber(getData(client,item))>=tonumber(amount))then
							setData(client,item,tonumber(getData(client,item))-amount)
							dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Itemdepots",item,tonumber(result[1][item])+amount,"ID",getElementData(client,"set:clickeddepot"))
						else
							triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough "..item.."! (x"..amount.."")
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","There can not be more than x1000 "..item.." in stock!")
					end
				elseif(item~="Coins")then
					if(tonumber(result[1][item])+amount<=tonumber(100))then
						if(tonumber(getData(client,item))>=tonumber(amount))then
							setData(client,item,tonumber(getData(client,item))-amount)
							dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Itemdepots",item,tonumber(result[1][item])+amount,"ID",getElementData(client,"set:clickeddepot"))
						else
							triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough "..item.."! (x"..amount.."")
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","There can not be more than x100 "..item.." in stock!")
					end
				end
			end
		elseif(typ=="payout")then
			if(item and item~=nil)then
				if(tonumber(result[1][item])>=tonumber(amount))then
					setData(client,item,tonumber(getData(client,item))+amount)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Itemdepots",item,tonumber(result[1][item])-amount,"ID",getElementData(client,"set:clickeddepot"))
				else
					triggerClientEvent(client,"draw:infobox",root,"error","So much "..item.." is not in the depot! (x"..amount..")")
				end
			end
		end
		refreshItemDepotItems(client)
	end
end)

function refreshItemDepotItems(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Itemdepots","ID",getElementData(client,"set:clickeddepot")),-1)
	if(result or result[1])then
		triggerClientEvent(client,"refresh:itemdepotitems",client,result[1]["Coins"],result[1]["Pizza"],result[1]["Pastacan"],result[1]["Ravioli"],result[1]["Cola"],result[1]["Pepsi"],result[1]["Jerrycan"],result[1]["FirstAidKit"],result[1]["Repairkit"])
	end
end