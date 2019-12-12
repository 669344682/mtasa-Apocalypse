--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Click/cFunctions.lua))

function getCursor()
	if(getElementData(lp,"Loggedin")==1)then
		if(getElementData(lp,"ElementClicked")==false)then
			showCursor(not(isCursorShowing()))
		end
	end
end
bindKey("m","down",getCursor)
bindKey("ralt","down",getCursor)


function openLootdropUI(tbl)
	if(getElementData(lp,"ElementClicked")==false)then
		setWindowData("add","cursor_clicked")
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,settings.generel.servername.." - Lootdrop",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsWindowSetSizable(GUI.Window[1],false)
		dgsWindowSetMovable(GUI.Window[1],false)
		GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
		
		GUI.Gridlist[1]=dgsCreateGridList(5,5,250,365,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
		dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		lootdropitem=dgsGridListAddColumn(GUI.Gridlist[1],"Item",0.6)
		lootdropitemamount=dgsGridListAddColumn(GUI.Gridlist[1],"Amount",0.24)
		
		GUI.Edit[1]=dgsCreateEdit(260,280,235,40,0,false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Button[2]=dgsCreateButton(260,329,235,40,"Get selected item",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		dgsGridListClear(GUI.Gridlist[1])
		if(#tbl>=1)then
			for _,v in pairs(tbl)do
				local row=dgsGridListAddRow(GUI.Gridlist[1])
				dgsGridListSetItemText(GUI.Gridlist[1],row,lootdropitem,v[1],false,false)
				dgsGridListSetItemText(GUI.Gridlist[1],row,lootdropitemamount,v[2],false,false)
			end
		end
		
		dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
		dgsSetProperty(GUI.Gridlist[1],"rowHeight",20)
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
					if(item>0)then
						local item=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
						local amount=tonumber(dgsGetText(GUI.Edit[1]))
						if(item~="")then
							if(amount>=1)then
								if(amount<=20)then
									if(isOnlyNumbers(amount))then
										triggerServerEvent("get:itemfromlootdrop",lp,lp,item,amount)
									end
								else
									triggerEvent("draw:infobox",lp,"error","you can only take this item x20 at a time!")
								end
							end
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
addEvent("open:lootdropUI",true)
addEventHandler("open:lootdropUI",root,openLootdropUI)

addEvent("refresh:lootdropUI",true)
addEventHandler("refresh:lootdropUI",root,function(tbl)
	dgsGridListClear(GUI.Gridlist[1])
	
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(GUI.Gridlist[1])
			dgsGridListSetItemText(GUI.Gridlist[1],row,lootdropitem,v[1],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,lootdropitemamount,v[2],false,false)
		end
	end
end)




function openLootUI(tbl)
	if(getElementData(lp,"ElementClicked")==false)then
		setWindowData("add","cursor_clicked")
		GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-400/2,500,400,settings.generel.servername.." - Loot",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsWindowSetSizable(GUI.Window[1],false)
		dgsWindowSetMovable(GUI.Window[1],false)
		GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
		dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
		
		GUI.Gridlist[1]=dgsCreateGridList(5,5,250,365,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
		dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
		dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
		lootitem=dgsGridListAddColumn(GUI.Gridlist[1],"Item",0.6)
		lootitemamount=dgsGridListAddColumn(GUI.Gridlist[1],"Amount",0.24)
		
		GUI.Edit[1]=dgsCreateEdit(260,280,235,40,0,false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Button[2]=dgsCreateButton(260,329,235,40,"Get selected item",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		dgsGridListClear(GUI.Gridlist[1])
		if(#tbl>=1)then
			for _,v in pairs(tbl)do
				local row=dgsGridListAddRow(GUI.Gridlist[1])
				dgsGridListSetItemText(GUI.Gridlist[1],row,lootitem,v[1],false,false)
				dgsGridListSetItemText(GUI.Gridlist[1],row,lootitemamount,v[2],false,false)
			end
		end
		
		dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
		dgsSetProperty(GUI.Gridlist[1],"rowHeight",20)
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
					if(item>0)then
						local item=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
						local amount=tonumber(dgsGetText(GUI.Edit[1]))
						if(item~="")then
							if(amount>=1)then
								if(amount<=20)then
									if(isOnlyNumbers(amount))then
										triggerServerEvent("get:itemfromlootbox",lp,lp,item,amount)
									end
								else
									triggerEvent("draw:infobox",lp,"error","you can only take this item x20 at a time!")
								end
							end
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
addEvent("open:lootUI",true)
addEventHandler("open:lootUI",root,openLootUI)

addEvent("refresh:lootUI",true)
addEventHandler("refresh:lootUI",root,function(tbl)
	dgsGridListClear(GUI.Gridlist[1])
	
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(GUI.Gridlist[1])
			dgsGridListSetItemText(GUI.Gridlist[1],row,lootitem,v[1],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,lootitemamount,v[2],false,false)
		end
	end
end)