--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/sDiscord.lua))

local Webhook1URL=""--Restart/Join-Quit Log
local Webhook2URL=""--Loot respawn Log
local Webhook3URL=""--Chat Log

function sendMessageToDiscordServer(typ,msg)
	if(devMode==false)then
		sendOptions={
			formFields={
				content=" "..msg..""
			},
		}
		if(typ==1)then
			fetchRemote(Webhook1URL,sendOptions,callback)
		elseif(typ==2)then
			fetchRemote(Webhook2URL,sendOptions,callback)
		elseif(typ==3)then
			fetchRemote(Webhook3URL,sendOptions,callback)
		end
	end
end
function callback(msg)
end