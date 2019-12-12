--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Inventory/cFunctions.lua))

local invState=false
local invScroll=0
local invText="Inventory"
local invItems={
	"Coins",
	"FirstAidKit",
	"Jerrycan",
	"Repairkit",
	"Pizza",
	"Pastacan",
	"Ravioli",
	"Cola",
	"Pepsi",
	"Bottle",
	"Emptybottle",
	"Itemdepot",
	"Keycard",
	"Skin_1",
	"Skin_2",
	"Skin_7",
	"Skin_11",
	"Skin_12",
	"Skin_40",
	"Skin_55",
	"Skin_63",
	"Skin_76",
	"Skin_83",
	"Skin_93",
	"Skin_297",
	"Skin_298",
	"Skin_305",
	"Skin_312",
}
local invItemsName={
	["Coins"]="Coins",
	["FirstAidKit"]="First Aid Kit",
	["Jerrycan"]="Jerrycan",
	["Repairkit"]="Repair kit",
	["Pizza"]="Pizza",
	["Pastacan"]="Pastacan",
	["Ravioli"]="Ravioli",
	["Cola"]="Cola",
	["Pepsi"]="Pepsi",
	["Bottle"]="Bottle",
	["Emptybottle"]="Emptybottle",
	["Itemdepot"]="Itemdepot",
	["Keycard"]="Keycard",
	["Skin_1"]="Default (Skin)",
	["Skin_2"]="Default (Skin)",
	["Skin_7"]="Default (Skin)",
	["Skin_11"]="Default (Skin)",
	["Skin_12"]="Default (Skin)",
	["Skin_40"]="Default (Skin)",
	["Skin_55"]="Zombie Cheerleader (Skin)",
	["Skin_63"]="Honoka Summer Outfit (Skin)",
	["Skin_76"]="Crimson Zombie (Skin)",
	["Skin_83"]="L4D2 Policeman (Skin)",
	["Skin_93"]="Amanda The Hooker (Skin)",
	["Skin_297"]="Michael Myers (Skin)",
	["Skin_298"]="Point Blank V5 (Skin)",
	["Skin_305"]="DayZ Zombie (Skin)",
	["Skin_312"]="Ghilliesuit (Skin)",
}
local invItemsImage={
	["Coins"]="Coins.png",
	["FirstAidKit"]="FirstAidKit.png",
	["Jerrycan"]="Jerrycan.png",
	["Repairkit"]="Repairkit.png",
	["Pizza"]="Pizza.png",
	["Pastacan"]="Pastacan.png",
	["Ravioli"]="Ravioli.png",
	["Cola"]="Cola.png",
	["Pepsi"]="Pepsi.png",
	["Bottle"]="Bottle.png",
	["Emptybottle"]="Emptybottle.png",
	["Itemdepot"]="Itemdepot.png",
	["Keycard"]="Keycard.png",
	["Skin_1"]="Skin.png",
	["Skin_2"]="Skin.png",
	["Skin_7"]="Skin.png",
	["Skin_11"]="Skin.png",
	["Skin_12"]="Skin.png",
	["Skin_40"]="Skin.png",
	["Skin_55"]="Skin.png",
	["Skin_63"]="Skin.png",
	["Skin_76"]="Skin.png",
	["Skin_83"]="Skin.png",
	["Skin_93"]="Skin.png",
	["Skin_297"]="Skin.png",
	["Skin_298"]="Skin.png",
	["Skin_305"]="Skin.png",
	["Skin_312"]="Skin.png",
}
local invSlots={
	{730,430,50,50},
	{790,430,50,50},
	{850,430,50,50},
	{910,430,50,50},
	{970,430,50,50},
	{1030,430,50,50},
	{1090,430,50,50},
}

function drawInventory()
	dxDrawRectangle(720*Gsx,400*Gsy,430*Gsx,150*Gsy,settings.generel.guimaincolor,false)
	dxDrawRectangle(720*Gsx,400*Gsy,430*Gsx,20*Gsy,settings.generel.guibarcolor,false)
	dxDrawText(invText,1780*Gsx,800*Gsy,100*Gsx,20*Gsy,tocolor(255,255,255,255),1.00*Gsx,"default-bold","center","center",false,false,false,false,false)
	
	for i=0,1 do
		local coord=430+(i*60)
		dxDrawRectangle(730*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(790*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(850*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(910*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(970*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(1030*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
		dxDrawRectangle(1090*Gsx,coord*Gsy,50*Gsx,50*Gsy,tocolor(255,255,255,175),false)
	end
	
	local state1=false
	for i=1+invScroll,7+invScroll do
		if(invItemTable[i])then
			local tbl=invItemTable[i]
			if(isMouseInPosition(tbl[3],tbl[4],tbl[5],tbl[6]))then
				dxDrawRectangle(tbl[3],tbl[4],tbl[5],tbl[6],settings.generel.guibarcolor,false)
				invText=invItemsName[tbl[1]].." (x"..math.floor(tbl[2])..")"
				state1=true
			end
			dxDrawImage(tbl[3],tbl[4],tbl[5],tbl[6],":"..settings.generel.scriptname.."/Files/Images/Inventory/"..invItemsImage[tbl[1]],0,0,0,tocolor(255,255,255,255),false)
		end
	end
	
	local state2=false
	for i=8+invScroll,14+invScroll do
		if(invItemTable[i])then
			local tbl=invItemTable[i]
			if(isMouseInPosition(tbl[3],tbl[4]+60*Gsy,tbl[5],tbl[6]))then
				dxDrawRectangle(tbl[3],tbl[4]+60*Gsy,tbl[5],tbl[6],settings.generel.guibarcolor,false)
				invText=invItemsName[tbl[1]].." (x"..math.floor(tbl[2])..")"
				state2=true
			end
			dxDrawImage(tbl[3],tbl[4]+60*Gsy,tbl[5],tbl[6],":"..settings.generel.scriptname.."/Files/Images/Inventory/"..invItemsImage[tbl[1]],0,0,0,tocolor(255,255,255,255),false)
		end
	end
	
	if(state1==false and state2==false)then
		invText="Inventory"
	end
end



function refreshInventory()
	local count=0
	local distance=0
	invItemTable={}
	
	for _,v in pairs(invItems)do
		if(tonumber(getClientData(v))>=1)then
			if(count>=7)then
				count=0
			end
			count=count+1
			
			local tbl=invSlots[count]
			table.insert(invItemTable,{v,getClientData(v),tbl[1]*Gsx,(tbl[2]+distance*60)*Gsy,tbl[3]*Gsx,tbl[4]*Gsy})
		end
	end
end
addEvent("refresh:inventory",true)
addEventHandler("refresh:inventory",root,refreshInventory)

function clickInventory(button)
	if(button=="left")then
		for i=1+invScroll,7+invScroll do
			if(invItemTable[i])then
				local tbl=invItemTable[i]
				if(isMouseInPosition(tbl[3],tbl[4],tbl[5],tbl[6]))then
					triggerServerEvent("use:invitem",lp,tbl[1])
				end
			end
		end
		
		for i=8+invScroll,14+invScroll do
			if(invItemTable[i])then
				local tbl=invItemTable[i]
				if(isMouseInPosition(tbl[3],tbl[4]+60*Gsy,tbl[5],tbl[6]))then
					triggerServerEvent("use:invitem",lp,tbl[1])
				end
			end
		end
	end
end

function openCloseInventory()
	if(getElementData(lp,"Loggedin")==1)then
		if(invState==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				invScroll=0
				refreshInventory()
				setWindowData("add","cursor_clicked")
				invState=true
				addEventHandler("onClientRender",root,drawInventory)
				bindKey("mouse_wheel_down","down",InventoryScrollDown)
				bindKey("mouse_wheel_up","down",InventoryScrollUp)
				addEventHandler("onClientDoubleClick",root,clickInventory)
			end
		else
			setWindowData("rem","cursor_clicked")
			removeEventHandler("onClientRender",root,drawInventory)
			invState=false
			unbindKey("mouse_wheel_down","down",InventoryScrollDown)
			unbindKey("mouse_wheel_up","down",InventoryScrollUp)
			removeEventHandler("onClientDoubleClick",root,clickInventory)
		end
	end
end
bindKey("I","down",openCloseInventory)
bindKey("J","down",openCloseInventory)

addEventHandler("onClientPlayerWasted",root,function(player)
	if(player==lp)then
		if(invState==true)then
			openCloseInventory()
		end
	end
end)



function InventoryScrollDown()
	if(invScroll+14<#invItemTable)then
		invScroll=invScroll+7
	end
end

function InventoryScrollUp()
	if(invScroll>0)then
		invScroll=invScroll-7
	end
end