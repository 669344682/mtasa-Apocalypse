--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/NPC/sFunctions.lua))

local pedsTable={
	{287,-1968.5,114.4,27.7,77,true,0,0,"shop:weapon","Joshua Mellor [NPC]","Weaponshop"},
	{287,-2674.8,634,14.45,174,true,0,0,"shop:weapon","Patrick Hopkins [NPC]","Weaponshop"},
}

addEventHandler("onResourceStart",resourceRoot,function()
	local Peds={}
	for i,v in pairs(pedsTable)do
		if(#pedsTable>=1)then
			Peds[i]=createPed(v[1],v[2],v[3],v[4],v[5],v[6])
			
			setElementDimension(Peds[i],v[7])
			setElementInterior(Peds[i],v[8])
			setElementFrozen(Peds[i],true)
			setElementData(Peds[i],"dontdamagePED",true)
			
			if(v[9]=="shop:weapon")then
				setElementData(Peds[i],"shop:weaponPED",true)
			end
			
			
			
			if(v[10])then
				setElementData(Peds[i],"set:pedtext",v[10])
			end
			if(v[11])then
				setElementData(Peds[i],"set:peddescription",v[11])
			end
		end
	end
end)