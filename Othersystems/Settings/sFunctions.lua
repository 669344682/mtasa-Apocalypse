--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Settings/sFunctions.lua))

addEvent("set:settings",true)
addEventHandler("set:settings",root,function(typ,amount)
	if(typ)then
		if(typ=="Ambienceshader")then
			if(tonumber(getData(client,"Ambienceshader"))==1)then
				setData(client,"Ambienceshader",tonumber(2))
				triggerClientEvent("draw:details",client)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Ambienceshader")
			elseif(tonumber(getData(client,"Ambienceshader"))==2)then
				setData(client,"Ambienceshader",tonumber(1))
				triggerClientEvent("undraw:details",client)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Ambienceshader")
			end
		elseif(typ=="Blurshader")then
			if(tonumber(getData(client,"Blurshader"))==1)then
				setData(client,"Blurshader",tonumber(2))
				setPlayerBlurLevel(client,36)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			elseif(tonumber(getData(client,"Blurshader"))==2)then
				setData(client,"Blurshader",tonumber(1))
				setPlayerBlurLevel(client,0)
				triggerClientEvent(client,"refresh:settingsmenu",client,"Blurshader")
			end
		elseif(typ=="loadDistance")then
			setData(client,"loadDistance",tonumber(amount))
			triggerClientEvent("draw:loadDistance",client,amount)
			triggerClientEvent(client,"refresh:settingsmenu",client,"loadDistance")
		end
	end
end)


addEvent("change:accountsettings",true)
addEventHandler("change:accountsettings",root,function(typ,variable)
	local pname=getPlayerName(client)
	if(typ=="Password")then
		if(variable)then
			local variable=md5(hash("sha512",variable))
			
			dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","Password",variable,"Username",pname)
			triggerClientEvent(client,"draw:infobox",root,"success","Your password has been changed successfully!")
		end
	elseif(typ=="Nickchange")then
		if(variable)then
			if(tonumber(getData(client,"Playtime"))<=120)then
				nickcosts=0
			else
				nickcosts=100000
			end
			if(tonumber(getData(client,"Coins"))>=nickcosts)then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Userdata","Username",variable),-1)
				if(not result or not result[1])then
					setData(client,"Coins",tonumber(getData(client,"Coins"))-nickcosts)
					
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Achievement","Username",variable,"Username",pname)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","Username",variable,"Username",pname)
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","Userdepots","Username",pname),-1)
					if(result and result[1])then
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdepots","Username",variable,"Username",pname)
					end
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Useritems","Username",variable,"Username",pname)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Usersettings","Username",variable,"Username",pname)
					dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userstats","Username",variable,"Username",pname)
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","Vehicles","Owner",pname),-1)
					if(result and result[1])then
						dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Vehicles","Owner",variable,"Owner",pname)
					end
					
					
					setPlayerName(client,variable)
				else
					triggerClientEvent(client,"draw:infobox",root,"error","This Username is already exist!")
				end
			else
				triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x"..nickcosts..")")
			end
		end
	end
end)