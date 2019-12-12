--((Project: LakeZ - Zombie Apocalypse))
--((Developers: DorteY))
--((File: Mysql/cFunctions.lua))

function startIfPlayerJoin()
	fadeCamera(true)
	showChat(false)
	setCameraMatrix(-2005.4,194,46.2,-2004.8,193.3,45.8)
	setElementDimension(lp,0)
	
	triggerServerEvent("check:account",lp)
end
addEventHandler("onPlayerJoin",resourceRoot,startIfPlayerJoin)
addEventHandler("onClientResourceStart",resourceRoot,startIfPlayerJoin)

function openRegisterLoginUI(typ)
	local rdm=math.random(1,3)
	
	JoinMusic=playSound("Files/Sounds/RegisterLogin.mp3",true)
	setSoundVolume(JoinMusic,0.5)
	setPlayerHudComponentVisible("radar",false)
	setWindowData("add","cursor_clicked")
	GUI.Image[100]=dgsCreateImage(0,0,GLOBALscreenX,GLOBALscreenY,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/BG_"..rdm..".png")
	dgsSetEnabled(GUI.Image[100],false)
	dgsSetInputMode("no_binds")
	dgsSetInputMode("no_binds_when_editing")
	
	if(typ=="Register")then
		GUI.Window[100]=dgsCreateWindow(GLOBALscreenX/2-440/2,GLOBALscreenY/2-390/2,440,0,settings.generel.servername.." - Register",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsSizeTo(GUI.Window[100],440,390,false,false,"Linear",2000)
		dgsWindowSetSizable(GUI.Window[100],false)
		dgsWindowSetMovable(GUI.Window[100],false)
		dgsSetRenderSetting("postGUI",false)
		GUI.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(GUI.Window[100],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],GUI.Blurbox[1])
		
		
		GUI.Image[1]=dgsCreateImage(10,50,45,45,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/User.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Edit[1]=dgsCreateEdit(65,50,360,45,"",false,GUI.Window[100],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Progressbar[1]=dgsCreateProgressBar(65,95,360,4,false,GUI.Window[100])
		
		GUI.Image[2]=dgsCreateImage(5,120,45,45,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/Pass.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Edit[2]=dgsCreateEdit(65,120,360,45,"",false,GUI.Window[100],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Progressbar[2]=dgsCreateProgressBar(65,165,360,4,false,GUI.Window[100])
		
		GUI.Image[3]=dgsCreateImage(5,190,45,45,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/Pass.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Edit[3]=dgsCreateEdit(65,190,360,45,"",false,GUI.Window[100],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Progressbar[3]=dgsCreateProgressBar(65,235,360,4,false,GUI.Window[100])
		
		GUI.Image[4]=dgsCreateImage(5,260,45,40,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/Gender.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Radio[1]=dgsCreateRadioButton(65,265,11,11,"Male",false,GUI.Window[100])
		GUI.Radio[2]=dgsCreateRadioButton(65,285,11,11,"Female",false,GUI.Window[100])
		
		GUI.Button[1]=dgsCreateButton(10,320,420,35,"create your account",false,GUI.Window[100],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local username=dgsGetText(GUI.Edit[1])or ""
					local password=dgsGetText(GUI.Edit[2])or ""
					local password2=dgsGetText(GUI.Edit[3])or ""
					
					if(dgsRadioButtonGetSelected(GUI.Radio[1])==true)then
						gender="Male"
					elseif(dgsRadioButtonGetSelected(GUI.Radio[2])==true)then
						gender="Female"
					end
					if(username:len()>=3 and username:len()<=20)then
						if(password:len()>=3)then
							if(password==password2)then
								triggerServerEvent("register:account",lp,username,password,gender)
							else
								triggerEvent("draw:infobox",lp,"error","The passwords do not match!")
							end
						else
							triggerEvent("draw:infobox",lp,"error","Please enter a Password! (3 characters or higher)")
						end
					else
						triggerEvent("draw:infobox",lp,"error","Please enter a Username! (3-20 characters)")
					end
				end
			end,
		false)
		
		
		dgsSetAlpha(GUI.Button[1],0)
		dgsSetAlpha(GUI.Edit[1],0)
		dgsSetAlpha(GUI.Edit[2],0)
		dgsSetAlpha(GUI.Edit[3],0)
		dgsSetAlpha(GUI.Progressbar[1],0)
		dgsSetAlpha(GUI.Progressbar[2],0)
		dgsSetAlpha(GUI.Progressbar[3],0)
		dgsSetAlpha(GUI.Image[1],0)
		dgsSetAlpha(GUI.Image[2],0)
		dgsSetAlpha(GUI.Image[3],0)
		dgsSetAlpha(GUI.Image[4],0)
		dgsSetAlpha(GUI.Radio[1],0)
		dgsSetAlpha(GUI.Radio[2],0)
		
		dgsSetVisible(GUI.Button[1],false)
		dgsSetVisible(GUI.Edit[1],false)
		dgsSetVisible(GUI.Edit[2],false)
		dgsSetVisible(GUI.Edit[3],false)
		dgsSetVisible(GUI.Progressbar[1],false)
		dgsSetVisible(GUI.Progressbar[2],false)
		dgsSetVisible(GUI.Progressbar[3],false)
		dgsSetVisible(GUI.Image[1],false)
		dgsSetVisible(GUI.Image[2],false)
		dgsSetVisible(GUI.Image[3],false)
		dgsSetVisible(GUI.Image[4],false)
		dgsSetVisible(GUI.Radio[1],false)
		dgsSetVisible(GUI.Radio[2],false)
		
		setTimer(function()
			dgsSetVisible(GUI.Button[1],true)
			dgsSetVisible(GUI.Edit[1],true)
			dgsSetVisible(GUI.Edit[2],true)
			dgsSetVisible(GUI.Edit[3],true)
			dgsSetVisible(GUI.Progressbar[1],true)
			dgsSetVisible(GUI.Progressbar[2],true)
			dgsSetVisible(GUI.Progressbar[3],true)
			dgsSetVisible(GUI.Image[1],true)
			dgsSetVisible(GUI.Image[2],true)
			dgsSetVisible(GUI.Image[3],true)
			dgsSetVisible(GUI.Image[4],true)
			dgsSetVisible(GUI.Radio[1],true)
			dgsSetVisible(GUI.Radio[2],true)
			dgsAlphaTo(GUI.Button[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Edit[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Edit[2],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Edit[3],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Progressbar[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Progressbar[2],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Progressbar[3],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[2],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[3],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[4],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Radio[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Radio[2],1,false,"Linear",2000)
			
			dgsEditSetMasked(GUI.Edit[2],true)
			dgsEditSetMasked(GUI.Edit[3],true)
			dgsRadioButtonSetSelected(GUI.Radio[1],true)
		end,2200,1)
	elseif(typ=="Login")then
		GUI.Window[100]=dgsCreateWindow(GLOBALscreenX/2-440/2,GLOBALscreenY/2-390/2,440,0,settings.generel.servername.." - Login",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsSizeTo(GUI.Window[100],440,390,false,false,"Linear",2000)
		dgsWindowSetSizable(GUI.Window[100],false)
		dgsWindowSetMovable(GUI.Window[100],false)
		dgsSetRenderSetting("postGUI",false)
		GUI.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(GUI.Window[100],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],GUI.Blurbox[1])
		
		
		GUI.Image[1]=dgsCreateImage(5,80,45,45,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/User.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Edit[1]=dgsCreateEdit(65,80,360,45,"",false,GUI.Window[100],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Progressbar[1]=dgsCreateProgressBar(65,125,360,4,false,GUI.Window[100])
		
		GUI.Image[2]=dgsCreateImage(5,155,45,45,":"..settings.generel.scriptname.."/Files/Images/RegisterLogin/Pass.png",false,GUI.Window[100],tocolor(255,255,255,255))
		GUI.Edit[2]=dgsCreateEdit(65,155,360,45,"",false,GUI.Window[100],tocolor(255,255,255,255),_,_,_,tocolor(50,50,50,255))
		GUI.Progressbar[2]=dgsCreateProgressBar(65,200,360,4,false,GUI.Window[100])
		
		GUI.Button[1]=dgsCreateButton(10,310,420,45,"log in into your account",false,GUI.Window[100],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local username=dgsGetText(GUI.Edit[1])or ""
					local password=dgsGetText(GUI.Edit[2])or ""
					if(password:len()>=3 and password:len()<=25)then
						triggerServerEvent("login:account",lp,username,password)
					end
				end
			end,
		false)
		
		
		dgsSetAlpha(GUI.Button[1],0)
		dgsSetAlpha(GUI.Edit[1],0)
		dgsSetAlpha(GUI.Edit[2],0)
		dgsSetAlpha(GUI.Progressbar[1],0)
		dgsSetAlpha(GUI.Progressbar[2],0)
		dgsSetAlpha(GUI.Image[1],0)
		dgsSetAlpha(GUI.Image[2],0)
		
		dgsSetVisible(GUI.Button[1],false)
		dgsSetVisible(GUI.Edit[1],false)
		dgsSetVisible(GUI.Edit[2],false)
		dgsSetVisible(GUI.Progressbar[1],false)
		dgsSetVisible(GUI.Progressbar[2],false)
		dgsSetVisible(GUI.Image[1],false)
		dgsSetVisible(GUI.Image[2],false)
		
		setTimer(function()
			dgsSetVisible(GUI.Button[1],true)
			dgsSetVisible(GUI.Edit[1],true)
			dgsSetVisible(GUI.Edit[2],true)
			dgsSetVisible(GUI.Progressbar[1],true)
			dgsSetVisible(GUI.Progressbar[2],true)
			dgsSetVisible(GUI.Image[1],true)
			dgsSetVisible(GUI.Image[2],true)
			dgsAlphaTo(GUI.Button[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Edit[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Edit[2],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Progressbar[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Progressbar[2],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[1],1,false,"Linear",2000)
			dgsAlphaTo(GUI.Image[2],1,false,"Linear",2000)
			
			dgsEditSetMasked(GUI.Edit[2],true)
		end,2200,1)
	end
end
addEvent("open:registerlogin",true)
addEventHandler("open:registerlogin",root,openRegisterLoginUI)



addEvent("destroy:registerlogin",true)
addEventHandler("destroy:registerlogin",root,function()
	if(isElement(GUI.Window[100]))then
		dgsSetAlpha(GUI.Button[1],100)
		dgsSetAlpha(GUI.Edit[1],100)
		dgsSetAlpha(GUI.Edit[2],100)
		if(isElement(GUI.Edit[3]))then
			dgsSetAlpha(GUI.Edit[3],100)
		end
		dgsSetAlpha(GUI.Progressbar[1],100)
		dgsSetAlpha(GUI.Progressbar[2],100)
		if(isElement(GUI.Progressbar[3]))then
			dgsSetAlpha(GUI.Progressbar[3],100)
		end
		dgsSetAlpha(GUI.Image[1],100)
		dgsSetAlpha(GUI.Image[2],100)
		if(isElement(GUI.Image[3]))then
			dgsSetAlpha(GUI.Image[3],100)
			dgsSetAlpha(GUI.Image[4],100)
		end
		if(isElement(GUI.Radio[1]))then
			dgsSetAlpha(GUI.Radio[1],100)
			dgsSetAlpha(GUI.Radio[2],100)
		end
		--[[dgsAlphaTo(GUI.Button[1],0,false,"Linear",1000)
		dgsAlphaTo(GUI.Edit[1],0,false,"Linear",1000)
		dgsAlphaTo(GUI.Edit[2],0,false,"Linear",1000)
		if(isElement(GUI.Edit[3]))then
			dgsAlphaTo(GUI.Edit[3],0,false,"Linear",1000)
		end
		dgsAlphaTo(GUI.Progressbar[1],0,false,"Linear",1000)
		dgsAlphaTo(GUI.Progressbar[2],0,false,"Linear",1000)
		if(isElement(GUI.Progressbar[3]))then
			dgsAlphaTo(GUI.Progressbar[3],0,false,"Linear",1000)
		end
		dgsAlphaTo(GUI.Image[1],0,false,"Linear",1000)
		dgsAlphaTo(GUI.Image[2],0,false,"Linear",1000)
		if(isElement(GUI.Image[3]))then
			dgsAlphaTo(GUI.Image[3],0,false,"Linear",1000)
			dgsAlphaTo(GUI.Image[4],0,false,"Linear",1000)
		end
		if(isElement(GUI.Radio[1]))then
			dgsAlphaTo(GUI.Radio[1],0,false,"Linear",1000)
			dgsAlphaTo(GUI.Radio[2],0,false,"Linear",1000)
		end
		setTimer(function()
			dgsSizeTo(GUI.Window[100],440,0,false,false,"Linear",2400)
		end,2200,1)]]
		setTimer(function()
			if(isElement(GUI.Window[100]))then
				dgsCloseWindow(GUI.Window[100])
				showChat(true)
				setWindowData("rem","cursor_clicked")
				setPlayerHudComponentVisible("radar",true)
			end
			if(isElement(JoinMusic))then
				destroyElement(JoinMusic)
			end
			if(isElement(GUI.Image[100]))then
				destroyElement(GUI.Image[100])
			end
		end,1000,1)
	end
end)












local skinSped=nil
local curskin=0
local rdmDIM=math.random(20000,30000)


function openSkinSelector()
	showChat(false)
	setTimer(function()
		showChat(false)
		if(isElement(GUI.Window[100]))then
			dgsCloseWindow(GUI.Window[100])
		end
		if(isElement(GUI.Window[3]))then
			dgsCloseWindow(GUI.Window[3])
		end
		if(getClientData("Gender")=="Male")then
			startSkinID=1
		elseif(getClientData("Gender")=="Female")then
			startSkinID=11
		end
		
		
		setCameraInterior(14)
		setCameraMatrix(254.7190,-41.1370,1002,256.7190,-41.1370,1002)
		skinSped=createPed(startSkinID,258,-42,1002)
		setElementDimension(skinSped,rdmDIM)
		setElementInterior(skinSped,14)
		setElementInterior(lp,14)
		setElementDimension(lp,rdmDIM)
		setPedRotation(skinSped,87)
		setElementDimension(skinSped,getElementDimension(lp))
		fadeCamera(true,1,0,0,0)
		
		GUI.Window[3]=dgsCreateWindow(20,20,420,300,"select your skin",false,tocolor(255,255,255),nil,nil,settings.generel.guibarcolor,nil,settings.generel.guimaincolor,nil,true)
		dgsWindowSetSizable(GUI.Window[3],false)
		dgsWindowSetMovable(GUI.Window[3],false)
		setWindowData("add","cursor_clicked",false)
		
		GUI.Blurbox[1]=dgsCreateBlurBox()
		dgsSetProperty(GUI.Window[3],"functions",[[
			local arguments = {...}
			local blurbox = arguments[1]
			local renderArguments = renderArguments
			local x,y,w,h = renderArguments[1],renderArguments[2],renderArguments[3],renderArguments[4]
			dgsBlurBoxRender(blurbox,x,y,w,h)
		]],GUI.Blurbox[1])
		
		GUI.Button[1]=dgsCreateButton(20,120,180,55,"<- Previous Skin",false,GUI.Window[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		GUI.Button[2]=dgsCreateButton(220,120,180,55,"Next Skin ->",false,GUI.Window[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		GUI.Button[3]=dgsCreateButton(20,200,380,55,"select this skin!",false,GUI.Window[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
		
		
		addEventHandler("onDgsMouseClick",GUI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					changeSkinClick()
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					changeSkinClick()
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",GUI.Button[3],
			function(btn,state)
				if(btn=="left" and state=="up")then
					if(isElement(GUI.Window[3]))then
						dgsCloseWindow(GUI.Window[3])
					end
					setWindowData("rem","cursor_clicked")
					showCursor(false)
					showChat(true)
					triggerServerEvent("select:skin",lp,getElementModel(skinSped))
				end
			end,
		false)
	end,6000,1)
end
addEvent("open:skinselector",true)
addEventHandler("open:skinselector",root,openSkinSelector)

function changeSkinClick()
	local diff=0
	if(source==GUI.Button[2])then
		diff=1
	elseif(source==GUI.Button[1])then
		diff=-1
	else
		curskin=1
	end
	changeSkin(diff)
end

function changeSkin(diff)
	local array=getSkinGender()
	local skin=0
	if(diff~=nil)then
		curskin=curskin+diff
	end
	if(curskin>#array or curskin<1)then
		curskin=1
		skin=array[1]
	else
		curskin=curskin
		skin=array[curskin]
	end
	if(skin~=nil)then
		setElementModel(skinSped,tonumber(skin))
	end
end

function getSkinGender()
	local array={}
	if(getClientData("Gender")=="Male")then 
		array=maleSkins
	elseif(getClientData("Gender")=="Female")then 
        array=femaleSkins
	end
	return array
end






