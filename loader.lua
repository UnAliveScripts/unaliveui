--[[
	UnAlive UI Loader — Key System Entry Point
	
	Loads the key verification UI. On success, loads the main UnAlive UI.
	
	Usage:
		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/loader.lua"
		))()
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Clean up existing
for _, name in pairs({ "UnAliveKeySystem", "UnAliveUI" }) do
	local e = playerGui:FindFirstChild(name)
	if e then e:Destroy() end
end

-- Configuration
local KEY_LINK = "https://unalive.net/keysystem"
local API_URL = "https://unalive.net/api/v1/validateget"

local function getHWID()
	local ok, result = pcall(function()
		return game:GetService("RbxAnalyticsService"):GetClientId()
	end)
	if ok and result and result ~= "" then return result end
	return tostring(
		game:GetService("GuiService"):GetScreenResolution().X
	) .. tostring(UserInputService:GetPlatform()) .. tostring(game.JobId)
end

local function validateKeyOnline(key)
	local hwid = getHWID()
	local url = API_URL .. "?key=" .. key .. "&hwid=" .. hwid

	-- Try game:HttpGet
	local ok, resp = pcall(function() return game:HttpGet(url) end)
	if ok and resp then
		local dec, data = pcall(function() return HttpService:JSONDecode(resp) end)
		if dec and data then return data end
	end

	-- Try syn.request
	ok, resp = pcall(function() return syn.request({ Url = url, Method = "GET" }).Body end)
	if ok and resp and resp ~= "" then
		local dec, data = pcall(function() return HttpService:JSONDecode(resp) end)
		if dec and data then return data end
	end

	-- Try request
	ok, resp = pcall(function() return request({ Url = url, Method = "GET" }).Body end)
	if ok and resp and resp ~= "" then
		local dec, data = pcall(function() return HttpService:JSONDecode(resp) end)
		if dec and data then return data end
	end

	return { success = false, code = "NET_ERROR", message = "Failed to connect to key server." }
end

-- Config
local CONFIG = {
	Window = {
		Width = 540, Height = 400, CornerRadius = 16, BorderThickness = 1,
		BgColor = Color3.fromRGB(12, 12, 14), BorderColor = Color3.fromRGB(34, 34, 40),
		Shadow = { Enabled = true, Transparency = 0.55, Offset = 6 },
	},
	TitleBar = {
		Height = 34, BgColor = Color3.fromRGB(16, 16, 19), LineColor = Color3.fromRGB(36, 36, 42),
		Text = "UnAlive", TextColor = Color3.fromRGB(190, 190, 198),
		Font = Enum.Font.Gotham, TextSize = 14, TextLeft = 14,
	},
	Dots = {
		Enabled = true, RightOffset = 16, Size = 10, Spacing = 8,
		Colors = { Close = Color3.fromRGB(255, 95, 87), Minimize = Color3.fromRGB(255, 189, 46),
			Stroke = Color3.fromRGB(0, 0, 0) },
		HoverLerp = 0.22, HoverDur = 0.12,
	},
	Card = {
		MarginLeft = 22, MarginRight = 22, MarginTop = 18, MarginBottom = 18,
		CornerRadius = 16, BorderThickness = 1,
		BgColor = Color3.fromRGB(20, 20, 24), BorderColor = Color3.fromRGB(38, 38, 46),
		Shadow = { Enabled = true, Image = "rbxassetid://6015897843", Transparency = 0.7, Offset = 30 },
	},
	Font = {
		Heading = Enum.Font.GothamBold, Subtitle = Enum.Font.Gotham,
		Input = Enum.Font.Gotham, Button = Enum.Font.GothamSemibold,
		Link = Enum.Font.Gotham,
	},
	TextSize = { Heading = 26, Subtitle = 14, Input = 14, Placeholder = 14, Button = 15, Link = 12 },
	Input = {
		Height = 46, CornerRadius = 10, BorderThickness = 1,
		IconSize = 16, IconLeft = 15, TextLeft = 40, Gap = 12,
		BgColor = Color3.fromRGB(24, 24, 28), BorderColor = Color3.fromRGB(42, 42, 50),
		BorderFocus = Color3.fromRGB(64, 64, 78), BorderError = Color3.fromRGB(185, 50, 50),
		IconColor = Color3.fromRGB(82, 82, 100), IconFocus = Color3.fromRGB(118, 118, 142),
		PlaceholderColor = Color3.fromRGB(72, 72, 88), TextColor = Color3.fromRGB(225, 225, 234),
	},
	Button = {
		Height = 46, CornerRadius = 10, BorderThickness = 1, GapFromInputs = 12,
		Text = "→] Login", BgColor = Color3.fromRGB(30, 30, 36),
		BorderColor = Color3.fromRGB(48, 48, 58),
		HoverBg = Color3.fromRGB(38, 38, 46), HoverBorder = Color3.fromRGB(64, 64, 78),
		TextColor = Color3.fromRGB(255, 255, 255),
	},
	States = {
		LockBg = Color3.fromRGB(34, 16, 16), LockBd = Color3.fromRGB(72, 28, 28),
		LockTx = Color3.fromRGB(225, 65, 65),
		OkBg = Color3.fromRGB(16, 34, 22), OkBd = Color3.fromRGB(34, 82, 46),
		OkTx = Color3.fromRGB(72, 210, 130),
	},
	Drag = {
		Enabled = true, Smoothness = 0.15, DragAnywhere = true,
		ScaleDown = 0.97, ScaleDur = 0.15, ShadowDarken = 0.15,
	},
	Minimize = {
		CollapsedHeight = 36, AnimDur = 0.35,
		Easing = { Enum.EasingStyle.Quad, Enum.EasingDirection.Out },
	},
	Icons = { Key = "rbxassetid://7733964640", Link = "rbxassetid://7733978093" },
	Anim = {
		TweenDur = 0.25, ShakeDur = 0.03, FlashDur = 0.08, FlashHold = 1.5,
		FadeOutDur = 0.4, SuccessWait = 0.5,
		Intro = {
			WindowDur = 0.5, WindowEasing = { Enum.EasingStyle.Back, Enum.EasingDirection.Out },
			CardDur = 0.4, CardDelay = 0.1, TextStagger = 0.06,
		},
	},
}

local W = CONFIG.Window
local TB = CONFIG.TitleBar
local DT = CONFIG.Dots
local CD = CONFIG.Card
local IN = CONFIG.Input
local BT = CONFIG.Button
local ST = CONFIG.States
local DR = CONFIG.Drag
local MN = CONFIG.Minimize
local AN = CONFIG.Anim
local IC = CONFIG.Icons

local WIN_W = W.Width
local WIN_H = W.Height
local TB_H = TB.Height
local CARD_W = WIN_W - CD.MarginLeft - CD.MarginRight
local CARD_H = WIN_H - TB_H - CD.MarginTop - CD.MarginBottom
local CARD_X = CD.MarginLeft
local CARD_Y = TB_H + CD.MarginTop
local PAD_H = IN.IconLeft
local ELEM_W = CARD_W - (PAD_H * 2)

local Y_HEAD = 28
local Y_SUB = Y_HEAD + 34 + 10
local Y_KEY = Y_SUB + 20 + 24
local Y_BTN = Y_KEY + IN.Height + BT.GapFromInputs
local Y_LINK = Y_BTN + BT.Height + 14

local function Tween(obj, props, dur, sty, dir)
	TweenService:Create(
		obj,
		TweenInfo.new(dur or AN.TweenDur, sty or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
		props
	):Play()
end

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveKeySystem"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

local window = Instance.new("Frame")
window.Name = "Window"
window.Size = UDim2.new(0, WIN_W, 0, WIN_H)
window.Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2)
window.BackgroundColor3 = W.BgColor
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.ZIndex = 2
window.Parent = gui

Instance.new("UICorner", window).CornerRadius = UDim.new(0, W.CornerRadius)

local winStroke = Instance.new("UIStroke", window)
winStroke.Color = W.BorderColor
winStroke.Thickness = W.BorderThickness
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uiScale = Instance.new("UIScale")
uiScale.Parent = window

if W.Shadow.Enabled then
	local s = Instance.new("ImageLabel")
	s.Name = "Shadow"
	s.Size = UDim2.new(1, W.Shadow.Offset, 1, W.Shadow.Offset)
	s.Position = UDim2.new(0, -W.Shadow.Offset / 2, 0, -W.Shadow.Offset / 2)
	s.BackgroundTransparency = 1
	s.Image = W.Shadow.Image
	s.ImageColor3 = Color3.fromRGB(0, 0, 0)
	s.ImageTransparency = W.Shadow.Transparency
	s.ScaleType = Enum.ScaleType.Slice
	s.SliceCenter = Rect.new(49, 49, 50, 50)
	s.ZIndex = 1
	s.Parent = window
end

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, TB_H)
titleBar.BackgroundColor3 = TB.BgColor
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 10
titleBar.Parent = window

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, W.CornerRadius)

local tbMask = Instance.new("Frame")
tbMask.Name = "BottomMask"
tbMask.Size = UDim2.new(1, 0, 0, W.CornerRadius)
tbMask.Position = UDim2.new(0, 0, 1, -W.CornerRadius)
tbMask.BackgroundColor3 = TB.BgColor
tbMask.BorderSizePixel = 0
tbMask.ZIndex = 10
tbMask.Parent = titleBar

local tbLine = Instance.new("Frame")
tbLine.Name = "Hairline"
tbLine.Size = UDim2.new(1, 0, 0, 1)
tbLine.Position = UDim2.new(0, 0, 1, -1)
tbLine.BackgroundColor3 = TB.LineColor
tbLine.BorderSizePixel = 0
tbLine.ZIndex = 11
tbLine.Parent = titleBar

local titleLbl = Instance.new("TextLabel")
titleLbl.Name = "Title"
titleLbl.Size = UDim2.new(0, 200, 0, TB.TextSize)
titleLbl.AnchorPoint = Vector2.new(0, 0.5)
titleLbl.Position = UDim2.new(0, TB.TextLeft, 0.5, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = TB.Text
titleLbl.Font = TB.Font
titleLbl.TextSize = TB.TextSize
titleLbl.TextColor3 = TB.TextColor
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextYAlignment = Enum.TextYAlignment.Center
titleLbl.TextTruncate = Enum.TextTruncate.AtEnd
titleLbl.ZIndex = 11
titleLbl.Parent = titleBar

-- Dots (close/minimize)
if DT.Enabled then
	local dotColors = { DT.Colors.Close, DT.Colors.Minimize }
	local minimized = false
	local origSz, origPos

	local dotActions = {
		function() gui:Destroy() end,
		function()
			if minimized then
				Tween(window, { Size = origSz, Position = origPos }, MN.AnimDur, MN.Easing[1], MN.Easing[2])
				restoreCardDescendants(card)
				Tween(card, { BackgroundTransparency = 0 }, MN.AnimDur)
				Tween(cardStroke, { Transparency = 0 }, MN.AnimDur)
				minimized = false
			else
				origSz = window.Size
				origPos = window.Position
				local collapsed = UDim2.new(0, WIN_W, 0, MN.CollapsedHeight)
				for _, d in ipairs(card:GetDescendants()) do
					if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
						Tween(d, { TextTransparency = 1 }, 0.2)
					elseif d:IsA("ImageLabel") and d.Name ~= "Shadow" then
						Tween(d, { ImageTransparency = 1 }, 0.2)
					elseif d:IsA("Frame") then Tween(d, { BackgroundTransparency = 1 }, 0.2)
					elseif d:IsA("UIStroke") then Tween(d, { Transparency = 1 }, 0.2) end
				end
				Tween(card, { BackgroundTransparency = 1 }, 0.2)
				Tween(cardStroke, { Transparency = 1 }, 0.2)
				task.delay(0.15, function()
					Tween(window, { Size = collapsed }, MN.AnimDur, MN.Easing[1], MN.Easing[2])
				end)
				minimized = true
			end
		end,
	}

	local function restoreCardDescendants(c)
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
				Tween(d, { TextTransparency = 0 }, 0.3)
			elseif d:IsA("ImageLabel") and d.Name ~= "Shadow" then
				Tween(d, { ImageTransparency = 0 }, 0.3)
			elseif d:IsA("Frame") then Tween(d, { BackgroundTransparency = 0 }, 0.3)
			elseif d:IsA("UIStroke") then Tween(d, { Transparency = 0 }, 0.3) end
		end
	end

	for i = 1, 2 do
		local offset = DT.RightOffset + DT.Size / 2 + (2 - i) * (DT.Size + DT.Spacing)
		local dot = Instance.new("TextButton")
		dot.Name = "Dot" .. i
		dot.Size = UDim2.new(0, DT.Size, 0, DT.Size)
		dot.AnchorPoint = Vector2.new(0.5, 0.5)
		dot.Position = UDim2.new(1, -offset, 0.5, 0)
		dot.BackgroundColor3 = dotColors[i]
		dot.BorderSizePixel = 0
		dot.Text = ""
		dot.AutoButtonColor = false
		dot.ZIndex = 15
		dot.Parent = titleBar

		Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

		local ds = Instance.new("UIStroke", dot)
		ds.Color = DT.Colors.Stroke
		ds.Thickness = 0.5
		ds.Transparency = 0.6

		local base = dotColors[i]
		dot.MouseEnter:Connect(function()
			Tween(dot, { BackgroundColor3 = base:Lerp(Color3.new(1, 1, 1), DT.HoverLerp) }, DT.HoverDur)
		end)
		dot.MouseLeave:Connect(function()
			Tween(dot, { BackgroundColor3 = base }, DT.HoverDur)
		end)
		dot.MouseButton1Click:Connect(dotActions[i])
	end
end

-- Card
local card = Instance.new("Frame")
card.Name = "Card"
card.Size = UDim2.new(0, CARD_W, 0, CARD_H)
card.Position = UDim2.new(0, CARD_X, 0, CARD_Y)
card.BackgroundColor3 = CD.BgColor
card.BorderSizePixel = 0
card.ZIndex = 5
card.Parent = window

Instance.new("UICorner", card).CornerRadius = UDim.new(0, CD.CornerRadius)

local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = CD.BorderColor
cardStroke.Thickness = CD.BorderThickness
cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

if CD.Shadow.Enabled then
	local s = Instance.new("ImageLabel")
	s.Name = "Shadow"
	s.Size = UDim2.new(1, CD.Shadow.Offset, 1, CD.Shadow.Offset)
	s.Position = UDim2.new(0, -CD.Shadow.Offset / 2, 0, -CD.Shadow.Offset / 2)
	s.BackgroundTransparency = 1
	s.Image = CD.Shadow.Image
	s.ImageColor3 = Color3.fromRGB(0, 0, 0)
	s.ImageTransparency = CD.Shadow.Transparency
	s.ScaleType = Enum.ScaleType.Slice
	s.SliceCenter = Rect.new(49, 49, 50, 50)
	s.ZIndex = 4
	s.Parent = card
end

-- Heading
local heading = Instance.new("TextLabel")
heading.Name = "Heading"
heading.Size = UDim2.new(1, 0, 0, 34)
heading.Position = UDim2.new(0, 0, 0, Y_HEAD)
heading.BackgroundTransparency = 1
heading.Text = "Key Verification"
heading.Font = CONFIG.Font.Heading
heading.TextSize = CONFIG.TextSize.Heading
heading.TextColor3 = Color3.fromRGB(255, 255, 255)
heading.TextXAlignment = Enum.TextXAlignment.Center
heading.TextYAlignment = Enum.TextYAlignment.Center
heading.ZIndex = 6
heading.Parent = card

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, Y_SUB)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Paste your key below to access UnAlive"
subtitle.Font = CONFIG.Font.Subtitle
subtitle.TextSize = CONFIG.TextSize.Subtitle
subtitle.TextColor3 = Color3.fromRGB(135, 135, 150)
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextYAlignment = Enum.TextYAlignment.Center
subtitle.ZIndex = 6
subtitle.Parent = card

-- Input field
local function makeField(yPos, iconId, phText)
	local f = Instance.new("Frame")
	f.Name = phText .. "_Field"
	f.Size = UDim2.new(0, ELEM_W, 0, IN.Height)
	f.Position = UDim2.new(0, PAD_H, 0, yPos)
	f.BackgroundColor3 = IN.BgColor
	f.BorderSizePixel = 0
	f.ZIndex = 6
	f.Parent = card

	Instance.new("UICorner", f).CornerRadius = UDim.new(0, IN.CornerRadius)

	local stroke = Instance.new("UIStroke", f)
	stroke.Color = IN.BorderColor
	stroke.Thickness = IN.BorderThickness
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.Size = UDim2.new(0, IN.IconSize, 0, IN.IconSize)
	icon.AnchorPoint = Vector2.new(0, 0.5)
	icon.Position = UDim2.new(0, IN.IconLeft, 0.5, 0)
	icon.BackgroundTransparency = 1
	icon.Image = iconId
	icon.ImageColor3 = IN.IconColor
	icon.ScaleType = Enum.ScaleType.Fit
	icon.ZIndex = 8
	icon.Parent = f

	local ph = Instance.new("TextLabel")
	ph.Name = "Placeholder"
	ph.Size = UDim2.new(1, -(IN.TextLeft + 8), 1, 0)
	ph.Position = UDim2.new(0, IN.TextLeft, 0, 0)
	ph.BackgroundTransparency = 1
	ph.Text = phText
	ph.Font = CONFIG.Font.Input
	ph.TextSize = CONFIG.TextSize.Placeholder
	ph.TextColor3 = IN.PlaceholderColor
	ph.TextXAlignment = Enum.TextXAlignment.Left
	ph.TextYAlignment = Enum.TextYAlignment.Center
	ph.ZIndex = 7
	ph.Parent = f

	local box = Instance.new("TextBox")
	box.Name = "Box"
	box.Size = UDim2.new(1, -(IN.TextLeft + 8), 1, 0)
	box.Position = UDim2.new(0, IN.TextLeft, 0, 0)
	box.BackgroundTransparency = 1
	box.Text = ""
	box.Font = CONFIG.Font.Input
	box.TextSize = CONFIG.TextSize.Input
	box.TextColor3 = IN.TextColor
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.TextYAlignment = Enum.TextYAlignment.Center
	box.ClearTextOnFocus = false
	box.ZIndex = 9
	box.Parent = f

	local function syncPH() ph.Visible = (box.Text == "") end
	box:GetPropertyChangedSignal("Text"):Connect(syncPH)

	box.Focused:Connect(function()
		ph.Visible = false
		Tween(stroke, { Color = IN.BorderFocus }, AN.TweenDur)
		Tween(icon, { ImageColor3 = IN.IconFocus }, AN.TweenDur)
	end)

	box.FocusLost:Connect(function()
		syncPH()
		Tween(stroke, { Color = IN.BorderColor }, AN.TweenDur)
		Tween(icon, { ImageColor3 = IN.IconColor }, AN.TweenDur)
	end)

	return box, f, stroke
end

local keyBox, _, keyStroke = makeField(Y_KEY, IC.Key, "Enter Key")

-- Button
local btn = Instance.new("TextButton")
btn.Name = "LoginBtn"
btn.Size = UDim2.new(0, ELEM_W, 0, BT.Height)
btn.Position = UDim2.new(0, PAD_H, 0, Y_BTN)
btn.BackgroundColor3 = BT.BgColor
btn.BorderSizePixel = 0
btn.Text = "→] Verify Key"
btn.Font = CONFIG.Font.Button
btn.TextSize = CONFIG.TextSize.Button
btn.TextColor3 = BT.TextColor
btn.TextYAlignment = Enum.TextYAlignment.Center
btn.AutoButtonColor = false
btn.ZIndex = 6
btn.Parent = card

Instance.new("UICorner", btn).CornerRadius = UDim.new(0, BT.CornerRadius)

local btnStroke = Instance.new("UIStroke", btn)
btnStroke.Color = BT.BorderColor
btnStroke.Thickness = BT.BorderThickness
btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

btn.MouseEnter:Connect(function()
	Tween(btn, { BackgroundColor3 = BT.HoverBg }, AN.TweenDur)
	Tween(btnStroke, { Color = BT.HoverBorder }, AN.TweenDur)
end)

btn.MouseLeave:Connect(function()
	Tween(btn, { BackgroundColor3 = BT.BgColor }, AN.TweenDur)
	Tween(btnStroke, { Color = BT.BorderColor }, AN.TweenDur)
end)

-- Get Key Link
local linkBtn = Instance.new("TextButton")
linkBtn.Name = "GetKeyLink"
linkBtn.Size = UDim2.new(0, ELEM_W, 0, 20)
linkBtn.Position = UDim2.new(0, PAD_H, 0, Y_LINK)
linkBtn.BackgroundTransparency = 1
linkBtn.Text = "Don't have a key? Get one here"
linkBtn.Font = CONFIG.Font.Link
linkBtn.TextSize = CONFIG.TextSize.Link
linkBtn.TextColor3 = Color3.fromRGB(130, 130, 148)
linkBtn.TextXAlignment = Enum.TextXAlignment.Center
linkBtn.TextYAlignment = Enum.TextYAlignment.Center
linkBtn.AutoButtonColor = false
linkBtn.ZIndex = 6
linkBtn.Parent = card

linkBtn.MouseEnter:Connect(function()
	Tween(linkBtn, { TextColor3 = Color3.fromRGB(180, 180, 200) }, AN.TweenDur)
end)

linkBtn.MouseLeave:Connect(function()
	Tween(linkBtn, { TextColor3 = Color3.fromRGB(130, 130, 148) }, AN.TweenDur)
end)

linkBtn.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard(KEY_LINK)
			linkBtn.Text = "Link copied to clipboard!"
			task.delay(2, function()
				linkBtn.Text = "Don't have a key? Get one here"
			end)
		else
			local s = Instance.new("ScreenGui", playerGui)
			s.Name = "KeyLinkPopup"
			local f = Instance.new("Frame", s)
			f.Size = UDim2.fromOffset(400, 100)
			f.Position = UDim2.new(0.5, -200, 0.5, -50)
			f.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
			Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
			local l = Instance.new("TextLabel", f)
			l.Size = UDim2.new(1, -20, 1, -20)
			l.Position = UDim2.new(0, 10, 0, 10)
			l.BackgroundTransparency = 1
			l.Text = "Your key link:\n" .. KEY_LINK .. "\n\n(Copy it manually)"
			l.Font = Enum.Font.Gotham
			l.TextSize = 13
			l.TextColor3 = Color3.fromRGB(200, 200, 210)
			l.TextWrapped = true
			task.delay(5, function() s:Destroy() end)
		end
	end)
end)

-- Key Validation
local function shake()
	local base = card.Position
	local seq = { 10, -10, 8, -8, 6, -6, 4, -4, 2, -2 }
	for _, ox in ipairs(seq) do
		Tween(card, { Position = base + UDim2.new(0, ox, 0, 0) }, AN.ShakeDur, Enum.EasingStyle.Linear)
		task.wait(AN.ShakeDur)
	end
	Tween(card, { Position = base }, 0.06)
end

local function flashErr(s)
	Tween(s, { Color = IN.BorderError }, AN.FlashDur)
	task.delay(AN.FlashHold, function()
		Tween(s, { Color = IN.BorderColor }, 0.4)
	end)
end

btn.MouseButton1Click:Connect(function()
	local enteredKey = keyBox.Text
	if enteredKey == "" then
		task.spawn(shake)
		flashErr(keyStroke)
		return
	end

	local result = validateKeyOnline(enteredKey)
	if not result or not result.success then
		task.spawn(shake)
		flashErr(keyStroke)
		local msg = "✗ " .. (result and result.message or "Invalid Key")
		btn.Text = msg
		btn.TextColor3 = ST.LockTx
		Tween(btn, { BackgroundColor3 = ST.LockBg }, 0.2)
		Tween(btnStroke, { Color = ST.LockBd }, 0.2)
		task.delay(1.5, function()
			btn.Text = "→] Verify Key"
			btn.TextColor3 = BT.TextColor
			Tween(btn, { BackgroundColor3 = BT.BgColor }, 0.25)
			Tween(btnStroke, { Color = BT.BorderColor }, 0.25)
		end)
		return
	end

	-- Success
	btn.Text = "✓ Access Granted"
	btn.TextColor3 = ST.OkTx
	Tween(btn, { BackgroundColor3 = ST.OkBg }, 0.28)
	Tween(btnStroke, { Color = ST.OkBd }, 0.28)
	task.wait(AN.SuccessWait)

	-- Fade out everything
	local allObjects = {}
	for _, d in ipairs(card:GetDescendants()) do
		table.insert(allObjects, d)
	end
	table.insert(allObjects, card)
	table.insert(allObjects, cardStroke)
	table.insert(allObjects, window)
	table.insert(allObjects, winStroke)

	for _, obj in ipairs(allObjects) do
		if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
			Tween(obj, { TextTransparency = 1, BackgroundTransparency = 1 }, AN.FadeOutDur)
		elseif obj:IsA("ImageLabel") then
			Tween(obj, { ImageTransparency = 1, BackgroundTransparency = 1 }, AN.FadeOutDur)
		elseif obj:IsA("Frame") then
			Tween(obj, { BackgroundTransparency = 1 }, AN.FadeOutDur)
		elseif obj:IsA("UIStroke") then
			Tween(obj, { Transparency = 1 }, AN.FadeOutDur)
		end
	end

	if W.Shadow.Enabled and window:FindFirstChild("Shadow") then
		Tween(window.Shadow, { ImageTransparency = 1 }, AN.FadeOutDur)
	end

	task.wait(AN.FadeOutDur + 0.15)
	gui:Destroy()

	-- Load main UnAlive UI
	local UI_URL = "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/"
	print("[UnAlive] ✓ Key Verified — Loading UI...")

	local ok, mainUI = pcall(function()
		return loadstring(game:HttpGet(UI_URL .. "demo.lua"))()
	end)

	if ok then
		print("[UnAlive] ✓ Main UI loaded")
	else
		warn("[UnAlive] Failed to load main UI:", mainUI)
	end
end)

-- Drag System
local drag, dSt, dPos = false, nil, nil
local targetPos = window.Position
local dragConn

local dragTargets = { titleBar }
if DR.DragAnywhere then
	table.insert(dragTargets, card)
	table.insert(dragTargets, window)
end

local function startDrag(input)
	drag = true
	dSt = input.Position
	dPos = window.Position
	targetPos = dPos

	Tween(uiScale, { Scale = DR.ScaleDown }, DR.ScaleDur)
	if W.Shadow.Enabled and window:FindFirstChild("Shadow") then
		local darker = math.max(0, W.Shadow.Transparency - DR.ShadowDarken)
		Tween(window.Shadow, { ImageTransparency = darker }, DR.ScaleDur)
	end

	if dragConn then dragConn:Disconnect() end
	dragConn = RunService.Heartbeat:Connect(function()
		if not drag then
			dragConn:Disconnect()
			dragConn = nil
			return
		end
		window.Position = window.Position:Lerp(targetPos, DR.Smoothness)
	end)
end

for _, target in ipairs(dragTargets) do
	target.InputBegan:Connect(function(i, gp)
		if gp then return end
		if i.UserInputType == Enum.UserInputType.MouseButton1
			or i.UserInputType == Enum.UserInputType.Touch then
			startDrag(i)
		end
	end)
end

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
		if drag then
			drag = false
			Tween(uiScale, { Scale = 1 }, DR.ScaleDur, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			if W.Shadow.Enabled and window:FindFirstChild("Shadow") then
				Tween(window.Shadow, { ImageTransparency = W.Shadow.Transparency }, DR.ScaleDur)
			end
		end
	end
end)

-- Intro Animation
window.Size = UDim2.new(0, 0, 0, 0)
window.Position = UDim2.new(0.5, 0, 0.5, 0)
window.BackgroundTransparency = 1
winStroke.Transparency = 1
if W.Shadow.Enabled then window.Shadow.ImageTransparency = 1 end

Tween(window, {
	Size = UDim2.new(0, WIN_W, 0, WIN_H),
	Position = UDim2.new(0.5, -WIN_W / 2, 0.5, -WIN_H / 2),
	BackgroundTransparency = 0,
}, AN.Intro.WindowDur, AN.Intro.WindowEasing[1], AN.Intro.WindowEasing[2])

Tween(winStroke, { Transparency = 0 }, 0.5)
if W.Shadow.Enabled then
	Tween(window.Shadow, { ImageTransparency = W.Shadow.Transparency }, 0.6)
end

card.Position = UDim2.new(0, CARD_X, 0, CARD_Y + 25)
card.BackgroundTransparency = 1
cardStroke.Transparency = 1
if CD.Shadow.Enabled then card.Shadow.ImageTransparency = 1 end

task.delay(AN.Intro.CardDelay, function()
	Tween(card, {
		Position = UDim2.new(0, CARD_X, 0, CARD_Y),
		BackgroundTransparency = 0,
	}, AN.Intro.CardDur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	Tween(cardStroke, { Transparency = 0 }, AN.Intro.CardDur + 0.05)
	if CD.Shadow.Enabled then
		Tween(card.Shadow, { ImageTransparency = CD.Shadow.Transparency }, AN.Intro.CardDur + 0.1)
	end
end)

local staggerDelay = 0
for _, child in ipairs(card:GetDescendants()) do
	if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
		child.TextTransparency = 1
		task.delay(AN.Intro.CardDelay + 0.15 + staggerDelay, function()
			Tween(child, { TextTransparency = 0 }, 0.4)
		end)
		staggerDelay = staggerDelay + AN.Intro.TextStagger
	elseif child:IsA("ImageLabel") and child.Name ~= "Shadow" then
		child.ImageTransparency = 1
		task.delay(AN.Intro.CardDelay + 0.2 + staggerDelay, function()
			Tween(child, { ImageTransparency = 0 }, 0.4)
		end)
	end
end

print("[UnAlive] Key System loaded — waiting for input...")