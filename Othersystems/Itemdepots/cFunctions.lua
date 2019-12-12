--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Itemdepots/cFunctions.lua))

addEvent("open:itemdepotUI",true)
addEventHandler("open:itemdepotUI",root,function(coins,pizza,pastacan,ravioli,cola,pepsi,jerrycan,medkit,repairkit)
	if(getElementData(lp,"Loggedin")==1)then
		if(not isPedInVehicle(lp))then
			if(getElementData(lp,"ElementClicked")==false)then
				setWindowData("add","cursor_clicked",true)
				dgsSetInputMode("no_binds")
				dgsSetInputMode("no_binds_when_editing")
				GUI.Window[1]=dgsCreateWindow(GLOBALscreenX/2-300/2,GLOBALscreenY/2-380/2,300,380,settings.generel.servername.." - Itemdepot",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
				dgsWindowSetSizable(GUI.Window[1],false)
				dgsWindowSetMovable(GUI.Window[1],false)
				GUI.Button[1]=dgsCreateButton(274,-25,26,25,"×",false,GUI.Window[1],_,_,_,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
				dgsSetProperty(GUI.Button[1],"textSize",{1.6,1.6})
				
				
				GUI.Label[1]=dgsCreateLabel(45,5,200,60,"Coins: x"..coins.." Pizza: x"..pizza.." Jerrycan: x"..jerrycan.."\nCola: x"..cola.." First Aid Kit: x"..medkit.." Repairkit: x"..repairkit.."\nPastacan: x"..pastacan.." Pepsi: x"..pepsi.." Ravioli: x"..ravioli,false,GUI.Window[1],_,_,_,_,_,_,"center",_)
				
				GUI.Radio[1]=dgsCreateRadioButton(10,70,11,11,"Coins",false,GUI.Window[1])
				GUI.Radio[2]=dgsCreateRadioButton(115,70,11,11,"Pizza",false,GUI.Window[1])
				GUI.Radio[7]=dgsCreateRadioButton(115,90,11,11,"Pastacan",false,GUI.Window[1])
				GUI.Radio[9]=dgsCreateRadioButton(115,110,11,11,"Ravioli",false,GUI.Window[1])
				GUI.Radio[3]=dgsCreateRadioButton(115,130,11,11,"Cola",false,GUI.Window[1])
				GUI.Radio[8]=dgsCreateRadioButton(115,150,11,11,"Pepsi",false,GUI.Window[1])
				GUI.Radio[4]=dgsCreateRadioButton(10,90,11,11,"Jerrycan",false,GUI.Window[1])
				GUI.Radio[5]=dgsCreateRadioButton(10,110,11,11,"First Aid Kit",false,GUI.Window[1])
				GUI.Radio[6]=dgsCreateRadioButton(10,130,11,11,"Repairkit",false,GUI.Window[1])
				
				dgsCreateLabel(7,205,100,20,"Amount",false,GUI.Window[1])
				GUI.Edit[1]=dgsCreateEdit(5,220,290,40,"",false,GUI.Window[1],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
				GUI.Button[2]=dgsCreateButton(5,265,290,40,"Source",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				GUI.Button[3]=dgsCreateButton(5,310,290,40,"Outsource",false,GUI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
				
				
				dgsRadioButtonSetSelected(GUI.Radio[1],true)
				
				addEventHandler("onDgsMouseClick",GUI.Button[3],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(GUI.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(GUI.Radio[1]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Coins",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[2]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Pizza",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[3]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Cola",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[4]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Jerrycan",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[5]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","FirstAidKit",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[6]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Repairkit",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[7]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Pastacan",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[8]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Pepsi",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[9]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payout","Ravioli",amount)
								end
							end
						end
					end,
				false)
				addEventHandler("onDgsMouseClick",GUI.Button[2],
					function(btn,state)
						if(btn=="left" and state=="down")then
							local amount=dgsGetText(GUI.Edit[1])
							
							if(amount~="" and isOnlyNumbers(amount))then
								if(dgsRadioButtonGetSelected(GUI.Radio[1]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Coins",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[2]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Pizza",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[3]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Cola",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[4]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Jerrycan",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[5]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","FirstAidKit",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[6]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Repairkit",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[7]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Pastacan",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[8]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Pepsi",amount)
								elseif(dgsRadioButtonGetSelected(GUI.Radio[9]))then
									triggerServerEvent("payin_payout:itemdepotitems",lp,"payin","Ravioli",amount)
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

addEvent("refresh:itemdepotitems",true)
addEventHandler("refresh:itemdepotitems",root,function(coins,pizza,pastacan,ravioli,cola,pepsi,jerrycan,medkit,repairkit)
	if(isElement(GUI.Window[1]))then
		dgsSetText(GUI.Label[1],"Coins: x"..coins.." Pizza: x"..pizza.." Jerrycan: x"..jerrycan.."\nCola: x"..cola.." First Aid Kit: x"..medkit.." Repairkit: x"..repairkit.."\nPastacan: x"..pastacan.." Pepsi: x"..pepsi.." Ravioli: x"..ravioli)
	end
end)