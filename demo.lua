--[[ UnaliveUI — Main Window ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local existing = playerGui:FindFirstChild("UnAliveUI")
if existing then existing:Destroy() end

local W, H = 540, 400
local CR = 16
local TB_H = 34
local CM = 22
local dark = Color3.fromRGB(18, 20, 26)
local white = Color3.fromRGB(255, 255, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"; gui.ResetOnSpawn = false; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true; gui.DisplayOrder = 999; gui.Parent = playerGui

local window = Instance.new("Frame", gui)
window.Name = "Window"; window.Size = UDim2.fromOffset(W, H); window.Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2)
window.BackgroundColor3 = dark; window.BackgroundTransparency = 0.08; window.BorderSizePixel = 0; window.ClipsDescendants = true; window.ZIndex = 2
Instance.new("UICorner", window).CornerRadius = UDim.new(0, CR)
local winStroke = Instance.new("UIStroke", window); winStroke.Color = white; winStroke.Transparency = 0.88; winStroke.Thickness = 1
local uiScale = Instance.new("UIScale", window)

-- Title bar
local titleBar = Instance.new("Frame", window); titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, TB_H); titleBar.BackgroundColor3 = Color3.fromRGB(16, 16, 19); titleBar.BorderSizePixel = 0; titleBar.ZIndex = 10
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, CR)
local tbMask = Instance.new("Frame", titleBar); tbMask.Name = "BottomMask"; tbMask.Size = UDim2.new(1, 0, 0, CR); tbMask.Position = UDim2.new(0, 0, 1, -CR); tbMask.BackgroundColor3 = Color3.fromRGB(16, 16, 19); tbMask.BorderSizePixel = 0; tbMask.ZIndex = 10
local tbLine = Instance.new("Frame", titleBar); tbLine.Name = "Hairline"; tbLine.Size = UDim2.new(1, 0, 0, 1); tbLine.Position = UDim2.new(0, 0, 1, -1); tbLine.BackgroundColor3 = Color3.fromRGB(36, 36, 42); tbLine.BorderSizePixel = 0; tbLine.ZIndex = 11
local titleLbl = Instance.new("TextLabel", titleBar); titleLbl.Name = "Title"
titleLbl.Size = UDim2.fromOffset(200, 14); titleLbl.AnchorPoint = Vector2.new(0, 0.5); titleLbl.Position = UDim2.fromOffset(14, 0.5); titleLbl.BackgroundTransparency = 1
titleLbl.Text = "UnAlive"; titleLbl.Font = Enum.Font.Gotham; titleLbl.TextSize = 14; titleLbl.TextColor3 = Color3.fromRGB(190, 190, 198)
titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.TextYAlignment = Enum.TextYAlignment.Center; titleLbl.ZIndex = 11

-- Card
local card = Instance.new("Frame", window); card.Name = "Card"
card.Size = UDim2.fromOffset(W - CM * 2, H - TB_H - CM * 2); card.Position = UDim2.fromOffset(CM, TB_H + CM)
card.BackgroundColor3 = Color3.fromRGB(20, 20, 24); card.BorderSizePixel = 0; card.ZIndex = 5
Instance.new("UICorner", card).CornerRadius = UDim.new(0, CR)

print("[UnAliveUI] Main window loaded")