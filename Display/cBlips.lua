--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Display/cBlips.lua))

customBlipTable={}

function createCustomBlip(x,y,w,h,image,pradius)
	table.insert(customBlipTable,{posX=x,posY=y,width=w,height=h,path=image,radius=pradius})
	return exports.customblips:createCustomBlip(x,y,w,h,image,pradius)
end

createCustomBlip(1177.1,-1323.6,20,20,"Files/Images/Radar/Blips/Hospital.png",40)
createCustomBlip(-2655,637,20,20,"Files/Images/Radar/Blips/Hospital.png",40)
createCustomBlip(-2026.2,156.4,20,20,"Files/Images/Radar/Blips/Tankstation.png",40)
createCustomBlip(-1676.5,412,20,20,"Files/Images/Radar/Blips/Tankstation.png",40)
createCustomBlip(1941.8,-1774.9,20,20,"Files/Images/Radar/Blips/Tankstation.png",40)