--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/NPC/cFunctions.lua))

addEventHandler("onClientPedDamage",root,function()
	if(getElementData(source,"dontdamagePED")==true)then
		cancelEvent()
	end
end)