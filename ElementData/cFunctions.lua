--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: ElementData/cFunctions.lua))

local elementDataClient={}

function getClientData(dataString)
	return elementDataClient[dataString] or false
end

function setClientData(dataString,value)
	elementDataClient[dataString]=value
	triggerServerEvent("change:clientData",lp,dataString,value)
end

addEvent("trigger:clientData",true)
addEventHandler("trigger:clientData",root,function(dataString,value)
	if(value)then
		elementDataClient[dataString]=value
	end
end)