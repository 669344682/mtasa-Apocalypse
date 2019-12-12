--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Display/cHud.lua))

local startarmor=0
local starthealth=0
local starthungerbar=0
local startthirstbar=0
local startexpbar=0

local hudTable={"ammo","armour","clock","health","money","weapon","wanted","area_name","vehicle_name","breath","clock","ammo"}
function disableHudComponents()
	for i=1,#hudTable do
		setPlayerHudComponentVisible(hudTable[i],false)
	end
end
addEventHandler("onClientRender",root,disableHudComponents)

function drawHud()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(isPlayerMapVisible(lp)==false)then
				local armor=math.floor(getPedArmor(lp))or 0
				local armor1=math.floor(getPedArmor(lp))or 0
				local health=math.floor(getElementHealth(lp))or 0
				local health1=math.floor(getElementHealth(lp))or 0
				local level=getElementData(lp,"Level")or 0
				local expp=getElementData(lp,"EXP")
				local expp1=getElementData(lp,"EXP")
				local hunger=getClientData("Hunger")
				local hunger1=getClientData("Hunger")
				local thirst=getClientData("Thirst")
				local thrist1=getClientData("Thirst")
				local weaponID=getPedWeapon(lp)or 0
				
				local armor=216/100*armor
				local health=216/100*health
				local hunger=216/100*hunger
				local thirst=216/100*thirst
				local expp=216/settings.level[level]*expp
				
				local currentTick=getTickCount()/1500
				
				if(armor~=startarmor)then
					if(armor<startarmor)then
						local diff=startarmor-armor
						local rem=math.ceil(diff/150)
						startarmor=startarmor-rem
					else
						local diff=armor-startarmor
						local rem=math.ceil(diff/150)
						startarmor=startarmor+rem
					end
				end
				dxDrawImage(1655*Gsx,16*Gsy,21*Gsx,21*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Armor.png",0,0,0,tocolor(60,125,160,255),false)
				dxDrawRectangle(1680*Gsx,15*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
				if(armor1>=25)then
					dxDrawRectangle(1682*Gsx,17*Gsy,startarmor*Gsx,21*Gsy,tocolor(60,125,160,255),false)
				elseif(armor1<=25)then
					dxDrawRectangle(1682*Gsx,17*Gsy,startarmor*Gsx,21*Gsy,tocolor(60,125,160,currentTick*255),false)
				end
				dxDrawText("% "..armor1,1990*Gsx,20*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,"default","center",_,_,_,false,_,_)
				
				
				if(health~=starthealth)then
					if(health<starthealth)then
						local diff=starthealth-health
						local rem=math.ceil(diff/150)
						starthealth=starthealth-rem
					else
						local diff=health-starthealth
						local rem=math.ceil(diff/150)
						starthealth=starthealth+rem
					end
				end
				dxDrawImage(1655*Gsx,47*Gsy,21*Gsx,21*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Health.png",0,0,0,tocolor(160,0,0,255),false)
				dxDrawRectangle(1680*Gsx,46*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
				if(health1>=25)then
					dxDrawRectangle(1682*Gsx,48*Gsy,starthealth*Gsx,21*Gsy,tocolor(160,0,0,255),false)
				elseif(health1<=25)then
					dxDrawRectangle(1682*Gsx,48*Gsy,starthealth*Gsx,21*Gsy,tocolor(160,0,0,currentTick*255),false)
				end
				dxDrawText("% "..health1,1990*Gsx,51*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,"default","center",_,_,_,false,_,_)
				
				
				if(hunger~=starthungerbar)then
					if(hunger<starthungerbar)then
						local diff=starthungerbar-hunger
						local rem=math.ceil(diff/150)
						starthungerbar=starthungerbar-rem
					else
						local diff=hunger-starthungerbar
						local rem=math.ceil(diff/150)
						starthungerbar=starthungerbar+rem
					end
				end
				dxDrawImage(1655*Gsx,77*Gsy,21*Gsx,21*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Hunger.png",0,0,0,tocolor(200,200,0,255),false)
				dxDrawRectangle(1680*Gsx,76*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
				if(hunger1>=25)then
					dxDrawRectangle(1682*Gsx,78*Gsy,starthungerbar*Gsx,21*Gsy,tocolor(200,200,0,255),false)
				elseif(hunger1<=25)then
					dxDrawRectangle(1682*Gsx,78*Gsy,starthungerbar*Gsx,21*Gsy,tocolor(200,200,0,currentTick*255),false)
				end
				dxDrawText("% "..hunger1,1990*Gsx,81*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,"default","center",_,_,_,false,_,_)
				
				
				if(thirst~=startthirstbar)then
					if(thirst<startthirstbar)then
						local diff=startthirstbar-thirst
						local rem=math.ceil(diff/150)
						startthirstbar=startthirstbar-rem
					else
						local diff=thirst-startthirstbar
						local rem=math.ceil(diff/150)
						startthirstbar=startthirstbar+rem
					end
				end
				dxDrawImage(1655*Gsx,107*Gsy,21*Gsx,21*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Thrist.png",0,0,0,tocolor(0,0,200,255),false)
				dxDrawRectangle(1680*Gsx,106*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
				if(thrist1>=25)then
					dxDrawRectangle(1682*Gsx,108*Gsy,startthirstbar*Gsx,21*Gsy,tocolor(0,0,200,255),false)
				elseif(thrist1<=25)then
					dxDrawRectangle(1682*Gsx,108*Gsy,startthirstbar*Gsx,21*Gsy,tocolor(0,0,200,currentTick*255),false)
				end
				dxDrawText("% "..thrist1,1990*Gsx,111*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,"default","center",_,_,_,false,_,_)
				
				
				if(expp~=startexpbar)then
					if(expp<startexpbar)then
						local diff=startexpbar-expp
						local rem=math.ceil(diff/150)
						startexpbar=startexpbar-rem
					else
						local diff=expp-startexpbar
						local rem=math.ceil(diff/150)
						startexpbar=startexpbar+rem
					end
				end
				dxDrawImage(1655*Gsx,137*Gsy,21*Gsx,21*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Circle.png",0,0,0,tocolor(160,0,0,255),false)
				dxDrawRectangle(1680*Gsx,136*Gsy,220*Gsx,25*Gsy,tocolor(0,0,0,140),false)
				dxDrawRectangle(1682*Gsx,138*Gsy,startexpbar*Gsx,21*Gsy,tocolor(0,200,200,255),false)
				dxDrawText(level,1743*Gsx,136*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,255,255),1.50*Gsx,"default","center",_,_,_,false,_,_)
				dxDrawText(expp1.." / "..settings.level[level],1990*Gsx,141*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,"default","center",_,_,_,false,_,_)
				
				
				dxDrawRectangle(1545*Gsx,15*Gsy,88*Gsx,88*Gsy,tocolor(0,0,0,100),false)
				dxDrawImage(1545*Gsx,15*Gsy,88*Gsx,88*Gsy,":"..settings.generel.scriptname.."/Files/Images/Hud/Weapons/"..weaponID..".png",0.0,0.0,0.0,tocolor(255,255,255,200),false)
				dxDrawRectangle(1545*Gsx,108*Gsy,88*Gsx,25*Gsy,tocolor(0,0,0,100),false)
				if(weaponID==0)then
					dxDrawText("Melee",1585*Gsx,110*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
				else
					dxDrawText(getPedAmmoInClip(lp).." | "..getPedTotalAmmo(lp)-getPedAmmoInClip(lp),1585*Gsx,110*Gsy,1588*Gsx,30*Gsy,tocolor(255,255,225,255),1.00*Gsx,dxFONT2,"center",_,_,_,false,_,_)
				end
				
			end
		end
	end
end
addEventHandler("onClientRender",root,drawHud)