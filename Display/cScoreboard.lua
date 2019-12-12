--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Display/cScoreboard.lua))

local updateTimer
local scroll=0
local playerCounter=0
plp={}

function refreshScoreboard()
	playerCounter=0
	if(getElementData(lp,"Loggedin")==1)then
		plp={}
		local i=0
		for i,v in ipairs(getElementsByType("player"))do
			local ping=getPlayerPing(v)
			local name=getPlayerName(v)
			
			if(getElementData(v,"Loggedin")==1)then
				level=getElementData(v,"Level")
				fraktion=getElementData(v,"Gruppe")
				playingtime=tonumber(getElementData(v,"Playtime"))
				playtime=math.floor(playingtime/60)..":"..(playingtime-math.floor(playingtime/60)*60)
				kills=tonumber(getElementData(v,"Kills"))
				deaths=tonumber(getElementData(v,"Deaths"))
				zombkills=tonumber(getElementData(v,"ZombieKills"))
			else
				level="-"
				fraktion="-"
				playingtime="-"
				playtime="-"
				kills="-"
				deaths="-"
				zombkills="-"
			end
			
			plp[i]={}
			plp[i].name=name
			plp[i].level=level
			plp[i].fraktion=fraktion
			plp[i].playingtime=playingtime
			plp[i].playtime=playtime
			plp[i].kills=kills
			plp[i].deaths=deaths
			plp[i].zombkills=zombkills
			plp[i].ping=ping
			
			playerCounter=playerCounter+1
			
			i=i+1
		end
		table.sort(plp,function(a,b)
			return a.name<b.name
		end)
	end
end

function getPingColor(ping)
	if ping<=50 then
		return 0,200,0
	elseif ping<=150 then
		return 200,200,0
	else
		return 200,0,0
	end
end

function drawScoreboard()
	local rr,gg,bb,aa=10,10,10,160
	local width=660
	if(getElementData(lp,"Loggedin")==1)then
		if(isPlayerMapVisible(lp)==false)then
			if(getElementData(lp,"ElementClicked")==false)then
				if(getElementData(lp,"intchange")==false)then
					di=0
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2,width,30,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+32,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+59,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+86,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+113,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+140,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+167,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+194,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+221,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+248,width,25,tocolor(rr,gg,bb,aa),_)
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+275,width,25,tocolor(rr,gg,bb,aa),_)
					
					dxDrawText("Name",GLOBALscreenX/2-width/2+20,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Level",GLOBALscreenX/2-width/2+180,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Play time",GLOBALscreenX/2-width/2+230,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Group",GLOBALscreenX/2-width/2+300,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Kills",GLOBALscreenX/2-width/2+415,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Deaths",GLOBALscreenX/2-width/2+455,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Zombiekills",GLOBALscreenX/2-width/2+515,GLOBALscreenY/2-400/2+5,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					dxDrawText("Ping",GLOBALscreenX/2-width/2+615,GLOBALscreenY/2-400/2+4,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
					
					for i=0+scroll,10+scroll do
						if(plp[i])then
							pingR,pingG,pingB=getPingColor(plp[i].ping)
							fraktion=plp[i].fraktion
							
							dxDrawText(plp[i].name,GLOBALscreenX/2-width/2+20,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].level,GLOBALscreenX/2-width/2+180,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].playtime,GLOBALscreenX/2-width/2+230,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].fraktion,GLOBALscreenX/2-width/2+300,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].kills,GLOBALscreenX/2-width/2+415,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].deaths,GLOBALscreenX/2-width/2+455,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].zombkills,GLOBALscreenX/2-width/2+515,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(255,255,255,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							dxDrawText(plp[i].ping,GLOBALscreenX/2-width/2+615,GLOBALscreenY/2-400/2+35+(di*27),width,400,tocolor(pingR,pingG,pingB,255),1.00,dxFONT2,"left","top",_,_,false,_,_)
							
							di=di+1
						end
					end
					
					dxDrawRectangle(GLOBALscreenX/2-width/2,GLOBALscreenY/2-400/2+302,width,30,tocolor(rr,gg,bb,aa),false)
					
					dxDrawText("Players: "..playerCounter.."", GLOBALscreenX/2-width/2+5,GLOBALscreenY/2-400/2+305,width,400,tocolor(255,255,255,255),1.10,dxFONT2,"left","top",_,_,false,_,_)
				end
			end
		end
	end
end

function scrollDown()
	if(#getElementsByType("player")-scroll<2)then
		scroll=#getElementsByType("player")
	else
		scroll=scroll+2
	end
end

function scrollUp()
	if(scroll<=2)then
		scroll=0
	else
		scroll=scroll-2
	end
end

bindKey("tab","down",function()
	addEventHandler("onClientRender",root,drawScoreboard)
	refreshScoreboard()
	if(isTimer(updateTimer))then
		killTimer(updateTimer)
	end
	updateTimer=setTimer(refreshScoreboard,1500,0)
	bindKey("mouse_wheel_down","down",scrollDown)
	bindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",false)
	toggleControl("previous_weapon",false)
	toggleControl("fire",false)
end)

bindKey("tab","up",function()
	removeEventHandler("onClientRender",root,drawScoreboard)
	unbindKey("mouse_wheel_down","down",scrollDown)
	unbindKey("mouse_wheel_up","down",scrollUp)
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	toggleControl("fire",true)
	di=0
	i=0
end)