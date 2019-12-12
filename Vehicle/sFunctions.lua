--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Vehicle/sFunctions.lua))

VehicleSoundNEW={
[411]=true,
[415]=true,
[451]=true,
[560]=true,
[541]=true,
[480]=true,
[494]=true,
[502]=true,
[503]=true,
[402]=true,
[429]=true,
[477]=true,
}

VehicleSoundBIKE={
[522]=true,
[521]=true,
[461]=true,
[581]=true,
[463]=true,
}

VehicleSoundLKW={
[403]=true,
[406]=true,
[407]=true,
[408]=true,
[414]=true,
[431]=true,
[437]=true,
[443]=true,
[455]=true,
[456]=true,
[514]=true,
[515]=true,
[524]=true,
[544]=true,
[578]=true,
}

local VehicleRespawnTable={}
local VehicleStartEngine={}

addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(seat==0)then
		local id=getElementData(veh,"VehicleID")
		local fuel=getElementData(veh,"Fuel")
		local x,y,z=getElementPosition(veh)
		local rx,ry,rz=getElementRotation(veh)
		local vehhealth=getElementHealth(veh)
		if(id)then
			if(not(isElementInWater(veh)))then
				dbExec(handler,"UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","Vehicles","SpawnX",x,"SpawnY",y,"SpawnZ",z,"RotX",rx,"RotY",ry,"RotZ",rz,"Fuel",fuel,"Health",vehhealth,"ID",id)
			end
		end
		
		if(getElementType(source)=="player")then
			if(isKeyBound(source,"K","down",Engine_Func))then
				unbindKey(source,"K","down",Engine_Func)
			end
			if(isKeyBound(source,"L","down",Light_Func))then
				unbindKey(source,"L","down",Light_Func)
			end
		end
	end
end)
addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(seat==0)then
		if(veh)then
			local vehmodel=getElementModel(veh)
			if(vehmodel)then
				if(vehmodel~=481 and vehmodel~=509 and vehmodel~=510)then
					if(not getElementData(veh,"engine"))then
						setElementData(veh,"engine",false)
						setVehicleEngineState(veh,false)
					end
					if(getElementType(source)=="player")then
						if(not isKeyBound(source,"K","down",Engine_Func))then
							bindKey(source,"K","down",Engine_Func,"Engine on/off")
						end
						if(not isKeyBound(source,"L","down",Light_Func))then
							bindKey(source,"L","down",Light_Func,"Light on/off")
						end
					end
					
					if(tonumber(getData(source,"Playtime"))<=300)then
						outputChatBox("Press 'K' to turn on/off engine!",source,0,200,0)
						outputChatBox("Press 'L' to turn on/off lights!",source,0,200,0)
					end
				end
			end
		end
	end
end)

function Light_Func(player,key,state)
	if(getPedOccupiedVehicleSeat(player)==0)then
		local veh=getPedOccupiedVehicle(player)
		local vehmodel=getElementModel(veh)
		if(veh)then
			if(vehmodel)then
				if(vehmodel~=481 and vehmodel~=509 and vehmodel~=510)then
					if(getVehicleOverrideLights(veh)~=2)then
						setVehicleOverrideLights(veh,2)
						setElementData(veh,"light",true)
					else
						setVehicleOverrideLights(veh,1)
						setElementData(veh,"light",false)
					end
				end
			end
		end
	end
end


function Engine_Func(player)
	local veh=getPedOccupiedVehicle(player)
	local vehmodel=getElementModel(veh)
	if(isPedInVehicle(player))then
		if(veh)then
			if(vehmodel~=481 and vehmodel~=509 and vehmodel~=510)then
				if(getPedOccupiedVehicleSeat(player)==0)then
					if(getElementData(veh,"motorworking")==false)then
						local x,y,z=getElementPosition(veh)
						local rdm=math.random(1,16)
						if(getVehicleEngineState(veh))then
							setElementData(veh,"engine",false)
							setVehicleEngineState(veh,false)
							triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_Stop",x,y,z,false)
						elseif(getElementData(veh,"VehicleID"))then
							if(tonumber(getElementData(veh,"Fuel"))>=1)then
								if(rdm==4)then
									triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Notstarted",x,y,z,false)
								else
									if(VehicleSoundNEW[getElementModel(veh)])then
										triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_New",x,y,z,false)
									elseif(VehicleSoundBIKE[getElementModel(veh)])then
										triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Bike",x,y,z,false)
									elseif(VehicleSoundLKW[getElementModel(veh)])then
										triggerClientEvent(root,"playSound3D_mp3",root,player,"Motor_LKW",x,y,z,false)
									else
										triggerClientEvent(root,"playSound3D_ogg",root,player,"Motor_Old",x,y,z,false)
									end
								end
								
								if(rdm~=4)then
									setElementData(veh,"motorworking",true)
									VehicleStartEngine[player]=setTimer(function(player)
										setElementData(veh,"motorworking",false)
										setElementData(veh,"engine",true)
										setVehicleEngineState(veh,true)
										if not getElementData(veh,"timerrunning")then
											setElementData(veh,"timerrunning",true)
											setVehicleNewFuelState(veh)
										end
									end,2000,1,player)
								end
								
							else
								triggerClientEvent(player,"draw:infobox",root,"error","The vehicle is out of gas.")
							end
						end
					end
				end
			end
		end
	end
end
function setVehicleNewFuelState(veh)
	if(isElement(veh))then
		if(getVehicleEngineState(veh)==true)then
			vehfactor=450
			if(vehfactor)then
				local speed=getElementSpeed(veh)
				if(VehicleSoundNEW[getElementModel(veh)])then
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.10
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.30
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.45
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.55
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.65
					elseif(speed>=200)then
						speed=getElementSpeed(veh)/vehfactor+0.75
					end
				else
					if(speed>=0)then
						speed=getElementSpeed(veh)/vehfactor+0.31
					elseif(speed>=15)then
						speed=getElementSpeed(veh)/vehfactor+0.48
					elseif(speed>=45)then
						speed=getElementSpeed(veh)/vehfactor+0.58
					elseif(speed>=100)then
						speed=getElementSpeed(veh)/vehfactor+0.67
					elseif(speed>=160)then
						speed=getElementSpeed(veh)/vehfactor+0.73
					elseif(speed>=200)then
						speed=getElementSpeed(veh)/vehfactor+0.85
					end
				end
				
				setElementData(veh,"Fuel",tonumber(getElementData(veh,"Fuel"))-speed)
				if(getElementData(veh,"Fuel")<1)then
					saveDatasFromVehicle(veh)
					setVehicleEngineState(veh,false)
					setElementData(veh,"engine",false)
					setElementData(veh,"timerrunning",false)
				elseif math.floor(getElementData(veh,"Fuel"))/8==math.floor(getElementData(veh,"Fuel")/8)then
					saveDatasFromVehicle(veh)
					setTimer(setVehicleNewFuelState,7500,1,veh)
				else
					setTimer(setVehicleNewFuelState,7500,1,veh)
				end
			end
		else
			setElementData(veh,"timerrunning",false)
		end
	end
end
function saveDatasFromVehicle(veh)
	local id=getElementData(veh,"VehicleID")
	local vehhealth=getElementHealth(veh)
	if(id and fuel)then
		dbExec(handler,"UPDATE ?? SET ??=?,??=? WHERE ??=? AND ??=?","Vehicles","Fuel",fuel,"Health",vehhealth,"ID",id)
	end
end

addEventHandler("onVehicleExplode",root,function()
	if(isElement(source))then
		local x,y,z=getElementPosition(source)
		createExplosion(x,y,z,5)
		
		local VehicleID=getElementData(source,"VehicleID")
		
		if(VehicleID)then
			VehicleRespawnTable[source]=setTimer(function(source)
				destroyElement(source)
				dbExec(handler,"DELETE FROM ?? WHERE ??=?","Vehicles","ID",VehicleID)
			end,30*1000,1,source)
		end
	end
end)