--[[
	UnAliveUI — Main Window UI
	
	Dark Alert theme window with EditMenu, search bar, and content pages.
	
	Usage:
		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"
		))()
--]]

local TS = game:GetService("TweenService")
local dark = Color3.fromRGB(18, 20, 26)
local white = Color3.fromRGB(255, 255, 255)
local normalColor = Color3.fromRGB(245, 245, 245)
local selectedColor = Color3.fromRGB(255, 66, 84)

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local existing = playerGui:FindFirstChild("UnAliveUI")
if existing then existing:Destroy() end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "UnAliveUI"; gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true
gui.DisplayOrder = 999; gui.Parent = playerGui

-- Window
local win = Instance.new("Frame", gui); win.Name = "Window"
win.Size = UDim2.fromOffset(540, 400)
win.Position = UDim2.new(0.5, -270, 0.5, -200)
win.BackgroundColor3 = dark; win.BackgroundTransparency = 0.08
win.BorderSizePixel = 0; win.ZIndex = 2; win.ClipsDescendants = false
Instance.new("UICorner", win).CornerRadius = UDim.new(0, 16)
local winStroke = Instance.new("UIStroke", win)
winStroke.Color = white; winStroke.Transparency = 0.88; winStroke.Thickness = 1

-- Window shadow
local winShadow = Instance.new("Frame", win); winShadow.Name = "Shadow"
winShadow.Size = UDim2.new(1, 6, 1, 6); winShadow.Position = UDim2.new(0, -3, 0, -3)
winShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0); winShadow.BackgroundTransparency = 0.65
winShadow.BorderSizePixel = 0; winShadow.ZIndex = 1
Instance.new("UICorner", winShadow).CornerRadius = UDim.new(0, 16)

-- Card
local card = Instance.new("Frame", win); card.Name = "Card"
card.Size = UDim2.fromOffset(496, 330); card.Position = UDim2.fromOffset(22, 52)
card.BackgroundColor3 = Color3.fromRGB(20, 20, 24); card.BorderSizePixel = 0; card.ZIndex = 5
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(38, 38, 46); cardStroke.Thickness = 1; cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Card shadow
local cardShadow = Instance.new("ImageLabel", card); cardShadow.Name = "Shadow"
cardShadow.Size = UDim2.new(1, 30, 1, 30); cardShadow.Position = UDim2.new(0, -15, 0, -15)
cardShadow.BackgroundTransparency = 1; cardShadow.Image = "rbxassetid://6015897843"
cardShadow.ImageColor3 = Color3.fromRGB(0, 0, 0); cardShadow.ImageTransparency = 0.7
cardShadow.ScaleType = Enum.ScaleType.Slice; cardShadow.SliceCenter = Rect.new(49, 49, 50, 50)
cardShadow.ZIndex = 4

-- Search bar (top-right)
local sf = Instance.new("Frame", card); sf.Name = "SearchField"
sf.Size = UDim2.fromOffset(122, 26); sf.Position = UDim2.fromOffset(365, 10)
sf.BackgroundColor3 = dark; sf.BackgroundTransparency = 0.08
sf.BorderSizePixel = 0; sf.ZIndex = 20; sf.ClipsDescendants = true
Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 13)
local sfBorder = Instance.new("UIStroke", sf)
sfBorder.Color = white; sfBorder.Transparency = 0.92; sfBorder.Thickness = 0.5
local sfIcon = Instance.new("ImageLabel", sf); sfIcon.Size = UDim2.fromOffset(16,16); sfIcon.Position = UDim2.fromOffset(8,5)
sfIcon.BackgroundTransparency = 1; sfIcon.Image = "rbxassetid://117204739779559"; sfIcon.ImageColor3 = Color3.fromRGB(200,200,200); sfIcon.ScaleType = Enum.ScaleType.Fit; sfIcon.ZIndex = 21
local sfPH = Instance.new("TextLabel", sf); sfPH.Name = "Placeholder"
sfPH.Size = UDim2.fromOffset(74,16); sfPH.Position = UDim2.fromOffset(26,5)
sfPH.BackgroundTransparency = 1; sfPH.FontFace = Font.new("rbxassetid://12187365364"); sfPH.Text = "Search"; sfPH.TextSize = 13
sfPH.TextColor3 = Color3.fromRGB(245,245,245); sfPH.TextXAlignment = Enum.TextXAlignment.Left; sfPH.TextYAlignment = Enum.TextYAlignment.Center; sfPH.ZIndex = 21
local sfBox = Instance.new("TextBox", sf); sfBox.Name = "Input"
sfBox.Size = UDim2.fromOffset(74,16); sfBox.Position = UDim2.fromOffset(26,5)
sfBox.BackgroundTransparency = 1; sfBox.FontFace = Font.new("rbxassetid://12187365364"); sfBox.Text = ""; sfBox.TextSize = 13
sfBox.TextColor3 = Color3.fromRGB(245,245,245); sfBox.TextXAlignment = Enum.TextXAlignment.Left; sfBox.TextYAlignment = Enum.TextYAlignment.Center; sfBox.ClearTextOnFocus = false; sfBox.ZIndex = 22
local sfClear = Instance.new("ImageButton", sf); sfClear.Name = "Clear"
sfClear.Size = UDim2.fromOffset(16,16); sfClear.Position = UDim2.fromOffset(100,5)
sfClear.BackgroundTransparency = 1; sfClear.AutoButtonColor = false; sfClear.Image = "rbxassetid://78668603799563"
sfClear.ImageColor3 = Color3.fromRGB(138,138,138); sfClear.ScaleType = Enum.ScaleType.Fit; sfClear.ZIndex = 22; sfClear.Visible = false
local function syncPH() sfPH.Visible = (sfBox.Text == ""); sfClear.Visible = (sfBox.Text ~= "") end
sfBox:GetPropertyChangedSignal("Text"):Connect(syncPH)
sfBox.Focused:Connect(function() sfPH.Visible = false; TS:Create(sfBorder, TweenInfo.new(0.2), {Color = Color3.fromRGB(200,200,200), Transparency = 0.5}):Play() end)
sfBox.FocusLost:Connect(function() syncPH(); TS:Create(sfBorder, TweenInfo.new(0.2), {Color = white, Transparency = 0.92}):Play() end)
sfClear.MouseButton1Click:Connect(function() sfBox.Text = ""; sfBox:CaptureFocus() end)
syncPH()

-- Pages container
local pages = Instance.new("Frame", card); pages.Name = "Pages"
pages.Size = UDim2.fromOffset(496, 200); pages.Position = UDim2.fromOffset(0, 50)
pages.BackgroundTransparency = 1; pages.BorderSizePixel = 0; pages.ZIndex = 20

local pageData = {
	{title="Farm", desc="Manage your farm resources and crops"},
	{title="Shop", desc="Browse items available for purchase"},
	{title="Steal", desc="Steal resources from other players"},
	{title="Spawn", desc="Spawn vehicles, items, and more"},
	{title="Config", desc="Configure your settings and preferences"},
	{title="Settings", desc="Adjust your application settings and preferences"},
}

for pi, pd in ipairs(pageData) do
	local pg = Instance.new("Frame", pages); pg.Name = "Page"..pi
	pg.Size = UDim2.fromScale(1,1); pg.BackgroundTransparency = 1; pg.BorderSizePixel = 0; pg.ZIndex = 20
	pg.Visible = pi == 1
	local lbl = Instance.new("TextLabel", pg); lbl.Size = UDim2.fromOffset(200,30); lbl.Position = UDim2.fromOffset(20,40)
	lbl.BackgroundTransparency = 1; lbl.FontFace = Font.new("rbxassetid://12187365364"); lbl.Text = pd.title; lbl.TextSize = 24
	lbl.TextColor3 = Color3.fromRGB(255,255,255); lbl.TextXAlignment = Enum.TextXAlignment.Left
	local desc = Instance.new("TextLabel", pg); desc.Size = UDim2.fromOffset(400,20); desc.Position = UDim2.fromOffset(20,80)
	desc.BackgroundTransparency = 1; desc.FontFace = Font.new("rbxassetid://12187365364"); desc.Text = pd.desc; desc.TextSize = 14
	desc.TextColor3 = Color3.fromRGB(180,180,190); desc.TextXAlignment = Enum.TextXAlignment.Left
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

-- EditMenu items with animated selection
local items = {{"Farm",50,34,false},{"Shop",68,35,true},{"Steal",67,34,true},{"Spawn",78,45,true},{"Config",77,44,true},{"Settings",88,55,true}}
local selectedLabel = nil

for ei, ed in ipairs(items) do
	local text, w, tw, hasSep = table.unpack(ed)
	local a = Instance.new("Frame", emContent); a.Size = UDim2.fromOffset(w,18); a.BackgroundTransparency = 1; a.BorderSizePixel = 0
	if hasSep then
		local s = Instance.new("Frame", a); s.Size = UDim2.fromOffset(1,18); s.Position = UDim2.fromOffset(0,0)
		s.BackgroundColor3 = white; s.BackgroundTransparency = 0.8; s.BorderSizePixel = 0
	end
	local lb = Instance.new("TextLabel", a)
	lb.Size = UDim2.fromOffset(tw,18); lb.Position = UDim2.fromOffset(hasSep and 17 or 0,0)
	lb.BackgroundTransparency = 1; lb.FontFace = Font.new("rbxassetid://12187365364"); lb.Text = text; lb.TextSize = 15
	lb.TextColor3 = ei == 1 and selectedColor or normalColor
	lb.TextXAlignment = Enum.TextXAlignment.Left; lb.TextYAlignment = Enum.TextYAlignment.Center
	if ei == 1 then selectedLabel = lb end
	local hb = Instance.new("TextButton", a); hb.Size = UDim2.fromScale(1,1)
	hb.BackgroundTransparency = 1; hb.BorderSizePixel = 0; hb.Text = ""; hb.ZIndex = 22; hb.AutoButtonColor = false
	hb.MouseButton1Click:Connect(function()
		if selectedLabel == lb then return end
		-- Fade out old
		if selectedLabel then
			TS:Create(selectedLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				TextColor3 = normalColor, TextTransparency = 0.3,
			}):Play()
			task.delay(0.15, function()
				if selectedLabel then TS:Create(selectedLabel, TweenInfo.new(0.1), { TextTransparency = 0 }):Play() end
			end)
		end
		-- Fade in new
		lb.TextColor3 = selectedColor; lb.TextTransparency = 0.3
		TS:Create(lb, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextColor3 = selectedColor, TextTransparency = 0,
		}):Play()
		selectedLabel = lb
		-- Switch page
		for _, p in pairs(pages:GetChildren()) do if p:IsA("Frame") then p.Visible = false end end
		local target = pages:FindFirstChild("Page"..ei)
		if target then target.Visible = true end
	end)
end

-- Indicator
local ind = Instance.new("Frame", emContent); ind.Size = UDim2.fromOffset(36,36)
ind.BackgroundColor3 = Color3.fromRGB(3,3,3); ind.BackgroundTransparency = 0
Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
local ii = Instance.new("ImageLabel", ind); ii.Size = UDim2.fromOffset(24,24); ii.Position = UDim2.fromOffset(6,6)
ii.BackgroundTransparency = 1; ii.Image = "rbxassetid://103603118195781"; ii.ImageColor3 = white; ii.ScaleType = Enum.ScaleType.Fit; ii.ZIndex = 22

print("=== UnAliveUI Main Window ===")