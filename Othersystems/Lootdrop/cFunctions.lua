--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Lootdrop/cFunctions.lua))

addEvent("draw:airdropblip",true)
addEventHandler("draw:airdropblip",root,function(typ,x,y)
	if(typ=="create")then
		if(isElement(AirdropBlip))then
			destroyElement(AirdropBlip)
		end
		AirdropBlip=createCustomBlip(x,y,25,25,"Files/Images/Radar/Blips/Airdrop.png",99999)
	elseif(typ=="destroy")then
		if(isElement(AirdropBlip))then
			exports.customblips:destroyCustomBlip(AirdropBlip)
		end
	end
end)