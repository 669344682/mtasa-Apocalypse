--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Group/sFunctions.lua))

local function createGroup(player)
	if(getElementData(player,"Loggedin")==1)then
		if(getData(player,"Gruppe")=="none")then
			triggerClientEvent(player,"open:creategroupUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","You are already in a Group!")
		end
	end
end
addCommandHandler("creategroup",createGroup)

addEvent("create:group",true)
addEventHandler("create:group",root,function(name)
	if(getElementData(client,"Loggedin")==1)then
		if(getData(client,"Gruppe")=="none")then
			if(tonumber(getData(client,"Coins"))>=settings.group.createprice)then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Groups","Name",name),-1)
				if(not result or not result[1])then
					for _,v in ipairs(settings.notallowedcaracters)do
						if(string.find(name,v,1,true))then
							if(string.lower(name,v,1,true))then
								triggerClientEvent(client,"draw:infobox",root,"error","There are no special characters allowed!")
								return false
							end
						end
					end
					
					dbExec(handler,"INSERT INTO Groups (Name,Owner) VALUES (?,?)",name,getPlayerName(client))
					setData(client,"Coins",tonumber(getData(client,"Coins"))-settings.group.createprice)
					setData(client,"Gruppe",name)
					setData(client,"GruppeRank",3)
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Userdata","Gruppe",getData(client,"Gruppe"),"GruppeRank",getData(client,"GruppeRank"),"Username",getPlayerName(client))
					
					outputChatBox("Group successfully bought! Press F3!",client,0,200,0)
				else
					triggerClientEvent(client,"draw:infobox",root,"Error","A Group with this name is already exist!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You do not have enough coins! (x"..settings.group.createprice..")")
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","You are already in a Group!")
		end
	end
end)

addEvent("un_invite:player",true)
addEventHandler("un_invite:player",root,function(typ,kplayer)
	local target=getPlayerFromName(kplayer)
	if(typ=="invite")then
		if(tonumber(getData(client,"GruppeRank"))>=2)then
			if(isElement(target)and getElementData(target,"Loggedin")==1)then
				if(getData(target,"Gruppe")=="none")then
					setData(target,"Gruppe",getData(client,"Gruppe"))
					setData(target,"GruppeRank",0)
					dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Userdata","Gruppe",getData(target,"Gruppe"),"GruppeRank",tonumber(getData(targetPlayer,"GruppeRank")),"Username",getPlayerName(target))
					triggerClientEvent(target,"draw:infobox",root,"info","You were invited by "..getPlayerName(client).."!")
					triggerClientEvent(client,"draw:infobox",root,"success","You have "..getPlayerName(target).." invited!")
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","The player is offline!")
			end
		end
	elseif(typ=="uninvite")then
		if(tonumber(getData(client,"GruppeRank"))>=2)then
			if(isElement(target)and getElementData(target,"Loggedin")==1)then
				if(getData(target,"Gruppe")~="none")then
					if(getData(target,"Gruppe")==getData(client,"Gruppe"))then
						if(tonumber(getData(target,"GruppeRank"))<=1)then
							setData(target,"Gruppe","none")
							setData(target,"GruppeRank",0)
							dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Userdata","Gruppe",0,"GruppeRank",0,"Username",getPlayerName(target))
							triggerClientEvent(target,"draw:infobox",root,"info","You were uninvited by "..getPlayerName(client).."!")
							triggerClientEvent(client,"draw:infobox",root,"success","You have "..getPlayerName(target).." uninvited!")
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
					end
				end
			else
				local targetGroup=getMysqlData("Userdata","Username",kplayer,"Gruppe")
				if(targetGroup==getData(client,"Gruppe"))then
					if(tonumber(getMysqlData("Userdata","Username",kplayer,"GruppeRank"))<2)then
						dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Userdata","Gruppe",0,"GruppeRank",0,"Username",kplayer)
						triggerClientEvent(client,"draw:infobox",root,"success","You have "..kplayer.." uninvited!")
					end
				end
			end
		end
	end
	getGroupPanelMembers(client)
	updateGroupMemberBlips()
end)
addEvent("rankup_down:player",true)
addEventHandler("rankup_down:player",root,function(typ,kplayer)
	local target=getPlayerFromName(kplayer)
	if(typ=="rankup")then
		if(tonumber(getData(client,"GruppeRank"))>=3)then
			if(isElement(target)and getElementData(target,"Loggedin")==1)then
				if(getData(target,"Gruppe")==getData(client,"Gruppe"))then
					if(tonumber(getData(target,"GruppeRank"))<2)then
						setData(target,"GruppeRank",tonumber(getData(target,"GruppeRank"))+1)
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","GruppeRank",tonumber(getData(target,"GruppeRank")),"Username",getPlayerName(target))
						
						triggerClientEvent(target,"draw:infobox",root,"info","You were promoted by "..getPlayerName(client).."!")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The player already has the highest rank!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
				end
			else
				local targetRank=getMysqlData("Userdata","Username",kplayer,"GruppeRank")
				if(tonumber(getMysqlData("Userdata","Username",kplayer,"GruppeRank"))<2)then
					if(getMysqlData("Userdata","Username",kplayer,"Gruppe")==getData(client,"Gruppe"))then
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","GruppeRank",targetRank+1,"Username",kplayer)
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..kplayer.." einen Rankup gegeben! (offline)")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the highest rank!")
				end
			end
		end
	elseif(typ=="rankdown")then
		if(tonumber(getData(client,"GruppeRank"))>=3)then
			if(isElement(target)and getElementData(target,"Loggedin")==1)then
				if(getData(target,"Gruppe")==getData(client,"Gruppe"))then
					if(tonumber(getData(target,"GruppeRank"))>0)then
						setData(target,"GruppeRank",tonumber(getData(target,"GruppeRank"))-1)
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","GruppeRank",tonumber(getData(target,"GruppeRank")),"Username",getPlayerName(target))
						
						triggerClientEvent(target,"draw:infobox",root,"info","You were promoted by "..getPlayerName(client).."!")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The player already has the lowest rank!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
				end
			else
				local targetRank=getMysqlData("Userdata","Username",kplayer,"GruppeRank")
				if(tonumber(getMysqlData("Userdata","Username",kplayer,"GruppeRank"))>0)then
					if(getMysqlData("Userdata","Username",kplayer,"Gruppe")==getData(client,"Gruppe"))then
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","GruppeRank",targetRank-1,"Username",kplayer)
						triggerClientEvent(client,"draw:infobox",root,"success","Du hast "..kplayer.." einen Rankup gegeben! (offline)")
					else
						triggerClientEvent(client,"draw:infobox",root,"error","The player is already in a Group!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","The player already has the lowest rank!")
				end
			end
		end
	end
	getGroupPanelMembers(client)
	updateGroupMemberBlips()
end)

addEvent("delete:group",true)
addEventHandler("delete:group",root,function()
	local team=getData(client,"Gruppe")
	if(getMysqlData("Groups","Name",team,"Owner")==getPlayerName(client))then
		dbExec(handler,"DELETE FROM ?? WHERE ??=?","Groups","Name",team)
		local result = dbPoll(dbQuery(handler,"SELECT * FROM Userdata"),-1)
		for _,v in pairs(result)do
			if(v["Gruppe"]==team)then
				local target=getPlayerFromName(v["Username"])
				if(isElement(target)and getElementData(target,"Loggedin")==1)then
					setData(target,"Gruppe","none")
					setData(target,"GruppeRank",0)
				end
				dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=?","Userdata","Gruppe","none","GruppeRank",0,"Username",v["Username"])
			end
		end
		setData(client,"Coins",tonumber(getData(client,"Coins"))+settings.group.createprice/100*50)
		updateGroupMemberBlips()
		triggerClientEvent(client,"draw:infobox",root,"info","You deleted your team!")
	end
end)


function getGroupPanelMembers()
	if(getData(client,"Gruppe")~="none")then
		local tbl={}
		local result=dbPoll(dbQuery(handler,"SELECT * FROM Userdata"),-1)
		if(#result>=1)then
			for _,v in pairs(result)do
				if(v["Gruppe"]==getData(client,"Gruppe"))then
					local target=getPlayerFromName(v["Username"])
					if(isElement(target))then
						status="Online"
					else
						status="Offline"
					end
					table.insert(tbl,{v["Username"],v["Gruppe"],v["GruppeRank"],status})
				end
			end
			triggerClientEvent(client,"set:groupmembers",client,tbl)
		end
		updateGroupMemberBlips()
	end
end
addEvent("get:groupmembers",true)
addEventHandler("get:groupmembers",root,getGroupPanelMembers)

function updateGroupMemberBlips()
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"Loggedin")==1)then
			triggerClientEvent(v,"create:groupblips",v)
		end
	end
end