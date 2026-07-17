--[[
	UnAliveUI — Gag2 Layout
	
	Exact demo.lua structure. Add custom components below.
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("UnAliveUI")
if existing then existing:Destroy() end
local existingPill = playerGui:FindFirstChild("UnAliveUI_Pill")
if existingPill then existingPill:Destroy() end

-- Config
local CONFIG = {
    Window = {
        Width = 540, Height = 400, CornerRadius = 16, BorderThickness = 1,
        BgColor = Color3.fromRGB(12, 12, 14), BorderColor = Color3.fromRGB(34, 34, 40),
        Shadow = {Enabled = true, Transparency = 0.65},
    },
    TitleBar = {
        Height = 34, BgColor = Color3.fromRGB(16, 16, 19), LineColor = Color3.fromRGB(36, 36, 42),
        Text = "Gag2", TextColor = Color3.fromRGB(190, 190, 198),
        Font = Enum.Font.Gotham, TextSize = 14, TextLeft = 14,
    },
    Card = {
        MarginLeft = 22, MarginRight = 22, MarginTop = 18, MarginBottom = 18,
        CornerRadius = 16, BorderThickness = 1,
        BgColor = Color3.fromRGB(20, 20, 24), BorderColor = Color3.fromRGB(38, 38, 46),
        Shadow = {Enabled = true, Image = "rbxassetid://6015897843", Transparency = 0.7, Offset = 30},
    },
    Drag = {
        Smoothness = 0.15, ScaleDown = 0.97, ScaleDur = 0.15, ShadowDarken = 0.15,
    },
}

local W = CONFIG.Window; local TB = CONFIG.TitleBar
local CD = CONFIG.Card; local DR = CONFIG.Drag
local WIN_W = W.Width; local WIN_H = W.Height; local TB_H = TB.Height

local function Tween(obj, props, dur, sty, dir)
    TweenService:Create(obj, TweenInfo.new(dur or 0.25, sty or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

-- Main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true
gui.DisplayOrder = 999; gui.Parent = playerGui

local window = Instance.new("Frame")
window.Name = "Window"; window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.fromScale(0.5, 0.5)
window.BackgroundColor3 = W.BgColor; window.BorderSizePixel = 0
window.ClipsDescendants = false; window.ZIndex = 2; window.Parent = gui
Instance.new("UICorner", window).CornerRadius = UDim.new(0, W.CornerRadius)
local winStroke = Instance.new("UIStroke", window)
winStroke.Color = W.BorderColor; winStroke.Thickness = W.BorderThickness
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local guiScale = Instance.new("UIScale"); guiScale.Name = "UIScale"; guiScale.Parent = gui

if W.Shadow.Enabled then
    local s = Instance.new("Frame")
    s.Name = "Shadow"; s.Size = UDim2.new(1, 6, 1, 6)
    s.Position = UDim2.new(0, -3, 0, -3)
    s.BackgroundColor3 = Color3.fromRGB(0,0,0); s.BackgroundTransparency = 0.65
    s.BorderSizePixel = 0; s.ZIndex = 1; s.Parent = window
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, W.CornerRadius)
end

-- TitleBar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"; titleBar.Size = UDim2.new(1, 0, 0, TB_H)
titleBar.BackgroundColor3 = TB.BgColor; titleBar.BorderSizePixel = 0
titleBar.ZIndex = 10; titleBar.Parent = window
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, W.CornerRadius)
local tbMask = Instance.new("Frame")
tbMask.Name = "BottomMask"; tbMask.Size = UDim2.new(1, 0, 0, W.CornerRadius)
tbMask.Position = UDim2.new(0, 0, 1, -W.CornerRadius)
tbMask.BackgroundColor3 = TB.BgColor; tbMask.BorderSizePixel = 0
tbMask.ZIndex = 10; tbMask.Parent = titleBar
local tbLine = Instance.new("Frame")
tbLine.Name = "Hairline"; tbLine.Size = UDim2.new(1, 0, 0, 1)
tbLine.Position = UDim2.new(0, 0, 1, -1); tbLine.BackgroundColor3 = TB.LineColor
tbLine.BorderSizePixel = 0; tbLine.ZIndex = 11; tbLine.Parent = titleBar
local titleLbl = Instance.new("TextLabel")
titleLbl.Name = "Title"; titleLbl.Size = UDim2.new(0, 200, 0, TB.TextSize)
titleLbl.AnchorPoint = Vector2.new(0, 0.5); titleLbl.Position = UDim2.new(0, TB.TextLeft, 0.5, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Text = TB.Text; titleLbl.Font = TB.Font
titleLbl.TextSize = TB.TextSize; titleLbl.TextColor3 = TB.TextColor
titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.TextYAlignment = Enum.TextYAlignment.Center
titleLbl.TextTruncate = Enum.TextTruncate.AtEnd; titleLbl.ZIndex = 11; titleLbl.Parent = titleBar

-- Myriad-style traffic light buttons (close + minimize)
local RIGHT_OFFSET = 16
local DOT_SIZE = 12
local SPACING = 8

local btnData = {
	{Name = "Exit", Clr = Color3.fromHex("FF5F57"), Icn = "rbxassetid://94781753558308", Idx = 1},
	{Name = "Minimize", Clr = Color3.fromHex("FEBC2E"), Icn = "rbxassetid://118368309445367", Idx = 2},
}

local dotIcons = {}
for _, d in ipairs(btnData) do
	local offset = RIGHT_OFFSET + DOT_SIZE/2 + (2 - d.Idx) * (DOT_SIZE + SPACING)

	local btn = Instance.new("ImageButton")
	btn.Name = d.Name
	btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.Position = UDim2.new(1, -offset, 0.5, 0)
	btn.AutoButtonColor = false
	btn.BackgroundTransparency = 1
	btn.BorderSizePixel = 0
	btn.Image = "rbxassetid://132228700346004"
	btn.ImageColor3 = d.Clr
	btn.ImageTransparency = 0
	btn.Size = UDim2.fromOffset(DOT_SIZE, DOT_SIZE)
	btn.ZIndex = 15
	btn.Parent = titleBar

	local stk = Instance.new("ImageLabel")
	stk.Name = "Stroke"
	stk.Parent = btn

	local ic = Instance.new("ImageLabel")
	ic.Name = "Icon"
	ic.AnchorPoint = Vector2.new(0.5, 0.5)
	ic.BackgroundTransparency = 1
	ic.BorderSizePixel = 0
	ic.Image = d.Icn
	ic.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ic.ImageTransparency = 0.50
	ic.Position = UDim2.fromScale(0.5, 0.5)
	ic.Size = UDim2.fromScale(1, 1)
	ic.Visible = false
	ic.Parent = btn

	btn.MouseEnter:Connect(function() ic.Visible = true end)
	btn.MouseLeave:Connect(function() ic.Visible = false end)

	table.insert(dotIcons, ic)
end

-- Card
local card = Instance.new("Frame")
card.Name = "Card"; card.Size = UDim2.new(0, WIN_W - CD.MarginLeft - CD.MarginRight, 0, WIN_H - TB_H - CD.MarginTop - CD.MarginBottom)
card.Position = UDim2.new(0, CD.MarginLeft, 0, TB_H + CD.MarginTop)
card.BackgroundColor3 = CD.BgColor; card.BorderSizePixel = 0; card.ZIndex = 5; card.Parent = window
Instance.new("UICorner", card).CornerRadius = UDim.new(0, CD.CornerRadius)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = CD.BorderColor; cardStroke.Thickness = CD.BorderThickness
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
if CD.Shadow.Enabled then
    local s = Instance.new("ImageLabel")
    s.Name = "Shadow"; s.Size = UDim2.new(1, CD.Shadow.Offset, 1, CD.Shadow.Offset)
    s.Position = UDim2.new(0, -CD.Shadow.Offset/2, 0, -CD.Shadow.Offset/2)
    s.BackgroundTransparency = 1; s.Image = CD.Shadow.Image
    s.ImageColor3 = Color3.fromRGB(0,0,0); s.ImageTransparency = CD.Shadow.Transparency
    s.ScaleType = Enum.ScaleType.Slice; s.SliceCenter = Rect.new(49,49,50,50)
    s.ZIndex = 4; s.Parent = card
end

-- Drag
local drag, dSt, dPos = false, nil, nil
local targetPos = window.Position; local dragConn
local function startDrag(input)
    drag = true; dSt = input.Position; dPos = window.Position; targetPos = dPos
    Tween(guiScale, {Scale = DR.ScaleDown}, DR.ScaleDur)
    if window:FindFirstChild("Shadow") and window.Shadow:IsA("ImageLabel") then
        local darker = math.max(0, W.Shadow.Transparency - DR.ShadowDarken)
        Tween(window.Shadow, {ImageTransparency = darker}, DR.ScaleDur)
    end
    if dragConn then dragConn:Disconnect() end
    dragConn = RunService.Heartbeat:Connect(function()
        if not drag then dragConn:Disconnect(); dragConn = nil; return end
        window.Position = window.Position:Lerp(targetPos, DR.Smoothness)
    end)
end
titleBar.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then startDrag(i) end
end)
card.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then startDrag(i) end
end)
UserInputService.InputChanged:Connect(function(i)
    if not drag then return end
    if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
        local delta = i.Position - dSt
        targetPos = UDim2.new(dPos.X.Scale, dPos.X.Offset + delta.X, dPos.Y.Scale, dPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if drag then drag = false; Tween(guiScale, {Scale = 1}, DR.ScaleDur, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if window:FindFirstChild("Shadow") and window.Shadow:IsA("ImageLabel") then
                Tween(window.Shadow, {ImageTransparency = W.Shadow.Transparency}, DR.ScaleDur) end
        end
    end
end)

-- ==============================
-- CUSTOM COMPONENTS GO BELOW
-- ==============================



-- WindowPill (separate ScreenGui, stays visible when minimized)
local pillGui = Instance.new("ScreenGui")
pillGui.Name = "UnAliveUI_Pill"
pillGui.ResetOnSpawn = false
pillGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pillGui.DisplayOrder = 200
pillGui.IgnoreGuiInset = true
pillGui.Parent = playerGui

local pill = Instance.new("ImageButton")
pill.Name = "WindowPill"
pill.AnchorPoint = Vector2.new(0.5, 0)
pill.AutoButtonColor = false
pill.BackgroundTransparency = 1
pill.BorderSizePixel = 0
pill.Image = "rbxassetid://93520763686656"
pill.ImageTransparency = 0.5
pill.Position = UDim2.new(0.5, 0, 0, 10)
pill.Size = UDim2.fromOffset(180, 5)
pill.ZIndex = 999
pill.Parent = pillGui
Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

-- Minimize (Myriad exact)
local mined = false
local function toggleMinimize()
	mined = not mined
	local tY = mined and window.AbsoluteSize.Y * 2 or 0
	TweenService:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, tY)}):Play()
	TweenService:Create(guiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Scale = mined and 0 or 1}):Play()
end

-- WindowPill hover glow + click
local ct
pill.MouseEnter:Connect(function()
	if ct then ct:Cancel() end
	ct = TweenService:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.15})
	ct:Play()
end)
pill.MouseLeave:Connect(function()
	if ct then ct:Cancel() end
	ct = TweenService:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.5})
	ct:Play()
end)
pill.MouseButton1Click:Connect(toggleMinimize)

-- Wire traffic light buttons
local exitBtn = titleBar:FindFirstChild("Exit")
if exitBtn then
	exitBtn.MouseButton1Click:Connect(function() gui:Destroy(); pillGui:Destroy() end)
end
local minBtn = titleBar:FindFirstChild("Minimize")
if minBtn then
	minBtn.MouseButton1Click:Connect(toggleMinimize)
end

print("=== Gag2 Layout ===")
