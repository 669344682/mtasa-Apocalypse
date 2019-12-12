--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Display/cSpeedo.lua))

function drawSpeedo()
	if(isPedInVehicle(lp))then
		if(isPlayerMapVisible(lp)==false)then
			local veh=getPedOccupiedVehicle(lp)
			if(veh)then
				if(getElementData(veh,"VehicleID"))then
					local vehfuel=getElementData(veh,"Fuel")
					local vehspeed=getElementSpeed(veh)
					local lights=getVehicleOverrideLights(veh)
					local engine=getVehicleEngineState(veh)
					local vehmodel=getElementModel(veh)
					
					dxDrawRectangle(820*Gsx,970*Gsy,280*Gsx,80*Gsy,tocolor(0,0,0,180),false)
					
					dxDrawText(math.floor(vehspeed).." km/h",1725*Gsx,980*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.60*Gsx,"default-bold","center",_,_,_,false,_,_)
					if(vehmodel~=481 and vehmodel~=509 and vehmodel~=510)then
						dxDrawText(math.floor(vehfuel).." liters",1725*Gsx,1015*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,255),1.30*Gsx,"default-bold","center",_,_,_,false,_,_)
					end
					
					if(lights)then
						if(lights==2)then
							dxDrawImage(840*Gsx,990*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(0,85,200,255),false)
						else
							dxDrawImage(840*Gsx,990*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Light.png",0,0,0,tocolor(255,255,255,255),false)
						end
					end
					
					if(engine==true)then
						dxDrawImage(1050*Gsx,990*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(200,85,0,255),false)
					elseif(engine==false)then
						dxDrawImage(1050*Gsx,990*Gsy,35*Gsx,35*Gsy,"Files/Images/Speedo/Engine.png",0,0,0,tocolor(255,255,255,255),false)
					end
				end
			end
		end
	else
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
		addEventHandler("onClientRender",root,drawSpeedo)
	end
end)
addEventHandler("onClientVehicleExit",root,function(playere)
	if(playere==lp)then
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end)