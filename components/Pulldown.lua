--[[
	UnAliveUI — Pulldown Component
	
	Dropdown menu with scrolling item list and single selection.
	Only 1 item selected at a time. Dynamic scroll when 9+ items.
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}; props.Items = props.Items or {}; props.Label = props.Label or "Pulldown"
	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local darkText = Color3.fromRGB(220, 220, 220); local black = Color3.fromRGB(0, 0, 0)
	local selectedLabel = nil; local isOpen = false

	local pd = Instance.new("Frame")
	pd.Name = "Pulldown"; pd.Size = UDim2.fromOffset(100, 260)
	pd.BackgroundTransparency = 1; pd.BorderSizePixel = 0; pd.ZIndex = 50

	-- Button
	local btn = Instance.new("TextButton", pd)
	btn.Size = UDim2.fromOffset(100, 24); btn.Text = ""
	btn.BackgroundColor3 = Color3.fromRGB(30, 32, 38); btn.BorderSizePixel = 0
	btn.ZIndex = 51; btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local btnS = Instance.new("UIStroke", btn)
	btnS.Color = white; btnS.Transparency = 0.85; btnS.Thickness = 0.5
	local btnL = Instance.new("TextLabel", btn)
	btnL.Size = UDim2.fromOffset(56, 24); btnL.Position = UDim2.fromOffset(12, 0)
	btnL.BackgroundTransparency = 1; btnL.FontFace = Font.new("rbxassetid://12187365364")
	btnL.Text = props.Label; btnL.TextSize = 13; btnL.TextColor3 = white
	btnL.TextXAlignment = Enum.TextXAlignment.Left; btnL.TextYAlignment = Enum.TextYAlignment.Center
	local chev = Instance.new("ImageLabel", btn)
	chev.Size = UDim2.fromOffset(24, 24); chev.Position = UDim2.fromOffset(76, 0)
	chev.BackgroundTransparency = 1; chev.Image = "rbxassetid://84215348315149"; chev.ImageColor3 = white; chev.Name = "Chevron"

	-- Menu
	local menu = Instance.new("Frame", pd)
	menu.Size = UDim2.fromOffset(95, 0); menu.Position = UDim2.fromOffset(0, 28)
	menu.BackgroundColor3 = dark; menu.BackgroundTransparency = 0.08
	menu.BorderSizePixel = 0; menu.Visible = false; menu.ClipsDescendants = true; menu.ZIndex = 51
	Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 13)
	local mS = Instance.new("UIStroke", menu)
	mS.Color = white; mS.Transparency = 0.88; mS.Thickness = 0.5
	local glass = Instance.new("Frame", menu)
	glass.Size = UDim2.fromScale(1, 1); glass.BackgroundColor3 = dark; glass.BackgroundTransparency = 0.85
	glass.BorderSizePixel = 0; glass.ZIndex = 51
	Instance.new("UICorner", glass).CornerRadius = UDim.new(0, 13)

	-- Scroller
	local scroller = Instance.new("ScrollingFrame", menu)
	scroller.Size = UDim2.new(1, -4, 1, 0); scroller.Position = UDim2.fromOffset(2, 0)
	scroller.BackgroundTransparency = 1; scroller.BorderSizePixel = 0; scroller.ZIndex = 52
	scroller.ScrollBarThickness = 4; scroller.ScrollBarImageColor3 = Color3.fromRGB(160, 160, 160)
	scroller.ScrollBarImageTransparency = 0.2
	scroller.TopImage = "rbxasset://textures/ui/ScrollBar/top.png"
	scroller.MidImage = "rbxasset://textures/ui/ScrollBar/mid.png"
	scroller.BottomImage = "rbxasset://textures/ui/ScrollBar/bottom.png"
	scroller.ScrollingDirection = Enum.ScrollingDirection.Y
	scroller.ElasticBehavior = Enum.ElasticBehavior.Never; scroller.ClipsDescendants = true

	local layout = Instance.new("UIListLayout", scroller)
	layout.Padding = UDim.new(0, 0); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Instance.new("UIPadding", scroller).PaddingTop = UDim.new(0, 5)

	local function updateCanvas()
		scroller.CanvasSize = UDim2.fromOffset(0, math.max(layout.AbsoluteContentSize.Y + 10, scroller.AbsoluteSize.Y + 10))
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

	-- Add single item
	local function addItem(name, selectIt)
		local item = Instance.new("TextButton", scroller)
		item.Size = UDim2.fromOffset(71, 24); item.Text = ""; item.AutoButtonColor = false
		item.BackgroundTransparency = 1; item.BorderSizePixel = 0; item.ZIndex = 53

		local selBg = Instance.new("Frame", item); selBg.Name = "SelBg"
		selBg.Size = UDim2.fromOffset(85, 24); selBg.Position = UDim2.fromOffset(-7, 0)
		selBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255); selBg.BackgroundTransparency = selectIt and 0.1 or 1
		selBg.BorderSizePixel = 0; selBg.ZIndex = 53
		Instance.new("UICorner", selBg).CornerRadius = UDim.new(0, 8)

		local label = Instance.new("TextLabel", item)
		label.Size = UDim2.fromOffset(71, 24); label.BackgroundTransparency = 1; label.BorderSizePixel = 0; label.ZIndex = 54
		label.Font = Enum.Font.SourceSans; label.Text = name; label.TextSize = 13
		label.TextColor3 = selectIt and black or darkText
		label.TextXAlignment = Enum.TextXAlignment.Left; label.TextYAlignment = Enum.TextYAlignment.Center

		if selectIt then selectedLabel = label end

		item.MouseButton1Click:Connect(function()
			if selectedLabel == label then return end
			if selectedLabel then
				selectedLabel.TextColor3 = darkText
				local bg = selectedLabel.Parent:FindFirstChild("SelBg")
				if bg then bg.BackgroundTransparency = 1 end
			end
			label.TextColor3 = black; selBg.BackgroundTransparency = 0.1; selectedLabel = label
			if props.OnSelected then task.spawn(props.OnSelected, name) end
		end)
		updateCanvas(); return item
	end

	-- Populate items
	for _, data in ipairs(props.Items) do
		local name = type(data) == "string" and data or data.Label
		addItem(name, type(data) == "table" and data.Selected or false)
	end
	updateCanvas()

	-- Toggle menu
	local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	btn.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then menu.Size = UDim2.fromOffset(95, 0); menu.Visible = true
			TS:Create(menu, ti, { Size = UDim2.fromOffset(95, 226) }):Play()
			TS:Create(chev, ti, { Rotation = 180 }):Play()
		else local t = TS:Create(menu, ti, { Size = UDim2.fromOffset(95, 0) })
			t.Completed:Connect(function() menu.Visible = false end); t:Play()
			TS:Create(chev, ti, { Rotation = 0 }):Play() end
	end)

	local obj = { Type = "Pulldown", __instance = pd }
	function obj:Parent(p) pd.Parent = p end
	function obj:AddItem(name, sel) addItem(name, sel) end
	return obj
end