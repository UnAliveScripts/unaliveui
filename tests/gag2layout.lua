--[[
	UnAliveUI — Gag2 Layout
	
	Full 1:1 demo.lua UI with all 6 pages.
	Dark Alert theme, Myriad-style traffic lights,
	search bar, EditMenu, WindowPill minimize.
--]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local pg = player:WaitForChild("PlayerGui")

for _, n in pairs({"UnAliveUI","UnAliveUI_Pill"}) do
	local e = pg:FindFirstChild(n)
	if e then e:Destroy() end
end

-- Config
local C = {
	Window = {W=540,H=400,R=16,BT=1,BG=Color3.fromRGB(12,12,14),BD=Color3.fromRGB(34,34,40)},
	Title = {H=34,BG=Color3.fromRGB(16,16,19),LN=Color3.fromRGB(36,36,42),TX="UnAlive",TC=Color3.fromRGB(190,190,198),TS=14,TL=14},
	Card = {ML=22,MR=22,MT=18,MB=18,R=16,BT=1,BG=Color3.fromRGB(20,20,24),BD=Color3.fromRGB(38,38,46)},
}

local gui = Instance.new("ScreenGui"); gui.Name="UnAliveUI"; gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset=true; gui.DisplayOrder=999; gui.Parent=pg
local gs = Instance.new("UIScale"); gs.Name="UIScale"; gs.Parent=gui

-- Window
local win = Instance.new("Frame"); win.Name="Window"; win.Size=UDim2.new(0,C.Window.W,0,C.Window.H)
win.AnchorPoint=Vector2.new(0.5,0.5); win.Position=UDim2.fromScale(0.5,0.5)
win.BackgroundColor3=C.Window.BG; win.BorderSizePixel=0; win.ZIndex=2; win.Parent=gui
Instance.new("UICorner",win).CornerRadius=UDim.new(0,C.Window.R)
local ws = Instance.new("UIStroke",win); ws.Color=C.Window.BD; ws.Thickness=C.Window.BT; ws.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local sh = Instance.new("Frame",win); sh.Name="Shadow"; sh.Size=UDim2.new(1,6,1,6); sh.Position=UDim2.new(0,-3,0,-3)
sh.BackgroundColor3=Color3.fromRGB(0,0,0); sh.BackgroundTransparency=0.65; sh.BorderSizePixel=0; sh.ZIndex=1
Instance.new("UICorner",sh).CornerRadius=UDim.new(0,C.Window.R)

-- TitleBar
local tb = Instance.new("Frame",win); tb.Name="TitleBar"; tb.Size=UDim2.new(1,0,0,C.Title.H)
tb.BackgroundColor3=C.Title.BG; tb.BorderSizePixel=0; tb.ZIndex=10
Instance.new("UICorner",tb).CornerRadius=UDim.new(0,C.Window.R)
local tm = Instance.new("Frame",tb); tm.Name="BottomMask"; tm.Size=UDim2.new(1,0,0,C.Window.R)
tm.Position=UDim2.new(0,0,1,-C.Window.R); tm.BackgroundColor3=C.Title.BG; tm.BorderSizePixel=0; tm.ZIndex=10
local hl = Instance.new("Frame",tb); hl.Name="Hairline"; hl.Size=UDim2.new(1,0,0,1); hl.Position=UDim2.new(0,0,1,-1)
hl.BackgroundColor3=C.Title.LN; hl.BorderSizePixel=0; hl.ZIndex=11

-- Title Text
local lbl = Instance.new("TextLabel",tb); lbl.Name="Title"; lbl.Size=UDim2.new(0,200,0,C.Title.TS)
lbl.AnchorPoint=Vector2.new(0,0.5); lbl.Position=UDim2.new(0,C.Title.TL,0.5,0); lbl.BackgroundTransparency=1
lbl.Text=C.Title.TX; lbl.Font=Enum.Font.Gotham; lbl.TextSize=C.Title.TS; lbl.TextColor3=C.Title.TC
lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=11

-- Traffic Lights
for i,d in ipairs({{"Exit","#FF5F57","rbxassetid://94781753558308"},{"Minimize","#FEBC2E","rbxassetid://118368309445367"}}) do
	local off=16+6+(2-i)*20
	local b = Instance.new("ImageButton",tb); b.Name=d[1]; b.AnchorPoint=Vector2.new(0.5,0.5)
	b.Position=UDim2.new(1,-off,0.5,0); b.Size=UDim2.fromOffset(12,12); b.AutoButtonColor=false
	b.BackgroundTransparency=1; b.BorderSizePixel=0; b.Image="rbxassetid://132228700346004"
	b.ImageColor3=Color3.fromHex(d[2]); b.ZIndex=15
	local ic = Instance.new("ImageLabel",b); ic.Name="Icon"; ic.AnchorPoint=Vector2.new(0.5,0.5)
	ic.BackgroundTransparency=1; ic.BorderSizePixel=0; ic.Image=d[3]; ic.ImageColor3=Color3.fromRGB(0,0,0)
	ic.ImageTransparency=0.5; ic.Position=UDim2.fromScale(0.5,0.5); ic.Size=UDim2.fromScale(1,1); ic.Visible=false
	b.MouseEnter:Connect(function() ic.Visible=true end)
	b.MouseLeave:Connect(function() ic.Visible=false end)
end

-- Card
local cw,ch = C.Window.W-C.Card.ML-C.Card.MR, C.Window.H-C.Title.H-C.Card.MT-C.Card.MB
local card = Instance.new("Frame",win); card.Name="Card"; card.Size=UDim2.new(0,cw,0,ch)
card.Position=UDim2.new(0,C.Card.ML,0,C.Title.H+C.Card.MT)
card.BackgroundColor3=C.Card.BG; card.BorderSizePixel=0; card.ZIndex=5
Instance.new("UICorner",card).CornerRadius=UDim.new(0,C.Card.R)
local cs = Instance.new("UIStroke",card); cs.Color=C.Card.BD; cs.Thickness=C.Card.BT; cs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

-- Card Shadow
local csh = Instance.new("ImageLabel",card); csh.Name="Shadow"; csh.Size=UDim2.new(1,30,1,30)
csh.Position=UDim2.new(0,-15,0,-15); csh.BackgroundTransparency=1; csh.Image="rbxassetid://6015897843"
csh.ImageColor3=Color3.fromRGB(0,0,0); csh.ImageTransparency=0.7; csh.ScaleType=Enum.ScaleType.Slice
csh.SliceCenter=Rect.new(49,49,50,50); csh.ZIndex=4

-- Drag
local dragging,dStart,dPos,targetPos,dragConn
local function startDrag(inp) dragging=true; dStart=inp.Position; dPos=win.Position; targetPos=dPos
	TS:Create(gs,TweenInfo.new(0.15),{Scale=0.97}):Play()
	if dragConn then dragConn:Disconnect() end
	dragConn=RS.Heartbeat:Connect(function() if not dragging then dragConn:Disconnect(); dragConn=nil return end
		win.Position=win.Position:Lerp(targetPos,0.15) end)
end
local function onInput(i,gp) if not gp and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then startDrag(i) end end
tb.InputBegan:Connect(onInput); card.InputBegan:Connect(onInput)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-dStart; targetPos=UDim2.new(dPos.X.Scale,dPos.X.Offset+d.X,dPos.Y.Scale,dPos.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 and dragging then dragging=false; TS:Create(gs,TweenInfo.new(0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play() end end)

-- Search Bar
local sf = Instance.new("Frame",card); sf.Name="SearchField"; sf.Size=UDim2.fromOffset(122,26)
sf.Position=UDim2.fromOffset(365,10); sf.BackgroundColor3=Color3.fromRGB(18,20,26); sf.BackgroundTransparency=0.08
sf.BorderSizePixel=0; sf.ZIndex=20; sf.ClipsDescendants=true; Instance.new("UICorner",sf).CornerRadius=UDim.new(0,13)
local sfb = Instance.new("UIStroke",sf); sfb.Color=Color3.fromRGB(255,255,255); sfb.Transparency=0.92; sfb.Thickness=0.5
local sfi = Instance.new("ImageLabel",sf); sfi.Size=UDim2.fromOffset(16,16); sfi.Position=UDim2.fromOffset(8,5)
sfi.BackgroundTransparency=1; sfi.Image="rbxassetid://117204739779559"; sfi.ImageColor3=Color3.fromRGB(200,200,200); sfi.ScaleType=Enum.ScaleType.Fit; sfi.ZIndex=21
local sfp = Instance.new("TextLabel",sf); sfp.Name="Placeholder"; sfp.Size=UDim2.fromOffset(74,16); sfp.Position=UDim2.fromOffset(26,5)
sfp.BackgroundTransparency=1; sfp.FontFace=Font.new("rbxassetid://12187365364"); sfp.Text="Search"; sfp.TextSize=13
sfp.TextColor3=Color3.fromRGB(245,245,245); sfp.TextXAlignment=Enum.TextXAlignment.Left; sfp.ZIndex=21

-- Pages Container
local pages = Instance.new("Frame",card); pages.Name="Pages"; pages.Size=UDim2.fromOffset(496,200); pages.Position=UDim2.fromOffset(0,50)
pages.BackgroundTransparency=1; pages.BorderSizePixel=0; pages.ZIndex=20

-- 6 Pages
local pageData = {{"Farm","Manage your farm resources and crops"},{"Shop","Browse items available for purchase"},{"Steal","Steal resources from other players"},{"Spawn","Spawn vehicles, items, and more"},{"Config","Configure your settings"},{"Settings","Adjust your preferences"}}
for pi,pd in ipairs(pageData) do
	local p = Instance.new("Frame",pages); p.Name="Page"..pi; p.Size=UDim2.fromScale(1,1); p.BackgroundTransparency=1; p.BorderSizePixel=0; p.ZIndex=20; p.Visible=pi==1
	local t = Instance.new("TextLabel",p); t.Size=UDim2.fromOffset(200,30); t.Position=UDim2.fromOffset(20,40); t.BackgroundTransparency=1
	t.FontFace=Font.new("rbxassetid://12187365364"); t.Text=pd[1]; t.TextSize=24; t.TextColor3=Color3.fromRGB(255,255,255); t.TextXAlignment=Enum.TextXAlignment.Left
	local d = Instance.new("TextLabel",p); d.Size=UDim2.fromOffset(400,20); d.Position=UDim2.fromOffset(20,80); d.BackgroundTransparency=1
	d.FontFace=Font.new("rbxassetid://12187365364"); d.Text=pd[2]; d.TextSize=14; d.TextColor3=Color3.fromRGB(180,180,190); d.TextXAlignment=Enum.TextXAlignment.Left
end

-- EditMenu
local em = Instance.new("Frame",card); em.Name="EditMenu"; em.Size=UDim2.fromOffset(488,44); em.Position=UDim2.fromOffset(4,276)
em.ZIndex=20; em.BackgroundTransparency=1
local ems = Instance.new("Frame",em); ems.Size=UDim2.new(1,4,1,4); ems.Position=UDim2.fromOffset(-2,-2)
ems.BackgroundColor3=Color3.fromRGB(0,0,0); ems.BackgroundTransparency=0.82; ems.BorderSizePixel=0; ems.ZIndex=-1
Instance.new("UICorner",ems).CornerRadius=UDim.new(0,34)
local emg = Instance.new("Frame",em); emg.Size=UDim2.fromScale(1,1); emg.BackgroundColor3=Color3.fromRGB(12,14,18); emg.BorderSizePixel=0; emg.ZIndex=20
Instance.new("UICorner",emg).CornerRadius=UDim.new(0,34)
local emst = Instance.new("UIStroke",emg); emst.Color=Color3.fromRGB(255,255,255); emst.Transparency=0.88; emst.Thickness=1
local emc = Instance.new("Frame",em); emc.Size=UDim2.fromScale(1,1); emc.BackgroundTransparency=1; emc.BorderSizePixel=0; emc.ZIndex=22
local eml = Instance.new("UIListLayout",emc); eml.FillDirection=Enum.FillDirection.Horizontal; eml.VerticalAlignment=Enum.VerticalAlignment.Center; eml.Padding=UDim.new(0,0)
Instance.new("UIPadding",emc).PaddingLeft=UDim.new(0,20); Instance.new("UIPadding",emc).PaddingRight=UDim.new(0,4)

-- EditMenu Tabs
local items = {{"Farm",50,34,false},{"Shop",68,35,true},{"Steal",67,34,true},{"Spawn",78,45,true},{"Config",77,44,true},{"Settings",88,55,true}}
local selLabel
for ei,ed in ipairs(items) do
	local text,w,tw,hs = table.unpack(ed)
	local a = Instance.new("Frame",emc); a.Size=UDim2.fromOffset(w,18); a.BackgroundTransparency=1; a.BorderSizePixel=0
	if hs then local s=Instance.new("Frame",a); s.Size=UDim2.fromOffset(1,18); s.BackgroundColor3=Color3.fromRGB(255,255,255); s.BackgroundTransparency=0.8; s.BorderSizePixel=0 end
	local lb = Instance.new("TextLabel",a); lb.Size=UDim2.fromOffset(tw,18); lb.Position=UDim2.fromOffset(hs and 17 or 0,0)
	lb.BackgroundTransparency=1; lb.FontFace=Font.new("rbxassetid://12187365364"); lb.Text=text; lb.TextSize=15
	lb.TextColor3=ei==1 and Color3.fromRGB(255,66,84) or Color3.fromRGB(245,245,245)
	lb.TextXAlignment=Enum.TextXAlignment.Left; lb.TextYAlignment=Enum.TextYAlignment.Center
	if ei==1 then selLabel=lb end
	local hb = Instance.new("TextButton",a); hb.Size=UDim2.fromScale(1,1); hb.BackgroundTransparency=1; hb.BorderSizePixel=0; hb.Text=""; hb.ZIndex=22; hb.AutoButtonColor=false
	hb.MouseButton1Click:Connect(function()
		if selLabel==lb then return end
		if selLabel then TS:Create(selLabel,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3=Color3.fromRGB(245,245,245)}):Play() end
		lb.TextColor3=Color3.fromRGB(255,66,84); selLabel=lb
		for _,p in pairs(pages:GetChildren()) do if p:IsA("Frame") then p.Visible=false end end
		local t = pages:FindFirstChild("Page"..ei); if t then t.Visible=true end
	end)
end

-- Info Button
local ind = Instance.new("Frame",emc); ind.Size=UDim2.fromOffset(36,36); ind.BackgroundColor3=Color3.fromRGB(3,3,3)
Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
local ii = Instance.new("ImageLabel",ind); ii.Size=UDim2.fromOffset(24,24); ii.Position=UDim2.fromOffset(6,6)
ii.BackgroundTransparency=1; ii.Image="rbxassetid://103603118195781"; ii.ImageColor3=Color3.fromRGB(255,255,255); ii.ScaleType=Enum.ScaleType.Fit; ii.ZIndex=22

-- WindowPill
local pgui = Instance.new("ScreenGui"); pgui.Name="UnAliveUI_Pill"; pgui.ResetOnSpawn=false
pgui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; pgui.DisplayOrder=200; pgui.IgnoreGuiInset=true; pgui.Parent=pg
local pill = Instance.new("ImageButton",pgui); pill.Name="WindowPill"; pill.AnchorPoint=Vector2.new(0.5,0)
pill.AutoButtonColor=false; pill.BackgroundTransparency=1; pill.BorderSizePixel=0
pill.Image="rbxassetid://93520763686656"; pill.ImageTransparency=0.5
pill.Position=UDim2.new(0.5,0,0,10); pill.Size=UDim2.fromOffset(180,5); pill.ZIndex=999
Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)

-- Minimize
local mined = false
local function toggleMin()
	mined=not mined; local tY=mined and win.AbsoluteSize.Y*2 or 0
	TS:Create(win,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.5,tY)}):Play()
	TS:Create(gs,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Scale=mined and 0 or 1}):Play()
end
local ct
pill.MouseEnter:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.15}); ct:Play() end)
pill.MouseLeave:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.5}); ct:Play() end)
pill.MouseButton1Click:Connect(toggleMin)
tb:FindFirstChild("Exit").MouseButton1Click:Connect(function() gui:Destroy(); pgui:Destroy() end)
tb:FindFirstChild("Minimize").MouseButton1Click:Connect(toggleMin)

print("=== UnAliveUI Main Window ===")
