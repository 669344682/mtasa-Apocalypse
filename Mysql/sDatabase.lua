--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Mysql/sDatabase.lua))

local DB={
	HOST="127.0.0.1",
	PORT="3306",
	NAME="",
	PASS="",
	USER="",
}

function openMysqlConnection()
	handler=dbConnect("mysql","dbname="..DB.NAME..";host="..DB.HOST..";charset=utf8;port="..DB.PORT,DB.USER,DB.PASS)
	print("[MYSQL] Opening connection to MySQL database..")
	if(handler)then
		print("[MYSQL] Connection to the MySQL database was successfully established!")
	else
		print("[MYSQL] Failed to connect to MySQL database!")
		stopResource(getThisResource())
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),openMysqlConnection)

function closeMysqlConnection()
	if(handler)then
		destroyElement(handler)
		print("[MYSQL] Closed connection to MySQL database!")
	end
end
addEventHandler("onResourceStop",resourceRoot,closeMysqlConnection)

function checkMysqlConnection()
	if(not handler)then
		openMysqlConnection()
	end 
end
addEventHandler("onPlayerJoin",root,checkMysqlConnection)



addEventHandler("onPlayerConnect",root,function(ni,ip,uni,se,ver)
	for _,v in ipairs(settings.notallowedcaracters)do
		if(string.find(ni,v,1,true))then
			if(string.lower(ni,v,1,true))then
				cancelEvent(true,"There are no special characters allowed!")
			end
		end
	end
	
	local result=nil
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Bans","Serial",se),-1)
	local delete=false
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["STime"]~=0 and(result[i]["STime"]-getSecTime(0))<=0)then
				delete=true
			else
				local admin=tostring(result[i]["Admin"])
				local reason=tostring(result[i]["Reason"])
				local time=math.floor(((result[i]["STime"]-getSecTime(0))/60)*100)/100
				if(time>=0)then
					cancelEvent(true,"You were banned by "..admin.."! Reason: "..reason..", Time: "..time.." hours")
				else
					cancelEvent(true,"You were permanently banned by "..admin.."! Reason: "..reason)
				end
				return
			end
		end
		if(delete==true)then
			dbExec(handler,"DELETE FROM ?? WHERE ??=?","Bans","Serial",se)
		end
	end
	
	if(devMode==true)then
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","Whitelist","Serial",se),-1)
		if(result and result[1])then
			if(result[1]["Access"]~="Yes")then
				cancelEvent(true,"You are on the Whitelist without join Access!")
			end
		else
			cancelEvent(true,"You are not on the Whitelist!")
		end
	end
end)


function getMysqlData(from,where,name,data)
	local sql=dbQuery(handler,"SELECT * FROM ?? WHERE ??=?",from,where,name)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end



function spawnLoot()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","Lootitems"),-1)
	if(result and result[1])then
		for i=1,#result do
			local id=tonumber(result[i]["ID"])
			local x=result[i]["SpawnX"]
			local y=result[i]["SpawnY"]
			local z=result[i]["SpawnZ"]
			local rz=result[i]["RotZ"]
			local LootPriority=tonumber(result[i]["LootPriority"])
			
			if(isElement(Loot[id]))then
				destroyElement(Loot[id])
			end
			
			Loot[id]=createObject(2969,x,y,z,0,0,rz)
			setElementData(Loot[id],"loot",true)
			setElementData(Loot[id],"lootID",id)
			
			if(LootPriority==0)then
				local rdmSpawnItem=math.random(1,300)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"loot:Pizza",rdm)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"loot:Pastacan",rdm)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"loot:Ravioli",rdm)
				
				local rdm=math.random(0,1)
				setElementData(Loot[id],"loot:Cola",rdm)
				
				local rdm=math.random(0,1)
				setElementData(Loot[id],"loot:Pepsi",rdm)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"loot:Emptybottle",rdm)
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=80)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"loot:Jerrycan",rdm)
				end
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=60)then
					local rdm=math.random(0,5)
					setElementData(Loot[id],"loot:Coins",rdm)
				end
				
				if(rdmSpawnItem>=1 and rdmSpawnItem<=10)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"loot:Itemdepot",rdm)
				end
				if(rdmSpawnItem>=1 and rdmSpawnItem<=2)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"loot:Keycard",rdm)
				end
			end
			if(LootPriority==1)then
				local rdmSpawnItem=math.random(1,220)
				
				local rdm=math.random(0,5)
				setElementData(Loot[id],"loot:Pizza",rdm)
				
				local rdm=math.random(0,5)
				setElementData(Loot[id],"loot:Pastacan",rdm)
				
				local rdm=math.random(0,4)
				setElementData(Loot[id],"loot:Ravioli",rdm)
				
				local rdm=math.random(0,4)
				setElementData(Loot[id],"loot:Cola",rdm)
				
				local rdm=math.random(0,3)
				setElementData(Loot[id],"loot:Pepsi",rdm)
				
				local rdm=math.random(0,3)
				setElementData(Loot[id],"loot:Emptybottle",rdm)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"loot:Jerrycan",rdm)
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=80)then
					local rdm=math.random(0,17)
					setElementData(Loot[id],"loot:Coins",rdm)
				end
				
				if(rdmSpawnItem>=1 and rdmSpawnItem<=10)then
					local rdm=math.random(0,2)
					setElementData(Loot[id],"loot:Itemdepot",rdm)
				end
				if(rdmSpawnItem>=1 and rdmSpawnItem<=2)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"loot:Keycard",rdm)
				end
			end
			if(LootPriority==2)then
				local rdmSpawnItem=math.random(1,165)
				
				local rdm=math.random(0,10)
				setElementData(Loot[id],"loot:Pizza",rdm)
				
				local rdm=math.random(0,10)
				setElementData(Loot[id],"loot:Pastacan",rdm)
				
				local rdm=math.random(0,7)
				setElementData(Loot[id],"loot:Ravioli",rdm)
				
				local rdm=math.random(0,9)
				setElementData(Loot[id],"loot:Cola",rdm)
				
				local rdm=math.random(0,6)
				setElementData(Loot[id],"loot:Pepsi",rdm)
				
				local rdm=math.random(0,4)
				setElementData(Loot[id],"loot:Emptybottle",rdm)
				
				local rdm=math.random(0,6)
				setElementData(Loot[id],"loot:Jerrycan",rdm)
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=80)then
					local rdm=math.random(0,24)
					setElementData(Loot[id],"loot:Coins",rdm)
				end
				
				if(rdmSpawnItem>=1 and rdmSpawnItem<=10)then
					local rdm=math.random(0,2)
					setElementData(Loot[id],"loot:Itemdepot",rdm)
				end
				if(rdmSpawnItem>=1 and rdmSpawnItem<=2)then
					local rdm=math.random(0,2)
					setElementData(Loot[id],"loot:Keycard",rdm)
				end
				if(rdmSpawnItem>=7 and rdmSpawnItem<=10)then
					setElementData(Loot[id],"loot:Skin_312",1)
				end
			end
			
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,spawnLoot)

addEventHandler("onResourceStart",resourceRoot,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","Itemdepots"),-1)
	if(result and result[1])then
		for i=1,#result do
			local id=tonumber(result[i]["ID"])
			local owner=result[i]["Owner"]
			local x=result[i]["SpawnX"]
			local y=result[i]["SpawnY"]
			local z=result[i]["SpawnZ"]
			local rz=result[i]["RotZ"]
			
			Itemdepots[id]=createObject(1271,x,y,z-0.5,0,0,rz)
			setElementData(Itemdepots[id],"itemdepot",true)
			setElementData(Itemdepots[id],"itemdepotOWNER",owner)
			setElementData(Itemdepots[id],"itemdepotID",id)
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","Vehicles"),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(not(isElement(Vehicles[v["ID"]])))then
				Vehicles[v["ID"]]=createVehicle(v["VehID"],v["SpawnX"],v["SpawnY"],v["SpawnZ"],v["RotX"],v["RotY"],v["RotZ"])
				
				setElementData(Vehicles[v["ID"]],"VehicleID",v["ID"])
				setElementData(Vehicles[v["ID"]],"Fuel",v["Fuel"])
				
				setElementHealth(Vehicles[v["ID"]],v["Health"])
				setVehicleOverrideLights(Vehicles[v["ID"]],1)
				
				local model=getElementModel(Vehicles[v["ID"]])
				if(model==429)then
					local thisveh=getOriginalHandling(model)
					local mahl=2
					setVehicleHandling(Vehicles[v["ID"]],"maxVelocity",thisveh["maxVelocity"]+30/3*mahl)
					setVehicleHandling(Vehicles[v["ID"]],"engineAcceleration",thisveh["engineAcceleration"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*mahl))
					setVehicleHandling(Vehicles[v["ID"]],"engineInertia",thisveh["engineInertia"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*mahl))
					setVehicleHandling(Vehicles[v["ID"]],"driveType","awd")
				end
			end
		end
	end
end)