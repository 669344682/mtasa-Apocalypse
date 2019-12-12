--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: shTables.lua))

Vehicles={}
Itemdepots={}
Loot={}
gotLastHit={}

devMode=false

settings={
	generel={
		servername="LakeZ Apocalypse",
		scriptname="selfmade",
		scriptversion="1.9",
		discordurl="https://discord.gg/6hdxzUZ",
		websiteurl="https://lake-gaming.com/",
		
		days={"So","Mo","Di","Mi","Do","Fr","Sa"},
		
		lastHitTimer=1*60*1000,
		
		guibarcolor=tocolor(130,0,0,255),
		guimaincolor=tocolor(40,40,40,255),
		guilinecolor=tocolor(150,0,0,200),
	},
	group={
		createprice=45000,
		ranknames={
			[3]="Leader",
			[2]="Co-Leader",
			[1]="Member",
			[0]="Newbie",
		},
	},
	admin={
		levelnames={
			[4]="Owner",
			[3]="Administrator",
			[2]="Moderator",
			[1]="Supporter",
			[0]="Player",
		},
		colorToHASH={
			[4]="#c80000",
			[3]="#017e00",
			[2]="#007dd4",
			[1]="#c5be00",
			[0]="#ffffff",
		},
	},
	level={
		[1]=1000,
		[2]=2000,
		[3]=3000,
		[4]=4000,
		[5]=5000,
		[6]=6000,
		[7]=7000,
		[8]=8000,
		[9]=9000,
		[10]=10000,
		[11]=11000,
		[12]=12000,
		[13]=13000,
		[14]=14000,
		[15]=15000,
		[16]=16000,
		[17]=17000,
		[18]=18000,
		[19]=19000,
		[20]=20000,
		[21]=21000,
		[22]=22000,
		[23]=23000,
		[24]=24000,
		[25]=25000,
		[26]=26000,
		[27]=27000,
		[28]=28000,
		[29]=29000,
		[30]=30000,
		[31]=31000,
		[32]=32000,
		[33]=33000,
		[34]=34000,
		[35]=35000,
		[36]=36000,
		[37]=37000,
		[38]=38000,
		[39]=39000,
		[40]=40000,
		[41]=41000,
		[42]=42000,
		[43]=43000,
		[44]=44000,
		[45]=45000,
		[46]=46000,
		[47]=47000,
		[48]=48000,
		[49]=49000,
		[50]=50000,
		[51]=1,
	},
	notallowedcaracters={"!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]","none"},
}

othertables={
	["facts"]={
		[1]="Our Discord\nURL: "..settings.generel.discordurl.."",
		[2]=settings.generel.servername.." is being\ndeveloped regularly.",
	},
	["Toplist"]={
		{"Kills"},{"Deaths"},{"Damage"},{"ZombieKills"},
	},
}

weaponDamageTable={
	[0]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[4]={[3]=10,[4]=9,[5]=5,[6]=5,[7]=5,[8]=5,[9]=20},
	[8]={[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=25},
	[10]={[3]=9,[4]=9,[5]=9,[6]=9,[7]=9,[8]=9,[9]=9},
	[16]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
	[17]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[18]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
	[22]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=15},
	[23]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=15},
	[24]={[3]=49,[4]=40,[5]=29,[6]=29,[7]=35,[8]=35,[9]=65},
	[25]={[3]=25,[4]=25,[5]=20,[6]=20,[7]=20,[8]=20,[9]=35},
	[26]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=35},
	[27]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=40},
	[28]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
	[29]={[3]=9,[4]=9,[5]=8,[6]=8,[7]=8,[8]=8,[9]=12},
	[32]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
	[30]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=14},
	[31]={[3]=9,[4]=9,[5]=7,[6]=7,[7]=7,[8]=7,[9]=12},
	[33]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=12,[9]=20},
	[34]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=12,[9]=200},
	[35]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
	[36]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
	[37]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=12},
	[38]={[3]=8,[4]=8,[5]=6,[6]=6,[7]=6,[8]=6,[9]=12},
	[39]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200},
	[51]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200}
}

loadDistanceTable={
{616},
{3900},
{3899},
{2932},
{16773},
{3976},
{1649},
{11305},
{970},
{7910},--Werbetafeln
{3334},--Werbeschilder
{944},
{8661},
{17950},
{11313},
{14528},--Stopper
{3890},--Blitzer
{968},--Orange Schranke
{966},--Orange Schranke Halterung
{2934},--RedContainer
{3043},--BlueContainer
{2935},--YellowContainer
{2036},--New Sirene
{1676},--Tanken
{11293},--Das hinter den Tanken(Riesen Fässer)
--//Baüme Stämme
{13369},
{846},
{839},
{847},

{3947},
{2979},
{2324},
{2401},
{2779},
{3938},
{2754},
{2689},
{2992},
{14622},
{899},
{733},
{901},
}




maleSkins={1,2,7}
femaleSkins={11,12,40}







--//Functions
function damagePlayer(player,amount,damager,weapon)
	local amount=amount
	if(isElement(player))then
		local armor=getPedArmor(player)
		local health=getElementHealth(player)
		local died=false
		if(armor>0)then
			if(armor>=amount)then
				setPedArmor(player,armor-amount)
			else
				setPedArmor(player,0)
				local newamount=amount-armor
				if(health-newamount<=0)then
					killPed(player,damager,weapon,3,false)
					amount=armor+health
					died=true
				else
					setElementHealth(player,health-newamount)
				end
			end
		else
			if(health-amount<=0)then
				amount=health
				killPed(player,damager,weapon,3,false)
				died=true
			else
				setElementHealth(player,health-amount)
			end
		end
	end
end


function getElementSpeed(element,unit)
	if(unit==nil)then
		unit=0
	end
	if(isElement(element))then
		local x,y,z=getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit=="1")then
			return(x^2+y^2+z^2)^0.5*100
		else
			return(x^2+y^2+z^2)^0.5*1.91*100
		end
	else
		return false
	end
end
function setElementSpeed(element,unit,speed)
	if(unit==nil)then unit=0 end
	if(speed==nil)then speed=0 end
	speed=tonumber(speed)
	local acSpeed=getElementSpeed(element,unit)
	if(acSpeed~=false)then
		local diff=speed/acSpeed
		local x,y,z=getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
	return false
end


function stringTextWithAllParameters(...)
	local tbl={...}
	return table.concat(tbl," ")
end