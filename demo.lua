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

print("[UnAliveUI] Main window loaded")