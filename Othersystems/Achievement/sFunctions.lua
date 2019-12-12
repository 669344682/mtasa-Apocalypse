--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Achievement/sFunctions.lua))

function setPlayerAchievment(player,achievment,text,amount)
	if(isElement(player))then
		if(getElementData(player,"Loggedin")==1)then
			local pname=getPlayerName(player)
			local sql=getMysqlData("Achievement","Username",pname,achievment)
			if(sql==0)then
				setData(player,"Coins",tonumber(getData(player,"Coins"))+amount)
				dbExec(handler,"UPDATE ?? SET "..achievment.."=? WHERE ??=?","Achievement",1,"Username",pname)
				triggerClientEvent(player,"open:achievement",player,text,amount)
			end
		end
	end
end