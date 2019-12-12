--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Shops/Coinshop/cFunctions.lua))

local premiumTimeTable={
	{"7days","x7500 Coins"},
	{"14days","x13500 Coins"},
}
local premiumSkinTable={
	{"55","Cheerleader Girl","x2500 Coins"},
	{"83","L4D2 Policeman","x2500 Coins"},
	{"76","Crimson Zombie","x2500 Coins"},
	{"297","Michael Myers","x2500 Coins"},
	{"298","Point Blank V5","x2500 Coins"},
	{"305","DayZ Zombie","x2500 Coins"},
}
local otherItemTable={
	{"Weapondepot","x2000 Coins"},
	{"Itemdepot","x2000 Coins"},
}

bindKey("f2","down",function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-450/2,500,450,settings.generel.servername.." - Coin shop",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				
				GUI.Tabpanel[1]=dgsCreateTabPanel(5,5,490,410,false,GUI.Window[1])
				GUI.Tab[1]=dgsCreateTab("Premium",GUI.Tabpanel[1])
				
				GUI.Gridlist[1]=dgsCreateGridList(5,5,200,380,false,GUI.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
				dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local premtime=dgsGridListAddColumn(GUI.Gridlist[1],"Time",0.35)
				local premcosts=dgsGridListAddColumn(GUI.Gridlist[1],"Price",0.5)
				
				dgsCreateLabel(212,10,160,200,"You can buy Premium for a limited time.\n\n\nWith premium you have special functions.\n\n-more playtime coins (x300)\n-more coins at zombiekill\n-16 weapondepot slots",false,GUI.Tab[1])
				
				GUI.Button[2]=dgsCreateButton(210,345,275,40,"Buy selected premium",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				GUI.Tab[2]=dgsCreateTab("Skins",GUI.Tabpanel[1])
				
				GUI.Gridlist[2]=dgsCreateGridList(5,5,200,380,false,GUI.Tab[2],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[2]=dgsGridListGetScrollBar(GUI.Gridlist[2])
				dgsSetProperty(GUI.ScrollBar[2],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[2],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[2],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local skinid=dgsGridListAddColumn(GUI.Gridlist[2],"ID",0)
				local skinname=dgsGridListAddColumn(GUI.Gridlist[2],"Name",0.6)
				local skinprice=dgsGridListAddColumn(GUI.Gridlist[2],"Price",0.35)
				
				dgsCreateLabel(212,10,160,200,"You can buy Special skins for Coins.",false,GUI.Tab[2])
				
				GUI.Image[3]=dgsCreateImage(210,40,140,300,":"..settings.generel.scriptname.."/Files/Images/Skins/0.png",false,GUI.Tab[2])
				
				GUI.Button[3]=dgsCreateButton(210,345,275,40,"Buy selected skin",false,GUI.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				GUI.Tab[5]=dgsCreateTab("Other",GUI.Tabpanel[1])
				
				GUI.Gridlist[5]=dgsCreateGridList(5,5,200,380,false,GUI.Tab[5],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[5]=dgsGridListGetScrollBar(GUI.Gridlist[5])
				dgsSetProperty(GUI.ScrollBar[5],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[5],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[5],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local otheritemname=dgsGridListAddColumn(GUI.Gridlist[5],"Item",0.6)
				local otheritemprice=dgsGridListAddColumn(GUI.Gridlist[5],"Price",0.35)
				
				GUI.Button[5]=dgsCreateButton(210,345,275,40,"Buy selected item",false,GUI.Tab[5],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				
				for _,v in pairs(premiumTimeTable)do
					local row=dgsGridListAddRow(GUI.Gridlist[1])
					dgsGridListSetItemText(GUI.Gridlist[1],row,premtime,v[1],false,false)
					dgsGridListSetItemText(GUI.Gridlist[1],row,premcosts,v[2],false,false)
				end
				for _,v in pairs(premiumSkinTable)do
					local row=dgsGridListAddRow(GUI.Gridlist[2])
					dgsGridListSetItemText(GUI.Gridlist[2],row,skinid,v[1],false,false)
					dgsGridListSetItemText(GUI.Gridlist[2],row,skinname,v[2],false,false)
					dgsGridListSetItemText(GUI.Gridlist[2],row,skinprice,v[3],false,false)
				end
				for _,v in pairs(otherItemTable)do
					local row=dgsGridListAddRow(GUI.Gridlist[5])
					dgsGridListSetItemText(GUI.Gridlist[5],row,otheritemname,v[1],false,false)
					dgsGridListSetItemText(GUI.Gridlist[5],row,otheritemprice,v[2],false,false)
				end
				
				dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
				dgsGridListSetSortEnabled(GUI.Gridlist[2],false)
				dgsGridListSetSortEnabled(GUI.Gridlist[5],false)
				dgsSetProperty(GUI.Gridlist[1],"rowHeight",20)
				dgsSetProperty(GUI.Gridlist[2],"rowHeight",20)
				dgsSetProperty(GUI.Gridlist[5],"rowHeight",20)
				
				addEventHandler("onDgsMouseClick",GUI.Button[5],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[5])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[5],dgsGridListGetSelectedItem(GUI.Gridlist[5]),1)
								if(clicked~="")then
									triggerServerEvent("buy:coinshop",lp,clicked)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",GUI.Gridlist[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[2])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[2],dgsGridListGetSelectedItem(GUI.Gridlist[2]),1)
								if(clicked~="")then
									dgsImageSetImage(GUI.Image[3],":"..settings.generel.scriptname.."/Files/Images/Skins/"..clicked..".png")
								end
							else
								dgsImageSetImage(GUI.Image[3],":"..settings.generel.scriptname.."/Files/Images/Skins/0.png")
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",GUI.Button[3],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[2])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[2],dgsGridListGetSelectedItem(GUI.Gridlist[2]),1)
								if(clicked~="")then
									triggerServerEvent("buy:coinshop",lp,"Skin",clicked)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",GUI.Button[2],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("buy:coinshop",lp,"Premium",clicked)
								end
							end
						end
					end,
				false)
				--[[addEventHandler("onDgsMouseClick",GUI.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								if(item==grid1)then
									deleteAllUIItems()
									
									GUI.Label[2]=dgsCreateLabel(212,10,160,200,"You can buy Premium for 7 days.\nCosts: x10000 Coins",false,GUI.Window[1])
									GUI.Button[2]=dgsCreateButton(210,375,285,40,"Buy Premium",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									
									
									addEventHandler("onDgsMouseClick",GUI.Button[2],
										function(btn,state)
											if(btn=="left" and state=="up")then
												triggerServerEvent("buy:coinshop",lp,"Premium")
											end
										end,
									false)
								elseif(item==grid3)then
									deleteAllUIItems()
									
									GUI.Label[8]=dgsCreateLabel(212,10,160,200,"Here you can buy Special skins.\nCosts: Coins",false,GUI.Window[1])
									GUI.Button[8]=dgsCreateButton(210,375,285,40,"Zombie Cheerleader (x2500)",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
									
									
									addEventHandler("onDgsMouseClick",GUI.Button[8],
										function(btn,state)
											if(btn=="left" and state=="up")then
												triggerServerEvent("buy:coinshop",lp,"Skin_55")
											end
										end,
									false)
								end
							end
						end
					end,
				false)]]
				
				
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
	dgsSetText(GUI.Label[1],"Your coins: "..getClientData("Coins"))
end)