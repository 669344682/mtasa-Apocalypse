--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Mysql/sFunctions.lua))

local registerloginTable={
	["Achievement"]={
		"FirstPlayerKill","FirstZombieKill","1000ZombieKills","10000ZombieKills"
	},
	["Userdata"]={
		"AdminLvL","LifetimePremium","Playtime","Hunger","Thirst","Level","EXP","Weapondepot","Gruppe","Hospitaltime","GruppeRank","Gender","SpawnX","SpawnY","SpawnZ","SpawnINT","SpawnDIM","SpawnROT","SkinID"
	},
	["Useritems"]={
		"Coins","FirstAidKit","Jerrycan","Repairkit","Pizza","Pastacan","Ravioli","Cola","Pepsi","Bottle","Emptybottle","Itemdepot","Keycard","Skin_1","Skin_2","Skin_7","Skin_11","Skin_12","Skin_40","Skin_55","Skin_63","Skin_76","Skin_83","Skin_93","Skin_297","Skin_298","Skin_305","Skin_312"
	},
	["Usersettings"]={
		"Ambienceshader","Blurshader","loadDistance"
	},
	["Userstats"]={
		"Kills","Deaths","Damage","ZombieKills"
	},
	["notallowedcaracter"]={"!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]","none"},
}

addEvent("register:account",true)
addEventHandler("register:account",root,function(username,password,gender)
	if(getElementData(client,"Loggedin")==0)then
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Userdata","Serial",getPlayerSerial(client)),-1)
		if(not result or not result[1])then
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Userdata","Username",username),-1)
			if(not result or not result[1])then
				for _,v in ipairs(registerloginTable["notallowedcaracter"])do
					if(string.find(username,v,1,true))then
						if(string.lower(username,v,1,true))then
							triggerClientEvent(client,"draw:infobox",root,"error","There are no special characters allowed!")
							return false
						end
					end
				end
				
				setPlayerName(client,username)
				setPlayerName(client,username)
				setPlayerName(client,username)
				local pwhash=md5(hash("sha512",password))
				local pname=getPlayerName(client)
				local pserial=getPlayerSerial(client)
				
				dbExec(handler,"INSERT INTO Achievement (Username,FirstPlayerKill,FirstZombieKill,1000ZombieKills,10000ZombieKills) VALUES (?,?,?,?,?)",pname,"0","0","0","0")
				dbExec(handler,"INSERT INTO Userdata (Username,Password,Serial,AdminLvL,LifetimePremium,Playtime,Hunger,Thirst,Level,EXP,Weapondepot,Gruppe,GruppeRank,Gender,Hospitaltime,SpawnX,SpawnY,SpawnZ,SpawnINT,SpawnDIM,SpawnROT,SkinID) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",pname,pwhash,pserial,"0","0","0","100","65","1","0","Weapondepot","none","0",gender,"0","-1962.5","120","27.7","0","0","0","0")
				dbExec(handler,"INSERT INTO Useritems (Username,Coins,FirstAidKit,Jerrycan,Repairkit,Pizza,Pastacan,Ravioli,Cola,Pepsi,Bottle,Emptybottle,Itemdepot,Keycard,Skin_1,Skin_2,Skin_7,Skin_11,Skin_12,Skin_40,Skin_55,Skin_63,Skin_76,Skin_83,Skin_93,Skin_297,Skin_298,Skin_305,Skin_312) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",pname,"1200","0","0","0","10","5","5","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0")
				dbExec(handler,"INSERT INTO Usersettings (Username,Ambienceshader,Blurshader,loadDistance) VALUES (?,?,?,?)",pname,"2","2","100")
				dbExec(handler,"INSERT INTO Userstats (Username,Kills,Deaths,Damage,ZombieKills) VALUES (?,?,?,?,?)",pname,"0","0","0","0")
				
				setPlayerDataAfterRegisterLogin(client)
				triggerClientEvent(client,"destroy:registerlogin",client)
				triggerClientEvent(client,"open:skinselector",client)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","This Username is already exist!",8)
			end
		else
			triggerClientEvent(client,"draw:infobox",root,"error","Only 1 account per serial is allowed!\n(Old name: ".. result[1]["Username"] ..")",15)
		end
	end
end)
addEvent("login:account",true)
addEventHandler("login:account",root,function(username,password)
	if(getElementData(client,"Loggedin")==0)then
		local pwhash=md5(hash("sha512",password))
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","Userdata","Username",username,"Password",pwhash),-1)
		if(result and result[1])then
			setPlayerName(client,username)
			setPlayerDataAfterRegisterLogin(client)
			triggerClientEvent(client,"destroy:registerlogin",client)
		else
			triggerClientEvent(client,"draw:infobox",root,"error","The username/password combination\nis not correct or not available!",10)
		end
	end
end)

function setPlayerDataAfterRegisterLogin(player)
	local pname=getPlayerName(player)
	
	setCameraTarget(player,player)
	
	for i=1,#registerloginTable["Userdata"] do
		setData(player,registerloginTable["Userdata"][i],getMysqlData("Userdata","Username",pname,registerloginTable["Userdata"][i]))
	end
	
	for i=1,#registerloginTable["Useritems"] do
		setData(player,registerloginTable["Useritems"][i],getMysqlData("Useritems","Username",pname,registerloginTable["Useritems"][i]))
	end
	
	for i=1,#registerloginTable["Usersettings"] do
		setData(player,registerloginTable["Usersettings"][i],getMysqlData("Usersettings","Username",pname,registerloginTable["Usersettings"][i]))
	end
	
	for i=1,#registerloginTable["Userstats"] do
		setData(player,registerloginTable["Userstats"][i],getMysqlData("Userstats","Username",pname,registerloginTable["Userstats"][i]))
	end
	
	setElementData(player,"ElementClicked",false)
	setElementData(player,"Loggedin",1)
	setElementData(player,"Savezone",0)
	
	if(getData(player,"Gruppe")=="none")then
		setData(player,"GruppeRank",0)
	end
	
	startPaydayPlayerTimer(player)
	startHungerPlayerTimer(player)
	startThirstPlayerTimer(player)
	checkPremiumStatus(player)
	syncWeather(player)
	uLevel(player)
	updateGroupMemberBlips()
	
	setPedStat(player,22,500)
	setPedStat(player,69,900)
	setPedStat(player,70,999)
	setPedStat(player,71,999)
	setPedStat(player,72,999)
	setPedStat(player,73,999)
	setPedStat(player,74,999)
	setPedStat(player,75,999)
	setPedStat(player,76,999)
	setPedStat(player,77,999)
	setPedStat(player,78,999)
	setPedStat(player,79,999)
	setPedStat(player,160,999)
	setPedStat(player,229,999)
	setPedStat(player,230,999)
	
	setElementFrozen(player,false)
	toggleAllControls(player,true)
	
	--triggerClientEvent("switchGoundSnow",player,true)
	if(getData(player,"Blurshader")==1)then
		setPlayerBlurLevel(player,0)
	elseif(getData(player,"Blurshader")==2)then
		setPlayerBlurLevel(player,36)
	end
	if(getData(player,"Ambienceshader")==2)then
		triggerClientEvent("draw:details",player)
	end
	triggerClientEvent("draw:loadDistance",player,getData(player,"loadDistance"))
	
	bindKey(player,"Z","down","chatbox","Global")
	bindKey(player,"Y","down","chatbox","Groupchat")
	
	if(getData(player,"Hospitaltime")>=1)then
		fadeCamera(player,true)
		triggerClientEvent(player,"open:hospitalUI",player,getData(player,"Hospitaltime"))
	else
		spawnPlayerAfterRegisterLogin(player)
	end
	
	if(getElementModel(player)==11)then
		setData(player,"Skin_11",1)
	elseif(getElementModel(player)==12)then
		setData(player,"Skin_12",1)
	elseif(getElementModel(player)==40)then
		setData(player,"Skin_40",1)
	elseif(getElementModel(player)==1)then
		setData(player,"Skin_1",1)
	elseif(getElementModel(player)==2)then
		setData(player,"Skin_2",1)
	elseif(getElementModel(player)==7)then
		setData(player,"Skin_7",1)
	end
	
	if(tonumber(getData(player,"Playtime"))<=180)then
		outputChatBox("Hello and Welcome to "..settings.generel.servername.."! Press F1 for Help!",player,0,200,0)
	end
	
	local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Weapons","LogoutWeapons","Username",getPlayerName(player)),-1)
	if(result and result[1])then
		dbExec(handler,"DELETE FROM ?? WHERE ??=?","LogoutWeapons","Username",getPlayerName(player))
		for i=1,12 do
			local wstring=gettok(result[1]["Weapons"],i,string.byte("|"))
			if(wstring and #wstring>=1)then
				local weapon=tonumber(gettok(wstring,1,string.byte(",")))
				local ammo=tonumber(gettok(wstring,2,string.byte(",")))
				giveWeapon(player,weapon,ammo)
			end
		end
	end
end
function savePlayerData(player)
	if(getElementData(player,"Loggedin")==1)then
		local pname=getPlayerName(player)
		
		for i=1,#registerloginTable["Userdata"] do
			dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata",registerloginTable["Userdata"][i],getData(player,registerloginTable["Userdata"][i]),"Username",pname)
		end
		
		for i=1,#registerloginTable["Useritems"] do
			dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Useritems",registerloginTable["Useritems"][i],getData(player,registerloginTable["Useritems"][i]),"Username",pname)
		end
		
		for i=1,#registerloginTable["Usersettings"] do
			dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Usersettings",registerloginTable["Usersettings"][i],getData(player,registerloginTable["Usersettings"][i]),"Username",pname)
		end
		
		for i=1,#registerloginTable["Userstats"] do
			dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userstats",registerloginTable["Userstats"][i],getData(player,registerloginTable["Userstats"][i]),"Username",pname)
		end
		
		local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Weapons","LogoutWeapons","Username",getPlayerName(player)),-1)
		if(result and result[1])then
			dbExec(handler,"DELETE FROM ?? WHERE ??=?","LogoutWeapons","Username",pname)
			for i=1,12 do
				local wstring=gettok(result[1]["Weapons"],i,string.byte("|"))
				if(wstring and #wstring>=1)then
					local weapon=tonumber(gettok(wstring,1,string.byte(",")))
					local ammo=tonumber(gettok(wstring,2,string.byte(",")))
					giveWeapon(player,weapon,ammo)
				end
			end
		end
		
		
		local x,y,z=getElementPosition(player)
		local rx,ry,rz=getElementRotation(player)
		local int=getElementInterior(player)
		local dim=getElementDimension(player)
		if(not isPedDead(player))then
			if(x)and(y)and(z)and(rz)and(int)and(dim)then
				dbExec(handler,"UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","Userdata","SpawnX",x,"SpawnY",y,"SpawnZ",z,"SpawnROT",rz,"SpawnINT",int,"SpawnDIM",dim,"Username",pname)
			end
		end
	end
end
function spawnPlayerAfterRegisterLogin(player)
	local pname=getPlayerName(player)
	setCameraTarget(player,player)
	
	spawnPlayer(player,getMysqlData("Userdata","Username",pname,"SpawnX"),getMysqlData("Userdata","Username",pname,"SpawnY"),getMysqlData("Userdata","Username",pname,"SpawnZ"),getMysqlData("Userdata","Username",pname,"SpawnROT"),getMysqlData("Userdata","Username",pname,"SkinID"),getMysqlData("Userdata","Username",pname,"SpawnINT"),getMysqlData("Userdata","Username",pname,"SpawnDIM"))
end


addEventHandler("onPlayerJoin",root,function()
	setElementData(source,"Loggedin",0)
end)
addEventHandler("onPlayerQuit",root,function()
	local pname=getPlayerName(source)
	if(getElementData(source,"Loggedin")==1)then
		savePlayerData(source)
		updateGroupMemberBlips()
		
		local curWeaponsForSave="|"
		for i=1,11 do
			if(i~=10)then
				local weapon=getPedWeapon(source,i)
				local ammo=getPedTotalAmmo(source,i)
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=40)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=5)then
			handler:exec("INSERT INTO ?? (Username,Weapons) VALUES (?,?)","LogoutWeapons",pname,curWeaponsForSave)
		end
	end
end)


function checkPlayerHasAlreadyAccount()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Userdata","Serial",getPlayerSerial(client)),-1)
	if(#result>=1)then
		triggerClientEvent(client,"open:registerlogin",client,"Login")
	else
		triggerClientEvent(client,"open:registerlogin",client,"Register")
	end
end
addEvent("check:account",true)
addEventHandler("check:account",root,checkPlayerHasAlreadyAccount)


function selectAfterRegisterLoginSkin(skin)
	dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=?","Userdata","SkinID",skin,"Serial",getPlayerSerial(client))
	setElementModel(client,skin)
	setElementFrozen(client,false)
	triggerClientEvent(client,"destroy:registerlogin",client)
	setPlayerDataAfterRegisterLogin(client)
	setElementData(client,"ElementClicked",false)
	setData(client,"Skin_"..getElementModel(client).."",1)
end
addEvent("select:skin",true)
addEventHandler("select:skin",root,selectAfterRegisterLoginSkin)