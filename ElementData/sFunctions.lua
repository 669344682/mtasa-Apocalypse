--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: ElementData/sFunctions.lua))

elementData={}
local syncDataToClient={
["Gender"]=true,
["Hospitaltime"]=true,
["Hunger"]=true,
["Thirst"]=true,
["Weapondepot"]=true,

["Coins"]=true,
["FirstAidKit"]=true,
["Jerrycan"]=true,
["Repairkit"]=true,
["Pizza"]=true,
["Pastacan"]=true,
["Ravioli"]=true,
["Cola"]=true,
["Pepsi"]=true,
["Bottle"]=true,
["Emptybottle"]=true,
["Itemdepot"]=true,
["Keycard"]=true,
["Skin_1"]=true,
["Skin_2"]=true,
["Skin_7"]=true,
["Skin_11"]=true,
["Skin_12"]=true,
["Skin_40"]=true,
["Skin_55"]=true,
["Skin_63"]=true,
["Skin_76"]=true,
["Skin_83"]=true,
["Skin_93"]=true,
["Skin_297"]=true,
["Skin_298"]=true,
["Skin_305"]=true,
["Skin_312"]=true,

["Ambienceshader"]=true,
["Blurshader"]=true,
["loadDistance"]=true,
}

local syncDataNotToClient={
["SpawnX"]=true,
["SpawnY"]=true,
["SpawnZ"]=true,
["SpawnROT"]=true,
["SkinID"]=true,
}


function setData(player,dataString,value)
	if(player and dataString and value and value~=nil)then	
		if(not elementData[player])then
			elementData[player]={}
		end
		elementData[player][dataString]=value
		if(syncDataToClient[dataString])then
			triggerClientEvent(player,"trigger:clientData",player,dataString,value)
		elseif(not syncDataNotToClient[dataString] and isElement(player))then
			setElementData(player,dataString,value)
		end
	else
		return nil
	end
end

function getData(player,dataString)
	if(player and dataString)then
		if(not elementData[player])then
			elementData[player]={}
		end
		if(elementData[player][dataString])then
			return elementData[player][dataString]
		elseif(not elementData[player][dataString] and dataString~="AdminLvL" and dataString~="Loggedin" and not syncDataNotToClient[dataString])then
			elementData[player][dataString]=getElementData(player,dataString)
			return elementData[player][dataString]
		else
			return nil
		end
	else
		return nil
	end
end

function freeElementData()
	if(elementData)then
		if(getElementType(source)~="player")then
			if(elementData[source])then
				elementData[source]=nil
			end
		end
	end
end
addEventHandler("onElementDestroy",root,freeElementData)

addEvent("change:clientData",true)
addEventHandler("change:clientData",root,function(dataString,value)
	elementData[client][dataString]=value
end)