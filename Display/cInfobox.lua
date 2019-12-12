--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Display/cInfobox.lua))

local infoboxState=false
local sound=nil
local startInfoboxAlpha=0

function infobox(typ,text,time)
	if(isTimer(infoboxTimer))then
		killTimer(infoboxTimer)
	end
	if(infoboxState==false)then
		infoboxState=true
		removeEventHandler("onClientRender",root,dxDrawInfobox)
		addEventHandler("onClientRender",root,dxDrawInfobox)
	end
	
	if(typ)then
	infoboxText=text
		if(typ=="error")then
			infoboxColor={200,0,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="success")then
			infoboxColor={0,200,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="info")then
			infoboxColor={0,110,220}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="warning")then
			infoboxColor={200,200,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		end
		sound=playSound(":"..settings.generel.scriptname.."/Files/Sounds/Infobox/"..typ..".mp3")
		setSoundVolume(sound,0.6)
	end
	time=time or 7
	infoboxTimer=setTimer(function()
		removeEventHandler("onClientRender",root,dxDrawInfobox)
		infoboxState=false
		startInfoboxAlpha=0
	end,time*1000,1)
end
addEvent("draw:infobox",true)
addEventHandler("draw:infobox",root,infobox)

function dxDrawInfobox()
	if(190~=startInfoboxAlpha)then
		if(190<startInfoboxAlpha)then
			local diff=startInfoboxAlpha-190
			local rem=math.ceil(diff/150)
			startInfoboxAlpha=startInfoboxAlpha-rem
		else
			local diff=190-startInfoboxAlpha
			local rem=math.ceil(diff/150)
			startInfoboxAlpha=startInfoboxAlpha+rem
		end
	end
	
	dxDrawRectangle(800*Gsx,20*Gsy,300*Gsx,100*Gsy,tocolor(0,0,0,startInfoboxAlpha),false)
	dxDrawRectangle(800*Gsx,20*Gsy,300*Gsx,20*Gsy,tocolor(infoboxColor[1],infoboxColor[2],infoboxColor[3],startInfoboxAlpha),false)
	
	dxDrawText("Information",1700*Gsx,22*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,startInfoboxAlpha),1.0*Gsx,"default-bold","center",_,_,_,false,_,_)
	dxDrawText(infoboxText,1700*Gsx,135*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,startInfoboxAlpha),1.20*Gsx,dxFONT2,"center","center",_,_,false,_,_)
end


function sssss()
	infobox("info","testsssss")
end
addCommandHandler("sss",sssss)