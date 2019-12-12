--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Achievement/cFunctions.lua))

local x,y=guiGetScreenSize()
local AchievmentText="test"
local achieveAlpha=0

function renderAchievment()
	if(getElementData(lp,"ElementClicked")==false)then
		if(255~=achieveAlpha)then
			if(255<achieveAlpha)then
				local diff=achieveAlpha-255
				local rem=math.ceil(diff/150)
				achieveAlpha=achieveAlpha-rem
			else
				local diff=255-achieveAlpha
				local rem=math.ceil(diff/150)
				achieveAlpha=achieveAlpha+rem
			end
		end
		
		dxDrawImage(0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,"Files/Images/AchievmentBG.png",0,0,0,tocolor(255,255,255,achieveAlpha),false)
        dxDrawText("Achievement reached!!\n"..AchievmentText.."\n+ x"..AchievmentCoins.." Coins",0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,tocolor(160,0,0,achieveAlpha),1.80,"default","center","center",false,false,false,false,false)
	end
end

addEvent("open:achievement",true)
addEventHandler("open:achievement",root,function(text,amount)
	AchievmentText=text
	AchievmentCoins=amount
	
	if(getElementData(lp,"ElementClicked")==false)then
	addEventHandler("onClientRender",root,renderAchievment)
		setTimer(function()
			removeEventHandler("onClientRender",root,renderAchievment)
		end,15*1000,1)
	else
		outputChatBox("Achievment reached: "..text.." - You get x"..AchievmentCoins.." Coins.",255,255,255,true)
	end
end)