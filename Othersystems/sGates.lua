--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/sGates.lua))

local Gate_1_Object=createObject(5020,214.7,1875.6,13.8,0,0,90)
local Gate_1_MovedState=false

--//Move gate functions
function moveSpecialGate(player,cmd,typ)
	if(typ=="area")then
		if(tonumber(getData(player,"Keycard"))>=1)then
			if(getDistanceBetweenPoints3D(214.7,1875.6,13.8,getElementPosition(player))<20)then
				if(Gate_1_MovedState==false)then
					moveObject(Gate_1_Object,3000,214.7,1875.6,10.5,0,0,0)
					Gate_1_MovedState=true
					setTimer(closeGateArea,10*60*1000,1)
				end
			end
		end
	end
end
addCommandHandler("fusaf6dsdhzsah",moveSpecialGate)

function closeGateArea()
	Gate_1_MovedState=false
	moveObject(Gate_1_Object,3000,214.7,1875.6,13.8,0,0,0)
end