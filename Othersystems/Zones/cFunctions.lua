--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Zones/cFunctions.lua))

local alphac=0
local unrender=false

function openSavezone()
	if(alphac<1 and unrender==false)then
		alphac=alphac+0.01
	elseif(alphac>0 and unrender==true)then
		alphac=alphac-0.01
	elseif(alphac==0 and unrender==true)then
		removeEventHandler("onClientRender",root,openSavezone)
		unrender=false
	end
	if(isPlayerMapVisible(lp)==false)then
		if(not(isPedDead(lp)))then
			dxDrawRectangle(1640*Gsx, 340*Gsy, 270*Gsx, 75*Gsy, tocolor(200,0,0,140*alphac), false)
			dxDrawText("No-Dm-Zone",1724*Gsx, 347*Gsy, 1837*Gsx, 372*Gsy, tocolor(255,255,255,255*alphac), 1.50*Gsx, "default")
			dxDrawText("Any deathmatch is prohibited!",1675*Gsx, 388*Gsy, 1894*Gsx, 406*Gsy, tocolor(255,255,255,255*alphac),1.10*Gsx,"default")
		end
	end
end
addEvent("open:savezone",true)
addEventHandler("open:savezone",root,function()
	if(unrender==true and alphac~=0)then
		unrender=false
	else
		unrender=false
		removeEventHandler("onClientRender",root,openSavezone)
		addEventHandler("onClientRender",root,openSavezone)
	end
end)
addEvent("close:savezone",true)
addEventHandler("close:savezone",root,function()
	unrender=true
end)