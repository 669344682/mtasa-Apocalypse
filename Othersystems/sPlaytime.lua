--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/sPlaytime.lua))

local paydayPlayerTimerTable={}
local hungerPlayerTimerTable={}
local thirstPlayerTimerTable={}

function startPaydayPlayerTimer(player)
	if(not(isTimer(paydayPlayerTimerTable[player])))then
		paydayPlayerTimerTable[player]=setTimer(function()
			startPlayerPayday(player)
		end,1*60*1000,0)
	end
end
function startHungerPlayerTimer(player)
	if(not(isTimer(hungerPlayerTimerTable[player])))then
		local rdm=math.random(2,3)
		hungerPlayerTimerTable[player]=setTimer(function()
			hungerLoss(player)
		end,rdm*60*1000,0)
	end
end
function startThirstPlayerTimer(player)
	if(not(isTimer(thirstPlayerTimerTable[player])))then
		local rdm=math.random(1,2)
		thirstPlayerTimerTable[player]=setTimer(function()
			ThirstLoss(player)
		end,rdm*60*1000,0)
	end
end

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(paydayPlayerTimerTable[source]))then
		killTimer(paydayPlayerTimerTable[source])
	end
	if(isTimer(hungerPlayerTimerTable[source]))then
		killTimer(hungerPlayerTimerTable[source])
	end
end)

function startPlayerPayday(player)
	if(isElement(player))then
		if(getElementData(player,"Loggedin")==1)then
			setData(player,"Playtime",tonumber(getData(player,"Playtime"))+1)
			
			checkPremiumStatus(player)
			if(math.floor(getData(player,"Playtime")/60)==(getData(player,"Playtime")/60))then
				savePlayerData(player)
				
				
				if(not(isPremium(player)))then
					outputChatBox("Playtime bonus: x150 Coins",player,0,200,0)
					setData(player,"Coins",tonumber(getData(player,"Coins"))+150)
				else
					outputChatBox("Playtime bonus: x300 Coins",player,0,200,0)
					setData(player,"Coins",tonumber(getData(player,"Coins"))+300)
				end
			end
		end
	end
end

function hungerLoss(player)
	if(isElement(player))then
		if(getElementData(player,"Loggedin")==1)then
			local hunger=tonumber(getData(player,"Hunger"))
			setData(player,"Hunger",hunger-1)
			--if(hunger<25)then
			--	setElementHealth(player,getElementHealth(player)-math.floor((25-hunger)/2*20)/10)
			--end
			if(hunger<1)then
				killPed(player)
				setData(player,"Hunger",30)
				outputChatBox("You died because of hunger!",player,200,0,0)
			end
			if(hunger==20)then
				outputChatBox("You are hungry!",player,200,0,0)
			elseif(hunger==15)then
				outputChatBox("You are hungry!",player,200,0,0)
			elseif(hunger==10)then
				outputChatBox("You are hungry!",player,200,0,0)
			end
		end
	end
end
function ThirstLoss(player)
	if(isElement(player))then
		if(getElementData(player,"Loggedin")==1)then
			local Thirst=tonumber(getData(player,"Thirst"))
			setData(player,"Thirst",Thirst-1)
			if(Thirst<1)then
				killPed(player)
				setData(player,"Thirst",30)
				outputChatBox("You died because of Thirst!",player,200,0,0)
			end
			if(Thirst==20)then
				outputChatBox("You are Thirsty!",player,200,0,0)
			elseif(Thirst==15)then
				outputChatBox("You are Thirsty!",player,200,0,0)
			elseif(Thirst==10)then
				outputChatBox("You are Thirsty!",player,200,0,0)
			end
		end
	end
end