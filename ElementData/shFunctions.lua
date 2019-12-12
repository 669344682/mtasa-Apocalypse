--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: ElementData/shFunctions.lua))

local allowedDataTable={
	["ElementClicked"]=true,
}

addEventHandler("onElementDataChange",root,function(value,old,new)
	if(not getElementType(source)=="player" and not client and not(allowedDataTable[value]))then
		outputChatBox("Change Elementdata canceled! "..value,root,200,200,0)
		cancelEvent()
	end
end)