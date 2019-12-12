--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Admin/cFunctions.lua))

function getPOS()
	if(getElementData(lp,"AdminLvL")>=3)then
		x,y,z=getElementPosition(lp)
		xr,yr,zr=getElementRotation(lp)
		outputChatBox("Your Position: "..x..", " ..y..", " ..z,239,100,0)
		outputChatBox("Your Rotation: "..xr..", " ..yr..", " ..zr,239,100,0)
		
		setClipboard(x..","..y..","..z)
	end
end
addCommandHandler("pos",getPOS)