--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Group/cFunctions.lua))

local TeamBlips={}

addEvent("open:creategroupUI",true)
addEventHandler("open:creategroupUI",root,function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked")
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-400/2,GLOBALscreenY/2-300/2,400,300,settings.generel.servername.." - Create group",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(374,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				dgsCreateLabel(5,10,100,20,"Group costs: x"..settings.group.createprice.." Coins",false,GUI.Window[1])
				dgsCreateLabel(5,40,100,20,"INFO: If you create a group, you will get a free base!",false,GUI.Window[1])
				dgsCreateLabel(5,110,100,20,"Group name:",false,GUI.Window[1])
				GUI.Edit[1]=dgsCreateEdit(5,135,200,45,"",false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				GUI.Progressbar[1]=dgsCreateProgressBar(5,180,200,4,false,GUI.Window[1])
				
				GUI.Button[2]=dgsCreateButton(5,225,390,45,"Create group",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				addEventHandler("onDgsMouseClick",GUI.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local name=dgsGetText(GUI.Edit[1])
							if(name~="")then
								if(name:len()>=3 and name:len()<=15)then
									triggerServerEvent("create:group",lp,name)
								end
							else
								triggerEvent("draw:infobox",lp,"Error","Enter a Group name!")
							end
						end
					end,
				false)
				
				addEventHandler("onDgsMouseClick",GUI.Button[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							dgsCloseWindow(GUI.Window[1])
							setWindowData("rem","cursor_clicked")
						end
					end,
				false)
			end
		end
	end
end)

bindKey("f3","down",function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"Gruppe")~="none")then
					setWindowData("add","cursor_clicked")
					GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-380/2,500,380,settings.generel.servername.." - Grouppanel",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
					dgsWindowSetSizable(GUI.Window[1],false)
					dgsWindowSetMovable(GUI.Window[1],false)
					GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
					dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
					
					
					GUI.Tabpanel[1]=dgsCreateTabPanel(10,10,480,335,false,GUI.Window[1])
					GUI.Tab[1]=dgsCreateTab("Memberlist",GUI.Tabpanel[1])
					
					GUI.Gridlist[1]=dgsCreateGridList(5,7,280,300,false,GUI.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
					GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
					dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
					dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
					dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
					members=dgsGridListAddColumn(GUI.Gridlist[1],"Member",0.5)
					rank=dgsGridListAddColumn(GUI.Gridlist[1],"Rank",0.3)
					status=dgsGridListAddColumn(GUI.Gridlist[1],"Status",0.2)
					
					dgsCreateLabel(290,12,100,20,"Enter player name:",false,GUI.Tab[1])
					GUI.Edit[1]=dgsCreateEdit(290,30,185,35,"",false,GUI.Tab[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
					
					GUI.Button[2]=dgsCreateButton(290,70,185,35,"Invite  [R2+]",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					GUI.Button[3]=dgsCreateButton(290,110,185,35,"Uninvite  [R2+]",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					GUI.Button[4]=dgsCreateButton(290,150,185,35,"Rankup  [R3]",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					GUI.Button[5]=dgsCreateButton(290,190,185,35,"Rankdown  [R3]",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					GUI.Button[6]=dgsCreateButton(290,230,185,35,"Delete Group  [R3]\n50% refund",false,GUI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
					
					
					triggerServerEvent("get:groupmembers",lp)
					
					dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
					
					local sortfnc=[[
						local arg={...}
						local a=arg[1]
						local b=arg[2]
						local column=dgsElementData[self].sortColumn
						local texta,textb=a[column][1],b[column][1]
						return texta>textb
					]]
					dgsGridListSetSortFunction(GUI.Gridlist[1],sortfnc)
					dgsGridListSetSortColumn(GUI.Gridlist[1],2)
					
					if(getElementData(lp,"GruppeRank")>=3)then
						dgsSetEnabled(GUI.Button[4],true)
						dgsSetEnabled(GUI.Button[5],true)
						dgsSetEnabled(GUI.Button[6],true)
					else
						dgsSetEnabled(GUI.Button[4],false)
						dgsSetEnabled(GUI.Button[5],false)
						dgsSetEnabled(GUI.Button[6],false)
					end
					if(getElementData(lp,"GruppeRank")>=2)then
						dgsSetEnabled(GUI.Button[2],true)
						dgsSetEnabled(GUI.Button[3],true)
					else
						dgsSetEnabled(GUI.Button[2],false)
						dgsSetEnabled(GUI.Button[3],false)
					end
					
					addEventHandler("onDgsMouseClick",GUI.Button[6],
						function(btn,state)
							if(btn=="left" and state=="down")then
								triggerServerEvent("delete:group",lp)
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",GUI.Button[5],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
								if(item>0)then
									local target=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
									if(target~="")then
										triggerServerEvent("rankup_down:player",lp,"rankdown",target)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",GUI.Button[4],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
								if(item>0)then
									local target=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
									if(target~="")then
										triggerServerEvent("rankup_down:player",lp,"rankup",target)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",GUI.Button[3],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
								if(item>0)then
									local target=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
									if(target~="")then
										triggerServerEvent("un_invite:player",lp,"uninvite",target)
									end
								end
							end
						end,
					false)
					addEventHandler("onDgsMouseClick",GUI.Button[2],
						function(btn,state)
							if(btn=="left" and state=="down")then
								local target=dgsGetText(GUI.Edit[1])or ""
								if(target~="")then
									triggerServerEvent("un_invite:player",lp,"invite",target)
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
end)

addEvent("set:groupmembers",true)
addEventHandler("set:groupmembers",root,function(member)
	dgsGridListClear(GUI.Gridlist[1])
	if(member and #member>=1)then
		for _,v in pairs(member)do
			local row=dgsGridListAddRow(GUI.Gridlist[1])
			dgsGridListSetItemText(GUI.Gridlist[1],row,members,v[1],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,rank,v[3].." - "..settings.group.ranknames[v[3]],false,false)
			dgsGridListSetItemText(GUI.Gridlist[1],row,status,v[4],false,false)
		end
	end
end)


addEvent("create:groupblips",true)
addEventHandler("create:groupblips",root,function()
	for i=1,#TeamBlips do
		if(isElement(TeamBlips[i]))then
			destroyElement(TeamBlips[i])
		end
	end
	
	if(getElementData(lp,"Gruppe")~="none")then
		local counter=0
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"Gruppe")==getElementData(lp,"Gruppe"))then
				--if(getPlayerName(v)~=getPlayerName(lp))then
				if(v~=lp)then
					counter=counter+1
					TeamBlips[counter]=createBlipAttachedTo(v,0,3,0,255,0,255)
				end
			end
		end
	end
end)