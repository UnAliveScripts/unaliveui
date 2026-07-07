--[[
	UnAliveUI — Main Window UI
	
	Loads the main application window with title bar and content card.
	
	Usage:
		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"
		))()
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Clean up existing
local existing = playerGui:FindFirstChild("UnAliveUI")
if existing then existing:Destroy() end

-- Config
local WIDTH = 540
local HEIGHT = 400
local CORNER = 16
local TB_HEIGHT = 34
local CARD_MARGIN = 22
local CARD_W = WIDTH - CARD_MARGIN * 2
local CARD_H = HEIGHT - TB_HEIGHT - CARD_MARGIN * 2
local CARD_X = CARD_MARGIN
local CARD_Y = TB_HEIGHT + CARD_MARGIN

local colors = {
	bg = Color3.fromRGB(12, 12, 14),
	border = Color3.fromRGB(34, 34, 40),
	titleBg = Color3.fromRGB(16, 16, 19),
	titleLine = Color3.fromRGB(36, 36, 42),
	titleText = Color3.fromRGB(190, 190, 198),
	cardBg = Color3.fromRGB(20, 20, 24),
	cardBorder = Color3.fromRGB(38, 38, 46),
	closeDot = Color3.fromRGB(255, 95, 87),
	minDot = Color3.fromRGB(255, 189, 46),
	dotStroke = Color3.fromRGB(0, 0, 0),
}

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- Window
local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.fromOffset(WIDTH, HEIGHT)
window.Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2)
window.BackgroundColor3 = colors.bg
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.ZIndex = 2
window.Parent = gui

Instance.new("UICorner", window).CornerRadius = UDim.new(0, CORNER)

local winStroke = Instance.new("UIStroke", window)
winStroke.Color = colors.border
winStroke.Thickness = 1
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uiScale = Instance.new("UIScale")
uiScale.Parent = window

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.65
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 50, 50)
shadow.ZIndex = 1
shadow.Parent = window

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, TB_HEIGHT)
titleBar.BackgroundColor3 = colors.titleBg
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 10
titleBar.Parent = window

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, CORNER)

local tbMask = Instance.new("Frame")
tbMask.Name = "BottomMask"
tbMask.Size = UDim2.new(1, 0, 0, CORNER)
tbMask.Position = UDim2.new(0, 0, 1, -CORNER)
tbMask.BackgroundColor3 = colors.titleBg
tbMask.BorderSizePixel = 0
tbMask.ZIndex = 10
tbMask.Parent = titleBar

local tbLine = Instance.new("Frame")
tbLine.Name = "Hairline"
tbLine.Size = UDim2.new(1, 0, 0, 1)
tbLine.Position = UDim2.new(0, 0, 1, -1)
tbLine.BackgroundColor3 = colors.titleLine
tbLine.BorderSizePixel = 0
tbLine.ZIndex = 11
tbLine.Parent = titleBar

local titleLbl = Instance.new("TextLabel")
titleLbl.Name = "Title"
titleLbl.Size = UDim2.new(0, 200, 0, 14)
titleLbl.AnchorPoint = Vector2.new(0, 0.5)
titleLbl.Position = UDim2.new(0, 14, 0.5, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "UnAlive"
titleLbl.Font = Enum.Font.Gotham
titleLbl.TextSize = 14
titleLbl.TextColor3 = colors.titleText
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextYAlignment = Enum.TextYAlignment.Center
titleLbl.TextTruncate = Enum.TextTruncate.AtEnd
titleLbl.ZIndex = 11
titleLbl.Parent = titleBar

-- Close Dot
local function makeDot(color, rightOffset, onClick)
	local dot = Instance.new("TextButton")
	dot.Size = UDim2.fromOffset(10, 10)
	dot.AnchorPoint = Vector2.new(0.5, 0.5)
	dot.Position = UDim2.new(1, -rightOffset, 0.5, 0)
	dot.BackgroundColor3 = color
	dot.BorderSizePixel = 0
	dot.Text = ""
	dot.AutoButtonColor = false
	dot.ZIndex = 15
	dot.Parent = titleBar

	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	local ds = Instance.new("UIStroke", dot)
	ds.Color = colors.dotStroke
	ds.Thickness = 0.5
	ds.Transparency = 0.6

	local base = color
	dot.MouseEnter:Connect(function()
		TweenService:Create(dot, TweenInfo.new(0.12), {
			BackgroundColor3 = base:Lerp(Color3.new(1, 1, 1), 0.22),
		}):Play()
	end)
	dot.MouseLeave:Connect(function()
		TweenService:Create(dot, TweenInfo.new(0.12), {
			BackgroundColor3 = base,
		}):Play()
	end)
	dot.MouseButton1Click:Connect(onClick)

	return dot
end

makeDot(colors.closeDot, 21, function() gui:Destroy() end)
makeDot(colors.minDot, 21 + 10 + 8, function()
	-- Minimize: shrink to title bar
	local minimized = window:GetAttribute("Minimized")
	if minimized then
		TweenService:Create(window, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(WIDTH, HEIGHT),
			Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2),
		}):Play()
		window:SetAttribute("Minimized", false)
	else
		TweenService:Create(window, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
			Size = UDim2.fromOffset(WIDTH, TB_HEIGHT),
			Position = UDim2.new(0.5, -WIDTH / 2, 0, 0),
		}):Play()
		window:SetAttribute("Minimized", true)
	end
end)

-- Card (content area)
local card = Instance.new("Frame")
card.Name = "Card"
card.Size = UDim2.fromOffset(CARD_W, CARD_H)
card.Position = UDim2.fromOffset(CARD_X, CARD_Y)
card.BackgroundColor3 = colors.cardBg
card.BorderSizePixel = 0
card.ZIndex = 5
card.Parent = window

Instance.new("UICorner", card).CornerRadius = UDim.new(0, CORNER)

local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = colors.cardBorder
cardStroke.Thickness = 1
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local cardShadow = Instance.new("ImageLabel")
cardShadow.Name = "Shadow"
cardShadow.Size = UDim2.new(1, 30, 1, 30)
cardShadow.Position = UDim2.new(0, -15, 0, -15)
cardShadow.BackgroundTransparency = 1
cardShadow.Image = "rbxassetid://6015897843"
cardShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
cardShadow.ImageTransparency = 0.7
cardShadow.ScaleType = Enum.ScaleType.Slice
cardShadow.SliceCenter = Rect.new(49, 49, 50, 50)
cardShadow.ZIndex = 4
cardShadow.Parent = card

-- Drag System
local drag, dSt, dPos = false, nil, nil
local targetPos = window.Position

local function startDrag(input)
	drag = true
	dSt = input.Position
	dPos = window.Position
	targetPos = dPos
end

titleBar.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		startDrag(i)
	end
end)

card.InputBegan:Connect(function(i, gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		startDrag(i)
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if not drag then return end
	if i.UserInputType == Enum.UserInputType.MouseMovement
		or i.UserInputType == Enum.UserInputType.Touch then
		local delta = i.Position - dSt
		targetPos = UDim2.new(
			dPos.X.Scale, dPos.X.Offset + delta.X,
			dPos.Y.Scale, dPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		drag = false
	end
end)

-- Smooth drag
RunService.Heartbeat:Connect(function()
	if drag then
		window.Position = window.Position:Lerp(targetPos, 0.15)
	end
end)

-- Intro Animation
window.Size = UDim2.fromOffset(0, 0)
window.Position = UDim2.new(0.5, 0, 0.5, 0)
window.BackgroundTransparency = 1
winStroke.Transparency = 1
shadow.ImageTransparency = 1

TweenService:Create(window, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.fromOffset(WIDTH, HEIGHT),
	Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2),
	BackgroundTransparency = 0,
}):Play()

TweenService:Create(winStroke, TweenInfo.new(0.5), { Transparency = 0 }):Play()
TweenService:Create(shadow, TweenInfo.new(0.6), { ImageTransparency = 0.65 }):Play()

card.Position = UDim2.fromOffset(CARD_X, CARD_Y + 25)
card.BackgroundTransparency = 1
cardStroke.Transparency = 1
cardShadow.ImageTransparency = 1

task.delay(0.1, function()
	TweenService:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromOffset(CARD_X, CARD_Y),
		BackgroundTransparency = 0,
	}):Play()

	TweenService:Create(cardStroke, TweenInfo.new(0.45), { Transparency = 0 }):Play()
	TweenService:Create(cardShadow, TweenInfo.new(0.5), { ImageTransparency = 0.7 }):Play()
end)

-- ═══════════════════════════════════════════════════════════════════
-- COMPONENT SETUP
-- ═══════════════════════════════════════════════════════════════════

-- Icons map
local icons = {
	minus = "rbxassetid://110147285593118",
	plus = "rbxassetid://126761302820331",
	chevronUp = "rbxassetid://137296891812002",
	chevronDown = "rbxassetid://84215348315149",
	info = "rbxassetid://134900376381669",
}

-- Helper: create component label
local function sectionLabel(text, y)
	local lbl = Instance.new("TextLabel", card)
	lbl.Size = UDim2.fromOffset(120, 16)
	lbl.Position = UDim2.fromOffset(16, y)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamSemibold
	lbl.Text = text; lbl.TextSize = 13
	lbl.TextColor3 = Color3.fromRGB(180, 180, 190)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	return lbl
end

local y = 20

-- Section: Stepper
sectionLabel("Stepper", y)
local st = Instance.new("Frame", card)
st.Name = "Stepper"
st.Size = UDim2.fromOffset(100, 24); st.Position = UDim2.fromOffset(16, y + 22)
st.BackgroundColor3 = Color3.fromRGB(18, 20, 26); st.BackgroundTransparency = 0.08
st.BorderSizePixel = 0; st.ClipsDescendants = true; st.ZIndex = 6
Instance.new("UICorner", st).CornerRadius = UDim.new(0, 6)
local stStroke = Instance.new("UIStroke", st)
stStroke.Color = Color3.fromRGB(255, 255, 255); stStroke.Transparency = 0.85; stStroke.Thickness = 0.5
local stVal = 5000
local stLbl = Instance.new("TextLabel", st)
stLbl.Size = UDim2.fromOffset(56, 16); stLbl.Position = UDim2.fromOffset(12, 4)
stLbl.BackgroundTransparency = 1; stLbl.Font = Enum.Font.SourceSansSemibold
stLbl.Text = tostring(stVal); stLbl.TextSize = 13; stLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
stLbl.TextXAlignment = Enum.TextXAlignment.Left; stLbl.ZIndex = 2
local stUp = Instance.new("ImageButton", st)
stUp.Size = UDim2.fromOffset(20, 12); stUp.Position = UDim2.fromOffset(80, 0)
stUp.BackgroundTransparency = 1; stUp.BorderSizePixel = 0; stUp.ZIndex = 3
local stUpI = Instance.new("ImageLabel", stUp)
stUpI.Size = UDim2.fromOffset(14, 14); stUpI.Position = UDim2.fromOffset(3, -1)
stUpI.BackgroundTransparency = 1; stUpI.Image = icons.chevronUp
stUpI.ImageColor3 = Color3.fromRGB(255, 255, 255); stUpI.ImageTransparency = 0.2
stUp.MouseButton1Click:Connect(function() stVal = stVal + 500; stLbl.Text = tostring(stVal) end)
local stDown = Instance.new("ImageButton", st)
stDown.Size = UDim2.fromOffset(20, 12); stDown.Position = UDim2.fromOffset(80, 12)
stDown.BackgroundTransparency = 1; stDown.BorderSizePixel = 0; stDown.ZIndex = 3
local stDownI = Instance.new("ImageLabel", stDown)
stDownI.Size = UDim2.fromOffset(14, 14); stDownI.Position = UDim2.fromOffset(3, -1)
stDownI.BackgroundTransparency = 1; stDownI.Image = icons.chevronDown
stDownI.ImageColor3 = Color3.fromRGB(255, 255, 255); stDownI.ImageTransparency = 0.2
stDown.MouseButton1Click:Connect(function() stVal = stVal - 500; stLbl.Text = tostring(stVal) end)

-- Section: Stepper Pill
local y2 = y + 22 + 24 + 16
sectionLabel("Stepper Pill", y2)
local sp = Instance.new("Frame", card)
sp.Name = "StepperPill"
sp.Size = UDim2.fromOffset(92, 32); sp.Position = UDim2.fromOffset(16, y2 + 22)
sp.BackgroundColor3 = Color3.fromRGB(18, 20, 26); sp.BackgroundTransparency = 0.08
sp.ClipsDescendants = true; sp.BorderSizePixel = 0; sp.ZIndex = 6
Instance.new("UICorner", sp).CornerRadius = UDim.new(0, 16)
local spStroke = Instance.new("UIStroke", sp)
spStroke.Color = Color3.fromRGB(255, 255, 255); spStroke.Transparency = 0.92; spStroke.Thickness = 0.5
local spDec = Instance.new("ImageButton", sp)
spDec.Size = UDim2.fromOffset(46, 32); spDec.Position = UDim2.fromOffset(0, 0)
spDec.BackgroundTransparency = 1; spDec.BorderSizePixel = 0; spDec.ZIndex = 2
local spMinus = Instance.new("ImageLabel", spDec)
spMinus.Size = UDim2.fromOffset(22, 22); spMinus.Position = UDim2.fromOffset(12, 5)
spMinus.BackgroundTransparency = 1; spMinus.Image = icons.minus
spMinus.ImageColor3 = Color3.fromRGB(255, 255, 255)
local spInc = Instance.new("ImageButton", sp)
spInc.Size = UDim2.fromOffset(46, 32); spInc.Position = UDim2.fromOffset(46, 0)
spInc.BackgroundTransparency = 1; spInc.BorderSizePixel = 0; spInc.ZIndex = 2
local spPlus = Instance.new("ImageLabel", spInc)
spPlus.Size = UDim2.fromOffset(22, 22); spPlus.Position = UDim2.fromOffset(12, 5)
spPlus.BackgroundTransparency = 1; spPlus.Image = icons.plus
spPlus.ImageColor3 = Color3.fromRGB(255, 255, 255)
local spSep = Instance.new("Frame", sp)
spSep.Size = UDim2.fromOffset(1, 24); spSep.Position = UDim2.fromOffset(45.5, 4)
spSep.BackgroundColor3 = Color3.fromRGB(235, 235, 245); spSep.BackgroundTransparency = 0.7
spSep.BorderSizePixel = 0
Instance.new("UICorner", spSep).CornerRadius = UDim.new(0, 8)
local spV = 0
spDec.MouseButton1Click:Connect(function() spV = spV - 1 end)
spInc.MouseButton1Click:Connect(function() spV = spV + 1 end)

-- Section: Pulldown
local y3 = y2 + 22 + 32 + 16
sectionLabel("Pulldown", y3)
local pd = Instance.new("Frame", card)
pd.Name = "Pulldown"
pd.Size = UDim2.fromOffset(100, 24); pd.Position = UDim2.fromOffset(16, y3 + 22)
pd.BackgroundColor3 = Color3.fromRGB(30, 32, 38); pd.BorderSizePixel = 0
pd.ZIndex = 6
Instance.new("UICorner", pd).CornerRadius = UDim.new(0, 6)
local pdStroke = Instance.new("UIStroke", pd)
pdStroke.Color = Color3.fromRGB(255, 255, 255); pdStroke.Transparency = 0.85; pdStroke.Thickness = 0.5
local pdLbl = Instance.new("TextLabel", pd)
pdLbl.Size = UDim2.fromOffset(56, 24); pdLbl.Position = UDim2.fromOffset(12, 0)
pdLbl.BackgroundTransparency = 1; pdLbl.Font = Enum.Font.SourceSans
pdLbl.Text = "Pets"; pdLbl.TextSize = 13; pdLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
pdLbl.TextXAlignment = Enum.TextXAlignment.Left; pdLbl.TextYAlignment = Enum.TextYAlignment.Center

-- Trailing Accessories
local y4 = y3 + 22 + 24 + 16
sectionLabel("Trailing", y4)
local ta = Instance.new("Frame", card)
ta.Name = "TrailingAccessories"
ta.Size = UDim2.fromOffset(60, 16); ta.Position = UDim2.fromOffset(16, y4 + 22)
ta.BackgroundTransparency = 1; ta.ZIndex = 6
local taLbl = Instance.new("TextLabel", ta)
taLbl.Size = UDim2.fromOffset(40, 16); taLbl.Position = UDim2.fromOffset(-1, 0)
taLbl.BackgroundTransparency = 1; taLbl.Font = Enum.Font.SourceSans
taLbl.Text = "Label"; taLbl.TextSize = 15
taLbl.TextColor3 = Color3.fromRGB(246, 246, 246); taLbl.TextTransparency = 0.16
taLbl.TextXAlignment = Enum.TextXAlignment.Right; taLbl.TextYAlignment = Enum.TextYAlignment.Center
local taIcon = Instance.new("ImageLabel", ta)
taIcon.Size = UDim2.fromOffset(16, 16); taIcon.Position = UDim2.fromOffset(44, 0)
taIcon.BackgroundTransparency = 1; taIcon.Image = icons.info
taIcon.ImageColor3 = Color3.fromRGB(246, 246, 246); taIcon.ImageTransparency = 0.16

print("[UnAliveUI] Main window loaded")