--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/cDrawText.lua))

addEventHandler("onClientRender",root,function()
	if(getElementData(lp,"Loggedin")==1)then
		if(not(isPedDead(lp)))then
			for _,v in pairs(getElementsByType("ped"))do
				if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
					if(getElementData(v,"set:pedtext"))then
						local px,py,pz=getPedBonePosition(v,8)
						local x,y,z=getPedBonePosition(lp,8)
						
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8 and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false))then
							local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true)
							
							if(sx and sy)then
							
							local peddescription=getElementData(v,"set:peddescription")
							if(peddescription)then
								peddescription=getElementData(v,"set:peddescription")
							else
								peddescription="-"
							end
								if(isPlayerMapVisible(lp)==false)then
									if(getElementData(lp,"ElementClicked")==false)then
										dxDrawText(getElementData(v,"set:peddescription"),sx,sy-30,sx,sy,tocolor(255,255,255,255),1.0,"default","center","center")
										dxDrawText(getElementData(v,"set:pedtext"),sx,sy,sx,sy,tocolor(0,80,200,255),1.5,"default","center","center")
									end
								end
							end
						end
					elseif(getElementData(v,"zombie")and getElementData(v,"zombie")==true)then
						local px,py,pz=getPedBonePosition(v,8)
						local x,y,z=getPedBonePosition(lp,8)
						
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8 and isLineOfSightClear(px,py,pz,x,y,z,true,false,false,true,false))then
							local sx,sy=getScreenFromWorldPosition(px,py,pz+0.5,1000,true)
							
							if(sx and sy)then
								if(isPlayerMapVisible(lp)==false)then
									if(getElementData(lp,"ElementClicked")==false)then
										--dxDrawText(getElementData(v,"set:peddescription"),sx,sy-30,sx,sy,tocolor(255,255,255,255),1.0,"default","center","center")
										dxDrawText("Zombie",sx,sy+30,sx,sy,tocolor(160,0,0,255),1.5,"default","center","center")
									end
								end
							end
						end
					end
				end
			end
			for _,v in pairs(getElementsByType("object"))do
				if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
					local px,py,pz=getElementPosition(lp)
					local x,y,z=getElementPosition(v)
					if(getElementModel(v)==1686 or getElementModel(v)==1676)then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=8)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							if(sx and sy)then
								if(getElementData(lp,"ElementClicked")==false)then
									if(isPlayerMapVisible(lp)==false)then
										dxDrawText("Click on this tankstation to buy a gas canister.\nPrice: x150 Coins",sx,sy-42,sx,sy,tocolor(255,255,255,255),0.90,dxFONT3,"center")
									end
								end
							end
						end
					elseif(getElementModel(v)==1271 and getElementData(v,"itemdepot")==true)then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=6)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							if(sx and sy)then
								if(getElementData(lp,"ElementClicked")==false)then
									if(isPlayerMapVisible(lp)==false)then
										dxDrawText("ID: "..getElementData(v,"itemdepotID")or "",sx,sy+180,sx,sy,tocolor(255,255,255,255),0.90,dxFONT3,"center")
										dxDrawText("Itemdepot",sx,sy+200,sx,sy,tocolor(255,255,255,255),0.90,dxFONT3,"center")
									end
								end
							end
						end
					elseif(getElementModel(v)==2969 and getElementData(v,"loot")==true)then
						if(getDistanceBetweenPoints3D(px,py,pz,x,y,z)<=2.5)then
							local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
							if(sx and sy)then
								if(getElementData(lp,"ElementClicked")==false)then
									if(isPlayerMapVisible(lp)==false)then
										dxDrawText("Loot",sx,sy+210,sx,sy,tocolor(255,255,255,255),1.10,"default-bold","center")
										dxDrawText("Click with 'M' on this box",sx,sy+240,sx,sy,tocolor(255,255,255,255),1.05,"default","center")
									end
								end
							end
						end
					end
				end
			end
			for _,v in pairs(getElementsByType("player"))do
				if(getElementData(lp,"Gruppe")==getElementData(v,"Gruppe"))then
					if(getElementData(lp,"Gruppe")~="none")then
						if(getElementData(v,"Gruppe")~="none")then
							if(v~=lp)then
								if(getElementDimension(lp)==getElementDimension(v)and getElementInterior(lp)==getElementInterior(v))then
									local px,py,pz=getElementPosition(lp)
									local x,y,z=getElementPosition(v)
									
									local sx,sy=getScreenFromWorldPosition(x,y,z+1.7,1000,true)
									if(sx and sy)then
										if(getElementData(lp,"ElementClicked")==false)then
											if(isPlayerMapVisible(lp)==false)then
												dxDrawText(getPlayerName(v).."\n("..math.floor(getDistanceBetweenPoints3D(px,py,pz,x,y,z)).."m)",sx,sy+60,sx,sy,tocolor(255,255,255,255),0.90,dxFONT3,"center")
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)









