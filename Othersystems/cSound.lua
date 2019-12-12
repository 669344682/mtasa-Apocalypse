--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY & Lars-Marcel))
--((File: Othersystems/cSound.lua))

soundsTable={}
function playSound3D_ogg_Func(player,sound,x,y,z,loop,volume)
	local vehicle=getPedOccupiedVehicle(player)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".ogg",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
	if vehicle then
		attachElements(soundsTable[sound],vehicle)
	end
end
addEvent("playSound3D_ogg",true)
addEventHandler("playSound3D_ogg",root,playSound3D_ogg_Func)

addEvent("playSound_ogg",true)
addEventHandler("playSound_ogg", root, function(sound, loop, volume)
	if (soundsTable[sound] ~= nil and isElement(soundsTable[sound])) then
		stopSound(soundsTable[sound])
		soundsTable[sound] = nil
	end
	
	if (loop == nil) then loop = false end
	if (volume == nil) then volume = 0.6 end
	
	soundsTable[sound] = playSound("Files/Sounds/"..sound..".ogg", loop)
	setSoundVolume(soundsTable[sound], volume)
end)

function playSound3D_mp3_Func(player,sound,x,y,z,loop,volume)
	local vehicle=getPedOccupiedVehicle(player)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".mp3",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
	if(not vehicle)then
	
	else
		attachElements(soundsTable[sound],vehicle)
	end
end
addEvent("playSound3D_mp3",true)
addEventHandler("playSound3D_mp3",root,playSound3D_mp3_Func)
function playSound3D_mp3_not_attach_Func(sound,x,y,z,loop,volume)
	if (soundsTable[sound]~=nil and isElement(soundsTable[sound]))then
		stopSound(soundsTable[sound])
		soundsTable[sound]=nil
	end
	if (loop==nil)then loop=false end
	if (volume==nil)then volume=0.6 end
	soundsTable[sound]=playSound3D("Files/Sounds/"..sound..".mp3",x,y,z,loop)
	setSoundVolume(soundsTable[sound],volume)
end
addEvent("playSound3D_mp3_not_attach",true)
addEventHandler("playSound3D_mp3_not_attach",root,playSound3D_mp3_not_attach_Func)

addEvent("playSound_mp3", true)
addEventHandler("playSound_mp3", root, function(sound,endung, loop, volume)
	if (soundsTable[sound] ~= nil and isElement(soundsTable[sound])) then
		stopSound(soundsTable[sound])
		soundsTable[sound] = nil
	end
	
	if (loop == nil) then loop = false end
	if (volume == nil) then volume = 0.6 end
	
	soundsTable[sound] = playSound("Files/Sounds/"..sound.."."..endung.."", loop)
	setSoundVolume(soundsTable[sound], volume)
end)









local citysounds={":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Helicopter.mp3"}
local ambiencesounds={
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_1.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_2.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_3.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_4.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_5.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_6.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_7.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_8.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_9.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_10.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_11.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_12.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_13.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_14.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_15.ogg",
	":"..settings.generel.scriptname.."/Files/Sounds/Ambience/Ambience_16.ogg",
}

local ambience=true
local ambiencesound=nil

local rdmTime=math.random(50,80)
function playAmbienceMusic()
	if(getElementData(lp,"Loggedin")==1)then
		if(not(isPedDead(lp)))then
			if(ambience)then
				ambiencesound=playSound(ambiencesounds[math.random(1,#ambiencesounds)],false)
				if(ambiencesound~=nil)then
					setSoundVolume(ambiencesound,0.5)
				end
			end
		end
	end
end
setTimer(playAmbienceMusic,rdmTime*1000,0)

local rdmTime=math.random(10,30)
function PlayCityAmbience()
	if(getElementData(lp,"Loggedin")==1)then
		local x,y,z=getElementPosition(lp)
		local city=getZoneName(x,y,z)
		if(city=="Los Santos" or city=="Las Venturas" or city=="San Fierro")then
			playSound(citysounds[math.random(1,#citysounds)],false)
		else
			return
		end
	end
end
setTimer(PlayCityAmbience,rdmTime*60*1000,0)