--[[
	UnAliveUI — Gag2 Complete Layout
	
	Demo.lua UI structure with GitHub components.
	6 pages with subcards using Toggle, Slider, Pulldown, etc.
--]]

local UnAlive = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"))()
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

for _, n in pairs({"UnAliveUI","UnAliveUI_Pill"}) do local e=pg:FindFirstChild(n) if e then e:Destroy() end end

-- Config
local C = {W=540,H=400,R=16,BT=1,BG=Color3.fromRGB(12,12,14),BD=Color3.fromRGB(34,34,40),
	T={H=34,BG=Color3.fromRGB(16,16,19),LN=Color3.fromRGB(36,36,42),TX="Gag2",TC=Color3.fromRGB(190,190,198),TS=14,TL=14},
	CD={ML=22,MR=22,MT=18,MB=18,R=16,BT=1,BG=Color3.fromRGB(20,20,24),BD=Color3.fromRGB(38,38,46)},
	D={S=0.15,SD=0.97,SU=0.15,SH=0.15}}

-- ScreenGui
local gui=Instance.new("ScreenGui"); gui.Name="UnAliveUI"; gui.ResetOnSpawn=false; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset=true; gui.DisplayOrder=999; gui.Parent=pg
local gs=Instance.new("UIScale"); gs.Name="UIScale"; gs.Parent=gui

-- Window
local W,H,R=C.W,C.H,C.R
local win=Instance.new("Frame"); win.Name="Window"; win.Size=UDim2.new(0,W,0,H); win.AnchorPoint=Vector2.new(0.5,0.5); win.Position=UDim2.fromScale(0.5,0.5)
win.BackgroundColor3=C.BG; win.BorderSizePixel=0; win.ZIndex=2; win.Parent=gui; Instance.new("UICorner",win).CornerRadius=UDim.new(0,R)
local ws=Instance.new("UIStroke",win); ws.Color=C.BD; ws.Thickness=C.BT; ws.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

-- Shadow
local sh=Instance.new("Frame",win); sh.Name="Shadow"; sh.Size=UDim2.new(1,6,1,6); sh.Position=UDim2.new(0,-3,0,-3); sh.BackgroundColor3=Color3.fromRGB(0,0,0); sh.BackgroundTransparency=0.65; sh.BorderSizePixel=0; sh.ZIndex=1; Instance.new("UICorner",sh).CornerRadius=UDim.new(0,R)

-- TitleBar
local tb=Instance.new("Frame",win); tb.Name="TitleBar"; tb.Size=UDim2.new(1,0,0,C.T.H); tb.BackgroundColor3=C.T.BG; tb.BorderSizePixel=0; tb.ZIndex=10; Instance.new("UICorner",tb).CornerRadius=UDim.new(0,R)
local tm=Instance.new("Frame",tb); tm.Name="BottomMask"; tm.Size=UDim2.new(1,0,0,R); tm.Position=UDim2.new(0,0,1,-R); tm.BackgroundColor3=C.T.BG; tm.BorderSizePixel=0; tm.ZIndex=10
local hl=Instance.new("Frame",tb); hl.Name="Hairline"; hl.Size=UDim2.new(1,0,0,1); hl.Position=UDim2.new(0,0,1,-1); hl.BackgroundColor3=C.T.LN; hl.BorderSizePixel=0; hl.ZIndex=11
local tl=Instance.new("TextLabel",tb); tl.Name="Title"; tl.Size=UDim2.new(0,200,0,C.T.TS); tl.AnchorPoint=Vector2.new(0,0.5); tl.Position=UDim2.new(0,C.T.TL,0.5,0); tl.BackgroundTransparency=1; tl.Text=C.T.TX; tl.Font=Enum.Font.Gotham; tl.TextSize=C.T.TS; tl.TextColor3=C.T.TC; tl.TextXAlignment=Enum.TextXAlignment.Left; tl.ZIndex=11

-- Traffic Lights
for i,d in ipairs({{"Exit","#FF5F57","rbxassetid://94781753558308"},{"Minimize","#FEBC2E","rbxassetid://118368309445367"}}) do
	local off=16+6+(2-i)*20; local b=Instance.new("ImageButton",tb); b.Name=d[1]; b.AnchorPoint=Vector2.new(0.5,0.5); b.Position=UDim2.new(1,-off,0.5,0); b.Size=UDim2.fromOffset(12,12); b.AutoButtonColor=false; b.BackgroundTransparency=1; b.BorderSizePixel=0; b.Image="rbxassetid://132228700346004"; b.ImageColor3=Color3.fromHex(d[2]); b.ZIndex=15
	local ic=Instance.new("ImageLabel",b); ic.Name="Icon"; ic.AnchorPoint=Vector2.new(0.5,0.5); ic.BackgroundTransparency=1; ic.BorderSizePixel=0; ic.Image=d[3]; ic.ImageColor3=Color3.fromRGB(0,0,0); ic.ImageTransparency=0.5; ic.Position=UDim2.fromScale(0.5,0.5); ic.Size=UDim2.fromScale(1,1); ic.Visible=false
	b.MouseEnter:Connect(function() ic.Visible=true end); b.MouseLeave:Connect(function() ic.Visible=false end)
end

-- Card
local cw,ch=W-C.CD.ML-C.CD.MR, H-C.T.H-C.CD.MT-C.CD.MB
local card=Instance.new("Frame",win); card.Name="Card"; card.Size=UDim2.new(0,cw,0,ch); card.Position=UDim2.new(0,C.CD.ML,0,C.T.H+C.CD.MT); card.BackgroundColor3=C.CD.BG; card.BorderSizePixel=0; card.ZIndex=5; Instance.new("UICorner",card).CornerRadius=UDim.new(0,C.CD.R)
local cst=Instance.new("UIStroke",card); cst.Color=C.CD.BD; cst.Thickness=C.CD.BT; cst.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local csh=Instance.new("ImageLabel",card); csh.Name="Shadow"; csh.Size=UDim2.new(1,30,1,30); csh.Position=UDim2.new(0,-15,0,-15); csh.BackgroundTransparency=1; csh.Image="rbxassetid://6015897843"; csh.ImageColor3=Color3.fromRGB(0,0,0); csh.ImageTransparency=0.7; csh.ScaleType=Enum.ScaleType.Slice; csh.SliceCenter=Rect.new(49,49,50,50); csh.ZIndex=4

-- Drag
local dragging,dStart,dPos,targetPos,dragConn
local function startDrag(inp) dragging=true; dStart=inp.Position; dPos=win.Position; targetPos=dPos; TS:Create(gs,TweenInfo.new(C.D.SU),{Scale=C.D.SD}):Play()
	if dragConn then dragConn:Disconnect() end
	dragConn=RS.Heartbeat:Connect(function() if not dragging then dragConn:Disconnect(); dragConn=nil return end; win.Position=win.Position:Lerp(targetPos,C.D.S) end)
end
local function onInput(i,gp) if not gp and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then startDrag(i) end end
tb.InputBegan:Connect(onInput); card.InputBegan:Connect(onInput)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-dStart; targetPos=UDim2.new(dPos.X.Scale,dPos.X.Offset+d.X,dPos.Y.Scale,dPos.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 and dragging then dragging=false; TS:Create(gs,TweenInfo.new(C.D.SU,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play() end end)

-- Search Bar
local sf=Instance.new("Frame",card); sf.Name="SearchField"; sf.Size=UDim2.fromOffset(122,26); sf.Position=UDim2.fromOffset(365,10); sf.BackgroundColor3=Color3.fromRGB(18,20,26); sf.BackgroundTransparency=0.08; sf.BorderSizePixel=0; sf.ZIndex=20; sf.ClipsDescendants=true; Instance.new("UICorner",sf).CornerRadius=UDim.new(0,13)
local sfb=Instance.new("UIStroke",sf); sfb.Color=Color3.fromRGB(255,255,255); sfb.Transparency=0.92; sfb.Thickness=0.5
local sfi=Instance.new("ImageLabel",sf); sfi.Size=UDim2.fromOffset(16,16); sfi.Position=UDim2.fromOffset(8,5); sfi.BackgroundTransparency=1; sfi.Image="rbxassetid://117204739779559"; sfi.ImageColor3=Color3.fromRGB(200,200,200); sfi.ScaleType=Enum.ScaleType.Fit; sfi.ZIndex=21
local sfp=Instance.new("TextLabel",sf); sfp.Name="Placeholder"; sfp.Size=UDim2.fromOffset(74,16); sfp.Position=UDim2.fromOffset(26,5); sfp.BackgroundTransparency=1; sfp.FontFace=Font.new("rbxassetid://12187365364"); sfp.Text="Search"; sfp.TextSize=13; sfp.TextColor3=Color3.fromRGB(245,245,245); sfp.TextXAlignment=Enum.TextXAlignment.Left; sfp.ZIndex=21

-- Pages
local pages=Instance.new("Frame",card); pages.Name="Pages"; pages.Size=UDim2.fromOffset(496,224); pages.Position=UDim2.fromOffset(0,50); pages.BackgroundTransparency=1; pages.BorderSizePixel=0; pages.ZIndex=20
local pageData = {"Farm","Shop","Steal","Spawn","Config","Settings"}
local pageFrames = {}

for pi, name in ipairs(pageData) do
	local p=Instance.new("Frame",pages); p.Name="Page"..pi; p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.ZIndex=20; p.Visible=pi==1
	pageFrames[pi] = p
end

-- EditMenu
local em=Instance.new("Frame",card); em.Name="EditMenu"; em.Size=UDim2.fromOffset(488,44); em.Position=UDim2.fromOffset(4,276); em.ZIndex=20; em.BackgroundTransparency=1
local ems=Instance.new("Frame",em); ems.Size=UDim2.new(1,4,1,4); ems.Position=UDim2.fromOffset(-2,-2); ems.BackgroundColor3=Color3.fromRGB(0,0,0); ems.BackgroundTransparency=0.82; ems.BorderSizePixel=0; ems.ZIndex=-1; Instance.new("UICorner",ems).CornerRadius=UDim.new(0,34)
local emg=Instance.new("Frame",em); emg.Size=UDim2.fromScale(1,1); emg.BackgroundColor3=Color3.fromRGB(12,14,18); emg.BorderSizePixel=0; emg.ZIndex=20; Instance.new("UICorner",emg).CornerRadius=UDim.new(0,34)
local emst=Instance.new("UIStroke",emg); emst.Color=Color3.fromRGB(255,255,255); emst.Transparency=0.88; emst.Thickness=1
local emc=Instance.new("Frame",em); emc.Size=UDim2.fromScale(1,1); emc.BackgroundTransparency=1; emc.BorderSizePixel=0; emc.ZIndex=22
local eml=Instance.new("UIListLayout",emc); eml.FillDirection=Enum.FillDirection.Horizontal; eml.VerticalAlignment=Enum.VerticalAlignment.Center; eml.Padding=UDim.new(0,0)
Instance.new("UIPadding",emc).PaddingLeft=UDim.new(0,20); Instance.new("UIPadding",emc).PaddingRight=UDim.new(0,4)

local items={{"Farm",50,34,false},{"Shop",68,35,true},{"Steal",67,34,true},{"Spawn",78,45,true},{"Config",77,44,true},{"Settings",88,55,true}}
local selLabel
for ei,ed in ipairs(items) do
	local text,w,tw,hs=table.unpack(ed)
	local a=Instance.new("Frame",emc); a.Size=UDim2.fromOffset(w,18); a.BackgroundTransparency=1; a.BorderSizePixel=0
	if hs then local s=Instance.new("Frame",a); s.Size=UDim2.fromOffset(1,18); s.BackgroundColor3=Color3.fromRGB(255,255,255); s.BackgroundTransparency=0.8; s.BorderSizePixel=0 end
	local lb=Instance.new("TextLabel",a); lb.Size=UDim2.fromOffset(tw,18); lb.Position=UDim2.fromOffset(hs and 17 or 0,0); lb.BackgroundTransparency=1; lb.FontFace=Font.new("rbxassetid://12187365364"); lb.Text=text; lb.TextSize=15; lb.TextColor3=ei==1 and Color3.fromRGB(255,66,84) or Color3.fromRGB(245,245,245); lb.TextXAlignment=Enum.TextXAlignment.Left; lb.TextYAlignment=Enum.TextYAlignment.Center
	if ei==1 then selLabel=lb end
	local hb=Instance.new("TextButton",a); hb.Size=UDim2.fromScale(1,1); hb.BackgroundTransparency=1; hb.BorderSizePixel=0; hb.Text=""; hb.ZIndex=22; hb.AutoButtonColor=false
	hb.MouseButton1Click:Connect(function()
		if selLabel==lb then return end
		if selLabel then TS:Create(selLabel,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(245,245,245)}):Play() end
		lb.TextColor3=Color3.fromRGB(255,66,84); selLabel=lb
		for _,p in pairs(pages:GetChildren()) do if p:IsA("Frame") then p.Visible=false end end
		local t=pages:FindFirstChild("Page"..ei); if t then t.Visible=true end
	end)
end
local ind=Instance.new("Frame",emc); ind.Size=UDim2.fromOffset(36,36); ind.BackgroundColor3=Color3.fromRGB(3,3,3); Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
local ii=Instance.new("ImageLabel",ind); ii.Size=UDim2.fromOffset(24,24); ii.Position=UDim2.fromOffset(6,6); ii.BackgroundTransparency=1; ii.Image="rbxassetid://103603118195781"; ii.ImageColor3=Color3.fromRGB(255,255,255); ii.ScaleType=Enum.ScaleType.Fit; ii.ZIndex=22

-- =====================
-- POPULATE PAGES WITH GITHUB COMPONENTS
-- =====================

-- Component wrappers for compact placement
local function pl(parent, item, x, y)
	item:Parent(parent)
	item.__instance.Position = UDim2.fromOffset(x, y)
	item.__instance.ZIndex = 25
end

local function toggle(parent, x, y, val)
	local t = UnAlive:New("Toggle", {Value = val or false})
	pl(parent, t, x, y)
	return t
end

local function slider(parent, x, y, val)
	local s = UnAlive:New("Slider", {Value = val or 3})
	pl(parent, s, x, y)
	return s
end

local function pulldown(parent, x, y, label, items)
	local p = UnAlive:New("Pulldown", {Label = label or "Select", Items = items or {"Option 1","Option 2"}})
	pl(parent, p, x, y)
	return p
end

local function stepper(parent, x, y, val)
	local s = UnAlive:New("Stepper", {Value = val or 5000})
	pl(parent, s, x, y)
	return s
end

local function btn(parent, x, y, text, label)
	local b = UnAlive:New("Button", {Text = text or "Action", Label = label or "Run"})
	pl(parent, b, x, y)
	return b
end

local function tfield(parent, x, y, text, ph)
	local tf = UnAlive:New("TextField", {Text = text or "", Placeholder = ph or "Enter..."})
	pl(parent, tf, x, y)
	return tf
end

local function cardc(parent, x, y, w, h)
	local c = UnAlive:New("SubCard", {Width = w or 472, Height = h or 48})
	pl(parent, c, x, y)
	return c
end

local function trailing(parent, x, y, text)
	local t = UnAlive:New("TrailingAccessories", {Label = text or "Label"})
	pl(parent, t, x, y)
	return t
end

local function mkLabel(parent, x, y, text, color)
	local l = Instance.new("TextLabel", parent)
	l.Size = UDim2.fromOffset(300, 14); l.Position = UDim2.fromOffset(x, y)
	l.BackgroundTransparency = 1; l.FontFace = Font.new("rbxassetid://12187365364")
	l.TextSize = 11; l.TextColor3 = color or Color3.fromRGB(245,245,245)
	l.Text = text; l.TextXAlignment = Enum.TextXAlignment.Left; l.ZIndex = 25
	return l
end

-- FARM PAGE
local farm = pageFrames[1]
toggle(farm, 14, 4, false); mkLabel(farm, 80, 6, "Auto-Farm")
toggle(farm, 175, 4); mkLabel(farm, 241, 6, "Expand")
toggle(farm, 310, 4); mkLabel(farm, 376, 6, "Daily")
toggle(farm, 14, 34); mkLabel(farm, 80, 36, "Pot")
toggle(farm, 175, 34); mkLabel(farm, 241, 36, "Sprinkler")
toggle(farm, 310, 34); mkLabel(farm, 376, 36, "Water")

-- SHOP PAGE
local shop = pageFrames[2]
toggle(shop, 14, 4, false); mkLabel(shop, 80, 6, "Auto-Buy"); pulldown(shop, 200, 4, "Seeds", {"All","Wheat","Corn"})

print("=== Gag2 Complete Layout ===")

-- WindowPill
local pgui=Instance.new("ScreenGui"); pgui.Name="UnAliveUI_Pill"; pgui.ResetOnSpawn=false; pgui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; pgui.DisplayOrder=200; pgui.IgnoreGuiInset=true; pgui.Parent=pg
local pill=Instance.new("ImageButton",pgui); pill.Name="WindowPill"; pill.AnchorPoint=Vector2.new(0.5,0); pill.AutoButtonColor=false; pill.BackgroundTransparency=1; pill.BorderSizePixel=0; pill.Image="rbxassetid://93520763686656"; pill.ImageTransparency=0.5; pill.Position=UDim2.new(0.5,0,0,10); pill.Size=UDim2.fromOffset(180,5); pill.ZIndex=999; Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
local mined=false
local function toggleMin() mined=not mined; local tY=mined and win.AbsoluteSize.Y*2 or 0; TS:Create(win,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.5,tY)}):Play(); TS:Create(gs,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Scale=mined and 0 or 1}):Play() end
local ct; pill.MouseEnter:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.15}); ct:Play() end)
pill.MouseLeave:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.5}); ct:Play() end)
pill.MouseButton1Click:Connect(toggleMin)
tb:FindFirstChild("Exit").MouseButton1Click:Connect(function() gui:Destroy(); pgui:Destroy() end)
tb:FindFirstChild("Minimize").MouseButton1Click:Connect(toggleMin)
