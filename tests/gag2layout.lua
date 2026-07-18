--[[
	UnAliveUI — Gag2 Complete Layout
	
	All 6 pages with subcards and controls.
	Uses UnAliveUI library components.
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
	CD={ML=22,MR=22,MT=18,MB=18,R=16,BT=1,BG=Color3.fromRGB(20,20,24),BD=Color3.fromRGB(38,38,46)}}

local gui=Instance.new("ScreenGui"); gui.Name="UnAliveUI"; gui.ResetOnSpawn=false; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset=true; gui.DisplayOrder=999; gui.Parent=pg
local gs=Instance.new("UIScale"); gs.Name="UIScale"; gs.Parent=gui
local win=Instance.new("Frame"); win.Name="Window"; win.Size=UDim2.new(0,C.W,0,C.H); win.AnchorPoint=Vector2.new(0.5,0.5); win.Position=UDim2.fromScale(0.5,0.5)
win.BackgroundColor3=C.BG; win.BorderSizePixel=0; win.ZIndex=2; win.Parent=gui; Instance.new("UICorner",win).CornerRadius=UDim.new(0,C.R)
local ws=Instance.new("UIStroke",win); ws.Color=C.BD; ws.Thickness=C.BT; ws.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local sh=Instance.new("Frame",win); sh.Name="Shadow"; sh.Size=UDim2.new(1,6,1,6); sh.Position=UDim2.new(0,-3,0,-3); sh.BackgroundColor3=Color3.fromRGB(0,0,0); sh.BackgroundTransparency=0.65; sh.BorderSizePixel=0; sh.ZIndex=1; Instance.new("UICorner",sh).CornerRadius=UDim.new(0,C.R)
local tb=Instance.new("Frame",win); tb.Name="TitleBar"; tb.Size=UDim2.new(1,0,0,C.T.H); tb.BackgroundColor3=C.T.BG; tb.BorderSizePixel=0; tb.ZIndex=10; Instance.new("UICorner",tb).CornerRadius=UDim.new(0,C.R)
local tm=Instance.new("Frame",tb); tm.Name="BottomMask"; tm.Size=UDim2.new(1,0,0,C.R); tm.Position=UDim2.new(0,0,1,-C.R); tm.BackgroundColor3=C.T.BG; tm.BorderSizePixel=0; tm.ZIndex=10
local hl=Instance.new("Frame",tb); hl.Name="Hairline"; hl.Size=UDim2.new(1,0,0,1); hl.Position=UDim2.new(0,0,1,-1); hl.BackgroundColor3=C.T.LN; hl.BorderSizePixel=0; hl.ZIndex=11
local lbl=Instance.new("TextLabel",tb); lbl.Name="Title"; lbl.Size=UDim2.new(0,200,0,C.T.TS); lbl.AnchorPoint=Vector2.new(0,0.5); lbl.Position=UDim2.new(0,C.T.TL,0.5,0); lbl.BackgroundTransparency=1; lbl.Text=C.T.TX; lbl.Font=Enum.Font.Gotham; lbl.TextSize=C.T.TS; lbl.TextColor3=C.T.TC; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=11
for i,d in ipairs({{"Exit","#FF5F57","rbxassetid://94781753558308"},{"Minimize","#FEBC2E","rbxassetid://118368309445367"}}) do
	local off=16+6+(2-i)*20; local b=Instance.new("ImageButton",tb); b.Name=d[1]; b.AnchorPoint=Vector2.new(0.5,0.5); b.Position=UDim2.new(1,-off,0.5,0); b.Size=UDim2.fromOffset(12,12); b.AutoButtonColor=false; b.BackgroundTransparency=1; b.BorderSizePixel=0; b.Image="rbxassetid://132228700346004"; b.ImageColor3=Color3.fromHex(d[2]); b.ZIndex=15
	local ic=Instance.new("ImageLabel",b); ic.Name="Icon"; ic.AnchorPoint=Vector2.new(0.5,0.5); ic.BackgroundTransparency=1; ic.BorderSizePixel=0; ic.Image=d[3]; ic.ImageColor3=Color3.fromRGB(0,0,0); ic.ImageTransparency=0.5; ic.Position=UDim2.fromScale(0.5,0.5); ic.Size=UDim2.fromScale(1,1); ic.Visible=false
	b.MouseEnter:Connect(function() ic.Visible=true end); b.MouseLeave:Connect(function() ic.Visible=false end)
end

-- Card + ScrollingContent
local cw,ch = C.W-C.CD.ML-C.CD.MR, C.H-C.T.H-C.CD.MT-C.CD.MB
local card=Instance.new("Frame",win); card.Name="Card"; card.Size=UDim2.new(0,cw,0,ch); card.Position=UDim2.new(0,C.CD.ML,0,C.T.H+C.CD.MT); card.BackgroundColor3=C.CD.BG; card.BorderSizePixel=0; card.ZIndex=5; Instance.new("UICorner",card).CornerRadius=UDim.new(0,C.CD.R)
local cs=Instance.new("UIStroke",card); cs.Color=C.CD.BD; cs.Thickness=C.CD.BT; cs.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local csh=Instance.new("ImageLabel",card); csh.Name="Shadow"; csh.Size=UDim2.new(1,30,1,30); csh.Position=UDim2.new(0,-15,0,-15); csh.BackgroundTransparency=1; csh.Image="rbxassetid://6015897843"; csh.ImageColor3=Color3.fromRGB(0,0,0); csh.ImageTransparency=0.7; csh.ScaleType=Enum.ScaleType.Slice; csh.SliceCenter=Rect.new(49,49,50,50); csh.ZIndex=4

local scroller=Instance.new("ScrollingFrame",card); scroller.Name="Content"; scroller.Size=UDim2.fromScale(1,1); scroller.BackgroundTransparency=1; scroller.BorderSizePixel=0; scroller.ZIndex=20; scroller.ScrollBarThickness=6; scroller.ScrollBarImageColor3=Color3.fromRGB(80,80,80); scroller.CanvasSize=UDim2.fromScale(0,0); scroller.AutomaticCanvasSize=Enum.AutomaticSize.Y
Instance.new("UIPadding",scroller).PaddingLeft=UDim.new(0,12); Instance.new("UIPadding",scroller).PaddingRight=UDim.new(0,12); Instance.new("UIPadding",scroller).PaddingTop=UDim.new(0,8)

local layout=Instance.new("UIListLayout",scroller); layout.Padding=UDim.new(0,4); layout.SortOrder=Enum.SortOrder.LayoutOrder
Instance.new("UIPadding",scroller).PaddingBottom=UDim.new(0,8)

-- Tab bar
local tabBar=Instance.new("Frame",scroller); tabBar.Size=UDim2.new(1,0,0,28); tabBar.BackgroundTransparency=1; tabBar.BorderSizePixel=0
local tabLayout=Instance.new("UIListLayout",tabBar); tabLayout.FillDirection=Enum.FillDirection.Horizontal; tabLayout.Padding=UDim.new(0,0); tabLayout.VerticalAlignment=Enum.VerticalAlignment.Center
local tabNames={"Farm","Shop","Steal","Spawn","Config","Settings"}; local tabButtons={}; local tabPages={}; local selectedTab

for i,name in ipairs(tabNames) do
	local btn=Instance.new("TextButton",tabBar); btn.Size=UDim2.fromOffset(0,24); btn.AutomaticSize=Enum.AutomaticSize.X; btn.BackgroundTransparency=1; btn.BorderSizePixel=0; btn.Text="   "..name.."   "; btn.FontFace=Font.new("rbxassetid://12187365364"); btn.TextSize=14; btn.TextColor3=Color3.fromRGB(245,245,245); btn.TextTransparency=0.4; btn.AutoButtonColor=false; btn.ZIndex=25
	btn.MouseEnter:Connect(function() if selectedTab~=i then btn.TextTransparency=0.15 end end)
	btn.MouseLeave:Connect(function() if selectedTab~=i then btn.TextTransparency=0.4 end end)
	tabButtons[i]=btn
	local page=Instance.new("Frame",scroller); page.Name=name.."Page"; page.Size=UDim2.fromScale(1,0); page.AutomaticSize=Enum.AutomaticSize.Y; page.BackgroundTransparency=1; page.BorderSizePixel=0; page.Visible=i==1; page.ZIndex=20
	local pl=Instance.new("UIListLayout",page); pl.Padding=UDim.new(0,4); pl.SortOrder=Enum.SortOrder.LayoutOrder
	tabPages[i]=page
	btn.MouseButton1Click:Connect(function()
		if selectedTab==i then return end
		if selectedTab then tabButtons[selectedTab].TextTransparency=0.4 end
		selectedTab=i; btn.TextTransparency=0; btn.TextColor3=Color3.fromRGB(255,66,84)
		for j,p in ipairs(tabPages) do p.Visible=j==i end
	end)
	if i==1 then selectedTab=1; btn.TextTransparency=0; btn.TextColor3=Color3.fromRGB(255,66,84) end
end

---- DRAG ----
local dragging,dStart,dPos,targetPos,dragConn
local function startDrag(inp) dragging=true; dStart=inp.Position; dPos=win.Position; targetPos=dPos
	TS:Create(gs,TweenInfo.new(0.15),{Scale=0.97}):Play()
	if dragConn then dragConn:Disconnect() end
	dragConn=RS.Heartbeat:Connect(function() if not dragging then dragConn:Disconnect(); dragConn=nil return end; win.Position=win.Position:Lerp(targetPos,0.15) end)
end
local function onInput(i,gp) if not gp and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then startDrag(i) end end
tb.InputBegan:Connect(onInput)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then local d=i.Position-dStart; targetPos=UDim2.new(dPos.X.Scale,dPos.X.Offset+d.X,dPos.Y.Scale,dPos.Y.Offset+d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 and dragging then dragging=false; TS:Create(gs,TweenInfo.new(0.15,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play() end end)

---- HELPERS ----
local function addToggle(parent, x, y, label, default)
	local bg=Instance.new("ImageButton",parent); bg.Size=UDim2.fromOffset(44,24); bg.Position=UDim2.fromOffset(x,y); bg.AutoButtonColor=false; bg.BorderSizePixel=0; bg.BackgroundColor3=default and Color3.fromRGB(71,140,246) or Color3.fromRGB(58,58,60); bg.ZIndex=22
	Instance.new("UICorner",bg).CornerRadius=UDim.new(1,0)
	local knob=Instance.new("Frame",bg); knob.Size=UDim2.fromOffset(20,20); knob.Position=default and UDim2.fromOffset(22,2) or UDim2.fromOffset(2,2); knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0; Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
	local lbl=Instance.new("TextLabel",parent); lbl.Size=UDim2.fromOffset(50,24); lbl.Position=UDim2.fromOffset(x+48,y); lbl.BackgroundTransparency=1; lbl.FontFace=Font.new("rbxassetid://12187365364"); lbl.TextSize=13; lbl.TextColor3=Color3.fromRGB(245,245,245); lbl.Text=label; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.TextYAlignment=Enum.TextYAlignment.Center; lbl.ZIndex=22
	local state=default; bg.MouseButton1Click:Connect(function() state=not state; bg.BackgroundColor3=state and Color3.fromRGB(71,140,246) or Color3.fromRGB(58,58,60); TS:Create(knob,TweenInfo.new(0.2),{Position=state and UDim2.fromOffset(22,2) or UDim2.fromOffset(2,2)}):Play() end)
end

local function addSlider(parent, x, y, w, val, max, label)
	local lbl=Instance.new("TextLabel",parent); lbl.Size=UDim2.fromOffset(w or 60,12); lbl.Position=UDim2.fromOffset(x,y+1); lbl.BackgroundTransparency=1; lbl.FontFace=Font.new("rbxassetid://12187365364"); lbl.TextSize=11; lbl.TextColor3=label and Color3.fromRGB(245,245,245) or Color3.fromRGB(180,180,190); lbl.Text=label or tostring(val).."s"; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=22
	if val then
		local track=Instance.new("Frame",parent); track.Size=UDim2.fromOffset(w or 50,3); track.Position=UDim2.fromOffset(x,y+13); track.BackgroundColor3=Color3.fromRGB(44,44,46); track.BorderSizePixel=0; Instance.new("UICorner",track).CornerRadius=UDim.new(1,0); track.ZIndex=22
		local fill=Instance.new("Frame",track); fill.Size=UDim2.fromScale((val or 0)/(max or 100),1); fill.BackgroundColor3=Color3.fromRGB(0,122,255); fill.BorderSizePixel=0; Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0); fill.ZIndex=22
	end
end

local function addPulldown(parent, x, y, label, items)
	local btn=Instance.new("TextButton",parent); btn.Size=UDim2.fromOffset(65,20); btn.Position=UDim2.fromOffset(x,y); btn.BackgroundColor3=Color3.fromRGB(50,50,55); btn.BorderSizePixel=0; btn.Text=label; btn.FontFace=Font.new("rbxassetid://12187365364"); btn.TextSize=11; btn.TextColor3=Color3.fromRGB(220,220,220); btn.AutoButtonColor=false; btn.ZIndex=25; Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5)
end

local function addStepper(parent, x, y, val)
	local bg=Instance.new("Frame",parent); bg.Size=UDim2.fromOffset(70,20); bg.Position=UDim2.fromOffset(x,y); bg.BackgroundColor3=Color3.fromRGB(50,50,55); bg.BorderSizePixel=0; bg.ZIndex=22; Instance.new("UICorner",bg).CornerRadius=UDim.new(0,5)
	local dec=Instance.new("TextButton",bg); dec.Size=UDim2.fromOffset(18,20); dec.Position=UDim2.fromOffset(0,0); dec.BackgroundTransparency=1; dec.BorderSizePixel=0; dec.Text="-"; dec.FontFace=Font.new("rbxassetid://12187365364"); dec.TextSize=14; dec.TextColor3=Color3.fromRGB(200,200,200); dec.AutoButtonColor=false; dec.ZIndex=23
	local vl=Instance.new("TextLabel",bg); vl.Size=UDim2.fromOffset(34,20); vl.Position=UDim2.fromOffset(18,0); vl.BackgroundTransparency=1; vl.FontFace=Font.new("rbxassetid://12187365364"); vl.TextSize=11; vl.TextColor3=Color3.fromRGB(245,245,245); vl.Text=tostring(val); vl.TextXAlignment=Enum.TextXAlignment.Center; vl.ZIndex=23
	local inc=Instance.new("TextButton",bg); inc.Size=UDim2.fromOffset(18,20); inc.Position=UDim2.fromOffset(52,0); inc.BackgroundTransparency=1; inc.BorderSizePixel=0; inc.Text="+"; inc.FontFace=Font.new("rbxassetid://12187365364"); inc.TextSize=14; inc.TextColor3=Color3.fromRGB(200,200,200); inc.AutoButtonColor=false; inc.ZIndex=23
end

local function addButton(parent, x, y, w, text)
	local btn=Instance.new("TextButton",parent); btn.Size=UDim2.fromOffset(w or 50,20); btn.Position=UDim2.fromOffset(x,y); btn.BackgroundColor3=Color3.fromRGB(55,55,60); btn.BorderSizePixel=0; btn.Text=text; btn.FontFace=Font.new("rbxassetid://12187365364"); btn.TextSize=11; btn.TextColor3=Color3.fromRGB(245,245,245); btn.AutoButtonColor=false; btn.ZIndex=22; Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5)
end

local function addTrailing(parent, x, y, text)
	local f=Instance.new("Frame",parent); f.Size=UDim2.fromOffset(80,14); f.Position=UDim2.fromOffset(x,y); f.BackgroundTransparency=1; f.BorderSizePixel=0; f.ZIndex=22
	local lbl=Instance.new("TextLabel",f); lbl.Size=UDim2.fromOffset(65,14); lbl.Position=UDim2.fromOffset(-1,0); lbl.BackgroundTransparency=1; lbl.FontFace=Font.new("rbxassetid://12187365364"); lbl.TextSize=11; lbl.TextColor3=Color3.fromRGB(180,180,190); lbl.Text=text; lbl.TextXAlignment=Enum.TextXAlignment.Right; lbl.TextYAlignment=Enum.TextYAlignment.Center; lbl.ZIndex=22
	local ic=Instance.new("ImageLabel",f); ic.Size=UDim2.fromOffset(12,12); ic.Position=UDim2.fromOffset(68,1); ic.BackgroundTransparency=1; ic.Image="rbxassetid://134900376381669"; ic.ImageColor3=Color3.fromRGB(180,180,190); ic.ImageTransparency=0.3; ic.ZIndex=22
end

local function addTextField(parent, x, y, w, label, ph)
	local lbl=Instance.new("TextLabel",parent); lbl.Size=UDim2.fromOffset(w or 70,20); lbl.Position=UDim2.fromOffset(x,y); lbl.BackgroundTransparency=1; lbl.FontFace=Font.new("rbxassetid://12187365364"); lbl.TextSize=11; lbl.TextColor3=Color3.fromRGB(180,180,190); lbl.Text=label; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.TextYAlignment=Enum.TextYAlignment.Center; lbl.ZIndex=22
end

local function subCard(parent, y, h, title)
	local bg=Instance.new("Frame",parent); bg.Size=UDim2.new(1,0,0,h); bg.BackgroundColor3=Color3.fromRGB(20,20,24); bg.BorderSizePixel=0; bg.ZIndex=15; Instance.new("UICorner",bg).CornerRadius=UDim.new(0,10)
	local st=Instance.new("UIStroke",bg); st.Color=Color3.fromRGB(38,38,46); st.Thickness=1; st.Transparency=0.8
	if title then
		local tl=Instance.new("TextLabel",bg); tl.Size=UDim2.fromOffset(120,14); tl.Position=UDim2.fromOffset(10,3); tl.BackgroundTransparency=1; tl.FontFace=Font.new("rbxassetid://12187365364"); tl.TextSize=11; tl.TextColor3=Color3.fromRGB(160,160,170); tl.Text=title; tl.TextXAlignment=Enum.TextXAlignment.Left; tl.ZIndex=18
	end
	return bg, bg
end

local function label(parent, x, y, text, color)
	local l=Instance.new("TextLabel",parent); l.Size=UDim2.fromOffset(300,14); l.Position=UDim2.fromOffset(x,y); l.BackgroundTransparency=1; l.FontFace=Font.new("rbxassetid://12187365364"); l.TextSize=11; l.TextColor3=color or Color3.fromRGB(180,180,190); l.Text=text; l.TextXAlignment=Enum.TextXAlignment.Left; l.ZIndex=22; return l
end

-- ====================
-- FARM PAGE
-- ====================
local farmPage = tabPages[1]

-- Master SubCard
local m, mc = subCard(farmPage, 0, 48, "Master")
addToggle(mc, 10, 18, "Auto-Farm", false); addTrailing(mc, 160, 20, "● Running")
addToggle(mc, 230, 18, "Expand"); addToggle(mc, 320, 18, "Daily"); addToggle(mc, 410, 18, "Pot")

-- Plant/Harvest SubCard
local ph, phc = subCard(farmPage, 0, 56, "Plant / Harvest / Sell")
addToggle(phc, 10, 18, "Plant", false); addPulldown(phc, 110, 18, "Wheat", {"Wheat","Corn","Carrot"}); addSlider(phc, 185, 18, 50, 4, 10)
addToggle(phc, 10, 38, "Harvest", false); addSlider(phc, 110, 38, 45, 1, 10, "0.01s"); addToggle(phc, 210, 38, "Sell")

-- Boosts SubCard
local bo, boc = subCard(farmPage, 0, 48, "Boosts")
addToggle(boc, 10, 18, "Sprinkler", false); addSlider(boc, 110, 18, 45, 30, 100, "30s")
addToggle(boc, 200, 18, "Water", false); addSlider(boc, 290, 18, 45, 8, 100, "8s")
addToggle(boc, 380, 18, "Smart Inventory")

-- Pets SubCard
local pe, pec = subCard(farmPage, 0, 56, "Pets & Opening")
addToggle(pec, 10, 18, "Equip"); addToggle(pec, 100, 18, "Slots"); addToggle(pec, 190, 18, "Sell"); addPulldown(pec, 280, 18, "All", {"Common","Uncommon","Rare","Epic"})
addToggle(pec, 10, 38, "Eggs", true); addToggle(pec, 100, 38, "Crates", true); addToggle(pec, 190, 38, "Packs", true); addSlider(pec, 280, 38, 45, 4, 10, "4s")

-- ====================
-- SHOP PAGE
-- ====================
local shopPage = tabPages[2]

-- Seed & Gear
local sg, sgc = subCard(shopPage, 0, 56, "Seed & Gear")
addToggle(sgc, 10, 18, "Auto-Buy", false); addPulldown(sgc, 110, 18, "Seeds", {"All","Wheat","Corn"}); addStepper(sgc, 185, 18, 8)
addSlider(sgc, 270, 18, 55, 5, 30, "Interval: 5s")
addToggle(sgc, 10, 38, "Auto-Gear", false); addPulldown(sgc, 110, 38, "Gear", {"Best","Rare","Epic"}); addSlider(sgc, 185, 38, 55, 10, 30, "Interval: 10s")

-- Wild Pets
local wp, wpc = subCard(shopPage, 0, 48, "Wild Pets")
addToggle(wpc, 10, 18, "Buy Wild Pets", false); addSlider(wpc, 130, 18, 60, 50, 100, "Max: 25000¢")
addSlider(wpc, 10, 36, 55, 5, 30, "Interval: 5s"); addToggle(wpc, 200, 36, "Teleport")

-- ====================
-- STEAL PAGE
-- ====================
local stealPage = tabPages[3]

-- Auto Steal
local as, asc = subCard(stealPage, 0, 48, "Auto-Steal")
addToggle(asc, 10, 18, "Auto-Steal", false); addTrailing(asc, 140, 20, "🌙 Night")
addToggle(asc, 230, 18, "Teleport"); addToggle(asc, 320, 18, "Return Base"); addSlider(asc, 410, 18, 50, 5, 100, "0.05s")

label(stealPage, 10, 4, "Smart: FruitValueCalc + StealFlags + lerp teleport", Color3.fromRGB(160,160,170))
label(stealPage, 10, 18, "Night-only. Servers with <7 players ideal.", Color3.fromRGB(140,140,150))

-- ====================
-- SPAWN PAGE
-- ====================
local spawnPage = tabPages[4]

-- Spawners
local sp, spc = subCard(spawnPage, 0, 56, "Spawners")
addPulldown(spc, 10, 18, "Seed", {"Wheat","Corn"}); addStepper(spc, 85, 18, 10); addButton(spc, 165, 18, 50, "Spawn")
addPulldown(spc, 230, 18, "Gear", {"Axe","Sickle"}); addStepper(spc, 305, 18, 5); addButton(spc, 385, 18, 50, "Spawn")
addPulldown(spc, 10, 38, "Pet", {"Dog","Cat"}); addStepper(spc, 85, 38, 1); addButton(spc, 230, 38, 70, "Spawn Pet")

-- Money
local mo, moc = subCard(spawnPage, 0, 48, "Money")
addStepper(moc, 10, 18, 50000); addButton(moc, 90, 18, 45, "Add"); addButton(moc, 145, 18, 60, "Sell All")

-- Pet Scanner
local ps, psc = subCard(spawnPage, 0, 48, "Pet Scanner")
addButton(psc, 10, 18, 80, "Start Scan"); addPulldown(psc, 100, 18, "Legendary", {"Common","Rare","Epic","Legendary"})
label(psc, 200, 19, "🔒 Locked to user", Color3.fromRGB(200,150,50))

-- ====================
-- CONFIG PAGE
-- ====================
local configPage = tabPages[5]

-- Skills & Tools
local sk, skc = subCard(configPage, 0, 48, "Skills & Tools")
addToggle(skc, 10, 18, "Auto-Skill", false); addPulldown(skc, 110, 18, "Farming", {"Farming","Foraging","Fishing"})
addButton(skc, 250, 18, 50, "Remove"); addButton(skc, 310, 18, 40, "List")
addTextField(skc, 185, 18, 60, "Remove plant", "")

-- Guild Comp
local gc, gcc = subCard(configPage, 0, 48, "Guild Competition")
addToggle(gcc, 10, 18, "Guild Comp", false); addTrailing(gcc, 140, 20, "Carrot · Phase 2")

-- Weather
local we, wec = subCard(configPage, 0, 48, "Weather")
label(wec, 10, 18, "Current: 🌙 Goldmoon  Next: 3h 12m", Color3.fromRGB(245,245,245))
addButton(wec, 260, 17, 70, "Predict 24h")

-- ====================
-- SETTINGS PAGE
-- ====================
local settingsPage = tabPages[6]

-- Performance
local pf, pfc = subCard(settingsPage, 0, 48, "Performance")
addToggle(pfc, 10, 18, "FPS Boost", false); addSlider(pfc, 110, 18, 55, 50, 100, "UI Scale"); addButton(pfc, 260, 17, 50, "Unload")

-- Session
local se, sec = subCard(settingsPage, 0, 56, "Session")
addToggle(sec, 10, 18, "Anti-AFK", false); addToggle(sec, 100, 18, "Hop", false); addStepper(sec, 190, 18, 30)
addToggle(sec, 280, 18, "Mailbox"); addToggle(sec, 370, 18, "Gifts")
addTextField(sec, 10, 38, 70, "Code", ""); addButton(sec, 100, 37, 50, "Redeem"); addToggle(sec, 190, 38, "Auto-Codes")

-- Webhook
local wh, whc = subCard(settingsPage, 0, 48, "Webhook")
addToggle(whc, 10, 18, "Webhook", false); addButton(whc, 100, 17, 40, "Test"); addSlider(whc, 160, 18, 65, 5, 30, "Interval: 5min")

---- WINDOW PILL ----
local pgui=Instance.new("ScreenGui"); pgui.Name="UnAliveUI_Pill"; pgui.ResetOnSpawn=false; pgui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; pgui.DisplayOrder=200; pgui.IgnoreGuiInset=true; pgui.Parent=pg
local pill=Instance.new("ImageButton",pgui); pill.Name="WindowPill"; pill.AnchorPoint=Vector2.new(0.5,0); pill.AutoButtonColor=false; pill.BackgroundTransparency=1; pill.BorderSizePixel=0; pill.Image="rbxassetid://93520763686656"; pill.ImageTransparency=0.5; pill.Position=UDim2.new(0.5,0,0,10); pill.Size=UDim2.fromOffset(180,5); pill.ZIndex=999; Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
local mined=false
local function toggleMin() mined=not mined; local tY=mined and win.AbsoluteSize.Y*2 or 0; TS:Create(win,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.5,tY)}):Play(); TS:Create(gs,TweenInfo.new(0.25,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Scale=mined and 0 or 1}):Play() end
local ct; pill.MouseEnter:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.15}); ct:Play() end)
pill.MouseLeave:Connect(function() if ct then ct:Cancel() end; ct=TS:Create(pill,TweenInfo.new(0.4,Enum.EasingStyle.Exponential),{ImageTransparency=0.5}); ct:Play() end)
pill.MouseButton1Click:Connect(toggleMin)
tb:FindFirstChild("Exit").MouseButton1Click:Connect(function() gui:Destroy(); pgui:Destroy() end)
tb:FindFirstChild("Minimize").MouseButton1Click:Connect(toggleMin)

print("=== Gag2 Complete Layout ===")
