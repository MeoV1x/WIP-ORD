--[[
	patchma hub by MyWorld
	optimize the optimized

	IDs of paid accessories:

	-for arms 11159410305,11263254795 or 14255556501,14255554762 or 12344545199,12344591101

	-for legs 14768693948,14768701869 or 11159483910,12652786974

	-for torso 14255528083 or 13421786478 or 14768678294

	or anything else that covers ur torso. examples:
	14532301415,13423624885,11502853991,14053485259,13779879140,14443132226
	can be same stuff but different colors

	there are 54 ways to make a rig with the ids above

	IDs of free accessories:
	3033910400,3409612660,3438342658,3398308134,4324158403,3822880197,4154538250,3443038622,4819740796
]]

--no need to get and index the library tables with function names every time the script uses them
local osclock=os.clock
local tspawn=task.spawn
local twait=task.wait
local schar=string.char
local ssub=string.sub
local sfind=string.find
local supper=string.upper
local mrandom=math.random
local sin=math.sin
local cos=math.cos
local abs=math.abs
local rad=math.rad
local min=math.min
local clamp=math.clamp
local tinsert=table.insert
local tclear=table.clear
local tclone=table.clone
local tfind=table.find
local tunpack=table.unpack

--the script doesnt have to read global varaibles every time to get them
--why not have them saved in local varaibles for faster access times
local pairs=pairs 
local ipairs=ipairs
local next=next
local pcall=pcall
local xpcall=xpcall
local type=type
local typeof=typeof
local game=game

local i=Instance.new 
local v2=Vector2.new 
local v3=Vector3.new
local c3=Color3.new 
local cf=CFrame.new
local cfl=CFrame.lookAt
local angles=CFrame.Angles
local u2=UDim2.new 
local e=Enum 
local rp=RaycastParams.new 
local cs=ColorSequence.new 
local csk=ColorSequenceKeypoint.new 

local sine=osclock()
local deltaTime=0
local v3_0=v3(0,0,0)
local v3_101=v3(1,0,1)
local v3_010=v3(0,1,0)
local v3_001=v3(0,0,1)
local cf_0=cf(0,0,0)
local v3_xz=v3_101*10
local v3_xzL=v3_101*250.1
local v3_net=v3_010*25.01

local function rs(l) 
	l=l or mrandom(8,15) 
	local s="" 
	for i=1,l do 
		if mrandom(1,2)==1 then 
			s=s..schar(mrandom(65,90)) 
		else 
			s=s..schar(mrandom(97,122)) 
		end 
	end 
	return s 
end

--it runs even faster if u call __index and __newindex of metatables of userdata directly
local function getMetamethodFromErrorStack(userdata,f,test)
	local ret=nil
	xpcall(f,function()
		ret=debug.info(2,"f")
	end,userdata,nil,0)
	if (type(ret)~="function") or not test(ret) then
		return f
	end
	return ret
end
local insSet=getMetamethodFromErrorStack(game,function(a,b,c) a[b]=c end,function(f) local a=i("Folder") local b=rs() f(a,"Name",b) return a.Name==b end)
local insGet=getMetamethodFromErrorStack(game,function(a,b) return a[b] end,function(f) local a=i("Folder") local b=rs() a.Name=b return f(a,"Name")==b end)
local cfGet=getMetamethodFromErrorStack(cf_0,function(a,b) return a[b] end,function(f) return f(cf(1,2,3),"Position")==v3(1,2,3) end)
local cfMul=getMetamethodFromErrorStack(cf_0,function(a,b) return a*b end,function(f) return angles(1,2,3)*angles(1,2,3)==f(angles(1,2,3),angles(1,2,3)) end)
local cfAdd=getMetamethodFromErrorStack(cf_0,function(a,b) return a+b end,function(f) return cf(1,2,3)+v3(1,2,3)==f(cf(1,2,3),v3(1,2,3)) end)
local v3Get=getMetamethodFromErrorStack(v3_0,function(a,b) return a[b] end,function(f) return v3(1,2,3).Unit==f(v3(1,2,3),"Unit") end)
--multiplying and adding vector3 is faster if you use the * and + operators

--no need to index instances every time to call their functions
local Clone=insGet(game,"Clone")
local ClearAllChildren=insGet(game,"ClearAllChildren")
local Destroy=insGet(game,"Destroy")
local IsA=insGet(game,"IsA")
local FindFirstChildOfClass=insGet(game,"FindFirstChildOfClass")
local FindFirstChildWhichIsA=insGet(game,"FindFirstChildWhichIsA")
local GetChildren=insGet(game,"GetChildren")
local GetDescendants=insGet(game,"GetDescendants")
local IsDescendantOf=insGet(game,"IsDescendantOf")
local GetPropertyChangedSignal=insGet(game,"GetPropertyChangedSignal")

--findfirstchildofclass faster than getservice
local plrs=FindFirstChildOfClass(game,"Players")
local rus=FindFirstChildOfClass(game,"RunService")
local ws=FindFirstChildOfClass(game,"Workspace")
local uis=FindFirstChildOfClass(game,"UserInputService")
local gs=FindFirstChildOfClass(game,"GuiService")
local lp=insGet(plrs,"LocalPlayer")
local pg=FindFirstChildOfClass(lp,"PlayerGui")
local mouse=insGet(lp,"GetMouse")(lp)
local stepped=insGet(rus,"Stepped")
local heartbeat=insGet(rus,"Heartbeat")
local renderstepped=insGet(rus,"RenderStepped")

local GetPlayers=insGet(plrs,"GetPlayers")
local Raycast=insGet(ws,"Raycast")
local Connect=heartbeat.Connect
local Disconnect=Connect(GetPropertyChangedSignal(game,"CreatorId"),type).Disconnect
local Wait=heartbeat.Wait
local GetMouseLocation=insGet(uis,"GetMouseLocation")
local GetFocusedTextBox=insGet(uis,"GetFocusedTextBox")
local GetMouseDelta=insGet(uis,"GetMouseDelta")
local IsMouseButtonPressed=insGet(uis,"IsMouseButtonPressed")
local IsKeyDown=insGet(uis,"IsKeyDown")

local Inverse=cfGet(cf_0,"Inverse")
local Lerp=cfGet(cf_0,"Lerp")

local guiTheme={
	guiTitle="MeowVis",
	windowTitleColor=c3(1,0,0),
	windowTopColor=c3(0,0,0),
	windowBottomColor=c3(1,0,0.0),
	windowMinimizedSize={X=200,Y=22},
	windowRegularSize={X=200,Y=220},
	buttonsTextColor=c3(1.0,0.0,0.0),
	labelsTextColor=c3(1.0,0.0,0.0),
	listTopColor=c3(0,0,0),
	listBottomColor=c3(0.0,0.0,0.0)
}

local accessorylimbs={

	{meshid="11263221350",textureid="11263219250",C0=angles(1.5707963267948966,0,1.5707963267948966),Name="Left Arm"},
	{meshid="11159370334",textureid="11159284657",C0=angles(-1.5707963267948966,0,1.5707963267948966),Name="Right Arm"},

	{meshid="14255522247",textureid="",C0=angles(1.5707963267948966,0,1.5707963267948966),Name="Left Arm"},
	{meshid="14255522247",textureid="",C0=angles(-1.5707963267948966,0,1.5707963267948966),Name="Right Arm"},

	{meshid="12344207333",textureid="",C0=angles(2,0,0),Name="Left Arm"},
	{meshid="12344206657",textureid="",C0=angles(2,0,0),Name="Right Arm"},

	{meshid="11159370334",textureid="11159285454",C0=angles(1.5707963267948966,0,1.5707963267948966),Name="Left Leg"},
	{meshid="12652772399",textureid="12652775021",C0=cf(0,-0.125,0),Name="Right Leg"},

	{meshid="14768684979",textureid="",C0=angles(0,0,1.5707963267948966),Name="Left Leg"},
	{meshid="14768684979",textureid="",C0=angles(0,0,1.5707963267948966),Name="Right Leg"},

	{meshid="14768666349",textureid="",C0=cf_0,Name="Torso"},
	{meshid="14241018198",textureid="",C0=cf_0,Name="Torso"},
	{meshid="13421774668",textureid="",C0=cf_0,Name="Torso"},

	{meshid="4324138105",textureid="4324138210",C0=cfMul(angles(-1.6144295580947547,1.5707963267948966,0),cf(-0.125,0.3,0)),Name="Left Arm"},
	{meshid="4154474745",textureid="4154474807",C0=cfMul(angles(1.5271630954950384,-1.5707963267948966,0),cf(-0.125,-0.3,0)),Name="Left Arm"},
	{meshid="3030546036",textureid="3650191503",C0=cfMul(angles(1.5271630954950384,1.5707963267948966,0),cf(0.125,-0.3,0)),Name="Right Arm"},
	{meshid="3030546036",textureid="3443321249",C0=cfMul(angles(-1.6144295580947547,-1.5707963267948966,0),cf(0.125,0.3,0)),Name="Right Arm"},
	{meshid="3030546036",textureid="3360974849",C0=cfMul(angles(1.5271630954950384,1.5707963267948966,0),cf(-0.125,-0.35,0)),Name="Left Leg"},
	{meshid="3030546036",textureid="3360978739",C0=cfMul(angles(-1.6144295580947547,-1.5707963267948966,0),cf(-0.125,0.3,0)),Name="Left Leg"},
	{meshid="3030546036",textureid="3033898741",C0=cfMul(angles(1.5271630954950384,-1.5707963267948966,0),cf(0.125,-0.35,0)),Name="Right Leg"},
	{meshid="3030546036",textureid="3409604993",C0=cfMul(angles(-1.6144295580947547,1.5707963267948966,0),cf(0.125,0.3,0)),Name="Right Leg"},
	{meshid="4819720316",textureid="4819722776",C0=angles(0,0,0.2617993877991494),Name="Torso"}
}

local function gp(p,n,cl)
	for i,v in ipairs(GetChildren(p)) do
		if IsA(v,cl) and (insGet(v,"Name")==n) then
			return v
		end
	end
	return nil
end
local function timegp(p,n,c,t)
	t=osclock()+t
	while t>osclock() do
		local r=gp(p,n,c)
		if r then
			return r
		end
		Wait(stepped)
	end
	return nil
end
local function getNetlessVelocity(realVel)
	--if true then return v3_0 end
	--if true then return realVel end
	--if true then return v3_net end
	if v3Get(realVel,"Magnitude")>25.01 then
		return v3Get(realVel,"Unit")*v3_xzL+v3_net
	end
	return realVel*v3_xz+v3_net
end
local sft=1/45
local function getFallingTime(Ypos,destY,gravity)
	local velY=25.01
	local fallingTime=0
	gravity=gravity*sft
	while (Ypos>destY) or (velY>0) do
		fallingTime=fallingTime+sft
		velY=velY-gravity
		Ypos=Ypos+(velY*sft)
	end
	return fallingTime
end
local function getMeshOfPart(v)
	if IsA(v,"MeshPart") then
		return insGet(v,"MeshId"), insGet(v,"TextureID")
	elseif IsA(v,"BasePart") then
		v=FindFirstChildOfClass(v,"SpecialMesh")
		if v then
			return insGet(v,"MeshId"), insGet(v,"TextureId")
		end
	end
	return nil, nil
end
local function makeplaceholder(v)
	if typeof(v)~="Instance" then
		return nil
	end
	if not insGet(v,"Archivable") then
		insSet(v,"Archivable",true)
	end
	v=Clone(v)
	for i,v in ipairs(GetChildren(v)) do
		if IsA(v,"SpecialMesh") then
			insSet(v,"Name",rs())
			ClearAllChildren(v)
		else
			Destroy(v)
		end
	end
	insSet(v,"Name",rs())
	insSet(v,"Anchored",true)
	insSet(v,"CanCollide",false)
	insSet(v,"Transparency",0.25)
	insSet(v,"Parent",ws)
	return v
end
local function emptyfunction() end

local i1=i("Frame") 
local i2=i("Frame") 
local i3=i("Frame") 
local i4=i("ScrollingFrame") 
local i5=i("UIListLayout") 
local i6=i("UIGradient") 
local i7=i("TextBox") 
local i8=i("TextButton") 
local i9=i("UIGradient") 
local i10=i("ScreenGui") 
insSet(i1,"AnchorPoint",v2(0.5,0))
insSet(i1,"Active",true)
insSet(i1,"BorderSizePixel",0)
insSet(i1,"ClipsDescendants",true)
insSet(i1,"Position",u2(0.5,0,0.5,-150))
insSet(i1,"Size",u2(0,guiTheme.windowRegularSize.X,0,guiTheme.windowRegularSize.Y))
insSet(i1,"Name",rs())
insSet(i1,"Parent",i10)
insSet(i2,"BackgroundColor3",c3(1,1,1))
insSet(i2,"BorderSizePixel",0)
insSet(i2,"Size",u2(0,guiTheme.windowRegularSize.X,0,guiTheme.windowRegularSize.Y))
insSet(i2,"Name",rs())
insSet(i2,"Parent",i1)
insSet(i3,"BackgroundColor3",c3(1,1,1))
insSet(i3,"BorderSizePixel",0)
insSet(i3,"Position",u2(0,5,0,guiTheme.windowMinimizedSize.Y-2))
insSet(i3,"Size",u2(1,-10,0,guiTheme.windowRegularSize.Y-guiTheme.windowMinimizedSize.Y-3))
insSet(i3,"Name",rs())
insSet(i3,"Parent",i2)
insSet(i4,"Active",true)
insSet(i4,"BackgroundTransparency",1)
insSet(i4,"BorderSizePixel",0)
insSet(i4,"Size",u2(1,-3,1,0))
insSet(i4,"AutomaticCanvasSize",e.AutomaticSize.Y)
insSet(i4,"CanvasSize",u2(0,0,0,0))
insSet(i4,"ScrollBarThickness",7)
insSet(i4,"Name",rs())
insSet(i4,"Parent",i3)
insSet(i5,"Name",rs())
insSet(i5,"Parent",i4)
insSet(i5,"SortOrder",e.SortOrder.LayoutOrder)
insSet(i6,"Name",rs())
insSet(i6,"Parent",i3)
insSet(i6,"Color",cs({csk(0,guiTheme.listTopColor),csk(1,guiTheme.listBottomColor)}))
insSet(i6,"Rotation",90)
insSet(i7,"Font",e.Font.SourceSans)
insSet(i7,"FontSize",e.FontSize.Size18)
insSet(i7,"ClearTextOnFocus",false)
insSet(i7,"Text",guiTheme.guiTitle)
insSet(i7,"TextColor3",guiTheme.windowTitleColor)
insSet(i7,"TextSize",16)
insSet(i7,"AnchorPoint",v2(0.5,0))
insSet(i7,"BackgroundTransparency",1)
insSet(i7,"Position",u2(0.5,0,0,guiTheme.windowMinimizedSize.Y/2))
insSet(i7,"Name",rs())
insSet(i7,"Parent",i2)
insSet(i8,"AnchorPoint",v2(1,0))
insSet(i8,"BackgroundTransparency",1)
insSet(i8,"Position",u2(1,0,0,0))
insSet(i8,"Size",u2(0,50,0,guiTheme.windowMinimizedSize.Y))
insSet(i8,"Name",rs())
insSet(i8,"Parent",i2)
insSet(i8,"Font",e.Font.SourceSans)
insSet(i8,"FontSize",e.FontSize.Size18)
insSet(i8,"Text","-")
insSet(i8,"TextColor3",c3(1,1,1))
insSet(i8,"TextSize",16)
insSet(i9,"Name",rs())
insSet(i9,"Parent",i2)
insSet(i9,"Color",cs({csk(0,guiTheme.windowTopColor),csk(1,guiTheme.windowBottomColor)}))
insSet(i9,"Rotation",90)
insSet(i10,"ZIndexBehavior",e.ZIndexBehavior.Sibling)
insSet(i10,"IgnoreGuiInset",true)
insSet(i10,"ResetOnSpawn",false)
insSet(i10,"DisplayOrder",2147483647)
insSet(i10,"Name",rs())
local guimin=false
local minloop=false
local i1X=guiTheme.windowRegularSize.X
local i1Y=guiTheme.windowRegularSize.Y
local i1Xdest=i1X
local i1Ydest=i1Y
Connect(insGet(i8,"MouseButton1Click"),function()
	guimin = not guimin
	if guimin then
		i1Xdest=guiTheme.windowMinimizedSize.X
		i1Ydest=guiTheme.windowMinimizedSize.Y
	else
		i1Xdest=guiTheme.windowRegularSize.X
		i1Ydest=guiTheme.windowRegularSize.Y
	end
	if minloop then
		return
	end
	minloop=true
	insSet(i3,"Visible",true) 
	sine=osclock()
	local lastsine=sine
	while true do
		sine=osclock()
		local deltaTime=(sine-lastsine)*10
		lastsine=sine
		local difX=i1Xdest-i1X
		local difY=i1Ydest-i1Y
		if (abs(difY)<=1) and (abs(difX)<=1) then
			i1X=i1Xdest
			i1Y=i1Ydest
			insSet(i1,"Size",u2(0,i1X,0,i1Y))
			break
		end
		i1X=i1X+difX*deltaTime
		i1Y=i1Y+difY*deltaTime
		insSet(i1,"Size",u2(0,i1X,0,i1Y))
		twait()
	end
	insSet(i3,"Visible",not guimin) 
	minloop=false
end)
local function Draggable(window,obj)
	local MB1enum = e.UserInputType.MouseButton1
	local TOUCHenum = e.UserInputType.Touch
	obj = obj or window
	local activeEntered = 0
	local mouseStart = nil
	local dragStart = nil
	local inputbegancon = nil
	local rendersteppedcon = nil
	local inputendedcon = nil
	local function inputendedf(a)
		a=insGet(a,"UserInputType")
		if (a==MB1enum) or (a==TOUCHenum) then
			Disconnect(rendersteppedcon)
			Disconnect(inputendedcon)
		end
	end
	local function rendersteppedf()
		local off = GetMouseLocation(uis)-mouseStart
		insSet(window,"Position",dragStart+u2(0,off.X,0,off.Y))
	end
	local function inputbeganf(a)
		a=insGet(a,"UserInputType")
		if ((a==MB1enum) or (a==TOUCHenum)) and (activeEntered==0) and not GetFocusedTextBox(uis) then
			mouseStart=GetMouseLocation(uis)
			dragStart=insGet(window,"Position")
			if rendersteppedcon then Disconnect(rendersteppedcon) end
			rendersteppedcon = Connect(renderstepped,rendersteppedf)
			if inputendedcon then Disconnect(inputendedcon) end
			inputendedcon = Connect(insGet(uis,"InputEnded"),inputendedf)
		end
	end
	Connect(insGet(obj,"MouseEnter"),function()
		if inputbegancon then Disconnect(inputbegancon) end
		inputbegancon = Connect(insGet(uis,"InputBegan"),inputbeganf)
	end)
	Connect(insGet(obj,"MouseLeave"),function()
		Disconnect(inputbegancon)
	end)
	local function ondes(d)
		if IsA(d,"GuiObject") then
			local thisEntered = false
			local thisAdded = false
			local con0 = Connect(insGet(d,"MouseEnter"),function()
				thisEntered = true
				if (not thisAdded) and insGet(d,"Active") then
					activeEntered = activeEntered + 1
					thisAdded = true
				end
			end)
			local con1 = Connect(insGet(d,"MouseLeave"),function()
				thisEntered = false
				if thisAdded then
					activeEntered = activeEntered - 1
					thisAdded = false
				end
			end)
			local con2 = Connect(GetPropertyChangedSignal(d,"Active"),function()
				if thisEntered then
					if thisAdded and not insGet(d,"Active") then
						activeEntered = activeEntered - 1
						thisAdded = false
					elseif insGet(d,"Active") and not thisAdded then
						activeEntered = activeEntered + 1
						thisAdded = true
					end
				end
			end)
			local con3 = nil
			con3 = Connect(insGet(d,"AncestryChanged"),function()
				if not IsDescendantOf(d,window) then
					if thisEntered then
						activeEntered = activeEntered - 1
					end
					Disconnect(con0)
					Disconnect(con1)
					Disconnect(con2)
					Disconnect(con3)
				end
			end)
		end
	end
	Connect(insGet(window,"DescendantAdded"),ondes)
	for i,v in ipairs(GetDescendants(window)) do 
		ondes(v)
	end
end

local cfr = nil

local function btn(txt, f)
	local i1=i("TextBox") 
	local i2=i("TextButton")
	insSet(i1,"Font",e.Font.SourceSans)
	insSet(i1,"FontSize",e.FontSize.Size14)
	insSet(i1,"Text",txt)
	insSet(i1,"ClearTextOnFocus",false)
	insSet(i1,"Position",u2(0.5,0,0.5,0))
	insSet(i1,"TextColor3",guiTheme.buttonsTextColor)
	insSet(i1,"Name",rs())
	insSet(i1,"Parent",i2)
	insSet(i2,"BackgroundTransparency",1)
	insSet(i2,"TextTransparency",1)
	insSet(i2,"Size",u2(1,0,0,14))
	insSet(i2,"Name",rs())
	if f then 
		Connect(insGet(i2,"MouseButton1Click"),f) 
	end 
	insSet(i2,"Parent",i4)
	return i1
end
local function lbl(txt)
	local i1=i("TextBox") 
	local i2=i("Frame") 
	insSet(i1,"Font",e.Font.SourceSans)
	insSet(i1,"FontSize",e.FontSize.Size14)
	insSet(i1,"Text",txt)
	insSet(i1,"ClearTextOnFocus",false)
	insSet(i1,"TextColor3",guiTheme.labelsTextColor)
	insSet(i1,"Position",u2(0.5,0,0.5))
	insSet(i1,"BackgroundTransparency",1)
	insSet(i1,"Name",rs())
	insSet(i1,"Parent",i2)
	insSet(i2,"Size",u2(1,0,0,14))
	insSet(i2,"BackgroundTransparency",1)
	insSet(i2,"Name",rs())
	insSet(i2,"Parent",i4)
	return i1
end

Draggable(i1)



local allowshiftlock=nil
local ctrltp=nil
local placeholders=nil
local clickfling=nil
local highlightflingtargets=nil
local discharscripts=nil
local flingchangestate=nil
local respawntp=true

local c=nil
local function stopreanimate() 
	if c then
		c=nil
		return true
	end
	return false
end
local function reanimate()
	--[[
		FDless reanimate by MyWorld
		aka no client sided instances
		"what else do i optimize here"
	]]

	local novoid = true --prevents parts from going under workspace.FallenPartsDestroyHeight if you control them
	local speedlimit = 3000 --makes your parts move slower if the magnitude of their velocity is higher than this
	local retVelTime = 0.51 --time that claimed parts have velocity to reclaim in case u lose them
	local walkSpeed = 16 --your walkspeed (can be changed at runtime)
	local jumpPower = 50 --your jump power (can be changed at runtime)
	local gravity = 196.2 --how fast the characters velocity decreases while falling (can be changed at runtime)
	local ctrlclicktp = ctrltp --makes you teleport where u point ur mouse cursor at when click and hold ctrl down
	local clickfling = clickfling --makes you fling the person you clicked when its available to do so
	local flingvel = v3(15000,16000,15000) --the rotation velocity that ur character will have while flinging

	if stopreanimate() then return end
	c=insGet(lp,"Character")
	if not (c and IsDescendantOf(c,ws)) then return end

	local rootpart=gp(c,"HumanoidRootPart","BasePart") or gp(c,"Torso","BasePart") or gp(c,"UpperTorso","BasePart") or timegp(c,"HumanoidRootPart","BasePart",0.5) or FindFirstChildWhichIsA(c,"BasePart")
	if not rootpart then return end

	local cam=nil
	--theres a way to have ws.currentcamera nil on heartbeat and still have the game run normally
	local function refcam()
		local newcam=insGet(ws,"CurrentCamera")
		while not newcam do
			Wait(GetPropertyChangedSignal(ws,"CurrentCamera"))
			newcam=insGet(ws,"CurrentCamera")
		end
		cam=newcam
	end
	refcam()
	local camcf=insGet(cam,"CFrame")
	local enumCamS=e.CameraType.Scriptable
	local camt=insGet(cam,"CameraType")
	local camcon0=nil
	local camcon1=nil
	local camcon2=nil
	local function onnewcamera()
		refcam()
		if camcon0 then 
			Disconnect(camcon0)
			Disconnect(camcon1)
			camcon0=nil
		end
		if not c then 
			if insGet(cam,"CameraType")==enumCamS then
				insSet(cam,"CameraType",camt)
			end
			return Disconnect(camcon2) 
		end
		camcon0=Connect(GetPropertyChangedSignal(cam,"CFrame"),function()
			if insGet(cam,"CFrame")~=camcf then
				insSet(cam,"CFrame",camcf)
			end
		end)
		camcon1=Connect(GetPropertyChangedSignal(cam,"CameraType"),function()
			if insGet(cam,"CameraType")~=enumCamS then
				insSet(cam,"CameraType",enumCamS)
			end
		end)
		if insGet(cam,"CameraType")~=enumCamS then
			insSet(cam,"CameraType",enumCamS)
		end
		if insGet(cam,"CFrame")~=camcf then
			insSet(cam,"CFrame",camcf)
		end
	end
	camcon2=Connect(GetPropertyChangedSignal(ws,"CurrentCamera"),onnewcamera)
	onnewcamera()

	local rGravity=insGet(ws,"Gravity")
	Connect(GetPropertyChangedSignal(ws,"Gravity"),function()
		rGravity=insGet(ws,"Gravity")
	end)

	local fpdh=insGet(ws,"FallenPartsDestroyHeight")
	novoid=novoid and (fpdh+1)

	local Yvel=0
	local cfr=insGet(rootpart,"CFrame")
	local pos=cfGet(cfr,"Position")
	cfr=cfl(pos,pos+cfGet(cfr,"LookVector")*v3_101)
	local primarypart=nil
	local shiftlock=false
	local firstperson=false
	local xzvel=v3_0
	local v3_0150=v3_010*1.5
	local camcfLV=cfGet(camcf,"LookVector")
	local camrot=cfl(v3_0,camcfLV)
	local camcfRV=cfGet(camrot,"RightVector")
	local cammag=-v3Get((cfGet(camcf,"Position")-(pos+v3_0150)),"Magnitude")

	local R6parts={ 
		head={Name="Head"},
		torso={Name="Torso"},
		root={Name="HumanoidRootPart"},
		leftArm={Name="Left Arm"},
		rightArm={Name="Right Arm"},
		leftLeg={Name="Left Leg"},
		rightLeg={Name="Right Leg"}
	}
	rootpart=R6parts.root
	local cframes={}
	for i,v in pairs(R6parts) do
		cframes[v]=cfr
	end
	local joints={
		{
			Name="Neck",
			Part0=R6parts.torso,Part1=R6parts.head,
			C0=cf(0,1,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,-0.5,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="RootJoint",
			Part0=rootpart,Part1=R6parts.torso,
			C0=cf(0,0,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,0,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="Right Shoulder",
			Part0=R6parts.torso,Part1=R6parts.rightArm,
			C0=cf(1,0.5,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(-0.5,0.5,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Shoulder",
			Part0=R6parts.torso,Part1=R6parts.leftArm,
			C0=cf(-1,0.5,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(0.5,0.5,0,0,0,-1,0,1,0,1,0,0)
		},
		{
			Name="Right Hip",
			Part0=R6parts.torso,Part1=R6parts.rightLeg,
			C0=cf(1,-1,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(0.5,1,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Hip",
			Part0=R6parts.torso,Part1=R6parts.leftLeg,
			C0=cf(-1,-1,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(-0.5,1,0,0,0,-1,0,1,0,1,0,0)
		}
	}

	local refreshedjoints={}
	local refreshjointsI=nil
	refreshjointsI=function(part)
		tinsert(refreshedjoints,part)
		for i,v in pairs(joints) do
			local part0=v.Part0
			local part1=v.Part1
			if part1 and (part0==part) then
				cframes[part1]=cfMul(cframes[part],cfMul(v.C0,Inverse(v.C1)))
				if not tfind(refreshedjoints,part1) then
					refreshjointsI(part1)
				end
			elseif part0 and (part1==part) then
				cframes[part0]=cfMul(cframes[part],cfMul(v.C1,Inverse(v.C0)))
				if not tfind(refreshedjoints,part0) then
					refreshjointsI(part0)
				end
			end
		end
	end
	refreshjointsI(rootpart)
	tclear(refreshedjoints)

	local attachments={
		RightShoulderAttachment={R6parts.rightArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		RightGripAttachment={R6parts.rightArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftFootAttachment={R6parts.leftLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftShoulderAttachment={R6parts.leftArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		LeftGripAttachment={R6parts.leftArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		RootAttachment={rootpart,cf(0,0,0,1,0,0,0,1,0,0,0,1)},
		RightFootAttachment={R6parts.rightLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		NeckAttachment={R6parts.torso,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		BodyFrontAttachment={R6parts.torso,cf(0,0,-0.5,1,0,0,0,1,0,0,0,1)},
		BodyBackAttachment={R6parts.torso,cf(0,0,0.5,1,0,0,0,1,0,0,0,1)},
		LeftCollarAttachment={R6parts.torso,cf(-1,1,0,1,0,0,0,1,0,0,0,1)},
		RightCollarAttachment={R6parts.torso,cf(1,1,0,1,0,0,0,1,0,0,0,1)},
		WaistFrontAttachment={R6parts.torso,cf(0,-1,-0.5,1,0,0,0,1,0,0,0,1)},
		WaistCenterAttachment={R6parts.torso,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		WaistBackAttachment={R6parts.torso,cf(0,-1,0.5,1,0,0,0,1,0,0,0,1)},
		HairAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		HatAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		FaceFrontAttachment={R6parts.head,cf(0,0,-0.6,1,0,0,0,1,0,0,0,1)},
		FaceCenterAttachment={R6parts.head,cf(0,0,0,1,0,0,0,1,0,0,0,1)}
	}

	local function getPart(name,blacklist)
		for i,v in pairs(cframes) do
			if (i.Name==name) and not (blacklist and tfind(blacklist,i)) then
				return i
			end
		end
		return nil
	end

	local function getJoint(name)
		for i,v in pairs(joints) do
			if v.Name==name then
				return v
			end
		end
		return {C0=cf_0,C1=cf_0}
	end

	local function getPartFromMesh(m,t,blacklist)
		if blacklist then
			for v,_ in pairs(cframes) do
				if v.m and (not tfind(blacklist,v)) and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		else
			for v,_ in pairs(cframes) do
				if v.m and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		end
		local p={m=m,t=t}
		cframes[p]=cfr
		local j={C0=cf_0,C1=cf_0,Part0=p}
		p.j=j
		return p
	end

	local function getPartJoint(p)
		if cframes[p] then
			local j=p.j
			if j then
				return j
			end
			for i,v in pairs(joints) do
				if v.Part0==p then
					return v
				end
			end
			for i,v in pairs(joints) do
				if v.Part1==p then
					return v
				end
			end
		end
		return nil
	end

	local function getAccWeldFromMesh(m,t)
		return getPartJoint(getPartFromMesh(m,t))
	end

	local raycastparams=rp()
	raycastparams.FilterType=e.RaycastFilterType.Blacklist
	raycastparams.RespectCanCollide=true
	local rayfilter={}
	local characters={}
	local function refreshrayfilter()
		tclear(rayfilter)
		for i,v in pairs(characters) do
			tinsert(rayfilter,v)
		end
		raycastparams.FilterDescendantsInstances=rayfilter
	end
	local flingtable={}
	local rootparts={}
	for i,v in ipairs(accessorylimbs) do
		v.p=getPart(v.Name)
	end
	local function makePartCons(p,t)
		if (t.p==p) and insGet(p,"Anchored") then
			t.p=nil
		end
		local con0=Connect(GetPropertyChangedSignal(p,"Anchored"),function()
			if insGet(p,"Anchored") then
				if t.p==p then
					t.c=nil
					t.p=nil
				end
			elseif not t.p then
				t.p=p
			end
		end)
		local con1=nil
		con1=Connect(insGet(p,"AncestryChanged"),function()
			if not IsDescendantOf(p,ws) then
				Disconnect(con0)
				Disconnect(con1)
				if t.p==p then
					t.p=nil
				end
			end
		end)
	end
	local ondes=nil
	ondes=function(v)
		if c and IsA(v,"Attachment") and IsDescendantOf(c,ws) then
			local v1=attachments[insGet(v,"Name")]
			if v1 then
				local p=insGet(v,"Parent")
				if insGet(p,"Parent")~=c then
					local meshid,textureid=getMeshOfPart(p)
					if meshid then
						local found=false
						for i,_ in pairs(cframes) do
							if (meshid==i.m) and (textureid==i.t) then
								local p1=i.p
								if p1 and IsDescendantOf(p1,c) then
									if p1==p then
										found=true
										break
									end
								else
									found=true
									i.p=p
									makePartCons(p,i)
									break
								end
							else
								local j=i.j
								if j and sfind(meshid,i.m) and sfind(textureid,i.t) then
									i.m=meshid
									i.t=textureid
									i.l=insGet(p,"Position")
									i.p=p
									makePartCons(p,i)
									i.j=nil
									i.Name=insGet(p,"Name")
									j.C0=insGet(v,"CFrame")
									j.C1=v1[2]
									j.Part1=v1[1]
									tinsert(joints,j)
									found=true
									break
								end
							end
						end
						if not found then
							for i,l in ipairs(accessorylimbs) do
								if l.p and sfind(meshid,l.meshid) and sfind(textureid,l.textureid) then
									local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
									makePartCons(p,t)
									if placeholders then
										t.v=makeplaceholder(p)
									end
									cframes[t]=insGet(p,"CFrame")
									tinsert(joints,{Part0=t,Part1=l.p,C0=l.C0,C1=cf_0})
									l.p=nil
									found=true
									break
								end
							end
							if not found then
								local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
								makePartCons(p,t)
								if placeholders then
									t.v=makeplaceholder(p)
								end
								cframes[t]=insGet(p,"CFrame")
								tinsert(joints,{Part0=t,Part1=v1[1],C0=insGet(v,"CFrame"),C1=v1[2]})
							end
						end
					end
				end
			end
		end
	end

	local charcons={}
	local function onplayer(v)
		local lastc=nil
		local function oncharacter()
			local newc=insGet(v,"Character")
			if c and newc and (newc~=lastc) then
				lastc=newc
				characters[v]=newc
				refreshrayfilter()
				if v==lp then
					if discharscripts then
						Connect(insGet(newc,"DescendantAdded"),discharscripts)
						for i,v in ipairs(GetDescendants(newc)) do
							if IsA(v,"Script") then
								insSet(v,"Disabled",true)
							end
						end
					end
					local hrp=timegp(newc,"HumanoidRootPart","BasePart",10)
					if not (hrp and c and IsDescendantOf(newc,ws)) then return end
					c=newc
					local fi,fv=next(flingtable)
					if fi then
						if flingchangestate then
							local hum=FindFirstChildOfClass(c,"Humanoid")
							if hum then
								insGet(hum,"ChangeState")(hum,e.HumanoidStateType.Physics)
							end
						end
						for i,v in pairs(tclone(flingtable)) do
							if not c then
								return
							end
							local startpos=insGet(i,"Position")
							local stoptime=sine+3
							while true do
								twait()
								if sine>stoptime then
									break
								end
								if insGet(i,"Anchored") or not IsDescendantOf(i,ws) then
									break
								end
								if v3Get((startpos-insGet(i,"Position")),"Magnitude")>200 then
									break
								end
								local tcf=cfAdd(insGet(i,"CFrame"),insGet(i,"AssemblyLinearVelocity")*(sin(sine*15)+1))
								if novoid and (cfGet(tcf,"Y")<novoid) then
									tcf=cfAdd(tcf,v3_010*(novoid-cfGet(tcf,"Y")))
								end
								insSet(hrp,"CFrame",tcf)
								insSet(hrp,"AssemblyLinearVelocity",insGet(i,"AssemblyLinearVelocity")*v3_101*75)
								insSet(hrp,"AssemblyAngularVelocity",flingvel)
							end
							if v then
								Destroy(v)
							end
							flingtable[i]=nil
						end
						insSet(hrp,"AssemblyLinearVelocity",v3_0)
						insSet(hrp,"AssemblyAngularVelocity",v3_0)
						insSet(hrp,"CFrame",cfr)
						twait(0.2501)
					end
					if respawntp then
						local startpos=pos+v3(mrandom(-32,32),0,mrandom(-32,32))
						local dir=nil
						local poscheck=true
						while poscheck do
							poscheck=false
							for i,v in pairs(rootparts) do
								local diff=(startpos-insGet(v,"Position"))*v3_101
								if v3Get(diff,"Magnitude")<10 then
									poscheck=true
									dir=dir or (v3Get(diff,"Unit") * 3)
									startpos=startpos+dir
								end
							end
							local diff=(startpos-pos)*v3_101
							if v3Get(diff,"Magnitude")<10 then
								poscheck=true
								dir=dir or (v3Get(diff,"Unit") * 3)
								startpos=startpos+dir
							end
						end
						startpos=cfAdd(cfGet(cfr,"Rotation"),startpos)
						insSet(hrp,"CFrame",startpos)
						insSet(hrp,"AssemblyLinearVelocity",v3_0)
						insSet(hrp,"AssemblyAngularVelocity",v3_0)
						twait(0.2501)
					end
					if newc~=c then
						return
					end
					primarypart=insGet(newc,"PrimaryPart") or hrp
					insGet(newc,"BreakJoints")(newc)
					Connect(insGet(newc,"DescendantAdded"),ondes)
					for i,v in ipairs(GetDescendants(newc)) do
						ondes(v)
					end
				else
					local hrp=timegp(newc,"HumanoidRootPart","BasePart",10)
					if hrp and c and IsDescendantOf(newc,ws) then
						rootparts[v]=hrp
					end
				end
			end
		end
		charcons[v]=Connect(GetPropertyChangedSignal(v,"Character"),oncharacter)
		oncharacter()
	end
	for i,v in ipairs(GetPlayers(plrs)) do onplayer(v) end
	Connect(insGet(plrs,"PlayerAdded"),onplayer)
	Connect(insGet(plrs,"PlayerRemoving"),function(v)
		local charcon=charcons[v]
		if charcon then
			Disconnect(charcon)
		end
		characters[v]=nil
		rootparts[v]=nil
	end)

	local mradN05=rad(-0.5)
	local KeyCode=e.KeyCode
	local enumMLC=e.MouseBehavior.LockCenter
	local enumMB2=e.UserInputType.MouseButton2
	local enumMLCP=e.MouseBehavior.LockCurrentPosition
	local enumMD=e.MouseBehavior.Default
	local enumMW=e.UserInputType.MouseWheel
	local enumMM=e.UserInputType.MouseMovement

	local mouseBehavior=nil
	local lastMouseBehavior=insGet(uis,"MouseBehavior")
	Connect(GetPropertyChangedSignal(uis,"MouseBehavior"),function()
		if mouseBehavior and (insGet(uis,"MouseBehavior")~=mouseBehavior) then
			insSet(uis,"MouseBehavior",mouseBehavior)
		end
	end)

	local mode="default"
	local defaultmode={}
	local modes={default=defaultmode}

	local lerpsIdle=emptyfunction
	local lerpsWalk=emptyfunction
	local lerpsJump=emptyfunction
	local lerpsFall=emptyfunction

	local function addmode(key,mode)
		if (type(key)~="string") or (type(mode)~="table") then
			return
		end
		for i,v in pairs(mode) do
			if type(v)~="function" then
				mode[i]=nil
			end
		end
		if key=="default" then
			defaultmode=mode
			modes.default=mode
			lerpsIdle=mode.idle or emptyfunction
			lerpsWalk=mode.walk or emptyfunction
			lerpsJump=mode.jump or emptyfunction
			lerpsFall=mode.fall or emptyfunction
			if mode.modeEntered then
				mode.modeEntered()
			end
		elseif #key==1 then
			key=KeyCode[supper(ssub(key,1,1))]
			modes[key]=mode
		end
	end

	local keyW=KeyCode.W
	local Wpressed=IsKeyDown(uis,keyW)
	local keyA=KeyCode.A
	local Apressed=IsKeyDown(uis,keyA)
	local keyS=KeyCode.S
	local Spressed=IsKeyDown(uis,keyS)
	local keyD=KeyCode.D
	local Dpressed=IsKeyDown(uis,keyD)
	local keySpace=KeyCode.Space
	local jumpingInput=IsKeyDown(uis,keySpace)

	local FWmovement=0
	local RTmovement=0
	local isWalking=false
	local function refreshKeyboardMovement()
		if Wpressed then if Spressed then if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end else FWmovement=1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true end else if Spressed then FWmovement=-1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true else if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end end end
	end
	refreshKeyboardMovement()

	local keyShift=KeyCode.LeftShift
	Connect(insGet(uis,"InputBegan"),function(a)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=true
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=true
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=true
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=true
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=true
		elseif a==keyShift then
			shiftlock=allowshiftlock and not shiftlock
		elseif modes[a] then
			if modes[mode].modeLeft then
				modes[mode].modeLeft()
			end
			if mode==a then
				mode="default"
			else
				mode=a
			end
			local modet=modes[mode]
			lerpsIdle=modet.idle or defaultmode.idle or emptyfunction
			lerpsWalk=modet.walk or defaultmode.walk or emptyfunction
			lerpsJump=modet.jump or defaultmode.jump or emptyfunction
			lerpsFall=modet.fall or defaultmode.fall or emptyfunction
			if modes[mode].modeEntered then
				modes[mode].modeEntered()
			end
		end
	end)
	Connect(insGet(uis,"InputEnded"),function(a)
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=false
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=false
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=false
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=false
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=false
		end
	end)

	local thumbstickEndX=0
	local thumbstickStartY=0

	local thumbstickSizeMultiplier=0

	local jumpStartX=0
	local jumpStartY=0
	local jumpEndX=0
	local jumpEndY=0

	local thumbstickInputObject=nil
	local jumpInputObject=nil
	local cameraRotateInputObject=nil
	local cameraZoomInputObject=nil

	local thumbstickTouchStart=v3_0
	local cameraZoomInputMagnitude=0

	Connect(insGet(uis,"TouchStarted"),function(inputObject)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end

		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")

		if (not thumbstickInputObject) and touchX<thumbstickEndX and touchY>thumbstickStartY then
			thumbstickInputObject=inputObject
			thumbstickTouchStart=insGet(inputObject,"Position")
			isWalking=false
		elseif (not jumpInputObject) and touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY then
			jumpInputObject=inputObject
			jumpingInput=true
		elseif not cameraRotateInputObject then
			cameraRotateInputObject=inputObject
		else
			cameraZoomInputObject=inputObject
			cameraZoomInputMagnitude=v3Get(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"),"Magnitude")
		end
	end)
	Connect(insGet(uis,"TouchMoved"),function(inputObject)
		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")
		if inputObject==thumbstickInputObject then
			local direction=insGet(inputObject,"Position")-thumbstickTouchStart
			local directionMag=v3Get(direction,"Magnitude")/thumbstickSizeMultiplier
			if directionMag>0.05 then
				isWalking=true
				direction=v3Get(direction,"Unit")*min(1,(directionMag-0.05)/0.95) 
				FWmovement=-v3Get(direction,"Y")
				RTmovement=v3Get(direction,"X")
			else
				isWalking=false
			end
		elseif inputObject==jumpInputObject then
			jumpingInput=touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY
		else
			if cameraZoomInputObject then
				local newMagnitude=v3Get(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"),"Magnitude")					
				cammag=cammag+(newMagnitude-cameraZoomInputMagnitude)*0.04*(0.75-cammag/4)
				cameraZoomInputMagnitude=newMagnitude
				if cammag<0 then
					firstperson=false
				else
					cammag=0
					firstperson=true
				end
			elseif inputObject==cameraRotateInputObject then
				local rotation=GetMouseDelta(uis)*mradN05
				camcfLV=cfGet(cfMul(camrot,angles(rotation.Y,rotation.X,0)),"LookVector")
				camrot=cfl(v3_0,camcfLV)
				camcfRV=cfGet(camrot,"RightVector")
			end
		end
	end)
	Connect(insGet(uis,"TouchEnded"),function(inputObject)
		if inputObject==thumbstickInputObject then
			thumbstickInputObject=nil
			isWalking=false
		elseif inputObject==jumpInputObject then
			jumpInputObject=nil
			jumpingInput=false
		elseif inputObject==cameraRotateInputObject then
			cameraRotateInputObject=nil
			cameraZoomInputObject=nil
		elseif inputObject==cameraZoomInputObject then
			cameraZoomInputObject=nil
		end
	end)

	local function refreshTouchRegions()
		local sX=insGet(mouse,"ViewSizeX")
		local sY=insGet(mouse,"ViewSizeY")
		local isSmallScreen=min(sX,sY)<=500

		sY=sY+insGet(gs,"TopbarInset").Height

		thumbstickEndX=sX*0.4
		thumbstickStartY=(sY+0)*0.333

		if isSmallScreen then
			thumbstickSizeMultiplier=35
			jumpStartX=sX-95
			jumpStartY=sY-90
			jumpEndX=jumpStartX+70
			jumpEndY=jumpStartY+70
		else
			thumbstickSizeMultiplier=60
			jumpStartX=sX-170
			jumpStartY=sY-210
			jumpEndX=jumpStartX+120
			jumpEndY=jumpStartY+120
		end
	end
	Connect(GetPropertyChangedSignal(mouse,"ViewSizeX"),refreshTouchRegions)
	Connect(GetPropertyChangedSignal(mouse,"ViewSizeY"),refreshTouchRegions)
	Connect(GetPropertyChangedSignal(gs,"TopbarInset"),refreshTouchRegions)
	refreshTouchRegions()

	local mouseCameraMove=false
	Connect(insGet(uis,"InputChanged"),function(a,b)
		if b then return end
		local inputType=insGet(a,"UserInputType")
		if mouseCameraMove and inputType==enumMM then
			local rotation=GetMouseDelta(uis)*mradN05
			camcfLV=cfGet(cfMul(camrot,angles(rotation.Y,rotation.X,0)),"LookVector")
			camrot=cfl(v3_0,camcfLV)
			camcfRV=cfGet(camrot,"RightVector")
		elseif inputType==enumMW then
			cammag=cammag+v3Get(insGet(a,"Position"),"Z")*(0.75-cammag/4)
			if cammag<0 then
				firstperson=false
			else
				cammag=0
				firstperson=true
			end
		end
	end)

	local function predictionfling(target)
		if not c then
			return false
		end
		if typeof(target)~="Instance" then 
			target=insGet(mouse,"Target")
			if not target then
				return false
			end
		end
		if not IsDescendantOf(target,ws) then
			return false
		end
		if IsA(target,"Humanoid") or IsA(target,"BasePart") then 
			target=insGet(target,"Parent") 
			if IsA(target,"Accessory") then
				target=insGet(target,"Parent")
			end
		end
		if (target==c) or (not IsA(target,"Model")) then
			return false
		end
		local targetpart=gp(target,"HumanoidRootPart","BasePart") or gp(target,"Torso","BasePart") or gp(target,"UpperTorso","BasePart")
		if (not targetpart) or (flingtable[targetpart]~=nil) then
			return false
		end
		if highlightflingtargets then
			local h=i("Highlight")
			insSet(h,"Name",rs())
			insSet(h,"Adornee",target)
			insSet(h,"FillColor",c3(1,0,0))
			insSet(h,"OutlineColor",c3(1,0,0))
			insSet(h,"FillTransparency",0.5)
			insSet(h,"OutlineTransparency",0)
			insSet(h,"Parent",i10)
			flingtable[targetpart]=h
		else
			flingtable[targetpart]=false
		end
		return true
	end

	local clickConnection=nil
	if ctrlclicktp then
		ctrlclicktp=KeyCode.LeftControl
		local tpoff=v3_010*3
		if clickfling then
			clickConnection=Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") then
					if IsKeyDown(uis,ctrlclicktp) then
						pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
						cfr=cfl(pos,pos+camcfLV*v3_101)
						xzvel=v3_0
						Yvel=0
					else
						predictionfling()
					end
				end
			end)
		else
			clickConnection=Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") and IsKeyDown(uis,ctrlclicktp) then
					pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
					cfr=cfl(pos,pos+camcfLV*v3_101)
					xzvel=v3_0
					Yvel=0
				end
			end)
		end
	elseif clickfling then
		clickConnection=Connect(insGet(mouse,"Button1Down"),predictionfling)
	end

	local noYvelTime=1
	local lastsine=sine
	local con=nil
	local function mainFunction()
		if not c then 
			for i,v in pairs(cframes) do
				local p=i.v
				if p then
					Destroy(p)
				end
			end
			for i,v in pairs(flingtable) do
				if v then --it could be false
					Destroy(v)
				end
			end
			for i,v in pairs(charcons) do
				Disconnect(v)
			end
			if clickConnection then
				Disconnect(clickConnection)
			end
			mouseBehavior=nil
			insSet(uis,"MouseBehavior",enumMD)
			onnewcamera()
			local c=insGet(lp,"Character")
			if c then
				insSet(cam,"CameraSubject",FindFirstChildOfClass(c,"Humanoid"))
			end
			return con and Disconnect(con) 
		end

		sine=osclock()
		local delta=sine-lastsine
		deltaTime=min(delta*10,1)
		lastsine=sine

		if shiftlock then
			if allowshiftlock then
				mouseBehavior=enumMLC
				mouseCameraMove=true
			else
				shiftlock=false
			end
		elseif firstperson then
			mouseBehavior=enumMLC
			mouseCameraMove=true
		elseif IsMouseButtonPressed(uis,enumMB2) then
			mouseBehavior=enumMLCP
			mouseCameraMove=true
		else
			mouseBehavior=enumMD
			mouseCameraMove=false
		end
		if lastMouseBehavior~=mouseBehavior then
			lastMouseBehavior=mouseBehavior
			insSet(uis,"MouseBehavior",mouseBehavior)
		end

		local raycastresult=Raycast(ws,pos,v3_010*(fpdh-v3Get(pos,"Y")),raycastparams)
		local onground=nil
		if raycastresult then
			raycastresult=v3Get(raycastresult.Position,"Y")
			onground=v3Get(pos,"Y")-raycastresult<3.01
			if onground then
				Yvel=0
				pos=pos+v3_010*(raycastresult+3-v3Get(pos,"Y"))*min(delta*20,1)
				if jumpingInput and (jumpPower>0) then
					Yvel=jumpPower
					onground=false
				end
			else
				Yvel=Yvel-gravity*delta
				if v3Get(pos,"Y")+Yvel*delta<raycastresult then
					Yvel=0
					pos=pos+v3_010*(raycastresult+3-v3Get(pos,"Y"))
				end
			end
		else
			Yvel=0
			onground=false
		end

		if firstperson then
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=v3Get(v3Get(camcfLV*v3_101,"Unit")*FWmovement+v3Get(camcfRV*v3_101,"Unit")*RTmovement,"Unit")*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else 
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		elseif shiftlock then	
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=v3Get(v3Get(camcfLV*v3_101,"Unit")*FWmovement+v3Get(camcfRV*v3_101,"Unit")*RTmovement,"Unit")*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		else
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=v3Get(v3Get(camcfLV*v3_101,"Unit")*FWmovement+v3Get(camcfRV*v3_101,"Unit")*RTmovement,"Unit")*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		end

		refreshjointsI(rootpart)
		tclear(refreshedjoints)

		local idlerv=v3(sin((sine-0.0375)*16),sin(sine*16),sin((sine+0.075)*16))
		local idleoff=idlerv*0.001

		local claimpos=insGet(primarypart,"Position")
		local claimposY=v3Get(claimpos,"Y")
		for i,v in pairs(cframes) do
			local part=i.p
			if part then
				if insGet(part,"ReceiveAge")==0 then
					local placeholder=i.v
					if placeholder then
						insSet(placeholder,"Parent",nil)
					end
					if novoid and (cfGet(v,"Y")<novoid) then
						v=cfAdd(v,v3_010*(novoid-cfGet(v,"Y")))
					end
					local lastpos=i.l
					local vel=(cfGet(v,"Position")-lastpos)/delta
					if v3Get(vel,"Magnitude")<0.15 then
						v=cfAdd(v,idleoff)
					elseif v3Get(vel,"Magnitude")>speedlimit then
						vel=v3Get(vel,"Unit")*speedlimit
						v=cfAdd(cfGet(v,"Rotation"),lastpos+vel*delta)
					end
					i.l=cfGet(v,"Position")
					local claimtime=i.c
					if claimtime then
						if sine-claimtime<retVelTime then
							insSet(part,"AssemblyLinearVelocity",(claimpos-cfGet(v,"Position"))*v3_101/getFallingTime(cfGet(v,"Y"),claimposY,rGravity)+v3_net)
						else
							insSet(part,"AssemblyLinearVelocity",getNetlessVelocity(vel*noYvelTime+xzvel))
						end
					else
						i.c=sine
						insSet(part,"AssemblyLinearVelocity",getNetlessVelocity(vel*noYvelTime+xzvel))
					end
					insSet(part,"CFrame",v)
					insSet(part,"AssemblyAngularVelocity",idlerv)
				else
					i.c=nil
					i.l=insGet(part,"Position")
					local placeholder=i.v
					if placeholder then
						insSet(placeholder,"Parent",ws)
						insSet(placeholder,"CFrame",v)
					end
				end
			else
				local placeholder=i.v
				if placeholder then
					insSet(placeholder,"Parent",ws)
					insSet(placeholder,"CFrame",v)
				end
			end
		end
	end

	sine=osclock()
	lastsine=sine
	con=Connect(heartbeat,mainFunction)
	mainFunction()

	local function refreshjoints(v) --use this on the main part if u have parts that
		refreshjointsI(v) --are connected with each other but arent connected to rootpart
		tclear(refreshedjoints)
	end

	local legcfR=cf(1,-1,0)
	local legcfL=cf(-1,-1,0)
	local raydir=v3_010*-2
	local function raycastlegs() --this returns 2 values: right leg raycast offset, left leg raycast offset
		local rY=Raycast(ws,cfGet(cfMul(cfr,legcfR),"Position"),raydir,raycastparams)
		local lY=Raycast(ws,cfGet(cfMul(cfr,legcfL),"Position"),raydir,raycastparams)
		return rY and (v3Get(rY.Position,"Y")-(v3Get(pos,"Y")-3)) or 0,lY and (v3Get(lY.Position,"Y")-(v3Get(pos,"Y")-3)) or 0
	end

	local function velbycfrvec() --this returns 2 values: forward/backwards movement (from -1 to 1), right/left movement (from -1 to 1)
		local fw=cfGet(cfr,"LookVector")*xzvel/walkSpeed
		local rt=cfGet(cfr,"RightVector")*xzvel/walkSpeed
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastvel=v3_0
	local velchg1=v3_0
	local function velchgbycfrvec() --this returns 2 values: forward/backwards velocity change, right/left velocity change
		velchg1=velchg1+(lastvel-xzvel) --i recommend setting velchg1 to v3_0 when u start using this function or it will look worse
		lastvel=xzvel
		velchg1=velchg1-velchg1*(deltaTime/2)
		local fw=cfGet(cfr,"LookVector")*velchg1/32
		local rt=cfGet(cfr,"RightVector")*velchg1/32
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastYvel=0
	local velYchg1=0
	local function velYchg() --this returns Y axis velocity change
		velYchg1=clamp(velYchg1+(lastYvel-Yvel),-50,50) --i recommend setting velYchg1 to 0 when u start using this function or it will look worse
		lastYvel=Yvel
		velYchg1=velYchg1-velYchg1*(deltaTime/2)
		return velYchg1
	end

	local function rotToMouse(alpha) --this rotates ur character towards your mouse hit position
		cfr=Lerp(cfr,cfl(pos,pos*v3_010+cfGet(insGet(mouse,"Hit"),"Position")*v3_101),alpha or deltaTime)
	end

	local function glitchJoint(joint,targetGlitchTime,delayFrom,delayTo,radiansFrom,radiansTo) 
		if sine>targetGlitchTime then --local glitchtime=0 addMode("x",{idle=function() glitchtime=glitchJoint(joint,glitchtime,0.2,0.4,-0.1,0.1) end})
			radiansFrom=radiansFrom*100
			radiansTo=radiansTo*100
			joint.C0=cfMul(joint.C0,angles(mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100)) 
			return sine+mrandom(delayFrom*100,delayTo*100)/100
		end
		return targetGlitchTime
	end

	local function setWalkSpeed(n)
		if type(n)~="number" then
			n=16
		end
		walkSpeed=n
	end
	local function setJumpPower(n)
		if type(n)~="number" then
			n=50
		end
		jumpPower=n
	end
	local function setGravity(n)
		if type(n)~="number" then
			n=196.2
		end
		gravity=n
	end
	local function setCfr(v) --sets character cframe
		if typeof(v)=="CFrame" then
			cfr=v
			pos=cfGet(v,"Position")
		end
	end
	local function getVel() --returns character velocity
		return xzvel+v3_010*Yvel --important: use only in lerps or it might not work
	end
	local function getCamCF() --returns camera cframe
		return camcf
	end
	local function isFirstPerson() --returns true if user is in first person camera mode
		return firstperson
	end

	return {
		cframes=cframes,
		joints=joints,
		fling=predictionfling,
		predictionfling=predictionfling,
		refreshjoints=refreshjoints,
		raycastlegs=raycastlegs,
		velbycfrvec=velbycfrvec,
		velchgbycfrvec=velchgbycfrvec,
		velYchg=velYchg,
		addmode=addmode,
		getPart=getPart,
		getPartFromMesh=getPartFromMesh,
		getAccWeldFromMesh=getAccWeldFromMesh,
		getJoint=getJoint,
		getPartJoint=getPartJoint,
		rotToMouse=rotToMouse,
		glitchJoint=glitchJoint,
		setWalkSpeed=setWalkSpeed,
		setJumpPower=setJumpPower,
		setGravity=setGravity,
		setCfr=setCfr,
		getVel=getVel,
		getCamCF=getCamCF,
		isFirstPerson=isFirstPerson
	}
end


btn("Ordinance Glitcher", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local raycastlegs=t.raycastlegs
	local velbycfrvec=t.velbycfrvec
	local addmode=t.addmode
	local getJoint=t.getJoint
	local velYchg=t.velYchg
	local setWalkSpeed=t.setWalkSpeed
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	t.setJumpPower(70)
	local Q = t.getAccWeldFromMesh(11279417526,11279940957)
	local E = t.getAccWeldFromMesh(11279417526,11279995049)
	local R = t.getAccWeldFromMesh(11279417526,11279988714)
	local T = t.getAccWeldFromMesh(11279417526,11279980006)

	local cframes=t.cframes
	local rootpart1=t.getPart("HumanoidRootPart")
	local rootpart=t.getPart("Head")
	local i1=i("TextLabel") 
	local i2=i("BillboardGui") 
	i1.Font=e.Font.Michroma
	i1.FontSize=e.FontSize.Size14 
	i1.Text="ORIDNANCE" 
	i1.TextColor3=c3(1.0,0,0) 
	i1.TextScaled=true 
	i1.TextStrokeTransparency=0 
	i1.BackgroundColor3=c3(0,0,0) 
	i1.BackgroundTransparency=1
	i1.Size=u2(1,0,1,0) 
	i1.Name=rs() 
	i1.Parent=i2 
	i2.AlwaysOnTop=true 
	i2.ClipsDescendants=true 
	i2.LightInfluence=1 
	i2.Size=u2(10,0,1.75,0) 
	i2.StudsOffset=v3(0,1.75,0) 
	i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
	i2.ResetOnSpawn=false 
	i2.Name=rs() 
	i2.Parent=pg 
	tspawn(function() while c do twait() end i2:Destroy() end)
	

	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local function createRedLight(character)
		local hat = character:FindFirstChildWhichIsA("Accessory")
		if not hat then
			character.ChildAdded:Wait()
			hat = character:FindFirstChildWhichIsA("Accessory")
		end
		
		local redLight = Instance.new("PointLight")
		redLight.Color = Color3.new(1, 0, 0) 
		redLight.Brightness = 2 
		redLight.Range = 15 
		
		if hat then
			local handle = hat:FindFirstChild("Handle")
			if handle then
				redLight.Parent = handle
			end
		end
	end

	if player.Character then
		createRedLight(player.Character)
	end
	player.CharacterAdded:Connect(function(character)
		createRedLight(character)
	end)


	
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MyScreenGui" 
	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") 

	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MyScreenGui"
	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") 

	-- Create an ImageLabel
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "MyImageLabel" 
	imageLabel.Size = UDim2.new(0.3, 0.01, 0.6, 0.01)
	imageLabel.Position = UDim2.new(0.98, 0, 0.9, 0) 
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5) 
	imageLabel.Image = "http://www.roblox.com/asset/?id=2397773764" 
	imageLabel.BackgroundTransparency = 1
	imageLabel.Parent = screenGui

	-- Function to rotate the image continuously
	local function rotateImage()
		local rotation = 0
		while true do
			rotation = rotation + 5 
			imageLabel.Rotation = rotation 
			wait(0.00)
		end
	end
	coroutine.wrap(rotateImage)()
	
	
	
	
	
	
	
	
	



	
	

	local sounds = {}

	local function ShadeID(ID, Duration, Looped)
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://" .. ID
		if Looped then
			s.Looped = true
		end
		sounds[s]=true
		s.Parent = workspace
		s:Play()
		task.wait(Duration)
		sounds[s]=nil
		s:Destroy()
	end

	tspawn(function() 
		while c do
			twait()
		end 
		i2:Destroy()
		i1:Destroy() 
		ShadeID = emptyfunction
		for i,v in pairs(sounds) do
			i:Destroy()
		end
	end)


	--task.spawn(ShadeID, 15689451063, 9999999999, true)

	local Floating = nil

	--AttackClick--
	
local function ShadeID(ID, Duration)
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://" .. ID
		s.Parent = workspace
		s:Play()
		task.wait(Duration)
		s:Destroy()

	end
	tspawn(function() while c do twait() end ShadeID = emptyfunction end)
	
	
	
	
	

	local attackAnimation=nil
	mouse.Button1Down:Connect(function()
		if attackAnimation then return end
		task.spawn(ShadeID, 4958427918, 5)
		attackAnimation=function()
			Q.C0=Lerp(Q.C0,cfMul(cf(4,-1,-4),angles(-1.3962634015954636,-0.6981317007977318,-0.8726646259971648)),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(4,2,3),angles(-0.8726646259971648,-0.6981317007977318,-0.8726646259971648)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,-0.3,0.5),angles(0.4363323129985824,0.7853981633974483,1.5707963267948966)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3,1.5),angles(-1.6580627893946132,0,3.490658503988659)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-1),angles(-0.4363323129985824,1.0471975511965976,-0.2617993877991494)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.6580627893946132,-0.08726646259971647,2.792526803190927)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.8,-0.3),angles(-0.6108652381980153,-1.2217304763960306,-0.4363323129985824)),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(4,-3,-4),angles(-0.8726646259971648,-1.5707963267948966,-0.8726646259971648)),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(4,-3,4),angles(-0.5235987755982988,-0.6981317007977318,0)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,-0.3,0.4),angles(0.4363323129985824,-0.7853981633974483,-1.5707963267948966)),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Purple_Handle,4,0,0,1,-80,0,0,1,-1,0,0,1,-40,0,0,1,-4,0,0,1,-50,0,0,1,ColossalCrystalGreatsword-Black_Handle,4,0,0,1,-50,0,0,1,2,0,0,1,-40,,0,1,3,0,0,1,-50,0,0,1,RightArm,1,0,0,1,25,0,0,1,-0.3,0,0,1,45,0,0,1,0.5,0,0,1,90,0,0,1,Torso,0,0,0,1,-95,0,0,1,3,0,0,0,0,0,0,1,1.5,0,0,1,200,0,0,1,RightLeg,1,0,0,1,-25,0,0,1,-,0,0,1,60,0,0,1,-1,0,0,1,-15,0,0,1,Head,0,0,0,1,-95,0,0,1,1,0,0,1,-5,0,0,1,0,0,0,1,160,0,0,1,LeftLeg,-1,0,0,1,-35,0,0,1,-0.8,0,0,1,-70,0,0,1,-0.3,0,0,1,-25,0,0,1,ColossalCrystalGreatsword-Blue_Handle,4,0,0,1,-50,0,0,1,-3,0,0,1,-90,0,0,1,-4,0,0,1,-50,0,0,1,ColossalCrystalGreatsword-Red_Handle,4,0,0,1,-30,0,0,1,-3,0,0,1,-40,0,0,1,4,0,0,1,,0,0,1,LeftArm,-1,0,0,1,25,0,0,1,-0.3,0,0,1,-45,0,0,1,0.4,0,0,1,-90,0,0,1
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 

		end
		task.wait(0.6)
		task.spawn(ShadeID, 7122613461, 5)
		task.spawn(ShadeID, 2866718318, 5)
		attackAnimation=function()
			Q.C0=Lerp(Q.C0,cfMul(cf(-6,3,-2.5),angles(-0.8726646259971648,-1.1344640137963142,-1.1344640137963142)),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-5,5.6,2.5),angles(-0.8726646259971648,-0.4363323129985824,-0.5235987755982988)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.6,0.1,-1),angles(0.4363323129985824,1.7453292519943295,1.5707963267948966)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3,-1),angles(-2.007128639793479,0,3.6651914291880923)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-1),angles(-0.4363323129985824,1.0471975511965976,0.2617993877991494)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.4835298641951802,-0.08726646259971647,2.705260340591211)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.8,-0.3),angles(-0.6108652381980153,-1.2217304763960306,-0.4363323129985824)),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5,-2,-4),angles(-0.8726646259971648,-1.5707963267948966,-1.0471975511965976)),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-5,-1,4),angles(-0.5235987755982988,-0.6981317007977318,0)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-0.3,0.1,-1.5),angles(0.4363323129985824,-2.443460952792061,-1.7453292519943295)),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Purple_Handle,-6,0,0,1,-50,0,0,1,3,0,0,1,-65,0,0,1,-2.5,0,0,1,-65,0,0,1,ColossalCrystalGreatsword-Black_Handle,-5,0,0,1,-50,0,0,1,5.6,0,0,1,-25,,0,1,2.5,0,0,1,-30,0,0,1,RightArm,0.6,0,0,1,25,0,0,1,0.1,0,0,1,100,0,0,1,-1,0,0,1,90,0,0,1,Torso,0,0,0,1,-115,0,0,1,3,0,0,0,0,0,0,1,-1,0,0,1,210,0,0,1,RightLeg,1,0,0,1,-25,0,0,1,-,0,0,1,60,0,0,1,-1,0,0,1,15,0,0,1,Head,0,0,0,1,-85,0,0,1,1,0,0,1,-5,0,0,1,0,0,0,1,155,0,0,1,LeftLeg,-1,0,0,1,-35,0,0,1,-0.8,0,0,1,-70,0,0,1,-0.3,0,0,1,-25,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-5,0,0,1,-50,0,0,1,-2,0,0,1,-90,0,0,1,-4,0,0,1,-60,0,0,1,ColossalCrystalGreatsword-Red_Handle,-5,0,0,1,-30,0,0,1,-1,0,0,1,-40,0,0,1,4,0,0,1,,0,0,1,LeftArm,-0.3,0,0,1,25,0,0,1,0.1,0,0,1,-140,0,0,1,-1.5,0,0,1,-100,0,0,1
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 

		end
		task.wait(0.9)
		attackAnimation=nil
	end)
	
--------------------------------

	addmode("default", {
		modeEntered=function()
			task.spawn(ShadeID, 1837829473, 5)
			i1.Font=e.Font.SpecialElite
			i1.FontSize=e.FontSize.Size14 
			i1.Text="ORDINANCE" 
			i1.TextColor3=c3(0.1,0,0) -- like this
			i1.TextStrokeColor3=c3(0.75, 0, 0)
			
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			local rY, lY = raycastlegs()
			
			
			local Ychg=velYchg()/20
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25-0.2*sin((sine+0.6)*4),0),angles(1.1344640137963142,-1.2217304763960306-0.12217304763960307*sin((sine+0.1)*4),-1.3962634015954636)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.05*sin((sine+0.45)*4),0),angles(-0.6108652381980153,1.1344640137963142+0.08726646259971647*sin(sine*4),0.2617993877991494+0.08726646259971647*sin(sine*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.35+0.1*sin((sine+0.45)*4),-0.8),angles(0.6108652381980153,-1.0471975511965976-0.08726646259971647*sin(sine*4),0.7853981633974483-0.08726646259971647*sin(sine*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.15-0.2*sin((sine+0.6)*4),0),angles(-0.6108652381980153,0.8726646259971648+0.12217304763960307*sin((sine+0.1)*4),0.6108652381980153-0.12217304763960307*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.8325957145940461+0.03490658503988659*sin((sine+0.6)*4),0.03490658503988659*sin((sine+0.6)*4),3.839724354387525)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.4*sin(sine*4),0.3 * sin((sine+0.25)*4)),angles(-1.7453292519943295+0.08726646259971647*sin(sine*2),0.08726646259971647*sin((sine+0.4)*4),2.0943951023931953)),deltaTime) 
			--MW_animatorProgressSave: LeftArm,-1,0,0,1,65,,0.4,4,0.25,-0.2,0.6,4,-70,-7,0.1,4,0,0,0,1,-80,0,0.25,4,RightLeg,1,0,0,1,-35,0,0,1,-1,0.05,0.45,4,65,5,0,4,0,0,0,1,15,5,0,4,LeftLeg,-1,0,0,1,35,0,0,1,-0.35,0.1,0.45,4,-60,-5,0,4,-0.8,0,0,1,45,-5,0,4,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightArm,1,0,0,1,-35,,0.4,4,0.15,-0.2,0.6,4,50,7,0.1,4,0,0,0,1,35,-7,0.25,4,Head,0,0,0,1,-105,2,0.6,4,1,0,0,1,,2,0.6,4,0,0,0,1,220,0,0,1,Torso,0,0,0,1,-100,5,0,2,3,0.4,0,4,,5,0.4,4,,0.3,0.25,4,120,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(40)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		jump = function()
			
			velYchg()
			local Vfw, Vrt = velbycfrvec()
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.3,0,0),angles(1.5707963267948966,-2.443460952792061-0.3490658503988659*sin(sine*4),1.7453292519943295)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.3,0,0),angles(-1.5707963267948966,0.6981317007977318-0.3490658503988659*sin((sine+0.2)*4),1.3962634015954636)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,angles(-1.3962634015954636-0.2617993877991494*sin(sine*4),0,3.490658503988659),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1,0),angles(-1.5707963267948966,-1.3962634015954636,-1.3962634015954636+0.08726646259971647*sin((sine+1)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.3962634015954636+0.2617993877991494*sin((sine+0.2)*4),0,2.792526803190927)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1.005,-0.5,-1),angles(0,1.5707963267948966,-0.2617993877991494+0.08726646259971647*sin((sine+0.3)*4))),deltaTime) 
			--i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
			--MW_animatorProgressSave: LeftArm,-1.3,0,0,1,90,0,0,1,0.,0,0,1,-140,-20,0,4,0,0,0,1,100,0,0,1,RightArm,1.3,0,0,1,-90,0,0,1,0.,0,0,1,40,-20,0.2,4,0,0,0,1,80,,0,1,Torso,0,0,0,1,-80,-15,0,4,0,0,0,15,0,0,0,15,0,0,0,1,200,0,0,0,LeftLeg,-1,0,0,1,-90,0,0,1,-1,0,0,1,-80,0,0,1,-0.,0,0,1,-80,5,1,4,Head,0,0,0,1,-80,15,0.2,4,1,0,0,1,0,0,0,1,0,0,0,1,160,0,0,1,RightLeg,1.005,0,0,1,0,0,0,1,-0.5,,0.25,4,90,0,0,1,-1,0,0,1,-15,5,0.3,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		fall = function()
			velYchg()
			local Vfw, Vrt = velbycfrvec()
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1.005,-0.2 * sin((sine+0.25)*4),-1),angles(0,1.5707963267948966,-0.2617993877991494+0.2617993877991494*sin((sine+0.3)*4))),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,angles(-1.3962634015954636-0.3490658503988659*sin(sine*5.25),0,3.490658503988659),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.3,0,0),angles(-1.5707963267948966,0.3490658503988659,1.3962634015954636)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.3,0,0),angles(1.5707963267948966,-2.792526803190927,1.7453292519943295)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.2689280275926285+0.2617993877991494*sin((sine+0.2)*4),0,2.8797932657906435)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.6,-0.5),angles(-1.5707963267948966,-1.3962634015954636,-1.8325957145940461+0.2617993877991494*sin((sine+1)*4))),deltaTime) 
			--i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
			--MW_animatorProgressSave: RightLeg,1.005,0,0,1,0,0,0,1,-,-0.2,0.25,4,90,0,0,1,-1,0,0,1,-15,15,0.3,4,Torso,0,0,0,1,-80,-20,0,5.25,0,0,0,15,0,0,0,15,0,0,0,1,200,0,0,0,RightArm,1.3,0,0,1,-90,0,0,1,0.,0,0,1,20,0,0,5,0,0,0,1,80,,0,1,LeftArm,-1.3,0,0,1,90,0,0,1,0.,0,0,1,-160,0,0,5,0,0,0,1,100,0,0,1,Head,0,0,0,1,-130,15,0.2,4,1,0,0,1,0,0,0,1,0,0,0,1,165,0,0,1,LeftLeg,-1,0,0,1,-90,0,0,1,-0.6,0,0,1,-80,0,0,1,-0.5,0,0,1,-105,15,1,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})

	addmode("q", {
		
		modeEntered=function()
			
			i1.Font=e.Font.SpecialElite
			i1.FontSize=e.FontSize.Size14 
			i1.Text="ORDINANCE" 
			i1.TextColor3=c3(0.0,0.0,0) -- like this
			i1.TextStrokeColor3=c3(1.0, 0, 0)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25-0.2*sin((sine+0.6)*4),0),angles(1.1344640137963142,-1.2217304763960306-0.12217304763960307*sin((sine+0.1)*4),-1.3962634015954636)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.05*sin((sine+0.45)*4),0),angles(-0.6108652381980153,1.1344640137963142+0.08726646259971647*sin(sine*4),0.2617993877991494+0.08726646259971647*sin(sine*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.35+0.1*sin((sine+0.45)*4),-0.8),angles(0.6108652381980153,-1.0471975511965976-0.08726646259971647*sin(sine*4),0.7853981633974483-0.08726646259971647*sin(sine*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.15-0.2*sin((sine+0.6)*4),0),angles(-0.6108652381980153,0.8726646259971648+0.12217304763960307*sin((sine+0.1)*4),0.6108652381980153-0.12217304763960307*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.8325957145940461+0.03490658503988659*sin((sine+0.6)*4),0.03490658503988659*sin((sine+0.6)*4),3.839724354387525)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.4*sin(sine*4),0.3 * sin((sine+0.25)*4)),angles(-1.7453292519943295+0.08726646259971647*sin(sine*2),0.08726646259971647*sin((sine+0.4)*4),2.0943951023931953)),deltaTime) 
			--MW_animatorProgressSave: LeftArm,-1,0,0,1,65,,0.4,4,0.25,-0.2,0.6,4,-70,-7,0.1,4,0,0,0,1,-80,0,0.25,4,RightLeg,1,0,0,1,-35,0,0,1,-1,0.05,0.45,4,65,5,0,4,0,0,0,1,15,5,0,4,LeftLeg,-1,0,0,1,35,0,0,1,-0.35,0.1,0.45,4,-60,-5,0,4,-0.8,0,0,1,45,-5,0,4,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightArm,1,0,0,1,-35,,0.4,4,0.15,-0.2,0.6,4,50,7,0.1,4,0,0,0,1,35,-7,0.25,4,Head,0,0,0,1,-105,2,0.6,4,1,0,0,1,,2,0.6,4,0,0,0,1,220,0,0,1,Torso,0,0,0,1,-100,5,0,2,3,0.4,0,4,,5,0.4,4,,0.3,0.25,4,120,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(40)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})
	
	addmode("g", {
		modeEntered=function()
			i1.Font=e.Font.PermanentMarker
			i1.FontSize=e.FontSize.Size14 
			i1.Text="UNALTERED"
			i1.TextColor3=c3(0.25,0.0,0) -- like this
			i1.TextStrokeColor3=c3(1.0, 0, 0)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(-5-1*sin((sine+0.9)*200),3+0.5*sin((sine+25)*45),0),angles(0.17453292519943295*sin(sine*521),2.2689280275926285+0.2617993877991494*sin((sine+0.8)*4),-3.141592653589793-0.2617993877991494*sin((sine+9)*4))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-5-1*sin((sine+0.25)*200),3+0.5*sin((sine+25)*45),0),angles(0.17453292519943295*sin((sine+0.25)*521),0.6981317007977318-0.2617993877991494*sin((sine+0.8)*4),3.141592653589793+0.2617993877991494*sin((sine+12)*4))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5+1*sin((sine+1.2)*200),3+0.5*sin((sine+15)*45),0),angles(0.17453292519943295*sin(sine*521),0.8726646259971648-0.2617993877991494*sin((sine+0.8)*4),-0.2617993877991494+0.2617993877991494*sin((sine+8)*4))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-5-1*sin((sine+0.6)*200),3+0.5*sin((sine+65)*45),0),angles(0.17453292519943295*sin(sine*521),2.443460952792061+0.2617993877991494*sin((sine+0.8)*4),-0.2617993877991494*sin((sine+8)*4))),deltaTime) 

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.3 * sin(sine*4),0),angles(-0.6108652381980153,-1.1344640137963142+0.2617993877991494*sin(sine*100),-1.2217304763960306+0.3490658503988659*sin((sine+0.5)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.6-0.15*sin(sine*4),-0.2-0.05*sin(sine*4)),angles(-0.6108652381980153,-0.8726646259971648+0.08726646259971647*sin(sine*100),-0.7853981633974483+0.12217304763960307*sin(sine*100))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.3 * sin(sine*4),0),angles(-0.6108652381980153,1.0471975511965976-0.2617993877991494*sin(sine*100),1.2217304763960306-0.3490658503988659*sin((sine+0.5)*4))),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1.2,-0.1-0.15*sin(sine*4),-1-0.05*sin(sine*4)),angles(-0.2617993877991494,1.0471975511965976,0.6981317007977318-0.12217304763960307*sin(sine*100))),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,-0.5+0.15*sin(sine*4),0),angles(-1.9198621771937625+0.10471975511965978*sin(sine*100),0,3.4033920413889427)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.2689280275926285-0.08726646259971647*sin((sine+0.25)*4),0.2617993877991494+0.08726646259971647*sin(sine*523),2.8797932657906435+0.06981317007977318*sin((sine+52)*623))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Purple_Handle,-5,1,1.2,200,0,10,0,521,3,0.5,15,45,50,-15,0.8,4,-,0,0,1,-15,15,8,4,ColossalCrystalGreatsword-Black_Handle,-5.,-1,0.6,200,,10,0,521,3,0.5,65,45,140,15,0.8,4,,0,0,1,,-15,8,4,LeftArm,-1,0,0,1,-35,,0,1,0.,0.3,0,4,-65,15,0,100,0,0,0,1,-70,20,0.5,4,LeftLeg,-1,0,0,1,-35,0,0,1,-0.6,-0.15,0,4,-50,5,0,100,-0.2,-0.05,0,4,-45,7,0,100,ColossalCrystalGreatsword-Red_Handle,-5,-1,0.9,200,0,10,0,521,3,0.5,25,45,130,15,0.8,4,,0,0,1,-180,-15,9,4,RightArm,1,0,0,1,-35,,0,1,0.,0.3,0,4,60,-15,0,100,0,0,0,4,70,-20,0.5,4,RightLeg,1.2,0,0,1,-15,0,0,1,-0.1,-0.15,0,4,60,,0,100,-1,-0.05,0,4,40,-7,0,100,ColossalCrystalGreatsword-Blue_Handle,-5.,-1,0.25,200,0,10,0.25,521,3,0.5,25,45,40,-15,0.8,4,,0,0,1,180,15,12,4,Torso,0,0,0,1,-110,6,0,100,-0.5,0.15,0,4,0,,52,,0,0,0,1,195,0,0,1,Head,0,0,0,1,-130,-5,0.25,4,1,0,0,1,15,5,0,523,0,0,0,1,165,4,52,623
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(17)
			Q.C0=Lerp(Q.C0,cfMul(cf(-5-1*sin((sine+0.9)*200),3+0.5*sin((sine+25)*45),0),angles(0.17453292519943295*sin(sine*521),2.2689280275926285+0.2617993877991494*sin((sine+0.8)*4),-3.141592653589793-0.2617993877991494*sin((sine+9)*4))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-5-1*sin((sine+0.25)*200),3+0.5*sin((sine+25)*45),0),angles(0.17453292519943295*sin((sine+0.25)*521),0.6981317007977318-0.2617993877991494*sin((sine+0.8)*4),3.141592653589793+0.2617993877991494*sin((sine+12)*4))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5+1*sin((sine+1.2)*200),3+0.5*sin((sine+15)*45),0),angles(0.17453292519943295*sin(sine*521),0.8726646259971648-0.2617993877991494*sin((sine+0.8)*4),-0.2617993877991494+0.2617993877991494*sin((sine+8)*4))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-5-1*sin((sine+0.6)*200),3+0.5*sin((sine+65)*45),0),angles(0.17453292519943295*sin(sine*521),2.443460952792061+0.2617993877991494*sin((sine+0.8)*4),-0.2617993877991494*sin((sine+8)*4))),deltaTime) 

			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,0.135 * sin((sine+0.1)*14),0),angles(-1.8325957145940461+0.05235987755982989*sin((sine-0.05)*14),0.008726646259971648*sin((sine-0.425)*-7),3.141592653589793+0.10471975511965978*sin((sine+0.1)*-7))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0.0325 * sin((sine-0.05)*-7),1+0.025*sin(sine*14),0.05 * sin((sine+0.1)*14)),angles(-1.7453292519943295+0.04363323129985824*sin((sine-0.1)*14),0.03490658503988659*sin((sine+0.2)*7),3.141592653589793+0.08726646259971647*sin((sine+0.1)*7))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.4,0.25 * sin(sine*7)),angles(-0.5235987755982988,1.3962634015954636,0.5235987755982988+0.6108652381980153*sin(sine*-7))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1+0.25*sin((sine+0.185)*-7),-0.125+0.35*sin((sine+0.075)*7)),angles(-0.17453292519943295+0.6108652381980153*sin(sine*-7),-1.5533430342749532+0.05672320068981571*sin(sine*-7),-0.17453292519943295)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.4,0.25 * sin(sine*-7)),angles(-0.5235987755982988,-1.3962634015954636,-0.5235987755982988+0.6108652381980153*sin(sine*-7))),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.25*sin((sine+0.185)*7),-0.125+0.35*sin((sine+0.075)*-7)),angles(-0.17453292519943295+0.6108652381980153*sin(sine*7),1.53588974175501+0.05672320068981571*sin((sine+0.35)*7),0.17453292519943295)),deltaTime) 
			--MW_animatorProgressSave: Torso,0,0,0,1,-105,3,-0.05,14,0,0.135,0.1,14,0,.5,-0.425,-7,0,0,0,1,180,6,0.1,-7,Head,0,0.0325,-0.05,-7,-100,2.5,-0.1,14,1,0.025,0,14,0,2,0.2,7,-0.0,0.05,0.1,14,180,5,0.1,7,RightArm,1,0,0,1,-30,0,0,1,0.4,0,0,1,80,0,0,1,0,0.25,0,7,30,35,0,-7,LeftLeg,-1,0,0,1,-10,35,0,-7,-1,0.25,0.185,-7,-89,3.25,0,-7,-0.125,0.35,0.075,7,-10,0,0,1,LeftArm,-1,0,0,1,-30,0,0,1,0.4,0,0,1,-80,0,0,1,0,0.25,0,-7,-30,35,0,-7,RightLeg,1,0,0,1,-10,35,-0,7,-1,0.25,0.185,7,88,3.25,0.35,7,-0.125,0.35,0.075,-7,10,0,0,1
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})
	
	
	addmode("e", {
		modeEntered=function()
			i1.Font=e.Font.Merriweather
			i1.FontSize=e.FontSize.Size14 
			i1.Text="Glacial" 
			i1.TextColor3=c3(0.0,0.75,1) -- like this
			i1.TextStrokeColor3=c3(0.0, 0, 0)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(-5,3,-0.5),angles(0,-0.2617993877991494*sin((sine+0.8)*2.5),3.141592653589793+0.13962634015954636*sin((sine+0.25)*2))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-5,3,0.5),angles(0,3.141592653589793+0.2617993877991494*sin((sine+0.8)*2.5),-3.141592653589793-0.13962634015954636*sin((sine+0.25)*2.5))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5,3,-0.5),angles(0,-0.2617993877991494*sin((sine+0.8)*2.5),-0.2617993877991494+0.13962634015954636*sin((sine+0.25)*2.5))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-5,3,0.5),angles(0,3.141592653589793+0.2617993877991494*sin((sine+0.8)*2.5),0.2617993877991494-0.2617993877991494*sin((sine+0.25)*2.5))),deltaTime) 

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.15 * sin((sine+0.1)*2.5),-1),angles(1.5707963267948966,0.3490658503988659+0.10471975511965978*sin((sine+0.4)*2.5),1.0471975511965976)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95+0.05*sin((sine+0.15)*2.5),-0.2),angles(-0.5235987755982988,-1.2217304763960306,-0.2617993877991494-0.08726646259971647*sin((sine+0.5)*2.5))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.3+0.19*sin((sine+0.15)*2.5),-1),angles(-0.8726646259971648,3.490658503988659+0.08726646259971647*sin((sine+0.4)*2.5),1.7453292519943295)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0.25 * sin((sine+0.15)*2.5),-1),angles(-0.4363323129985824,1.2217304763960306,0.2617993877991494+0.08726646259971647*sin((sine+0.5)*2.5))),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,4+0.5*sin(sine*2.5),0.2 * sin((sine+0.3)*2.5)),angles(-1.3962634015954636-0.08726646259971647*sin((sine+0.15)*2.5),0.08726646259971647+0.08726646259971647*sin((sine+0.5)*2.5),3.839724354387525+0.08726646259971647*sin((sine+0.3)*2.5))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.9198621771937625+0.08726646259971647*sin((sine+0.25)*2.5),0.08726646259971647+0.08726646259971647*sin(sine*2.5),2.6179938779914944+0.08726646259971647*sin((sine+0.65)*2))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Purple_Handle,-5,0,0,1,0,0,0,1,3,0,0,1,0,-15,0.8,2.5,-0.5,0,0,1,-15,8,0.25,2.5,ColossalCrystalGreatsword-Black_Handle,-5.,0,0,1,,0,0,1,3,0,0,1,180,15,0.8,2.5,0.5,0,0,1,15,-15,0.25,2.5,LeftArm,-1,0,0,1,90,0,0,1,0.,0.15,0.1,2.5,20,6,0.4,2.5,-1,0,0,1,60,0,0,1,LeftLeg,-1,0,0,1,-30,0,0,1,-0.95,0.05,0.15,2.5,-70,0,0,1,-0.2,0,0,1,-15,-5,0.5,2.5,ColossalCrystalGreatsword-Red_Handle,-5,0,0,1,0,0,0,1,3,0,0,1,180,15,0.8,2.5,0.5,0,0,1,-180,-8,0.25,2.5,RightArm,1,0,0,1,-50,0,0,1,0.3,0.19,0.15,2.5,200,5,0.4,2.5,-1,0,0,1,100,0,0,1 ,RightLeg,1,0,0,1,-25,0,0,1,0,0.25,0.15,2.5,70,0,0,1,-1,0,0,1,15,5,0.5,2.5,ColossalCrystalGreatsword-Blue_Handle,-5.,0,0,1,0,0,0,1,3,0,0,1,0,-15,0.8,2.5,-0.5,0,0,1,180,8,0.25,2,Torso,0,0,0,1,-80,-5,0.15,2.5,4,0.5,0,2.5,5,5,0.5,2.5,0,0.2,0.3,2.5,220,5,0.3,2.5,Head,0,0,0,1,-110,5,0.25,2.5,1,0,0,1,5,5,0,2.5,0,0,0,1,150,5,0.65,2
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(35)
			Q.C0=Lerp(Q.C0,cfMul(cf(-5,3,-0.5),angles(0,-0.2617993877991494*sin((sine+0.8)*2.5),3.141592653589793+0.13962634015954636*sin((sine+0.25)*2))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-5,3,0.5),angles(0,3.141592653589793+0.2617993877991494*sin((sine+0.8)*2.5),-3.141592653589793-0.13962634015954636*sin((sine+0.25)*2.5))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5,3,-0.5),angles(0,-0.2617993877991494*sin((sine+0.8)*2.5),-0.2617993877991494+0.13962634015954636*sin((sine+0.25)*2.5))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-5,3,0.5),angles(0,3.141592653589793+0.2617993877991494*sin((sine+0.8)*2.5),0.2617993877991494-0.2617993877991494*sin((sine+0.25)*2.5))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})

	addmode("u", {
		modeEntered=function()
			i1.Font=e.Font.PermanentMarker
			i1.FontSize=e.FontSize.Size14 
			i1.Text="ACE O SPADES" 
			i1.TextColor3=c3(0.0,0.0,0) -- like this
			i1.TextStrokeColor3=c3(1.0, 1, 0)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
T.C0=Lerp(T.C0,cfMul(cf(-4-1*sin(sine*1),3-0.15*sin(sine*1),-3.5),angles(1.5707963267948966,-1.5707963267948966+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
 R.C0=Lerp(R.C0,cfMul(cf(-3,2.5+1*sin(sine*1),-3.5),angles(1.5707963267948966,3.141592653589793+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
Q.C0=Lerp(Q.C0,cfMul(cf(-5,2-1*sin(sine*1),-3.5),angles(1.5707963267948966,87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
E.C0=Lerp(E.C0,cfMul(cf(-4+1*sin(sine*1),1.5+0.15*sin(sine*1),-3.5),angles(1.5707963267948966,1.5707963267948966+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,0,-1),angles(-0.6108652381980153,1.2217304763960306,0.13962634015954636*sin((sine+1)*3))),deltaTime) 
RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(2,0.6+0.2*sin((sine+0.25)*2),0),angles(-1.5707963267948966,-1.0471975511965976-0.4363323129985824*sin(sine*2),1.5707963267948966)),deltaTime) 
Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.0943951023931953-0.13962634015954636*sin((sine+0.5)*3),0.4363323129985824,3.141592653589793-0.08726646259971647*sin(sine*3))),deltaTime) 
LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.2 * sin((sine+0.25)*3),0),angles(-0.4363323129985824,-1.0471975511965976+0.2617993877991494*sin(sine*3),-0.4363323129985824)),deltaTime) 
RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,7+0.5*sin(sine*3),0.75 * sin((sine+0.5)*3)),angles(-1.5707963267948966+0.12217304763960307*sin((sine+0.25)*3),-0.4363323129985824,3.141592653589793-0.08726646259971647*sin((sine+0.5)*3))),deltaTime) 
LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.8,-0.5),angles(1.5707963267948966,-2.0943951023931953,2.0943951023931953-0.13962634015954636*sin((sine+0.7)*3))),deltaTime) 
--MW_animatorProgressSave: ColossalCrystalGreatsword-Blue_Handle,-5,0,0,1,90,,0,1,2,-1,0,1,0,5000,0,0.1,-3.5,0,0,1,25,,0,,ColossalCrystalGreatsword-Purple_Handle,-4,1,0,1,90,0,0,1,1.5,0.15,0,1,90,5000,0,0.1,-3.5,0,0,1,25,0,0,1,RightLeg,1,0,0,1,-35,0,0,1,-,0,0,1,70,0,0,1,-1,0,0,1,,8,1,3,RightArm,2,0,0,1,-90,0,0,1,0.6,0.2,0.25,2,-60,-25,0,2,0,0,0,1,90,0,0,1,Head,0,0,0,1,-120,-8,0.5,3,1,0,0,1,25,0,0,1,0,0,0,1,180,-5,0,3,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,90,0,0,1,2.5,1,0,1,180,5000,0,0.1,-3.5,0,0,1,25,0,0,1,LeftArm,-1,0,0,1,-25,0,0,1,,0.2,0.25,3,-60,15,0,3,0,0,0,1,-25,,0,3,Torso,0,0,0,1,-90,7,0.25,3,7,0.5,0,3,-25,0,0,1,,0.75,0.5,3,180,-5,0.5,3,LeftLeg,-1,0,0,1,90,0,0,1,-0.8,0,0,1,-120,0,0,1,-0.5,0,0,1,120,-8,0.7,3,ColossalCrystalGreatsword-Black_Handle,-4,-1,0,1,90,0,0,1,3.,-0.15,0,1,-90,5000,0,0.1,-3.5,0,0,1,25,0,0,1
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Purple_Handle,-5,0,0,1,0,0,0,1,3,0,0,1,0,-15,0.8,2.5,-0.5,0,0,1,-15,8,0.25,2.5,ColossalCrystalGreatsword-Black_Handle,-5.,0,0,1,,0,0,1,3,0,0,1,180,15,0.8,2.5,0.5,0,0,1,15,-15,0.25,2.5,LeftArm,-1,0,0,1,90,0,0,1,0.,0.15,0.1,2.5,20,6,0.4,2.5,-1,0,0,1,60,0,0,1,LeftLeg,-1,0,0,1,-30,0,0,1,-0.95,0.05,0.15,2.5,-70,0,0,1,-0.2,0,0,1,-15,-5,0.5,2.5,ColossalCrystalGreatsword-Red_Handle,-5,0,0,1,0,0,0,1,3,0,0,1,180,15,0.8,2.5,0.5,0,0,1,-180,-8,0.25,2.5,RightArm,1,0,0,1,-50,0,0,1,0.3,0.19,0.15,2.5,200,5,0.4,2.5,-1,0,0,1,100,0,0,1 ,RightLeg,1,0,0,1,-25,0,0,1,0,0.25,0.15,2.5,70,0,0,1,-1,0,0,1,15,5,0.5,2.5,ColossalCrystalGreatsword-Blue_Handle,-5.,0,0,1,0,0,0,1,3,0,0,1,0,-15,0.8,2.5,-0.5,0,0,1,180,8,0.25,2,Torso,0,0,0,1,-80,-5,0.15,2.5,4,0.5,0,2.5,5,5,0.5,2.5,0,0.2,0.3,2.5,220,5,0.3,2.5,Head,0,0,0,1,-110,5,0.25,2.5,1,0,0,1,5,5,0,2.5,0,0,0,1,150,5,0.65,2
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(35)
			T.C0=Lerp(T.C0,cfMul(cf(-4-1*sin(sine*1),3-0.15*sin(sine*1),-3.5),angles(1.5707963267948966,-1.5707963267948966+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
 R.C0=Lerp(R.C0,cfMul(cf(-3,2.5+1*sin(sine*1),-3.5),angles(1.5707963267948966,3.141592653589793+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
Q.C0=Lerp(Q.C0,cfMul(cf(-5,2-1*sin(sine*1),-3.5),angles(1.5707963267948966,87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 
E.C0=Lerp(E.C0,cfMul(cf(-4+1*sin(sine*1),1.5+0.15*sin(sine*1),-3.5),angles(1.5707963267948966,1.5707963267948966+87.26646259971648*sin(sine*0.1),0.4363323129985824)),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})

	addmode("y", {
		modeEntered=function()
			i1.Font=e.Font.PermanentMarker
			i1.FontSize=e.FontSize.Size14 
			i1.Text="Zextorium" 
			i1.TextColor3=c3(0.5,0.0,1) -- like this
			i1.TextStrokeColor3=c3(0.35,0.45, 0.35)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(-5,3,0.5),angles(3.141592653589793,0.6108652381980153*sin(sine*2),0.3490658503988659-0.2617993877991494*sin((sine+0.5)*2.5))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(5,-5,0),angles(0,-0.6108652381980153*sin(sine*2),0.2617993877991494*sin((sine+0.7)*2.5))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5,3,-0.5),angles(0,0.6108652381980153*sin(sine*2),2.792526803190927+0.2617993877991494*sin((sine+0.5)*2.5))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(5,-5,0.5),angles(0,3.141592653589793+0.6108652381980153*sin(sine*2),-0.2617993877991494*sin((sine+0.7)*2.5))),deltaTime) 
			
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,4+0.6*sin(sine*2.5),0.3 * sin((sine+0.5)*2.5)),angles(-1.2740903539558606+0.10471975511965978*sin((sine+0.25)*2.5),0,3.6651914291880923)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,-0.1+0.1*sin((sine+0.15)*2.5),-0.9),angles(1.3089969389957472,-0.8726646259971648,-1.3089969389957472-0.13962634015954636*sin((sine+0.35)*2.5))),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,-0.3+0.2*sin((sine+0.15)*2.5),-1),angles(1.5707963267948966,0.8726646259971648,1.5707963267948966+0.06981317007977318*sin((sine+0.2)*2.5))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.0943951023931953-0.08726646259971647*sin((sine+1)*2.5),0.2617993877991494,2.722713633111154+0.06981317007977318*sin((sine+1.25)*2.5))),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.3+0.15*sin((sine+0.75)*2.5),-1),angles(-0.8726646259971648,1.2217304763960306,0.4363323129985824+0.2617993877991494*sin((sine+0.25)*2.5))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.8+0.1*sin((sine+0.8)*3),-0.3),angles(-0.5235987755982988,-1.1344640137963142,-0.4363323129985824-0.2617993877991494*sin((sine+0.35)*2.5))),deltaTime) 
			--MW_animatorProgressSave: Torso,0,0,0,1,-73,6,0.25,2.5,4,0.6,0,2.5,0,0,0,1,0,0.3,0.5,2.5,210,0,0,1,RightArm,1,0,0,1,75,0,0,1,-0.1,0.1,0.15,2.5,-50,0,0,1,-0.9,0,0,1,-75,-8,0.35,2.5,LeftArm,-1,0,0,1,90,0,0,1,-0.3,0.2,0.15,2.5,50,0,0,1,-1,0,0,1,90,4,0.2,2.5,ColossalCrystalGreatsword-Red_Handle,-5,0,0,1,180,0,0,1,3,0,0,1,,35,0,2,0.5,0,0,1,20,-15,0.5,2.5,Head,0,0,0,1,-120,-5,1,2.5,1,0,0,1,15,0,0,1,0,0,0,1,156,4,1.25,2.5,ColossalCrystalGreatsword-Blue_Handle,5,0,0,1,0,0,0,1,-5,0,0,1,0,-35,0,2, ,0,0,1,0,15,0.7,2.5,ColossalCrystalGreatsword-Black_Handle,-5,0,0,1,0,0,0,1,3,0,0,1,0,35,0,2,-0.5,0,0,1,160,15,0.5,2.5,ColossalCrystalGreatsword-Purple_Handle,5,0,0,1,,0,0,1,-5,0,0,1,180,35,0,2,0.5,0,0,1,,-15,0.7,2.5,RightLeg,1,0,0,1,-50,0,0,1,-0.3,0.15,0.75,2.5,70,0,0,1,-1,0,0,1,25,15,0.25,2.5,LeftLeg,-1,0,0,1,-30,0,0,1,-0.8,0.1,0.8,3,-65,0,0,1,-0.3,0,0,1,-25,-15,0.35,2.5
						 i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(60)
			Q.C0=Lerp(Q.C0,cfMul(cf(-5,3,0.5),angles(3.141592653589793,0.6108652381980153*sin(sine*2),0.3490658503988659-0.2617993877991494*sin((sine+0.5)*2.5))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(5,-5,0),angles(0,-0.6108652381980153*sin(sine*2),0.2617993877991494*sin((sine+0.7)*2.5))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5,3,-0.5),angles(0,0.6108652381980153*sin(sine*2),2.792526803190927+0.2617993877991494*sin((sine+0.5)*2.5))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(5,-5,0.5),angles(0,3.141592653589793+0.6108652381980153*sin(sine*2),-0.2617993877991494*sin((sine+0.7)*2.5))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})
	
	addmode("r", {
		modeEntered=function()
			i1.Font=e.Font.SpecialElite
			i1.FontSize=e.FontSize.Size14 
			i1.Text="Deception" 
			i1.TextColor3=c3(0.0,0.0,0) -- like this
			i1.TextStrokeColor3=c3(0.5, 0, 1)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,1.5707963267948966+261.79938779914943*sin(sine*0.025))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,-1.5707963267948966+261.79938779914943*sin(sine*0.025))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,3.141592653589793+261.79938779914943*sin(sine*0.025))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,261.79938779914943*sin(sine*0.025))),deltaTime) 

			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.5,0.5-0.15*sin((sine+0.25)*3),0.75),angles(0.5235987755982988-0.08726646259971647*sin((sine+0.5)*3),1.0471975511965976,-0.7853981633974483)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.15 * sin((sine+0.7)*3),-1),angles(-0.8726646259971648+0.17453292519943295*sin((sine+0.35)*3),1.2217304763960306,0.4363323129985824)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.9,0),angles(-0.7853981633974483+0.17453292519943295*sin((sine+0.35)*3),-1.0471975511965976,-0.4363323129985824)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,4+0.4*sin(sine*3),0.25 * sin((sine+0.35)*3)),angles(-1.3089969389957472-0.13962634015954636*sin((sine+0.5)*3),-0.2617993877991494,3.5779249665883754)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.0943951023931953-0.08726646259971647*sin((sine+0.5)*3),0.5235987755982988+0.08726646259971647*sin(sine*3),2.8797932657906435)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-0.5,0.5-0.15*sin((sine+0.25)*3),0.75),angles(0.5235987755982988-0.08726646259971647*sin((sine+0.5)*3),-1.0471975511965976,0.7853981633974483)),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Red_Handle,,5,0,1,0,0,0,1,,5,0,1,,0,0,1,,3,1,1,90,15000,0,0.025,RightArm,0.5,0,0,1,30,-5,0.5,3,0.5,-0.15,0.25,3,60,0,0,1,0.75,0,0,1,-45,0,0,1,ColossalCrystalGreatsword-Blue_Handle,,5,0,1,0,0,0,1,,5,0,1,,0,0,1,,3,1,1,-90,15000,0,0.025,RightLeg,1,0,0,1,-50,10,0.35,3,-,-0.15,0.7,3,70,0,0,1,-1,0,0,1,25,0,0,1,LeftLeg,-1,0,0,1,-45,10,0.35,3,-0.9,0,0,1,-60,0,0,1,0,0,0,1,-25,0,0,1,Torso,0,0,0,1,-75,-8,0.5,3,4,0.4,0,3,-15,0,0,1,0,0.25,0.35,3,205,0,0,1,ColossalCrystalGreatsword-Black_Handle,,5,0,1,0,0,0,1,,5,0,1,,0,0,1,,3,1,1,180,15000,0,0.025,Head,0,0,0,1,-120,-5,0.5,3,1,0,0,1,30,5,0,3,0,0,0,1,165,,0,3,ColossalCrystalGreatsword-Purple_Handle,,5,0,1,0,0,0,1,,5,0,1,,0,0,1,,3,1,1,,15000,0,0.025,LeftArm,-0.5,0,0,1,30,-5,0.5,3,0.5,-0.15,0.25,3,-60,0,0,1,0.75,0,0,1,45,0,0,1
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(35)
			Q.C0=Lerp(Q.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,1.5707963267948966+261.79938779914943*sin(sine*0.025))),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,-1.5707963267948966+261.79938779914943*sin(sine*0.025))),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,3.141592653589793+261.79938779914943*sin(sine*0.025))),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(5 * sin(sine*1),5 * sin(sine*1),3 * sin((sine+1)*1)),angles(0,0,261.79938779914943*sin(sine*0.025))),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})
	

	addmode("t", {
		modeEntered=function()
			i1.Font=e.Font.SpecialElite
			i1.FontSize=e.FontSize.Size14 
			i1.Text="Vindine" 
			i1.TextColor3=c3(0.0,0.0,0) -- like this
			i1.TextStrokeColor3=c3(1.0, 1, 0)
			task.spawn(ShadeID, 1837829473, 5)
		end,
		idle = function()
			if attackAnimation then return attackAnimation() end
			Q.C0=Lerp(Q.C0,cfMul(cf(-5.6-1*sin(sine*3),3+0.5*sin(sine*3),-0.5),angles(0,0,4.1887902047863905)),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-6-1*sin(sine*3),4+1*sin(sine*3),-0.5),angles(0,0,2.0943951023931953)),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5-1*sin(sine*3),3+0.7*sin(sine*3),-0.5),angles(0,0,1.0471975511965976)),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-6-1*sin(sine*3),4+1*sin(sine*3),0.5),angles(0,3.141592653589793,-2.0943951023931953)),deltaTime) 

	
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.1+0.2*sin((sine+0.25)*4),-0.6),angles(-0.4363323129985824+0.13962634015954636*sin((sine+6)*4),-0.8726646259971648,-0.4363323129985824)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.9,-0.7+0.1*sin((sine+0.25)*4),-0.5),angles(-0.6981317007977318+0.10471975511965978*sin((sine+0.1)*4),1.3962634015954636,0.6283185307179586)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,5+0.3*sin(sine*4),0),angles(-1.9198621771937625+0.08726646259971647*sin((sine+0.3)*4),-0.2617993877991494,3.3161255787892263)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.8,-1+0.2*sin((sine+0.2)*4),-1),angles(2.2689280275926285+0.08726646259971647*sin(sine*4),2.792526803190927+0.08726646259971647*sin((sine+0.1)*4),1.0471975511965976)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.443460952792061-0.13962634015954636*sin((sine+0.9)*4),0.2617993877991494+0.17453292519943295*sin(sine*2551),3.141592653589793+0.2617993877991494*sin(sine*152))),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,-0.5,-0.3),angles(-0.6981317007977318,-1.0471975511965976,-1.0471975511965976+0.2617993877991494*sin((sine+0.5)*4))),deltaTime) 
			--MW_animatorProgressSave: LeftLeg,-1,0,0,1,-25,8,6,4,-0.1,0.2,0.25,4,-50,0,0,1,-0.6,0,0,1,-25,0,0,1,RightLeg,0.9,0,0,1,-40,6,0.1,4,-0.7,0.1,0.25,4,80,0,0,1,-0.5,0,0,1,36,0,0,1,ColossalCrystalGreatsword-Red_Handle,-5.6,-1,0,3,0,0,0,1,3,0.5,0,3,0,0,0,1,-0.5,0,0,1,240,,0,1,ColossalCrystalGreatsword-Purple_Handle,-6,-1,0,3,0,0,0,1,4,1,0,3,0,0,0,1,-0.5,0,0,1,120,0,0,1,ColossalCrystalGreatsword-Black_Handle,-5,-1,0,3,0,0,0,1,3,0.7,0,3,0,0,0,1,-0.5,0,0,1,60,,0,,Torso,0,0,0,1,-110,5,0.3,4,5,0.3,0,4,-15,0,0,1,0,0,0,1,190,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-6,-1,0,3,0,0,0,1,4,1,0,3,180,0,0,1,0.5,0,0,1,-120,0,0,1,RightArm,0.8,0,0,1,130,5,0,4,-1,0.2,0.2,4,160,5,0.1,4,-1,0,0,1,60,0,0,1,Head,0,0,0,1,-140,-8,0.9,4,1,0,0,1,15,10,0,2551,-0,0,0,1,180,15,0,152,LeftArm,-1,0,0,1,-40,0,0,1,-0.5,0,0,1,-60,0,0,1,-0.3,0,0,1,-60,15,0.5,4	
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end,
		walk = function()
			if attackAnimation then return attackAnimation() end
			t.setWalkSpeed(18)
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20
			t.setWalkSpeed(40)
			Q.C0=Lerp(Q.C0,cfMul(cf(-5.6-1*sin(sine*3),3+0.5*sin(sine*3),-0.5),angles(0,0,4.1887902047863905)),deltaTime) 
			E.C0=Lerp(E.C0,cfMul(cf(-6-1*sin(sine*3),4+1*sin(sine*3),-0.5),angles(0,0,2.0943951023931953)),deltaTime) 
			R.C0=Lerp(R.C0,cfMul(cf(-5-1*sin(sine*3),3+0.7*sin(sine*3),-0.5),angles(0,0,1.0471975511965976)),deltaTime) 
			T.C0=Lerp(T.C0,cfMul(cf(-6-1*sin(sine*3),4+1*sin(sine*3),0.5),angles(0,3.141592653589793,-2.0943951023931953)),deltaTime) 

			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.1 * sin((sine+0.3)*4),-1),angles(-0.9599310885968813,1.2217304763960306,0.4363323129985824-0.17453292519943295*sin((sine+0.25)*4))),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-0.6981317007977318+0.08726646259971647*sin((sine+0.55)*4),0,3.141592653589793)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.2*sin(sine*4),0),angles(-2.705260340591211-0.08726646259971647*sin((sine+0.5)*4),0,3.141592653589793)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25,0),angles(1.5707963267948966,-1.9198621771937625,2.0943951023931953+0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.25,0),angles(-2.0943951023931953,1.2217304763960306,1.5707963267948966-0.08726646259971647*sin((sine+0.7)*4))),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.95,-0.25),angles(-0.7853981633974483,-1.2217304763960306,-0.4363323129985824+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
			--MW_animatorProgressSave: ColossalCrystalGreatsword-Black_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,180,5000,0.07,0.15,RightLeg,1,0,0,1,-55,0,0,1,-,-0.1,0.3,4,70,0,0,1,-1,0,0,1,25,-10,0.25,4,Head,0,0,0,1,-40,5,0.55,4,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Red_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,360,5000,0.05,0.15,Torso,0,0,0,1,-155,-5,0.5,4,3,0.2,0,4,,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-3,0,0,1,0,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,90,5000,0.06,0.15,ColossalCrystalGreatsword-Purple_Handle,-3,0,0,1,,0,0,1,2,0,0,1,15,0,0,1,-0.5,0,0,1,270,5000,0.08,0.15,LeftArm,-1,0,0,1,90,0,0,1,0.25,0,0,1,-110,0,0,1,0,0,0,1,120,5,0.7,4,RightArm,1,0,0,1,-120,0,0,1,0.25,0,0,1,70,0,0,1,0,0,0,1,90,-5,0.7,4,LeftLeg,-1,0,0,1,-45,0,0,1,-0.95,0,0,1,-70,0,0,1,-0.25,0,0,1,-25,5,0.25,4
			i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		end
	})
	
	
	
	
	
	
	

--ULTIMATE--



	local modeStartTime=sine
	addmode("b", {
		modeEntered=function()
			i1.Font=e.Font.SpecialElite
			i1.FontSize=e.FontSize.Size14 
			i1.Text="ULTIORDINANCE" 
			i1.TextColor3=c3(0.0,0.0,0) -- like this
			i1.TextStrokeColor3=c3(1.0, 1, 1)
			modeStartTime=sine
		end,
		idle=function()
			if attackAnimation then return attackAnimation() end
			local modeTime=sine-modeStartTime
			if modeTime<1.0 then

				Q.C0=Lerp(Q.C0,cfMul(cf(7,-5,0.5),angles(3.141592653589793,0,0)),deltaTime) 
				E.C0=Lerp(E.C0,cf(7,-5,-0.5),deltaTime) 
				R.C0=Lerp(R.C0,cfMul(cf(7,-5,0.5),angles(0,3.141592653589793,0)),deltaTime) 
				T.C0=Lerp(T.C0,cfMul(cf(7,-5,-0.5),angles(0,0,3.141592653589793)),deltaTime) 

				LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.1,0.4,-1),angles(-0.4363323129985824,1.9198621771937625,-2.2689280275926285)),deltaTime) 
				RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3-0.215*sin((sine+0.5)*5),0),angles(-2.0943951023931953+0.08726646259971647*sin((sine+51)*5),0.17453292519943295*sin(sine*250),3.141592653589793+0.2617993877991494*sin((sine+25)*200))),deltaTime) 
				LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.6,-0.6),angles(-1.0471975511965976+0.17453292519943295*sin((sine+0.4)*5),-1.3962634015954636,-0.4363323129985824)),deltaTime) 
				RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.9,0,-0.5),angles(-0.4363323129985824+0.17453292519943295*sin((sine+0.4)*5),1.0471975511965976,0)),deltaTime) 
				RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.4,0.4,-1),angles(-0.4363323129985824,-2.0943951023931953,2.2689280275926285)),deltaTime) 
				Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-2.2689280275926285,0,3.141592653589793)),deltaTime) 
				--MW_animatorProgressSave: LeftArm,-1.1,0,0,1,-25,0,0,1,0.4,0,0,1,110,0,0,0,-1,0,0,1,-130,0,0,1,ColossalCrystalGreatsword-Purple_Handle,7,0,0,1,180,0,0,1,-5,0,0,1,0,0,0,1,0.5,0,0,1,0,0,0,1,Torso,0,0,0,1,-120,5,51,5,3,-0.215,0.5,5,0,10,0,250,0,0,0,1,180,15,25,200,LeftLeg,-1,0,0,1,-60,10,0.4,5,-0.6,0,0,1,-80,0,0,1,-0.6,0,0,1,-025,0,0,1,ColossalCrystalGreatsword-Blue_Handle,7,0,0,1,0,0,0,1,-5,0,0,1,0,0,0,1,-0.5,0,0,1,0,0,0,1,RightLeg,0.9,0,0,1,-25,10,0.4,5,0,0,0,1,60,0,0,1,-0.5,0,0,1,0,0,0,1,RightArm,1.4,0,0,1,-25,0,0,1,0.4,0,0,1,-120,,,,-1,0,0,1,130,0,0,1,ColossalCrystalGreatsword-Red_Handle,7,0,0,1,0,0,0,1,-5,0,0,1,180,0,0,1,0.5,0,0,1,,0,0,1,Head,0,0,0,1,-130,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Black_Handle,7,0,0,1,0,0,0,1,-5,0,0,1,0,0,0,1,-0.5,0,0,1,180,0,0,1
				i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
			else
				
				if modeTime<1.8 then
					
					Q.C0=Lerp(Q.C0,cfMul(cf(-7,5,0.5),angles(3.141592653589793,0,0)),deltaTime) 
					E.C0=Lerp(E.C0,cf(-7,5,-0.5),deltaTime) 
					R.C0=Lerp(R.C0,cfMul(cf(-7,5,0.5),angles(0,3.141592653589793,0)),deltaTime) 
					T.C0=Lerp(T.C0,cfMul(cf(-7,5,-0.5),angles(0,0,3.141592653589793)),deltaTime) 

					LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.7,-0.5,0.5),angles(-1.9198621771937625,0.5235987755982988,-1.7453292519943295)),deltaTime) 
					RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine*251),3+0.5*sin((sine+0.5)*51),0.1 * sin((sine+0.5)*100)),angles(-1.0471975511965976+0.017453292519943295*sin((sine+51)*215),0.12217304763960307*sin(sine*250),3.141592653589793+0.08726646259971647*sin((sine+25)*200))),deltaTime) 
					LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.6,-0.6),angles(-1.0471975511965976,-1.3962634015954636,-0.4363323129985824)),deltaTime) 
					RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.9,0,-0.5),angles(-0.4363323129985824,1.0471975511965976,0)),deltaTime) 
					Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.0471975511965976,0,3.141592653589793)),deltaTime) 
					RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.7,-0.5,0.5),angles(-1.9198621771937625,-0.5235987755982988,1.7453292519943295)),deltaTime) 
					--MW_animatorProgressSave: LeftArm,-1.7,0,0,1,-110,0,0,1,-0.5,0,0,1,30,0,0,0,0.5,0,0,1,-100,0,0,1,ColossalCrystalGreatsword-Purple_Handle,-7,0,0,1,180,0,0,1,5,0,0,1,0,0,0,1,0.5,0,0,1,0,0,0,1,Torso,0,-0.1,0,251,-60,1,51,215,3,0.5,0.5,51,0,7,0,250,0,0.1,0.5,100,180,5,25,200,LeftLeg,-1,0,0,1,-60,,0.4,5,-0.6,0,0,1,-80,0,0,1,-0.6,0,0,1,-025,0,0,1,ColossalCrystalGreatsword-Black_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,0,0,0,1,-0.5,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,0,0,0,1,-0.5,0,0,1,0,0,0,1,ColossalCrystalGreatsword-Red_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,180,0,0,1,0.5,0,0,1,,0,0,1,RightLeg,0.9,0,0,1,-25,0,0.4,5,0,0,0,1,60,0,0,1,-0.5,0,0,1,0,0,0,1,Head,0,0,0,1,-60,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,RightArm,1.7,0,0,1,-110,0,0,1,-0.5,0,0,1,-30,,,,0.5,0,0,1,100,0,0,1			
					i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
				else
			
			
					if modeTime<1.85 then
						
						task.spawn(ShadeID, 7405939280, 5) 
						task.spawn(ShadeID, 8699897760, 5) 
					--	task.spawn(ShadeID, 9046476113, 999999) 
						Q.C0=Lerp(Q.C0,cfMul(cf(-7,5,0.5),angles(3.141592653589793,0,0)),deltaTime) 
						E.C0=Lerp(E.C0,cf(-7,5,-0.5),deltaTime) 
						R.C0=Lerp(R.C0,cfMul(cf(-7,5,0.5),angles(0,3.141592653589793,0)),deltaTime) 
						T.C0=Lerp(T.C0,cfMul(cf(-7,5,-0.5),angles(0,0,3.141592653589793)),deltaTime) 

						LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1.7,-0.5,0.5),angles(-1.9198621771937625,0.5235987755982988,-1.7453292519943295)),deltaTime) 
						RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine*251),3+0.5*sin((sine+0.5)*51),0.1 * sin((sine+0.5)*100)),angles(-1.0471975511965976+0.017453292519943295*sin((sine+51)*215),0.12217304763960307*sin(sine*250),3.141592653589793+0.08726646259971647*sin((sine+25)*200))),deltaTime) 
						LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.6,-0.6),angles(-1.0471975511965976,-1.3962634015954636,-0.4363323129985824)),deltaTime) 
						RightHip.C0=Lerp(RightHip.C0,cfMul(cf(0.9,0,-0.5),angles(-0.4363323129985824,1.0471975511965976,0)),deltaTime) 
						Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.0471975511965976,0,3.141592653589793)),deltaTime) 
						RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1.7,-0.5,0.5),angles(-1.9198621771937625,-0.5235987755982988,1.7453292519943295)),deltaTime) 
						--MW_animatorProgressSave: LeftArm,-1.7,0,0,1,-110,0,0,1,-0.5,0,0,1,30,0,0,0,0.5,0,0,1,-100,0,0,1,ColossalCrystalGreatsword-Purple_Handle,-7,0,0,1,180,0,0,1,5,0,0,1,0,0,0,1,0.5,0,0,1,0,0,0,1,Torso,0,-0.1,0,251,-60,1,51,215,3,0.5,0.5,51,0,7,0,250,0,0.1,0.5,100,180,5,25,200,LeftLeg,-1,0,0,1,-60,,0.4,5,-0.6,0,0,1,-80,0,0,1,-0.6,0,0,1,-025,0,0,1,ColossalCrystalGreatsword-Black_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,0,0,0,1,-0.5,0,0,1,180,0,0,1,ColossalCrystalGreatsword-Blue_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,0,0,0,1,-0.5,0,0,1,0,0,0,1,ColossalCrystalGreatsword-Red_Handle,-7,0,0,1,0,0,0,1,5,0,0,1,180,0,0,1,0.5,0,0,1,,0,0,1,RightLeg,0.9,0,0,1,-25,0,0.4,5,0,0,0,1,60,0,0,1,-0.5,0,0,1,0,0,0,1,Head,0,0,0,1,-60,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,180,0,0,1,RightArm,1.7,0,0,1,-110,0,0,1,-0.5,0,0,1,-30,,,,0.5,0,0,1,100,0,0,1			
						i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
					else
												--Ultimate Ordinance--
												Q.C0=Lerp(Q.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,4.71238898038469+87.26646259971648*sin((sine+0.08)*0.15))),deltaTime) 
												E.C0=Lerp(E.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,6.283185307179586+87.26646259971648*sin((sine+0.05)*0.15))),deltaTime) 
												R.C0=Lerp(R.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,3.141592653589793+87.26646259971648*sin((sine+0.07)*0.15))),deltaTime) 
												T.C0=Lerp(T.C0,cfMul(cf(-3,2,-0.5),angles(0,0.2617993877991494,1.5707963267948966+87.26646259971648*sin((sine+0.06)*0.15))),deltaTime) 

												RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.15-0.2*sin((sine+0.6)*4),0),angles(-0.9599310885968813,1.0471975511965976+0.2617993877991494*sin((sine+0.1)*4),0.9599310885968813+0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
												RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,3+0.7*sin(sine*4),0.3 * sin((sine+0.25)*4)),angles(-1.7453292519943295+0.08726646259971647*sin(sine*2),0.08726646259971647*sin((sine+0.4)*4),2.443460952792061)),deltaTime) 
												RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.05*sin((sine+0.45)*4),0),angles(-0.6108652381980153,1.1344640137963142+0.08726646259971647*sin(sine*4),0.2617993877991494+0.08726646259971647*sin(sine*4))),deltaTime) 
												LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.35+0.2*sin((sine+0.45)*4),-0.8),angles(0.4363323129985824,-1.2217304763960306-0.08726646259971647*sin(sine*4),0.4363323129985824-0.08726646259971647*sin(sine*4))),deltaTime) 
												Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.710422666954443+0.08726646259971647*sin((sine+0.6)*4),0.08726646259971647*sin((sine+0.6)*4),3.839724354387525)),deltaTime) 
												LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.25-0.2*sin((sine+0.6)*4),0),angles(-1.2217304763960306,-0.8726646259971648-0.2617993877991494*sin((sine+0.1)*4),-1.2217304763960306-0.08726646259971647*sin((sine+0.25)*4))),deltaTime) 
												--MW_animatorProgressSave: RightArm,1,0,0,1,-55,,0.4,4,0.15,-0.2,0.6,4,60,15,0.1,4,0,0,0,1,55,5,0.25,4,SpikyBlackAnimeHair_Handle,-0.003238677978515625,0,0,1,180,0,0,1,0.1935257911682129,0,0,1,0,0,0,1,0.18658447265625,0,0,1,180,0,0,1,Fedora_Handle,2.384185791015625e-07,0,0,1,0,0,0,1,-0.03999924659729004,0,0,1,0,0,0,1,-0.04000011831521988,0,0,1,0,0,0,1,Meshes/beltupAccessory_Handle,0.09114837646484375,0,0,1,0,0,0,1,-0.1248544454574585,0,0,1,0,0,0,1,-0.4451904296875,0,0,1,0,0,0,1,Torso,0,0,0,1,-100,5,,2,3,0.7,0,4,,5,0.4,4,,0.3,0.25,4,140,0,0,1,DuffelBag_Handle,-0.1401824951171875,0,0,1,-180,0,0,1,0.029413461685180664,0,0,1,0,0,0,1,0.01397705078125,0,0,1,-180,0,0,1,Accessory(NeckFurCollar)_Handle,0,0,0,1,0,0,0,1,-0.13260126113891602,0,0,1,0,0,0,1,-0.149017333984375,0,0,1,0,0,0,1,TurtleNeck_Handle,0,0,0,1,0,0,0,1,-0.05000019073486328,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,Meshes/blackroundglasses_Plane.001(1)Accessory_Handle,0.00290679931640625,0,0,1,-180,0,0,1,-0.16674041748046875,0,0,1,0,0,0,1,0.42090749740600586,0,0,1,-180,0,0,1,RightLeg,1,0,0,1,-35,0,0,1,-1,0.05,0.45,4,65,5,0,4,0,0,0,1,15,5,0,4,LeftLeg,-1,0,0,1,25,0,0,1,-0.35,0.2,0.45,4,-70,-5,0,4,-0.8,0,0,1,25,-5,0,4,Head,0,0,0,1,-98,5,0.6,4,1,0,0,1,,5,0.6,4,0,0,0,1,220,0,0,1,TiedWaistJacket1.0_Handle,-3.0279159091151087e-07,0,0,1,0,0,0,1,0.15269756317138672,0,0,1,0,0,0,1,-0.016300499439239502,0,0,1,0,0,0,1,LeftArm,-1,0,0,1,-70,,0.4,4,0.25,-0.2,0.6,4,-50,-15,0.1,4,0,0,0,1,-70,-5,0.25,4
						i2.StudsOffsetWorldSpace=cframes[rootpart].Position 

end
 
	    end 
    end								 
end
	})

	
	
	









	local function idleL()
		local Ychg=velYchg()/20
		AccessoryWeld.C0=Lerp(AccessoryWeld.C0,cfMul(cf(0.1507892608642578,0.010945305228233337,0.03747892379760742),angles(0.5235987755982988,-1.5707963267948966,0)),deltaTime) 
		RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.9+0.2*sin((sine - 0.2)*16)-Ychg,0.25),angles(0,0.7853981633974483,0.4363323129985824-1.1344640137963142*sin((sine-0.0875)*8))),deltaTime) 
		RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0.15 * sin((sine-0.1)*8),0.54 * sin(sine*16)+Ychg,0),angles(-1.5707963267948966,-0.08726646259971647*sin((sine-0.0785)*8),3.141592653589793-0.08726646259971647*sin((sine-0.0785)*8))),deltaTime) 
		RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.75+0.07*sin((sine - 0.0785)*8),1.3+0.1*sin((sine - 0.0875)*16),0),angles(1.3962634015954636,2.356194490192345-0.06981317007977318*sin((sine-0.0785)*8),1.2217304763960306)),deltaTime) 
		Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.5707963267948966+0.08726646259971647*sin((sine-0.1)*16),0.12217304763960307*sin((sine-0.0785)*8),3.141592653589793)),deltaTime) 
		LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.9+0.2*sin((sine - 0.2)*16)-Ychg,0.25),angles(0,-0.7853981633974483,-0.4363323129985824-1.1344640137963142*sin((sine-0.0875)*8))),deltaTime) 
		LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.45+0.05*sin((sine - 0.0875)*16),-0.2),angles(2.0943951023931953+0.17453292519943295*sin((sine-0.0875)*16),-0.5235987755982988,1.5707963267948966+0.17453292519943295*sin((sine-0.0875)*16))),deltaTime) 
		i2.StudsOffsetWorldSpace=cframes[rootpart].Position 
		--MW_animatorProgressSave: RightLeg,1,0,0,16,0,0,0,8,-0.9,0.2,-0.2,16,45,0,-0.0875,8,0.25,0,0,16,25,-65,-0.0875,8,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Torso,0,0.15,-0.1,8,-90,0,0,16,0,0.54,0,16,-0,-5,-0.0785,8,0,0,0,16,180,-5,-0.0785,8,RightArm,0.75,0.07,-0.0785,8,80,0,0,16,1.3,0.1,-0.0875,16,135,-4,-0.0785,8,0,0,0,16,70,0,0,16,Head,0,0,0,16,-90,5,-0.1,16,1,0,0,16,-0,7,-0.0785,8,0,0,0,16,180,0,0,16,LeftLeg,-1,0,0,16,0,0,0,8,-0.9,0.2,-0.2,16,-45,0,0,8,0.25,0,0,16,-25,-65,-0.0875,8,Bandana_Handle,3.9362930692732334e-09,0,0,2,0,0,0,2,0.3000001907348633,0,0,2,0,0,0,2,-0.6002722978591919,0,0,2,0,0,0,2,LeftArm,-1,0,0,16,120,10,-0.0875,16,0.45,0.05,-0.0875,16,-30,0,0,16,-0.2,0,0,16,90,10,-0.0875,16
	end
	addmode("l", {
		modeEntered = function()
			setWalkSpeed(10)
		end,
		idle = idleL,
		walk = idleL,
		modeLeft = function()
			setWalkSpeed(16)
		end
	})
end)




insSet(btn("Stop",stopreanimate),"TextColor3",c3(0.75,0,0))

lbl("Settings")

local function swtc(txt,options,onchanged)
	local current=0
	local swtcbtn=nil
	local function btnpressed()
		current=current+1
		if current>#options then
			current=1
		end
		local option=options[current]
		insSet(swtcbtn,"Text",txt..": "..option.text)
		onchanged(option.value)
	end
	swtcbtn=btn("change",btnpressed)
	btnpressed()
	return swtcbtn
end

swtc("client sided placeholders",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	placeholders=v
end)

swtc("highlight fling targets",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	highlightflingtargets=v
end)

swtc("allow shiftlock",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	allowshiftlock=v
end)

swtc("ctrl click tp",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	ctrltp=v
end)

swtc("click fling",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	clickfling=v
end)

swtc("changestate when fling",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	flingchangestate=v
end)


swtc("respawn tp",{
	{value=true,text="random tp close"},
	{value=false,text="stay at spawn"}
},function(v)
	respawntp=v
end)

local disguiscripts=nil
swtc("new gui scripts",{
	{value=true,text="disable"},
	{value=false,text="keep"}
},function(v)
	disguiscripts=v
end)
Connect(insGet(pg,"DescendantAdded"),function(v)
	if c and disguiscripts and IsA(v,"Script") then --mind Enum.RunContext.Client
		insSet(v,"Disabled",true) 
	end
end)

swtc("new character scripts",{
	{value=function(v)
		if IsA(v,"Script") then --mind Enum.RunContext.Client
			insSet(v,"Disabled",true)
		end
	end,text="disable"},
	{value=false,text="keep"}
},function(v)
	discharscripts=v
end)

local iscg,_=pcall(insSet,i10,"Parent",FindFirstChildOfClass(game,"CoreGui"))
if not iscg then
	insSet(i7,"Text","MeowVis")
	insSet(i10,"Parent",pg)
	twait(3)
	insSet(i7,"Text",guiTheme.guiTitle)
end 
