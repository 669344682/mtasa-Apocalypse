--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Settings/cFunctions.lua))

local function deleteAllUIItems()
	--//Grid 1
	if(isElement(GUI.Button[10]))then
		GUI.Button[10]:destroy()
	end
	if(isElement(GUI.Label[10]))then
		GUI.Label[10]:destroy()
	end
	if(isElement(GUI.Edit[10]))then
		GUI.Edit[10]:destroy()
	end
	if(isElement(GUI.Button[11]))then
		GUI.Button[11]:destroy()
	end
	if(isElement(GUI.Label[11]))then
		GUI.Label[11]:destroy()
	end
	if(isElement(GUI.Edit[11]))then
		GUI.Edit[11]:destroy()
	end
	
	if(isElement(GUI.Button[20]))then
		GUI.Button[20]:destroy()
	end
	if(isElement(GUI.Label[20]))then
		GUI.Label[20]:destroy()
	end
	if(isElement(GUI.Edit[20]))then
		GUI.Edit[20]:destroy()
	end
	if(isElement(GUI.Button[21]))then
		GUI.Button[21]:destroy()
	end
	if(isElement(GUI.Label[21]))then
		GUI.Label[21]:destroy()
	end
	if(isElement(GUI.Edit[21]))then
		GUI.Edit[21]:destroy()
	end
	if(isElement(GUI.Button[22]))then
		GUI.Button[22]:destroy()
	end
	if(isElement(GUI.Label[22]))then
		GUI.Label[22]:destroy()
	end
	if(isElement(GUI.Edit[22]))then
		GUI.Edit[22]:destroy()
	end
end

bindKey("F7","down",function()
	if(getElementData(lp,"Loggedin")==1)then
		if(getElementData(lp,"ElementClicked")==false)then
			setWindowData("add","cursor_clicked")
			GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-500/2,500,500,settings.generel.servername.." - Settings",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
			dgsWindowSetSizable(GUI.Window[1],false)
			dgsWindowSetMovable(GUI.Window[1],false)
			GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
			dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
			
			GUI.Gridlist[1]=dgsCreateGridList(5,5,200,465,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
			GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
			dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
			dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
			dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
			local gridlist=dgsGridListAddColumn(GUI.Gridlist[1],"Settings",0.92)
			local grid1=dgsGridListAddRow(GUI.Gridlist[1],"Account")
			local grid2=dgsGridListAddRow(GUI.Gridlist[1],"Shader")
			
			dgsGridListSetItemText(GUI.Gridlist[1],grid1,gridlist,"Account")
			dgsGridListSetItemText(GUI.Gridlist[1],grid2,gridlist,"Shader")
			
			dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
			
			
			addEventHandler("onDgsMouseClick",GUI.Gridlist[1],
				function(btn,state)
					if(btn=="left" and state=="up")then
						local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
						if(item>0)then
							local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
							if(item==grid1)then
								deleteAllUIItems()
								
								GUI.Label[10]=dgsCreateLabel(220,25,160,20,"Nickchange (Under 2 hours free)",false,GUI.Window[1])
								GUI.Edit[10]=dgsCreateEdit(220,45,260,40,"",false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								GUI.Button[10]=dgsCreateButton(220,95,260,40,"Nickchange coins (x100.000)",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								GUI.Label[11]=dgsCreateLabel(220,155,160,20,"Change Password",false,GUI.Window[1])
								GUI.Edit[11]=dgsCreateEdit(220,175,260,40,"",false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								GUI.Button[11]=dgsCreateButton(220,225,260,40,"Change Password",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								addEventHandler("onDgsMouseClick",GUI.Button[10],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local username=dgsGetText(GUI.Edit[10])
											if(username~="")then
												triggerServerEvent("change:accountsettings",lp,"Nickchange",username)
											end
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",GUI.Button[11],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local password=dgsGetText(GUI.Edit[11])
											if(password~="")then
												triggerServerEvent("change:accountsettings",lp,"Password",password)
											end
										end
									end,
								false)
							elseif(item==grid2)then
								deleteAllUIItems()
								
								GUI.Label[20]=dgsCreateLabel(220,25,160,20,"Blurshader:",false,GUI.Window[1])
								GUI.Button[20]=dgsCreateButton(220,45,260,40,"Blurshader on/off",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								GUI.Label[21]=dgsCreateLabel(220,100,160,20,"Ambienceshader:",false,GUI.Window[1])
								GUI.Button[21]=dgsCreateButton(220,120,260,40,"Ambienceshader on/off",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								GUI.Label[22]=dgsCreateLabel(220,170,160,20,"LOD Distance:",false,GUI.Window[1])
								GUI.Edit[22]=dgsCreateEdit(220,190,260,40,0,false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
								GUI.Button[22]=dgsCreateButton(220,240,260,40,"Change LOD Distance",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
								
								
								if(tonumber(getClientData("Blurshader"))==1)then
									dgsSetText(GUI.Label[20],"Blurshader: off")
								elseif(tonumber(getClientData("Blurshader"))==2)then
									dgsSetText(GUI.Label[20],"Blurshader: on")
								end
								if(tonumber(getClientData("Ambienceshader"))==1)then
									dgsSetText(GUI.Label[21],"Ambienceshader: off")
								elseif(tonumber(getClientData("Ambienceshader"))==2)then
									dgsSetText(GUI.Label[21],"Ambienceshader: on")
								end
								dgsSetText(GUI.Label[22],"LOD Distance: "..getClientData("loadDistance").."")
								
								
								addEventHandler("onDgsMouseClick",GUI.Button[20],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Blurshader",_)
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",GUI.Button[21],
									function(btn,state)
										if(btn=="left" and state=="down")then
											triggerServerEvent("set:settings",lp,"Ambienceshader",_)
										end
									end,
								false)
								addEventHandler("onDgsMouseClick",GUI.Button[22],
									function(btn,state)
										if(btn=="left" and state=="down")then
											local amount=tonumber(dgsGetText(GUI.Edit[22]))
											if(amount>=100 and amount<=300)then
												triggerServerEvent("set:settings",lp,"loadDistance",amount)
												--for _,v in pairs(loadDistanceTable)do
												--	engineSetModelLODDistance(v[1],getClientData("loadDistance"))
												--end
											end
										end
									end,
								false)
							end
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
end)

addEvent("refresh:settingsmenu",true)
addEventHandler("refresh:settingsmenu",root,function(typ)
	if(typ=="Blurshader")then
		if(tonumber(getClientData("Blurshader"))==1)then
			dgsSetText(GUI.Label[20],"Blurshader: off")
		elseif(tonumber(getClientData("Blurshader"))==2)then
			dgsSetText(GUI.Label[20],"Blurshader: on")
		end
	elseif(typ=="Ambienceshader")then
		if(tonumber(getClientData("Ambienceshader"))==1)then
			dgsSetText(GUI.Label[21],"Ambienceshader: off")
		elseif(tonumber(getClientData("Ambienceshader"))==2)then
			dgsSetText(GUI.Label[21],"Ambienceshader: on")
		end
	elseif(typ=="loadDistance")then
		dgsSetText(GUI.Label[22],"LOD Distance: "..getClientData("loadDistance").."")
	end
end)