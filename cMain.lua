--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: cMain.lua))

lp=getLocalPlayer()
setOcclusionsEnabled(false)
loadstring(exports.dgs:dgsImportFunction())()

GUI={Window={},Button={},Label={},Edit={},Image={},Blurbox={},Progressbar={},Radio={},Tabpanel={},Tab={},Gridlist={},ScrollBar={}}

GLOBALscreenX,GLOBALscreenY=guiGetScreenSize()
Gsx=GLOBALscreenX/1920
Gsy=GLOBALscreenY/1080

dxFONT=dxCreateFont("Files/Fonts/BEBAS.ttf",14)
dxFONT2=dxCreateFont("Files/Fonts/SEGOEUI.ttf",10)
dxFONT3=dxCreateFont("Files/Fonts/Arial.ttf",12)
dxFONT4=dxCreateFont("Files/Fonts/Roboto-Thin.ttf",11)



addEventHandler("onClientResourceStart",resourceRoot,function()
	lakeZVersion=settings.generel.servername.." v."..settings.generel.scriptversion
	versionLabel=guiCreateLabel(1,1,0.3,0.3,lakeZVersion,true)
	guiSetSize(versionLabel,guiLabelGetTextExtent(versionLabel),guiLabelGetFontHeight(versionLabel),false)
	x,y=guiGetSize(versionLabel,true)
	guiSetPosition(versionLabel,1-x,1-y*1.8,true)
	guiSetAlpha(versionLabel,0.5)
end)

function setWindowData(typ,typ2,typ3)
	if(typ=="add")then
		if(typ2=="cursor_clicked")then
			showCursor(true)
			setElementData(lp,"ElementClicked",true)
		end
	end
	if(typ=="rem")then
		if(typ2=="cursor_clicked")then
			showCursor(false)
			setElementData(lp,"ElementClicked",false)
		end
	end
end

addEventHandler("onClientPlayerWasted",lp,function()
	if(isElement(GUI.Window[1]))then
		dgsCloseWindow(GUI.Window[1])
		setWindowData("rem","cursor_clicked")
	end
end)

function isMouseInPosition(x,y,width,height)
	if(not isCursorShowing())then
		return false
	end
    local cx,cy=getCursorPosition()
    local cx,cy=(cx*GLOBALscreenX),(cy*GLOBALscreenY)
    if((cx>=x and cx<=x+width)and(cy>=y and cy<=y+height))then
        return true
    else
        return false
    end
end

local OnlyNumbersTable={"a","b","c","d","e","f","g","h","i","j","k","l","m","o","p","y","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z","ä","ü","ö","Ä","Ü","Ö"," ",",","#","'","+","*","~",":",";","=","}","?","\\","{","&","/","§","\"","!","°","@","|","`","´","-","+"}

function isOnlyNumbers(text)
	local counter=0
	for _,v in ipairs(OnlyNumbersTable)do
		if(string.find(text,v))then
			counter=counter+1
			break
		end
	end
	if(counter>=1)then
		triggerEvent("draw:infobox",lp,"error","Only numbers are allowed!")
		return false
	else
		return true
	end
end


addEvent("sync:weather",true)
addEventHandler("sync:weather",root,function(id)
	setWeather(tonumber(id))
end)

function isPedAiming(ped)
	if(ped and isElement(ped))then
		if(getElementType(ped)=="player" or getElementType(ped)=="ped")then
			if(getPedTask(ped,"secondary",0)=="TASK_SIMPLE_USE_GUN")then
				return true
			end
		end
	end
	return false
end


function ResetRotor1_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.016)then
			setHelicopterRotorSpeed(heli,0)
		else
			setHelicopterRotorSpeed(heli,(h*0.935))
		end
	end
end
function ResetRotor2_Func(heli)
	local h=tonumber(getHelicopterRotorSpeed(heli))
	if(h)then
		if(h<0.22)then
			setHelicopterRotorSpeed(heli,h*1.01)
		else
			setHelicopterRotorSpeed(heli,0.22)
		end
	end
end
function ResetRotor_Func()
	local veh=getElementsByType("vehicle")
	for _,v in ipairs(veh)do
		local m=getElementModel(v)
		if((m==548)or(m==425)or(m==417)or(m==487)or(m==588)or(m==497)or(m==563)or(m==447)or(m==469)or(m==488))then
			if getVehicleEngineState(v) then
				ResetRotor2_Func(v)
			else
				ResetRotor1_Func(v)
			end
		end
	end
end
addEventHandler("onClientPreRender",root,ResetRotor_Func)


function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end