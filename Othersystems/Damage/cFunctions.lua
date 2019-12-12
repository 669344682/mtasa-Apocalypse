--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Damage/cFunctions.lua))

--//Bloodscreen
local bloodAlpha=0

function showBloodFlash()
	bloodAlpha=255
end
addEvent("showBloodFlash",true)
addEventHandler("showBloodFlash",root,showBloodFlash)

addEventHandler("onClientRender",root,function()
	if(bloodAlpha>0)then
		dxDrawImage(0,0,GLOBALscreenX,GLOBALscreenY,"Files/Images/Bloodscreen.png",0,0,0,tocolor(255,255,255,bloodAlpha))
		bloodAlpha=math.max(0,bloodAlpha-3)
	end
end)


addEventHandler("onClientPlayerDamage",root,function(attacker,weapon,bodypart,loss)
	if(source==lp)then
		showBloodFlash()
	end
	if(attacker==lp)then
		if(attacker and weapon and bodypart and loss)then
			if(weaponDamageTable[weapon])then
				triggerServerEvent("trigger:damage",lp,attacker,weapon,bodypart,loss,source)
			end
		end
	elseif(lp==source)then
		if(not(isPedDead(lp)))then
			showBloodFlash()
		end
		if(attacker and weapon and bodypart and loss)then
			if(weaponDamageTable[weapon])then
				cancelEvent()
			end
		end
	end
end)

addEvent("open:hospitalUI",true)
addEventHandler("open:hospitalUI",root,function(time)
	local deathsound=playSound(":"..settings.generel.scriptname.."/Files/Sounds/Wasted.mp3",false)
	setSoundVolume(deathsound,1)
	if(isTimer(HospitalStartTimer))then
		killTimer(HospitalStartTimer)
	end
	if(isElement(GUI.Window[1]))then
		dgsCloseWindow(GUI.Window[1])
	end
	HospitalStartTimer=setTimer(function()
		showChat(false)
		setElementData(lp,"ElementClicked",true)
		setElementInterior(lp,0)
		setElementDimension(lp,0)
		if(isPedInVehicle(lp))then
			removePedFromVehicle(lp)
		end
		setCameraMatrix(1216,-1323.6,21.5,1183.5,-1323.6,17.2)
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-380/2,GLOBALscreenY/2-355/2,380,355,settings.generel.servername.." - Hospital",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsWindowSetSizable(GUI.Window[1],false)
		dgsWindowSetMovable(GUI.Window[1],false)
		
		
		GUI.Label[1]=dgsCreateLabel(140,40,100,20,"You are still in the hospital for "..time.." seconds.",false,GUI.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(GUI.Label[1],"textSize",{1.5,1.5})
		
		dgsCreateImage(5,185,370,140,":"..settings.generel.scriptname.."/Files/Images/Pixel.png",false,GUI.Window[1],tocolor(0,0,0,140))
		GUI.Label[2]=dgsCreateLabel(140,150,100,20,"Did you know already?",false,GUI.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(GUI.Label[2],"textSize",{1.3,1.3})
		GUI.Label[3]=dgsCreateLabel(140,220,100,20,othertables["facts"][math.random(1,#othertables["facts"])],false,GUI.Window[1],_,_,_,_,_,_,"center",_)
		dgsSetProperty(GUI.Label[3],"textSize",{1.2,1.2})
		
		changeTextTimer=setTimer(function()
			dgsSetText(GUI.Label[3],othertables["facts"][math.random(1,#othertables["facts"])])
		end,6*1000,0)
		
		HospitalTimer=setTimer(function()
			time=time-1
			setClientData("Hospitaltime",getClientData("Hospitaltime")-1)
			dgsSetText(GUI.Label[1],"You are still in the hospital for "..time.." seconds.")
			if(time==0)then
				dgsCloseWindow(GUI.Window[1])
				setWindowData("rem","cursor_clicked",false)
				showChat(true)
				triggerServerEvent("spawn:hospital",lp)
				if(isTimer(HospitalTimer))then
					killTimer(HospitalTimer)
				end
				if(isTimer(HospitalStartTimer))then
					killTimer(HospitalStartTimer)
				end
				if(isTimer(changeTextTimer))then
					killTimer(changeTextTimer)
				end
				setElementData(lp,"Hospitaltime",0)
			end
		end,1000,time)
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer)
		end
	end,7200,1)
end)