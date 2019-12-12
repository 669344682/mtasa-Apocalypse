--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Othersystems/Toplist/sFunctions.lua))

addEvent("get:toplistdata",true)
addEventHandler("get:toplistdata",root,function(category)
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM Userstats ORDER BY "..category.." DESC;"),-1)
	if(#result>=1)then
		for i,v in pairs(result)do
			table.insert(tbl,{v["Username"],v[category]})
			if(i>=10)then
				break
			end
		end
	end
	triggerClientEvent(client,"set:toplistdata",client,tbl)
end)