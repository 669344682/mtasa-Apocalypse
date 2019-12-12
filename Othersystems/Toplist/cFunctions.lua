--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Toplist/cFunctions.lua))

bindKey("f5","down",function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedDead(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-500/2,GLOBALscreenY/2-420/2,500,420,settings.generel.servername.." - Toplist",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(474,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				GUI.Gridlist[1]=dgsCreateGridList(5,5,200,380,false,GUI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
				GUI.ScrollBar[1]=dgsGridListGetScrollBar(GUI.Gridlist[1])
				dgsSetProperty(GUI.ScrollBar[1],"troughColor",tocolor(50,50,50,255))
				dgsSetProperty(GUI.ScrollBar[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
				dgsSetProperty(GUI.Gridlist[1],"rowColor",{tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255)})
				toplistcategory=dgsGridListAddColumn(GUI.Gridlist[1],"category",0.6)
				
				GUI.Label[1]=dgsCreateLabel(212,10,160,200,"Choose a category.",false,GUI.Window[1])
				
				
				for _,v in pairs(othertables["Toplist"])do
					local row=dgsGridListAddRow(GUI.Gridlist[1])
					dgsGridListSetItemText(GUI.Gridlist[1],row,toplistcategory,v,false,false)
				end
				
				dgsGridListSetSortEnabled(GUI.Gridlist[1],false)
				
				addEventHandler("onDgsMouseClick",GUI.Gridlist[1],
					function(btn,state)
						if(btn=="left" and state=="up")then
							local item=dgsGridListGetSelectedItem(GUI.Gridlist[1])
							if(item>0)then
								local clicked=dgsGridListGetItemText(GUI.Gridlist[1],dgsGridListGetSelectedItem(GUI.Gridlist[1]),1)
								if(clicked~="")then
									triggerServerEvent("get:toplistdata",lp,clicked)
								end
							else
								dgsSetText(GUI.Label[1],"Choose a category.")
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

addEvent("set:toplistdata",true)
addEventHandler("set:toplistdata",root,function(tbl)
	if(#tbl>=1)then
		local text=""
		for i=1,#tbl do
			text=text..i..". "..tbl[i][1].." (x"..tbl[i][2]..")\n"
		end
		dgsSetText(GUI.Label[1],text)
	end
end)