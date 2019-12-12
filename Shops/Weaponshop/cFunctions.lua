--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY & Xendom))
--((File: Shops/Weaponshop/sFunctions.lua))

local WeaponshopTable={
	-- Name, Preis, Level, Ammo
	{"Colt 45",75,1,68},
	{"Silenced",100,1,68},
	{"Desert Eagle",250,1,42},
	{"Shotgun",500,3,30},
	{"Sawed-off",750,3,18},
	{"Combat Shotgun",1250,4,35},
	{"Uzi",1500,6,200},
	{"Mp5",1800,6,120},
	{"Tec-9",2000,7,200},
	{"AK-47",2200,10,250},
	{"M4",2500,12,300},
	{"Rifle",3000,13,50},
	{"Sniper",6000,19,25},
	{"Rocket Launcher",10000,25,5},
	{"Rocket Launcher HS",12500,25,5},
	{"Flamethrower",20000,30,250},
	{"Minigun",35000,45,1000},
	{"Grenade",40000,50,25},
	{"Molotov",40000,50,25},
	{"Satchel",50000,75,30},
}

addEvent("open:weaponUI",true)
addEventHandler("open:weaponUI",root,function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.generel.servername.." - Weapon shop",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				GUI.Label[1]=dgsCreateLabel(5,4,100,20,"Your coins: x"..getClientData("Coins"),false,GUI.Window[1])
				
				GUI.Gridlist[1]=dgsCreateGridList(5,20,490,285,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
				dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local weapon=dgsGridListAddColumn(GUI.Gridlist[1],"Weapon",0.38)
				local price=dgsGridListAddColumn(GUI.Gridlist[1],"Coins",0.16)
				local level=dgsGridListAddColumn(GUI.Gridlist[1],"Level",0.16)
				local ammo=dgsGridListAddColumn(GUI.Gridlist[1],"Ammo",0.16)
				
				GUI.Button[2]=dgsCreateButton(5,313,490,35,"Buy Item",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				for _,v in pairs(WeaponshopTable)do
					local row=dgsGridListAddRow(GUI.Gridlist[1])
					dgsGridListSetItemText(GUI.Gridlist[1],row,weapon,v[1],false,false)
					dgsGridListSetItemText(GUI.Gridlist[1],row,price,v[2],false,false)
					dgsGridListSetItemText(GUI.Gridlist[1],row,level,v[3],false,false)
					dgsGridListSetItemText(GUI.Gridlist[1],row,ammo,v[4],false,false)
				end
				
				dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
				dgsSetProperty(GUI.Gridlist[1],"rowHeight",20)
				
				
				addEventHandler("onDgsMouseClick",GUI.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("buy:weapon",lp,clicked)
								end
							end
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",GUI.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(GUI.Window[1])
							setWindowData("rem","cursor_clicked",true)
						end
					end,
				false)
			end
		end
	end
end)

addEvent("refresh:weaponshop",true)
addEventHandler("refresh:weaponshop",root,function()
	dgsSetText(GUI.Label[1],"Your coins: x"..getClientData("Coins"))
end)