--[[
	UnAliveUI — Main Window UI
	
	Dark Alert theme window with title bar, search bar, EditMenu, content pages,
	Myriad-style WindowPill, traffic light buttons (close/minimize), and Myriad exact minimize.
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
        Text = "UnAlive", TextColor = Color3.fromRGB(190, 190, 198),
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
	ic.ImageTransparency = 1
	ic.Position = UDim2.fromScale(0.5, 0.5)
	ic.Size = UDim2.fromScale(1, 1)
	ic.Parent = btn
	
	table.insert(dotIcons, ic)
end

-- Show icons when cursor enters title bar area; hide when it leaves
-- Uses a transparent overlay button for reliable hover detection
local hoverZone = Instance.new("TextButton")
hoverZone.Name = "HoverZone"
hoverZone.Size = UDim2.new(1, 0, 1, 0)
hoverZone.BackgroundTransparency = 1
hoverZone.BorderSizePixel = 0
hoverZone.Text = ""
hoverZone.ZIndex = 1
hoverZone.Parent = titleBar

local function showIcons()
	for _, ic in ipairs(dotIcons) do ic.ImageTransparency = 0.50 end
end
local function hideIcons()
	for _, ic in ipairs(dotIcons) do ic.ImageTransparency = 1 end
end

hoverZone.MouseEnter:Connect(showIcons)
hoverZone.MouseLeave:Connect(hideIcons)

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

-- === MAIN UI COMPONENTS ===
local TS = TweenService
local normalColor = Color3.fromRGB(245, 245, 245)
local selectedColor = Color3.fromRGB(255, 66, 84)
local dark = Color3.fromRGB(18, 20, 26)
local white = Color3.fromRGB(255, 255, 255)

-- Search bar (top-right)
local sf = Instance.new("Frame", card); sf.Name = "SearchField"
sf.Size = UDim2.fromOffset(122, 26); sf.Position = UDim2.fromOffset(365, 10)
sf.BackgroundColor3 = dark; sf.BackgroundTransparency = 0.08; sf.BorderSizePixel = 0; sf.ZIndex = 20; sf.ClipsDescendants = true
Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 13)
local sfBorder = Instance.new("UIStroke", sf); sfBorder.Color = white; sfBorder.Transparency = 0.92; sfBorder.Thickness = 0.5
local sfIcon = Instance.new("ImageLabel", sf); sfIcon.Size = UDim2.fromOffset(16,16); sfIcon.Position = UDim2.fromOffset(8,5)
sfIcon.BackgroundTransparency = 1; sfIcon.Image = "rbxassetid://117204739779559"; sfIcon.ImageColor3 = Color3.fromRGB(200,200,200); sfIcon.ScaleType = Enum.ScaleType.Fit; sfIcon.ZIndex = 21
local sfPH = Instance.new("TextLabel", sf); sfPH.Name = "Placeholder"
sfPH.Size = UDim2.fromOffset(74,16); sfPH.Position = UDim2.fromOffset(26,5); sfPH.BackgroundTransparency = 1
sfPH.FontFace = Font.new("rbxassetid://12187365364"); sfPH.Text = "Search"; sfPH.TextSize = 13
sfPH.TextColor3 = Color3.fromRGB(245,245,245); sfPH.TextXAlignment = Enum.TextXAlignment.Left; sfPH.TextYAlignment = Enum.TextYAlignment.Center; sfPH.ZIndex = 21
local sfBox = Instance.new("TextBox", sf); sfBox.Name = "Input"
sfBox.Size = UDim2.fromOffset(74,16); sfBox.Position = UDim2.fromOffset(26,5); sfBox.BackgroundTransparency = 1
sfBox.FontFace = Font.new("rbxassetid://12187365364"); sfBox.Text = ""; sfBox.TextSize = 13
sfBox.TextColor3 = Color3.fromRGB(245,245,245); sfBox.TextXAlignment = Enum.TextXAlignment.Left; sfBox.TextYAlignment = Enum.TextYAlignment.Center; sfBox.ClearTextOnFocus = false; sfBox.ZIndex = 22
local sfClear = Instance.new("ImageButton", sf); sfClear.Name = "Clear"
sfClear.Size = UDim2.fromOffset(16,16); sfClear.Position = UDim2.fromOffset(100,5); sfClear.BackgroundTransparency = 1
sfClear.AutoButtonColor = false; sfClear.Image = "rbxassetid://78668603799563"; sfClear.ImageColor3 = Color3.fromRGB(138,138,138); sfClear.ScaleType = Enum.ScaleType.Fit; sfClear.ZIndex = 22; sfClear.Visible = false
local function syncPH() sfPH.Visible = (sfBox.Text == ""); sfClear.Visible = (sfBox.Text ~= "") end
sfBox:GetPropertyChangedSignal("Text"):Connect(syncPH)
sfBox.Focused:Connect(function() sfPH.Visible = false; Tween(sfBorder, {Color = Color3.fromRGB(200,200,200), Transparency = 0.5}, 0.2) end)
sfBox.FocusLost:Connect(function() syncPH(); Tween(sfBorder, {Color = white, Transparency = 0.92}, 0.2) end)
sfClear.MouseButton1Click:Connect(function() sfBox.Text = ""; sfBox:CaptureFocus() end)
syncPH()

-- Pages
local pages = Instance.new("Frame", card); pages.Name = "Pages"
pages.Size = UDim2.fromOffset(496, 200); pages.Position = UDim2.fromOffset(0, 50)
pages.BackgroundTransparency = 1; pages.BorderSizePixel = 0; pages.ZIndex = 20
local pageData = {{"Farm","Manage your farm resources and crops"},{"Shop","Browse items available for purchase"},{"Steal","Steal resources from other players"},{"Spawn","Spawn vehicles, items, and more"},{"Config","Configure your settings and preferences"},{"Settings","Adjust your application settings and preferences"}}
for pi, pd in ipairs(pageData) do
	local pg = Instance.new("Frame", pages); pg.Name = "Page"..pi; pg.Size = UDim2.fromScale(1,1); pg.BackgroundTransparency = 1; pg.BorderSizePixel = 0; pg.ZIndex = 20; pg.Visible = pi == 1
	local lbl = Instance.new("TextLabel", pg); lbl.Size = UDim2.fromOffset(200,30); lbl.Position = UDim2.fromOffset(20,40); lbl.BackgroundTransparency = 1
	lbl.FontFace = Font.new("rbxassetid://12187365364"); lbl.Text = pd[1]; lbl.TextSize = 24; lbl.TextColor3 = Color3.fromRGB(255,255,255); lbl.TextXAlignment = Enum.TextXAlignment.Left
	local desc = Instance.new("TextLabel", pg); desc.Size = UDim2.fromOffset(400,20); desc.Position = UDim2.fromOffset(20,80); desc.BackgroundTransparency = 1
	desc.FontFace = Font.new("rbxassetid://12187365364"); desc.Text = pd[2]; desc.TextSize = 14; desc.TextColor3 = Color3.fromRGB(180,180,190); desc.TextXAlignment = Enum.TextXAlignment.Left
end

-- EditMenu
local em = Instance.new("Frame", card); em.Name = "EditMenu"
em.Size = UDim2.fromOffset(488, 44); em.Position = UDim2.fromOffset(4, 276); em.ZIndex = 20; em.BackgroundTransparency = 1
local emShadow = Instance.new("Frame", em); emShadow.Size = UDim2.new(1,4,1,4); emShadow.Position = UDim2.fromOffset(-2,-2)
emShadow.BackgroundColor3 = Color3.fromRGB(0,0,0); emShadow.BackgroundTransparency = 0.82; emShadow.BorderSizePixel = 0; emShadow.ZIndex = -1
Instance.new("UICorner", emShadow).CornerRadius = UDim.new(0, 34)
local emGlass = Instance.new("Frame", em); emGlass.Size = UDim2.fromScale(1,1); emGlass.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
emGlass.BackgroundTransparency = 0; emGlass.BorderSizePixel = 0; emGlass.ZIndex = 20
Instance.new("UICorner", emGlass).CornerRadius = UDim.new(0, 34)
local emStroke = Instance.new("UIStroke", emGlass); emStroke.Color = white; emStroke.Transparency = 0.88; emStroke.Thickness = 1
local emContent = Instance.new("Frame", em); emContent.Size = UDim2.fromScale(1,1); emContent.BackgroundTransparency = 1; emContent.BorderSizePixel = 0; emContent.ZIndex = 22
local emLayout = Instance.new("UIListLayout", emContent); emLayout.FillDirection = Enum.FillDirection.Horizontal; emLayout.VerticalAlignment = Enum.VerticalAlignment.Center; emLayout.Padding = UDim.new(0, 0)
Instance.new("UIPadding", emContent).PaddingLeft = UDim.new(0, 20); Instance.new("UIPadding", emContent).PaddingRight = UDim.new(0, 4)
local items = {{"Farm",50,34,false},{"Shop",68,35,true},{"Steal",67,34,true},{"Spawn",78,45,true},{"Config",77,44,true},{"Settings",88,55,true}}
local selectedLabel = nil
for ei, ed in ipairs(items) do
	local text, w, tw, hasSep = table.unpack(ed)
	local a = Instance.new("Frame", emContent); a.Size = UDim2.fromOffset(w,18); a.BackgroundTransparency = 1; a.BorderSizePixel = 0
	if hasSep then local s = Instance.new("Frame", a); s.Size = UDim2.fromOffset(1,18); s.Position = UDim2.fromOffset(0,0); s.BackgroundColor3 = white; s.BackgroundTransparency = 0.8; s.BorderSizePixel = 0 end
	local lb = Instance.new("TextLabel", a); lb.Size = UDim2.fromOffset(tw,18); lb.Position = UDim2.fromOffset(hasSep and 17 or 0,0)
	lb.BackgroundTransparency = 1; lb.FontFace = Font.new("rbxassetid://12187365364"); lb.Text = text; lb.TextSize = 15
	lb.TextColor3 = ei == 1 and selectedColor or normalColor; lb.TextXAlignment = Enum.TextXAlignment.Left; lb.TextYAlignment = Enum.TextYAlignment.Center
	if ei == 1 then selectedLabel = lb end
	local hb = Instance.new("TextButton", a); hb.Size = UDim2.fromScale(1,1); hb.BackgroundTransparency = 1; hb.BorderSizePixel = 0; hb.Text = ""; hb.ZIndex = 22; hb.AutoButtonColor = false
	hb.MouseButton1Click:Connect(function()
		if selectedLabel == lb then return end
		if selectedLabel then TS:Create(selectedLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = normalColor, TextTransparency = 0.3}):Play()
			task.delay(0.15, function() if selectedLabel then TS:Create(selectedLabel, TweenInfo.new(0.1), {TextTransparency = 0}):Play() end end) end
		lb.TextColor3 = selectedColor; lb.TextTransparency = 0.3
		TS:Create(lb, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = selectedColor, TextTransparency = 0}):Play()
		selectedLabel = lb
		for _, p in pairs(pages:GetChildren()) do if p:IsA("Frame") then p.Visible = false end end
		local t = pages:FindFirstChild("Page"..ei); if t then t.Visible = true end
	end)
end
local ind = Instance.new("Frame", emContent); ind.Size = UDim2.fromOffset(36,36); ind.BackgroundColor3 = Color3.fromRGB(3,3,3); ind.BackgroundTransparency = 0
Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
local ii = Instance.new("ImageLabel", ind); ii.Size = UDim2.fromOffset(24,24); ii.Position = UDim2.fromOffset(6,6)
ii.BackgroundTransparency = 1; ii.Image = "rbxassetid://103603118195781"; ii.ImageColor3 = white; ii.ScaleType = Enum.ScaleType.Fit; ii.ZIndex = 22

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

print("=== UnAliveUI Main Window ===")
