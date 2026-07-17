--[[
	UnAliveUI — Gag2 Layout
	
	Production-ready farm automation interface.
	Uses UnAliveUI components from GitHub.
	
	Usage:
		local UnAlive = loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
		))()
		local gag2 = UnAlive:New("Gag2")
--]]

local UnAlive = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
))()

-- Services
local TS = game:GetService("TweenService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Cleanup
for _, name in pairs({"UnAliveUI", "UnAliveUI_Pill"}) do
	local e = playerGui:FindFirstChild(name)
	if e then e:Destroy() end
end

-- Config
local COLORS = {
	bg = Color3.fromRGB(12, 12, 14),
	border = Color3.fromRGB(34, 34, 40),
	card = Color3.fromRGB(20, 20, 24),
	cardBorder = Color3.fromRGB(38, 38, 46),
	title = Color3.fromRGB(255, 66, 84),
	text = Color3.fromRGB(245, 245, 245),
	muted = Color3.fromRGB(180, 180, 190),
	accent = Color3.fromRGB(0, 122, 255),
}

-- Main gui
local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true
gui.DisplayOrder = 999; gui.Parent = playerGui

local guiScale = Instance.new("UIScale"); guiScale.Name = "UIScale"; guiScale.Parent = gui

-- Window
local WIN_W, WIN_H = 540, 400
local window = Instance.new("Frame")
window.Name = "Window"; window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
window.AnchorPoint = Vector2.new(0.5, 0.5); window.Position = UDim2.fromScale(0.5, 0.5)
window.BackgroundColor3 = COLORS.bg; window.BorderSizePixel = 0
window.ClipsDescendants = false; window.ZIndex = 2; window.Parent = gui
Instance.new("UICorner", window).CornerRadius = UDim.new(0, 16)
local winStroke = Instance.new("UIStroke", window)
winStroke.Color = COLORS.border; winStroke.Thickness = 1
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Shadow
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"; shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, -3)
shadow.BackgroundColor3 = Color3.fromRGB(0,0,0); shadow.BackgroundTransparency = 0.65
shadow.BorderSizePixel = 0; shadow.ZIndex = 1; shadow.Parent = window
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

-- Title bar
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

-- Traffic lights (Myriad-style)
local dots = {{"Exit","FF5F57","rbxassetid://94781753558308"},{"Minimize","FEBC2E","rbxassetid://118368309445367"}}
for i, d in ipairs(dots) do
	local off = 16 + 6 + (2 - i) * 20
	local btn = Instance.new("ImageButton")
	btn.Name = d[1]; btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.Position = UDim2.new(1, -off, 0.5, 0); btn.Size = UDim2.fromOffset(12, 12)
	btn.AutoButtonColor = false; btn.BackgroundTransparency = 1; btn.BorderSizePixel = 0
	btn.Image = "rbxassetid://132228700346004"; btn.ImageColor3 = Color3.fromHex(d[2])
	btn.ImageTransparency = 0; btn.ZIndex = 15; btn.Parent = titleBar
	local ic = Instance.new("ImageLabel", btn)
	ic.Name = "Icon"; ic.AnchorPoint = Vector2.new(0.5, 0.5)
	ic.BackgroundTransparency = 1; ic.BorderSizePixel = 0; ic.Image = d[3]
	ic.ImageColor3 = Color3.fromRGB(0, 0, 0); ic.ImageTransparency = 0.50
	ic.Position = UDim2.fromScale(0.5, 0.5); ic.Size = UDim2.fromScale(1, 1)
	ic.Visible = false
	btn.MouseEnter:Connect(function() ic.Visible = true end)
	btn.MouseLeave:Connect(function() ic.Visible = false end)
end

-- Card
local CARD_X, CARD_Y = 22, TB_H + 18
local CARD_W, CARD_H = WIN_W - 44, WIN_H - TB_H - 36
local card = Instance.new("Frame")
card.Name = "Card"; card.Size = UDim2.new(0, CARD_W, 0, CARD_H)
card.Position = UDim2.new(0, CARD_X, 0, CARD_Y)
card.BackgroundColor3 = COLORS.card; card.BorderSizePixel = 0; card.ZIndex = 5; card.Parent = window
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = COLORS.cardBorder; cardStroke.Thickness = 1
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local cardShadow = Instance.new("ImageLabel")
cardShadow.Name = "Shadow"; cardShadow.Size = UDim2.new(1, 30, 1, 30)
cardShadow.Position = UDim2.new(0, -15, 0, -15)
cardShadow.BackgroundTransparency = 1; cardShadow.BorderSizePixel = 0
cardShadow.Image = "rbxassetid://6015897843"; cardShadow.ImageColor3 = Color3.fromRGB(0,0,0)
cardShadow.ImageTransparency = 0.7; cardShadow.ScaleType = Enum.ScaleType.Slice
cardShadow.SliceCenter = Rect.new(49,49,50,50); cardShadow.ZIndex = 4; cardShadow.Parent = card

-- Drag system
local dragging, dStart, dPos, targetPos, dragConn = false
local function startDrag(input)
	dragging = true; dStart = input.Position; dPos = window.Position; targetPos = dPos
	TS:Create(guiScale, TweenInfo.new(0.15), {Scale = 0.97}):Play()
	if dragConn then dragConn:Disconnect() end
	dragConn = game:GetService("RunService").Heartbeat:Connect(function()
		if not dragging then dragConn:Disconnect(); dragConn = nil; return end
		window.Position = window.Position:Lerp(targetPos, 0.15)
	end)
end
local function onInput(i, gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then startDrag(i) end
end
titleBar.InputBegan:Connect(onInput)
card.InputBegan:Connect(onInput)
game:GetService("UserInputService").InputChanged:Connect(function(i)
	if not dragging then return end
	if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
		local delta = i.Position - dStart
		targetPos = UDim2.new(dPos.X.Scale, dPos.X.Offset + delta.X, dPos.Y.Scale, dPos.Y.Offset + delta.Y)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		if dragging then dragging = false
			TS:Create(guiScale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play() end
	end
end)

-- Content area
local content = Instance.new("ScrollingFrame")
content.Name = "Content"; content.Size = UDim2.fromScale(1, 1)
content.Position = UDim2.fromOffset(0, 0)
content.BackgroundTransparency = 1; content.BorderSizePixel = 0; content.ZIndex = 20
content.ScrollBarThickness = 6; content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
content.CanvasSize = UDim2.fromScale(0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y; content.Parent = card
Instance.new("UIPadding", content).PaddingLeft = UDim.new(0, 16)
Instance.new("UIPadding", content).PaddingRight = UDim.new(0, 16)
Instance.new("UIPadding", content).PaddingTop = UDim.new(0, 8)

-- Helper: section header
local function section(text)
	local lbl = Instance.new("TextLabel", content)
	lbl.Size = UDim2.new(1, 0, 0, 18); lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 13
	lbl.TextColor3 = COLORS.title; lbl.Text = text; lbl.TextXAlignment = Enum.TextXAlignment.Left
	return Instance.new("UIListLayout", content).Padding -- returns layout for spacing
end

-- Build layout using library components
local layout = Instance.new("UIListLayout", content)
layout.Padding = UDim.new(0, 6); layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Left

-- Top row: toggles
local topRow = Instance.new("Frame", content)
topRow.Size = UDim2.new(1, 0, 0, 30); topRow.BackgroundTransparency = 1; topRow.BorderSizePixel = 0
local topLayout = Instance.new("UIListLayout", topRow)
topLayout.FillDirection = Enum.FillDirection.Horizontal; topLayout.Padding = UDim.new(0, 12)
topLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Helper to add toggle to a parent
local function addToggle(parent, value)
	local t = UnAlive:New("Toggle", {Value = value or false})
	t:Parent(parent)
	return t
end

-- Helper to add pulldown
local function addPulldown(parent, label, items)
	local p = UnAlive:New("Pulldown", {Label = label, Items = items})
	p:Parent(parent)
	return p
end

-- Top toggles
addToggle(topRow, false) -- Expand
addToggle(topRow, false) -- Daily
addToggle(topRow, false) -- Pot

-- Section: PLANT / HARVEST / SELL
section("PLANT / HARVEST / SELL")

-- Row 1: Plant + seed pulldown + quantity slider
local row1 = Instance.new("Frame", content)
row1.Size = UDim2.new(1, 0, 0, 36); row1.BackgroundTransparency = 1; row1.BorderSizePixel = 0
local r1l = Instance.new("UIListLayout", row1)
r1l.FillDirection = Enum.FillDirection.Horizontal; r1l.Padding = UDim.new(0, 10)
r1l.VerticalAlignment = Enum.VerticalAlignment.Center

local plantTog = addToggle(row1, false)
addPulldown(row1, "Wheat", {"Wheat","Corn","Carrot","Tomato"})

-- Quantity label + simple counter
local qtyFrame = Instance.new("Frame", row1)
qtyFrame.Size = UDim2.fromOffset(60, 26); qtyFrame.BackgroundTransparency = 1
qtyFrame.BorderSizePixel = 0
local qtyLbl = Instance.new("TextLabel", qtyFrame)
qtyLbl.Size = UDim2.fromScale(1, 1); qtyLbl.BackgroundTransparency = 1
qtyLbl.FontFace = Font.new("rbxassetid://12187365364"); qtyLbl.TextSize = 14
qtyLbl.TextColor3 = COLORS.text; qtyLbl.Text = "×4"
qtyLbl.TextXAlignment = Enum.TextXAlignment.Center

-- Row 2: Harvest + interval slider + Sell toggle
local row2 = Instance.new("Frame", content)
row2.Size = UDim2.new(1, 0, 0, 36); row2.BackgroundTransparency = 1; row2.BorderSizePixel = 0
local r2l = Instance.new("UIListLayout", row2)
r2l.FillDirection = Enum.FillDirection.Horizontal; r2l.Padding = UDim.new(0, 10)
r2l.VerticalAlignment = Enum.VerticalAlignment.Center

local harvTog = addToggle(row2, false)
-- Harvest interval label
local hInterval = Instance.new("TextLabel", row2)
hInterval.Size = UDim2.fromOffset(60, 26); hInterval.BackgroundTransparency = 1
hInterval.FontFace = Font.new("rbxassetid://12187365364"); hInterval.TextSize = 13
hInterval.TextColor3 = COLORS.muted; hInterval.Text = "0.01s"
hInterval.TextXAlignment = Enum.TextXAlignment.Center
addToggle(row2, false) -- Sell

-- Sell interval row
local sellRow = Instance.new("Frame", content)
sellRow.Size = UDim2.new(1, 0, 0, 30); sellRow.BackgroundTransparency = 1; sellRow.BorderSizePixel = 0
local sellLbl = Instance.new("TextLabel", sellRow)
sellLbl.Size = UDim2.fromOffset(100, 26); sellLbl.BackgroundTransparency = 1
sellLbl.FontFace = Font.new("rbxassetid://12187365364"); sellLbl.TextSize = 13
sellLbl.TextColor3 = COLORS.text; sellLbl.Text = "Sell Interval"
sellLbl.TextXAlignment = Enum.TextXAlignment.Left; sellLbl.TextYAlignment = Enum.TextYAlignment.Center
local sInterval = Instance.new("TextLabel", sellRow)
sInterval.Size = UDim2.fromOffset(50, 26); sInterval.Position = UDim2.fromOffset(110, 0)
sInterval.BackgroundTransparency = 1; sInterval.FontFace = Font.new("rbxassetid://12187365364")
sInterval.TextSize = 13; sInterval.TextColor3 = COLORS.muted; sInterval.Text = "15s"
sInterval.TextXAlignment = Enum.TextXAlignment.Left; sInterval.TextYAlignment = Enum.TextYAlignment.Center

-- Section: BOOSTS
section("BOOSTS")

-- Boost rows
local function boostRow(text, interval)
	local row = Instance.new("Frame", content)
	row.Size = UDim2.new(1, 0, 0, 36); row.BackgroundTransparency = 1; row.BorderSizePixel = 0
	local rl = Instance.new("UIListLayout", row)
	rl.FillDirection = Enum.FillDirection.Horizontal; rl.Padding = UDim.new(0, 10)
	rl.VerticalAlignment = Enum.VerticalAlignment.Center
	addToggle(row, false)
	local lbl = Instance.new("TextLabel", row)
	lbl.Size = UDim2.fromOffset(60, 26); lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxassetid://12187365364"); lbl.TextSize = 13
	lbl.TextColor3 = COLORS.muted; lbl.Text = interval
	lbl.TextXAlignment = Enum.TextXAlignment.Center
end

boostRow("Sprinkler", "30s")
boostRow("Water", "8s")

-- Smart Inventory
local smartRow = Instance.new("Frame", content)
smartRow.Size = UDim2.new(1, 0, 0, 30); smartRow.BackgroundTransparency = 1; smartRow.BorderSizePixel = 0
addToggle(smartRow, false)
local smartLbl = Instance.new("TextLabel", smartRow)
smartLbl.Size = UDim2.fromOffset(120, 26); smartLbl.Position = UDim2.fromOffset(54, 0)
smartLbl.BackgroundTransparency = 1; smartLbl.FontFace = Font.new("rbxassetid://12187365364")
smartLbl.TextSize = 13; smartLbl.TextColor3 = COLORS.text; smartLbl.Text = "Smart Inventory"
smartLbl.TextXAlignment = Enum.TextXAlignment.Left; smartLbl.TextYAlignment = Enum.TextYAlignment.Center

-- Section: PETS & OPEN
section("PETS & OPEN")

-- Equip + Slots
local equipRow = Instance.new("Frame", content)
equipRow.Size = UDim2.new(1, 0, 0, 30); equipRow.BackgroundTransparency = 1; equipRow.BorderSizePixel = 0
local eLayout = Instance.new("UIListLayout", equipRow)
eLayout.FillDirection = Enum.FillDirection.Horizontal; eLayout.Padding = UDim.new(0, 10)
eLayout.VerticalAlignment = Enum.VerticalAlignment.Center
addToggle(equipRow, false) -- Equip
addToggle(equipRow, false) -- Slots

-- Sell Pets + multi pulldown
local sellPetsRow = Instance.new("Frame", content)
sellPetsRow.Size = UDim2.new(1, 0, 0, 36); sellPetsRow.BackgroundTransparency = 1; sellPetsRow.BorderSizePixel = 0
local spLayout = Instance.new("UIListLayout", sellPetsRow)
spLayout.FillDirection = Enum.FillDirection.Horizontal; spLayout.Padding = UDim.new(0, 10)
spLayout.VerticalAlignment = Enum.VerticalAlignment.Center
addToggle(sellPetsRow, false) -- Sell Pets
addPulldown(sellPetsRow, "Select...", {"Common","Uncommon","Rare","Epic","Legendary"})

-- Eggs + Crates + Packs
local itemsRow = Instance.new("Frame", content)
itemsRow.Size = UDim2.new(1, 0, 0, 30); itemsRow.BackgroundTransparency = 1; itemsRow.BorderSizePixel = 0
local iLayout = Instance.new("UIListLayout", itemsRow)
iLayout.FillDirection = Enum.FillDirection.Horizontal; iLayout.Padding = UDim.new(0, 10)
iLayout.VerticalAlignment = Enum.VerticalAlignment.Center
addToggle(itemsRow, true) -- Eggs
addToggle(itemsRow, true) -- Crates
addToggle(itemsRow, true) -- Packs

-- Minimize system (Myriad exact)
local mined = false
local function toggleMinimize()
	mined = not mined
	local tY = mined and window.AbsoluteSize.Y * 2 or 0
	TS:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, tY)}):Play()
	TS:Create(guiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Scale = mined and 0 or 1}):Play()
end

-- WindowPill
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

-- Wire exit/minimize
titleBar:FindFirstChild("Exit").MouseButton1Click:Connect(function() gui:Destroy(); pillGui:Destroy() end)
titleBar:FindFirstChild("Minimize").MouseButton1Click:Connect(toggleMinimize)

print("[Gag2] Production layout loaded")
