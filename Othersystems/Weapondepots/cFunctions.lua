--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Weapondepots/cFunctions.lua))

local Weapondepot={
	["Colt 45"] = 22,
	["Silenced"] = 23,
	["Desert Eagle"] = 24,
	["Shotgun"] = 25,
	["Sawed-off"] = 26,
	["Combat Shotgun"] = 27,
	["Uzi"] = 28,
	["Mp5"] = 29,
	["Tec-9"] = 32,
	["AK-47"] = 30,
	["M4"] = 31,
	["Country Rifle"] = 33,
	["Sniper"] = 34,
	["Rocket Launcher"] = 35,
	["Rocket Launcher HS"] = 36,
	["Flamethrower"] = 37,
	["Minigun"] = 38,
	["Grenade"] = 16,
	["Molotov"] = 18,
	["Satchel"] = 39
}

function openWeapondepotUI()
	if(getElementData(lp,"Loggedin")==1)then
		if(getClientData("Weapondepot")==1)then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-450/2,500,450,settings.generel.servername.." - Weapondepot",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				dgsCreateLabel(10,5,140,200,"Weapons in your depot:",false,GUI.Window[1])
				GUI.Gridlist[1]=dgsCreateGridList(5,25,240,350,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
				dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				weaponid=dgsGridListAddColumn(GUI.Gridlist[1],"ID",0.25)
				weaponweapon=dgsGridListAddColumn(GUI.Gridlist[1],"Weapon",0.4)
				weaponammo=dgsGridListAddColumn(GUI.Gridlist[1],"Ammo",0.3)
				
				GUI.Button[2]=dgsCreateButton(255,380,240,40,"Store",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				dgsCreateLabel(255,5,140,200,"Weapons on your hand:",false,GUI.Window[1])
				GUI.Gridlist[2]=dgsCreateGridList(255,25,240,350,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[2]=dgsGridListGetScrollBar(GUI.Gridlist[2])
				dgsSetProperty(GUI.ScrollBar[2],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[2],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				weaponhand=dgsGridListAddColumn(GUI.Gridlist[2],"Weapon",0.5)
				weaponammohand=dgsGridListAddColumn(GUI.Gridlist[2],"ammo",0.3)
				
				GUI.Button[3]=dgsCreateButton(5,380,240,40,"Outsource",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				triggerServerEvent("get:weapondepotweapons",lp)
				
				dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
				dgsGridListSetSortEnabled(GUI.Gridlist[2],false)
				
				addEventHandler("onDgsMouseClick",GUI.Button[3],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("putout:weaponindepot",lp,clicked)
									triggerServerEvent("get:weapondepotweapons",lp)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",GUI.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[2])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[2],dgsGridListGetSelectedItem(GUI.Gridlist[2]),1)
								if(clicked~="")then
									local weaponID=Weapondepot[clicked]
									triggerServerEvent("putin:weaponindepot",lp,weaponID)
									triggerServerEvent("get:weapondepotweapons",lp)
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
end
bindKey("f6","down",openWeapondepotUI)
addCommandHandler("weapondepot",openWeapondepotUI)

addEvent("refresh:weapondepot",true)
addEventHandler("refresh:weapondepot",root,function(tbl,tbl2)
	dgsGridListClear(GUI.Gridlist[1])
	dgsGridListClear(GUI.Gridlist[2])
	
	if(#tbl2>=1)then
		for _,v in pairs(tbl2)do
			local row=dgsGridListAddRow(GUI.Gridlist[1])
			dgsGridListSetItemText(GUI.Gridlist[1],row,weaponid,v[1],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,weaponweapon,v[2],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,weaponammo,v[3],false,false)
		end
	end
	
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(GUI.Gridlist[2])
			dgsGridListSetItemText(GUI.Gridlist[2],row,weaponhand,v[1],false,false)
			dgsGridListSetItemText(GUI.Gridlist[2],row,weaponammohand,v[2],false,false)
		end
	end
end)