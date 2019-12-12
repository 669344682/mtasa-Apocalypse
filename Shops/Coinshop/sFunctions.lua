--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Shops/Coinshop/sFunctions.lua))

addEvent("buy:coinshop",true)
addEventHandler("buy:coinshop",root,function(typ,typ2)
	if(typ=="Premium")then
		if(typ2=="7days")then
			buyPremium(client,"7days")
		elseif(typ2=="14days")then
			buyPremium(client,"14days")
		end
	elseif(typ=="Weapondepot")then
		if(tonumber(getData(client,"Coins"))>=2000)then
			if(tonumber(getData(client,"Weapondepot"))==0)then
				setData(client,"Weapondepot",1)
				setData(client,"Coins",tonumber(getData(client,"Coins"))-2000)
				
				triggerClientEvent(client,"draw:infobox",root,"success","You bought a Weapon-Depot")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You already have a Weapondepot!")
			end
		end
	elseif(typ=="Itemdepot")then
		if(tonumber(getData(client,"Coins"))>=2000)then
			setData(client,"Itemdepot",getData(client,"Itemdepot")+1)
			setData(client,"Coins",tonumber(getData(client,"Coins"))-2000)
			
			triggerClientEvent(client,"draw:infobox",root,"success","You bought a Item-Depot")
		end
	elseif(typ=="Skin")then
		if(typ2=="55")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_55"))==0)then
					setData(client,"Skin_55",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		elseif(typ2=="76")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_76"))==0)then
					setData(client,"Skin_76",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		elseif(typ2=="83")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_83"))==0)then
					setData(client,"Skin_83",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		elseif(typ2=="297")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_297"))==0)then
					setData(client,"Skin_297",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		elseif(typ2=="298")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_298"))==0)then
					setData(client,"Skin_298",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		elseif(typ2=="305")then
			if(tonumber(getData(client,"Coins"))>=2500)then
				if(tonumber(getData(client,"Skin_305"))==0)then
					setData(client,"Skin_305",1)
					setData(client,"Coins",tonumber(getData(client,"Coins"))-2500)
					
					triggerClientEvent(client,"draw:infobox",root,"success","Skin successfully buyed!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","You already have this skin!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x2500)")
			end
		end
	end
end)