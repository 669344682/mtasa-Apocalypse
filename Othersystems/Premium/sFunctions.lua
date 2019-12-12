--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Premium/sFunctions.lua))

local PremiumInfo={}

function isPremium(player)
	if(getData(player,"Premium")==1 or getData(player,"LifetimePremium")==1)then
		return true
	else
		return false
	end
end

function checkPremiumStatus(player)
	local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","STime","Userpremium","Username",getPlayerName(player)),-1)
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["STime"]~=0 and result[i]["STime"]-getSecTime(0)<=0)then
				setData(player,"Premium",0)
				outputChatBox("Your Premium-status has expired.",player,200,0,0)
				dbExec(handler,"DELETE FROM ?? WHERE ??=?","Userpremium","Username",getPlayerName(player))
			else
				if(PremiumInfo[player]~=true)then
					PremiumInfo[player]=true
					setData(player,"Premium",1)
					local var=math.floor(((result[i]["STime"]-getSecTime(0))/60)*100)/100
					if(var>=0)then
						outputChatBox("Your Premium-status is still active for "..math.floor(var).." hours.",player,0,200,0)
					end
				end
			end
		end
	end
end

function buyPremium(player,typ)
	if(not(isPremium(player)))then
		if(typ=="7days")then
			if(getData(player,"Coins")>=7500)then
				local stunden=getSecTime(168)
				dbExec(handler,"INSERT INTO ?? (Username,STime) VALUES ('"..getPlayerName(player).."','"..stunden.."')","Userpremium")
				setData("Premium",1)
				triggerClientEvent(player,"draw:infobox",root,"success","You bought 'Premium for 7 days'.")
				checkPremiumStatus(player)
				setData(player,"Coins",tonumber(getData(player,"Coins"))-7500)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","You don't have enough coins! (x7500")
			end
		elseif(typ=="14days")then
			if(getData(player,"Coins")>=13500)then
				local stunden=getSecTime(336)
				dbExec(handler,"INSERT INTO ?? (Username,STime) VALUES ('"..getPlayerName(player).."','"..stunden.."')","Userpremium")
				setData("Premium",1)
				triggerClientEvent(player,"draw:infobox",root,"success","You bought 'Premium for 14 days'.")
				checkPremiumStatus(player)
				setData(player,"Coins",tonumber(getData(player,"Coins"))-13500)
			else
				triggerClientEvent(player,"draw:infobox",root,"error","You don't have enough coins! (x13500")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"warning","You already have a active Premium-status!")
	end
end