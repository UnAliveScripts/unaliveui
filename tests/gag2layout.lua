--[[
	UnAliveUI — Gag2 Layout
	
	Production-ready farm automation interface.
	Uses UnAliveUI components from GitHub.
--]]

local UnAlive = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
))()

local TS = game:GetService("TweenService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

for _, name in pairs({"UnAliveUI", "UnAliveUI_Pill"}) do
	local e = playerGui:FindFirstChild(name)
	if e then e:Destroy() end
end

local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true
gui.DisplayOrder = 999; gui.Parent = playerGui
local guiScale = Instance.new("UIScale"); guiScale.Name = "UIScale"; guiScale.Parent = gui

local WIN_W, WIN_H = 540, 400
local window = Instance.new("Frame")
window.Name = "Window"; window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
window.AnchorPoint = Vector2.new(0.5, 0.5); window.Position = UDim2.fromScale(0.5, 0.5)
window.BackgroundColor3 = Color3.fromRGB(12, 12, 14); window.BorderSizePixel = 0
window.ClipsDescendants = false; window.ZIndex = 2; window.Parent = gui
Instance.new("UICorner", window).CornerRadius = UDim.new(0, 16)
local winStroke = Instance.new("UIStroke", window)
winStroke.Color = Color3.fromRGB(34, 34, 40); winStroke.Thickness = 1
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local shadow = Instance.new("Frame")
shadow.Name = "Shadow"; shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, -3)
shadow.BackgroundColor3 = Color3.fromRGB(0,0,0); shadow.BackgroundTransparency = 0.65
shadow.BorderSizePixel = 0; shadow.ZIndex = 1; shadow.Parent = window
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

local TB_H = 34
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"; titleBar.Size = UDim2.new(1, 0, 0, TB_H)
titleBar.BackgroundColor3 = Color3.fromRGB(16, 16, 19); titleBar.BorderSizePixel = 0
titleBar.ZIndex = 10; titleBar.Parent = window
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)
local tbMask = Instance.new("Frame")
tbMask.Name = "BottomMask"; tbMask.Size = UDim2.new(1, 0, 0, 16)
tbMask.Position = UDim2.new(0, 0, 1, -16)
tbMask.BackgroundColor3 = Color3.fromRGB(16, 16, 19); tbMask.BorderSizePixel = 0
tbMask.ZIndex = 10; tbMask.Parent = titleBar
local tbLine = Instance.new("Frame")
tbLine.Name = "Hairline"; tbLine.Size = UDim2.new(1, 0, 0, 1)
tbLine.Position = UDim2.new(0, 0, 1, -1)
tbLine.BackgroundColor3 = Color3.fromRGB(36, 36, 42); tbLine.BorderSizePixel = 0
tbLine.ZIndex = 11; tbLine.Parent = titleBar
local titleLbl = Instance.new("TextLabel")
titleLbl.Name = "Title"; titleLbl.Size = UDim2.new(0, 200, 0, 14)
titleLbl.AnchorPoint = Vector2.new(0, 0.5); titleLbl.Position = UDim2.new(0, 14, 0.5, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Font = Enum.Font.Gotham
titleLbl.TextSize = 14; titleLbl.TextColor3 = Color3.fromRGB(190, 190, 198)
titleLbl.Text = "Gag2"; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextTruncate = Enum.TextTruncate.AtEnd; titleLbl.ZIndex = 11; titleLbl.Parent = titleBar

local dotData = {{"Exit","FF5F57","rbxassetid://94781753558308"},{"Minimize","FEBC2E","rbxassetid://118368309445367"}}
for i, d in ipairs(dotData) do
	local off = 16 + 6 + (2 - i) * 20
	local btn = Instance.new("ImageButton")
	btn.Name = d[1]; btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.Position = UDim2.new(1, -off, 0.5, 0); btn.Size = UDim2.fromOffset(12, 12)
	btn.AutoButtonColor = false; btn.BackgroundTransparency = 1; btn.BorderSizePixel = 0
	btn.Image = "rbxassetid://132228700346004"; btn.ImageColor3 = Color3.fromHex(d[2]); btn.ZIndex = 15; btn.Parent = titleBar
	local ic = Instance.new("ImageLabel", btn)
	ic.Name = "Icon"; ic.AnchorPoint = Vector2.new(0.5, 0.5); ic.BackgroundTransparency = 1; ic.BorderSizePixel = 0
	ic.Image = d[3]; ic.ImageColor3 = Color3.fromRGB(0, 0, 0); ic.ImageTransparency = 0.50
	ic.Position = UDim2.fromScale(0.5, 0.5); ic.Size = UDim2.fromScale(1, 1); ic.Visible = false
	btn.MouseEnter:Connect(function() ic.Visible = true end)
	btn.MouseLeave:Connect(function() ic.Visible = false end)
end

local card = Instance.new("Frame")
card.Name = "Card"; card.Size = UDim2.new(0, WIN_W - 44, 0, WIN_H - TB_H - 36)
card.Position = UDim2.new(0, 22, 0, TB_H + 18)
card.BackgroundColor3 = Color3.fromRGB(20, 20, 24); card.BorderSizePixel = 0; card.ZIndex = 5; card.Parent = window
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(38, 38, 46); cardStroke.Thickness = 1
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local dragging, dStart, dPos, targetPos, dragConn = false
titleBar.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = true; dStart = i.Position; dPos = window.Position; targetPos = dPos
		TS:Create(guiScale, TweenInfo.new(0.15), {Scale = 0.97}):Play()
		if dragConn then dragConn:Disconnect() end
		dragConn = game:GetService("RunService").Heartbeat:Connect(function()
			if not dragging then dragConn:Disconnect(); dragConn = nil; return end
			window.Position = window.Position:Lerp(targetPos, 0.15)
		end)
	end
end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
	if not dragging then return end
	if i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - dStart
		targetPos = UDim2.new(dPos.X.Scale, dPos.X.Offset + delta.X, dPos.Y.Scale, dPos.Y.Offset + delta.Y)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
		dragging = false
		TS:Create(guiScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end
end)

-- Content area with scrolling
local content = Instance.new("ScrollingFrame")
content.Name = "Content"; content.Size = UDim2.fromScale(1, 1); content.Position = UDim2.fromOffset(0, 0)
content.BackgroundTransparency = 1; content.BorderSizePixel = 0; content.ZIndex = 20
content.ScrollBarThickness = 6; content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
content.CanvasSize = UDim2.fromScale(0, 0); content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = card
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0, 16)
Instance.new("UIPadding", content).PaddingRight = UDim.new(0, 16)
Instance.new("UIPadding", content).PaddingTop = UDim.new(0, 8)

local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 6); layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Helpers
local function addToggle(parent, value)
	local t = UnAlive:New("Toggle", {Value = value or false})
	t:Parent(parent); return t
end

local function addPulldown(parent, label, items)
	local p = UnAlive:New("Pulldown", {Label = label, Items = items})
	p:Parent(parent); return p
end

local function section(text)
	local lbl = Instance.new("TextLabel", content)
	lbl.Size = UDim2.new(1, 0, 0, 18); lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 13
	lbl.TextColor3 = Color3.fromRGB(255, 66, 84); lbl.Text = text
	lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function row()
	local r = Instance.new("Frame", content)
	r.Size = UDim2.new(1, 0, 0, 36); r.BackgroundTransparency = 1; r.BorderSizePixel = 0
	local rl = Instance.new("UIListLayout", r)
	rl.FillDirection = Enum.FillDirection.Horizontal; rl.Padding = UDim.new(0, 10)
	rl.VerticalAlignment = Enum.VerticalAlignment.Center
	return r, rl
end

local function label(text, w)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.fromOffset(w or 60, 26); lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxassetid://12187365364"); lbl.TextSize = 13
	lbl.TextColor3 = Color3.fromRGB(180, 180, 190); lbl.Text = text
	lbl.TextXAlignment = Enum.TextXAlignment.Center; lbl.TextYAlignment = Enum.TextYAlignment.Center
	return lbl
end

-- === BUILD LAYOUT ===

-- Top row
local r, _ = row()
addToggle(r, false); addToggle(r, false); addToggle(r, false)

section("PLANT / HARVEST / SELL")

-- Plant
local r, _ = row()
addToggle(r, false)
addPulldown(r, "Wheat", {"Wheat","Corn","Carrot","Tomato"})
local qLbl = label("×4", 40); qLbl.Parent = r

-- Harvest
local r, _ = row()
addToggle(r, false)
local hLbl = label("0.01s", 50); hLbl.Parent = r
addToggle(r, false)

-- Sell interval
local r, _ = row()
local siLbl = Instance.new("TextLabel")
siLbl.Size = UDim2.fromOffset(100, 26); siLbl.BackgroundTransparency = 1
siLbl.FontFace = Font.new("rbxassetid://12187365364"); siLbl.TextSize = 13
siLbl.TextColor3 = Color3.fromRGB(245, 245, 245); siLbl.Text = "Sell Interval"
siLbl.TextXAlignment = Enum.TextXAlignment.Left; siLbl.TextYAlignment = Enum.TextYAlignment.Center
siLbl.Parent = r
local siVal = label("15s", 40); siVal.Parent = r

section("BOOSTS")

-- Sprinkler
local r, _ = row()
addToggle(r, false)
local spVal = label("30s", 40); spVal.Parent = r

-- Water
local r, _ = row()
addToggle(r, false)
local wVal = label("8s", 40); wVal.Parent = r

-- Smart Inventory
local r, _ = row()
addToggle(r, false)
local siLbl2 = Instance.new("TextLabel")
siLbl2.Size = UDim2.fromOffset(120, 26); siLbl2.BackgroundTransparency = 1
siLbl2.FontFace = Font.new("rbxassetid://12187365364"); siLbl2.TextSize = 13
siLbl2.TextColor3 = Color3.fromRGB(245, 245, 245); siLbl2.Text = "Smart Inventory"
siLbl2.TextXAlignment = Enum.TextXAlignment.Left; siLbl2.TextYAlignment = Enum.TextYAlignment.Center
siLbl2.Parent = r

section("PETS & OPEN")

-- Equip + Slots
local r, _ = row()
addToggle(r, false); addToggle(r, false)

-- Sell Pets
local r, _ = row()
addToggle(r, false)
addPulldown(r, "Select...", {"Common","Uncommon","Rare","Epic","Legendary"})

-- Eggs + Crates + Packs
local r, _ = row()
addToggle(r, true); addToggle(r, true); addToggle(r, true)

-- Minimize
local mined = false
local function toggleMinimize()
	mined = not mined
	local tY = mined and window.AbsoluteSize.Y * 2 or 0
	TS:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, tY)}):Play()
	TS:Create(guiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Scale = mined and 0 or 1}):Play()
end

local pillGui = Instance.new("ScreenGui")
pillGui.Name = "UnAliveUI_Pill"; pillGui.ResetOnSpawn = false
pillGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; pillGui.DisplayOrder = 200
pillGui.IgnoreGuiInset = true; pillGui.Parent = playerGui

local pill = Instance.new("ImageButton")
pill.Name = "WindowPill"; pill.AnchorPoint = Vector2.new(0.5, 0)
pill.AutoButtonColor = false; pill.BackgroundTransparency = 1; pill.BorderSizePixel = 0
pill.Image = "rbxassetid://93520763686656"; pill.ImageTransparency = 0.5
pill.Position = UDim2.new(0.5, 0, 0, 10); pill.Size = UDim2.fromOffset(180, 5)
pill.ZIndex = 999; pill.Parent = pillGui
Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

local ct
pill.MouseEnter:Connect(function()
	if ct then ct:Cancel() end
	ct = TS:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.15}); ct:Play()
end)
pill.MouseLeave:Connect(function()
	if ct then ct:Cancel() end
	ct = TS:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.5}); ct:Play()
end)
pill.MouseButton1Click:Connect(toggleMinimize)

titleBar:FindFirstChild("Exit").MouseButton1Click:Connect(function() gui:Destroy(); pillGui:Destroy() end)
titleBar:FindFirstChild("Minimize").MouseButton1Click:Connect(toggleMinimize)

print("[Gag2] Production layout loaded")
