--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Lootdrop/sFunctions.lua))

local LootDropPositions={
	{1771.6,-209.1,81.7},
	{2571.8,-648.3,137.1},
	{-203.8,19.6,3.6},
	{-1552.1,-74.8,14.6},
}
local lootDropTimer={}

function startLootDrop()
	if(#LootDropPositions>=1)then
		if(not(isElement(Drop)))then
			local rdmCoins=math.random(20,125)
			local rdmMedkits=math.random(20,125)
			local rdmPizza=math.random(20,125)
			local rdmPasta=math.random(20,125)
			local rdmRavioli=math.random(20,125)
			local rdmCola=math.random(20,100)
			local rdmPepsi=math.random(20,100)
			local rdmJerrycan=math.random(20,125)
			local rdmGhilliesuitSkin=math.random(0,10)
			
			local rdmPos=math.random(1,#LootDropPositions)
			
			if(isElement(Drop))then
				setElementData(Drop,"lootdrop",nil)
				setElementData(Drop,"lootdropitem:Coins",nil)
				setElementData(Drop,"lootdropitem:FirstAidKit",nil)
				setElementData(Drop,"lootdropitem:Pizza",nil)
				setElementData(Drop,"lootdropitem:Pastacan",nil)
				setElementData(Drop,"lootdropitem:Ravioli",nil)
				setElementData(Drop,"lootdropitem:Cola",nil)
				setElementData(Drop,"lootdropitem:Pepsi",nil)
				setElementData(Drop,"lootdropitem:Jerrycan",nil)
				if(getElementData(Drop,"lootdropitem:Ghilliesuit"))then
					setElementData(Drop,"lootdropitem:Ghilliesuit",nil)
				end
				destroyElement(Drop)
			end
			
			Drop=createObject(2932,LootDropPositions[rdmPos][1],LootDropPositions[rdmPos][2],LootDropPositions[rdmPos][3],0,0,0)
			--DropBlip=createBlip(LootDropPositions[rdmPos][1],LootDropPositions[rdmPos][2],LootDropPositions[rdmPos][3],0,3,200,0,0,255,0,99999,root)
			triggerClientEvent(root,"draw:airdropblip",root,"create",LootDropPositions[rdmPos][1],LootDropPositions[rdmPos][2])
			
			setElementData(Drop,"lootdrop",true)
			
			if(rdmGhilliesuitSkin>=2 and rdmGhilliesuitSkin<=5)then
				local rdm=math.random(0,4)
				setElementData(Drop,"lootdropitem:Skin_312",rdm)
			end
			
			setElementData(Drop,"lootdropitem:Coins",rdmCoins)
			setElementData(Drop,"lootdropitem:FirstAidKit",rdmMedkits)
			setElementData(Drop,"lootdropitem:Pizza",rdmPizza)
			setElementData(Drop,"lootdropitem:Pastacan",rdmPasta)
			setElementData(Drop,"lootdropitem:Ravioli",rdmRavioli)
			setElementData(Drop,"lootdropitem:Cola",rdmCola)
			setElementData(Drop,"lootdropitem:Pepsi",rdmPepsi)
			setElementData(Drop,"lootdropitem:Jerrycan",rdmJerrycan)
			if(getElementData(Drop,"lootdropitem:Ghilliesuit"))then
				setElementData(Drop,"lootdropitem:Ghilliesuit",rdmGhilliesuitSkin)
			end
			
			lootDropTimer[Drop]=setTimer(function()
				setElementData(Drop,"lootdrop",nil)
				setElementData(Drop,"lootdropitem:Coins",nil)
				setElementData(Drop,"lootdropitem:FirstAidKit",nil)
				setElementData(Drop,"lootdropitem:Pizza",nil)
				setElementData(Drop,"lootdropitem:Pastacan",nil)
				setElementData(Drop,"lootdropitem:Ravioli",nil)
				setElementData(Drop,"lootdropitem:Cola",nil)
				setElementData(Drop,"lootdropitem:Pepsi",nil)
				setElementData(Drop,"lootdropitem:Jerrycan",nil)
				if(getElementData(Drop,"lootdropitem:Ghilliesuit"))then
					setElementData(Drop,"lootdropitem:Ghilliesuit",nil)
				end
				destroyElement(Drop)
				triggerClientEvent(root,"draw:airdropblip",root,"destroy",LootDropPositions[rdmPos][1],LootDropPositions[rdmPos][2])
			end,20*60*1000,1)
			
			outputChatBox("[INFO]: A Airdrop was dropped!",root,200,0,0)
			sendMessageToDiscordServer(2,"[INFO]: A Airdrop was dropped!")
		end
	end
end
setTimer(startLootDrop,30*60*1000,0)

function startLootDropAdmin(player)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=3)then
			startLootDrop()
		end
	end
end
addCommandHandler("lootdrop",startLootDropAdmin)

function getItemFromLootdrop(player,typ,amount)
	if(typ~=nil)then
		if(getElementData(Drop,"lootdropitem:"..typ.."")>=tonumber(amount))then
			setElementData(Drop,"lootdropitem:"..typ.."",getElementData(Drop,"lootdropitem:"..typ.."")-amount)
			setData(player,typ,tonumber(getData(player,typ))+amount)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","So much "..typ.." is not in the airdrop! (x"..amount..")")
		end
	elseif(typ=="Ghilliesuit")then
		if(getElementData(Drop,"lootdropitem:Ghilliesuit")>=tonumber(amount))then
			setElementData(Drop,"lootdropitem:Ghilliesuit",getElementData(Drop,"lootdropitem:Ghilliesuit")-amount)
			setData(player,"Skin_312",tonumber(getData(player,"Skin_312"))+amount)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","So much "..typ.." is not in the airdrop! (x"..amount..")")
		end
	end
end
addEvent("get:itemfromlootdrop",true)
addEventHandler("get:itemfromlootdrop",root,getItemFromLootdrop)