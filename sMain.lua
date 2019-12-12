--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: sMain.lua))

function startTimer()
	setTimer(setStartScriptDatas,2*1000,1)
	setTimer(mainTimer,1*1000,0)
end
addEventHandler("onResourceStart",resourceRoot,startTimer)

function setStartScriptDatas()
    setGameType(settings.generel.servername.." v."..settings.generel.scriptversion)
	setMapName(settings.generel.servername.." v."..settings.generel.scriptversion)
	if(devMode==true)then
		setServerPassword("lakeZ")
	else
		setServerPassword("")
	end
	
	setFPSLimit(60)
	
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	
	setTime(hour,minute)
	setMinuteDuration(60000)
	
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"Loggedin")==1)then
			if(getElementData(v,"ElementClicked")==true)then
				setElementData(v,"ElementClicked",false)
			end
			setElementData(v,"Loggedin",0)
		end
		if(not getElementData(v,"Loggedin"))then
			setElementData(v,"Loggedin",0)
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,setStartScriptDatas)



function mainTimer()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	local second=time.second
	local weekday=settings.generel.days[time.weekday+1]
	
	if(weekday=="So")then
		
	end
	
	if(hour==06 and minute==01 and second==00)then
		outputChatBox("INFO: Server successful restarted!",root,0,200,0)
		sendMessageToDiscordServer(1,"INFO: Server successful restarted!")
	elseif(hour==06 and minute==00 and second==00)then
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"Loggedin")==1)then
				savePlayerData(v)
				kickPlayer(v,"System","Serverrestart! Join again!")
			end
		end
		restartResource(getThisResource())
	elseif(hour==05 and minute==55 and second==00)then
		outputChatBox("WARNING: Serverrestart in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(1,"WARNING: Serverrestart in 5 minutes!")
	elseif(hour==05 and minute==50 and second==00)then
		outputChatBox("WARNING: Serverrestart in 10 minutes!",root,200,0,0)
		sendMessageToDiscordServer(1,"WARNING: Serverrestart in 10 minutes!")
	elseif(hour==05 and minute==45 and second==00)then
		outputChatBox("WARNING: Serverrestart in 15 minutes!",root,200,0,0)
		sendMessageToDiscordServer(1,"WARNING: Serverrestart in 15 minutes!")
	end
	
	
	if(hour==01 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	elseif(hour==05 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	elseif(hour==09 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	elseif(hour==13 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	elseif(hour==17 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	elseif(hour==21 and minute==55 and second==00)then
		outputChatBox("[INFO]: Loot respawn in 5 minutes!",root,200,0,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawn in 5 minutes!")
	end
	if(hour==02 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	elseif(hour==06 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	elseif(hour==10 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	elseif(hour==14 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	elseif(hour==18 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	elseif(hour==22 and minute==00 and second==00)then
		outputChatBox("[INFO]: Loot respawned!",root,0,200,0)
		sendMessageToDiscordServer(2,"[INFO]: Loot respawned!")
		spawnLoot()
	end
end



function getSecTime(duration)
	local time=getRealTime()
	local year=time.year
	local day=time.yearday
	local hour=time.hour
	local minute=time.minute
	
	return year*365*24*60+day*24*60+(hour+duration)*60+minute
end




local WeatherID=0
function changeWeather()
	local weather=math.random(0,18)
	
	setWeather(weather)
	WeatherID=weather
	setTimer(changeWeather,30*60*1000,0)
end
addEventHandler("onResourceStart",resourceRoot,changeWeather)

function syncWeather(player)
	triggerClientEvent(player,"sync:weather",player,WeatherID)
end



--((Chats))--
addEventHandler("onPlayerChat",root,function(message,messageType)
	if(getElementData(source,"Loggedin")==1)then
		if(not(isPedDead(source)))then
			if(messageType==0)then
				local x,y,z=getElementPosition(source)
				local interior=getElementInterior(source)
				local dimension=getElementDimension(source)
				local pname=getPlayerName(source)
				
				
				local nearbyPlayers=getElementsByType("player")
				for _,v in ipairs(nearbyPlayers)do
					if(getElementData(v,"Loggedin")==1)then
						local vx,vy,vz=getElementPosition(v)
						local vinterior=getElementInterior(v)
						local vdimension=getElementDimension(v)
						
						if(interior==vinterior and dimension==vdimension)then
							if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
								outputChatBox(pname.." says: "..message,v,255,255,255)
							end
						end
					end
				end
				sendMessageToDiscordServer(3,"[Local]: "..pname.." says: "..message)
			elseif(messageType==2)then
			end
		end
	end
	cancelEvent()
end)

function teamChat(player,cmd,...)
	if(getElementData(player,"Loggedin")==1)then
		if(getData(player,"Gruppe")~="none")then
			if(not(isPedDead(player)))then
				for _,v in ipairs(getElementsByType("player"))do
					if(getElementData(v,"Loggedin")==1)then
						if(getData(v,"Gruppe")==getData(player,"Gruppe"))then
							outputChatBox("[GROUP] "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,255,255,255)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("Groupchat",teamChat)

function globlaChat(player,cmd,...)
	if(getElementData(player,"Loggedin")==1)then
		if(...)then
			for _,v in ipairs(getElementsByType("player"))do
				if(getElementData(v,"Loggedin")==1)then
					outputChatBox("[GLOBAL] "..settings.admin.colorToHASH[getData(player,"AdminLvL")]..""..getPlayerName(player).."#ffffff: "..stringTextWithAllParameters(...).."",v,255,255,255,true)
				end
			end
			sendMessageToDiscordServer(3,"[Global]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...))
		end
	end
end
addCommandHandler("Global",globlaChat)
addCommandHandler("global",globlaChat)

function adminChat(player,cmd,...)
	if(getElementData(player,"Loggedin")==1)then
		if(tonumber(getData(player,"AdminLvL"))>=1)then
			if(...)then
				for _,v in ipairs(getElementsByType("player"))do
					if(getElementData(v,"Loggedin")==1)then
						if(tonumber(getData(v,"AdminLvL"))>=1)then
							outputChatBox("[GLOBAL] "..settings.admin.colorToHASH[getData(player,"AdminLvL")]..""..getPlayerName(player).."#ffffff: "..stringTextWithAllParameters(...).."",v,255,255,255,true)
						end
					end
				end
				sendMessageToDiscordServer(3,"[Admin]: "..getPlayerName(player)..": "..stringTextWithAllParameters(...))
			end
		end
	end
end
addCommandHandler("a",adminChat)






addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent()
end)



function joinPlayerMSG()
	sendMessageToDiscordServer(1,getPlayerName(source).." has entered the server.")
end
addEventHandler("onPlayerJoin",root,joinPlayerMSG)

function quitPlayerMSG(quitType)
	sendMessageToDiscordServer(1,getPlayerName(source).." has left the server. ("..quitType..")")
end
addEventHandler("onPlayerQuit",root,quitPlayerMSG)