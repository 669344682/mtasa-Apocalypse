--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/sLevel.lua))

function uLevel(player,typ)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"Level"))<=44)then
			if(tonumber(getData(player,"EXP"))>=settings.level[tonumber(getData(player,"Level"))])then
				setData(player,"Level",tonumber(getData(player,"Level"))+1)
				setData(player,"EXP",tonumber(0))
				outputChatBox("Congratulations, you have reached level "..tonumber(getData(player,"Level")).."!",player,255,255,255)
			end
		end
	end
end