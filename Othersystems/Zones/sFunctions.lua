--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Zones/sFunctions.lua))

local Savezones={
	-- x, y, width, height
	{1137.9,-1396,55,104},--LS Hospital
	{-2745.3,573.4,213,130},--SF Hospital
	{-2001.1,78.3,85,140},--SF BHF
}

function createSavezones()
	for _,v in pairs(Savezones)do
		local savezoneArea=createColRectangle(v[1],v[2],v[3],v[4])
		createRadarArea(v[1],v[2],v[3],v[4],0,255,0,100,root)
		
		addEventHandler("onColShapeHit",savezoneArea,function(hitElement)
			setData(hitElement,"Savezone",1)
			triggerClientEvent(hitElement,"open:savezone",hitElement)
			if(getElementData(hitElement,"zombie")and getElementData(hitElement,"zombie")==true)then
				killPed(hitElement)
			end
		end)
		
		addEventHandler("onColShapeLeave",savezoneArea,function(hitElement)
			setData(hitElement,"Savezone",0)
			triggerClientEvent(hitElement,"close:savezone",hitElement)
		end)
	end
end
addEventHandler("onResourceStart",resourceRoot,createSavezones)


local Warningzones={
	-- x, y, width, height
	{81.1,1774.2,320,320},--Area
	{-1127.5,-759.5,160,180},--SF Fabrik
}

function createWarningZones()
	for _,v in pairs(Warningzones)do
		createRadarArea(v[1],v[2],v[3],v[4],255,0,0,100,root)
	end
end
addEventHandler("onResourceStart",resourceRoot,createWarningZones)