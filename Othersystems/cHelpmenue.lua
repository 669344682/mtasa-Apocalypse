--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/cHelpmenue.lua))

local helpmenueText={
	["Welcome"]="Welcome to "..settings.generel.servername..".\nA new Generation under Apocalypse Server.\n\nYou need Help or you have a Question/Problem?\nThen contact an Admin Ingame or in Discord.\nType '/team' to see all online admins",
	["Clicksystem"]="With the key 'M' you can switch the cursor on and off again.\nYou can use the cursor to click on Peds, Lootboxes\nLootdrops and Itemdepots.",
	["Binds/Commands"]="Binds:\n\nM - show cursor\nT - Localchat\nZ - Globalchat\nY - Groupchat\nK - turn on/off engine\nL - turn on/off light\nJ - Inventory\nF2 - Coinshop\nF3 - Grouppanel\nF5 - Toplist\nF6 - Weapondepot\nF7 - Settings\n\nCommands:\n/creategroup - create a group\n/team - to see all online admins",
	["Datas"]="Discord URL: "..settings.generel.discordurl.."\n\nWebsite URL: "..settings.generel.websiteurl.."",
}
local standartHelpmenuTXT="Help menu"

local function deleteAllUIItems()
	if(isElement(GUI.Button[2]))then
		GUI.Button[2]:destroy()
	end
	if(isElement(GUI.Button[3]))then
		GUI.Button[3]:destroy()
	end
	if(isElement(GUI.Button[4]))then
		GUI.Button[4]:destroy()
	end
end

bindKey("f1","down",function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not(isPedDead(lp)))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-600/2,GLOBALscreenY/2-460/2,600,460,settings.generel.servername.." - Help menu",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(574,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				GUI.Gridlist[1]=dgsCreateGridList(5,7,205,422,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
				dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				local category=dgsGridListAddColumn(GUI.Gridlist[1],"category",0.9)
				local grid1=dgsGridListAddRow(GUI.Gridlist[1],"Welcome")
				local grid2=dgsGridListAddRow(GUI.Gridlist[1],"Clicksystem")
				local grid3=dgsGridListAddRow(GUI.Gridlist[1],"Binds/Commands")
				local grid4=dgsGridListAddRow(GUI.Gridlist[1],"Datas")
				
				GUI.Label[1]=dgsCreateLabel(220,15,160,200,standartHelpmenuTXT,false,GUI.Window[1])
				
				
				dgsGridListSetItemText(GUI.Gridlist[1],grid1,category,"Welcome")
				dgsGridListSetItemText(GUI.Gridlist[1],grid2,category,"Clicksystem")
				dgsGridListSetItemText(GUI.Gridlist[1],grid3,category,"Binds/Commands")
				dgsGridListSetItemText(GUI.Gridlist[1],grid4,category,"Datas")
				
				dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
				dgsSetProperty(GUI.Gridlist[1],"rowHeight",20)
				
				addEventHandler("onDgsMouseClick",GUI.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
								if(helpmenueText[clicked])then
									dgsSetText(GUI.Label[1],helpmenueText[clicked])
									if(item==grid4)then
										deleteAllUIItems()
										
										GUI.Button[2]=dgsCreateButton(490,10,100,20,"Copy",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
										GUI.Button[3]=dgsCreateButton(490,40,100,20,"Copy",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
										addEventHandler("onDgsMouseClick",GUI.Button[2],
											function(btn,state)
												if(btn=="left" and state=="up")then
													setClipboard(settings.generel.discordurl)
												end
											end,
										false)
										addEventHandler("onDgsMouseClick",GUI.Button[3],
											function(btn,state)
												if(btn=="left" and state=="up")then
													setClipboard(settings.generel.websiteurl)
												end
											end,
										false)
									else
										deleteAllUIItems()
									end
								end
							else
								dgsSetText(GUI.Label[1],standartHelpmenuTXT)
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