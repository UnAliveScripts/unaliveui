local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}
	props.Items = props.Items or {}

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)
	local normalColor = Color3.fromRGB(245, 245, 245)
	local selectedColor = Color3.fromRGB(255, 66, 84)
	local selectedLabel = nil
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local blur = _G.__unaliveui_blur

	local em = Instance.new("Frame")
	em.Name = "EditMenu"; em.Size = UDim2.fromOffset(488, 44)
	em.BackgroundTransparency = 1; em.ZIndex = 20
	Instance.new("UICorner", em).CornerRadius = UDim.new(0, 34)

	local fs = Instance.new("Frame", em)
	fs.Size = UDim2.new(1, 4, 1, 4); fs.Position = UDim2.fromOffset(-2, -2)
	fs.BackgroundColor3 = Color3.fromRGB(0, 0, 0); fs.BackgroundTransparency = 0.82
	fs.BorderSizePixel = 0; fs.ZIndex = -1
	Instance.new("UICorner", fs).CornerRadius = UDim.new(0, 34)

	local g = Instance.new("Frame", em)
	g.Size = UDim2.fromScale(1, 1)
	g.BackgroundColor3 = dark; g.BackgroundTransparency = 0.08
	g.BorderSizePixel = 0; g.ZIndex = 1
	Instance.new("UICorner", g).CornerRadius = UDim.new(0, 34)
	local gs = Instance.new("UIStroke", g); gs.Color = white; gs.Transparency = 0.88; gs.Thickness = 1

	local bp = Instance.new("Frame", em)
	bp.Size = UDim2.new(1, -34, 1, -34); bp.Position = UDim2.fromOffset(17, 17)
	bp.BackgroundTransparency = 1; bp.BorderSizePixel = 0; bp.ZIndex = 0
	if blur then blur(bp) end

	local ct = Instance.new("Frame", em)
	ct.Size = UDim2.fromScale(1, 1); ct.BackgroundTransparency = 1
	ct.BorderSizePixel = 0; ct.ZIndex = 3
	local lay = Instance.new("UIListLayout", ct)
	lay.FillDirection = Enum.FillDirection.Horizontal; lay.VerticalAlignment = Enum.VerticalAlignment.Center
	lay.Padding = UDim.new(0, 0)
	Instance.new("UIPadding", ct).PaddingLeft = UDim.new(0, 20)
	Instance.new("UIPadding", ct).PaddingRight = UDim.new(0, 4)

	for i, item in ipairs(props.Items) do
		if i > 1 then
			local s = Instance.new("Frame", ct)
			s.Size = UDim2.fromOffset(1, 18)
			s.BackgroundColor3 = white; s.BackgroundTransparency = 0.8; s.BorderSizePixel = 0
		end

		local a = Instance.new("Frame", ct)
		a.Size = UDim2.fromOffset(item.Width or 70, 18)
		a.BackgroundTransparency = 1; a.BorderSizePixel = 0

		local label = Instance.new("TextLabel", a)
		label.Size = UDim2.fromOffset(item.TextWidth or a.Size.X.Offset, 18)
		label.Position = UDim2.fromOffset(item.SeparatorOffset or 0, 0)
		label.BackgroundTransparency = 1; label.FontFace = Font.new("rbxassetid://12187365364")
		label.Text = item.Label; label.TextSize = 15
		label.TextColor3 = i == 1 and selectedColor or normalColor
		label.TextXAlignment = Enum.TextXAlignment.Left; label.TextYAlignment = Enum.TextYAlignment.Center
		label.ZIndex = 3

		if i == 1 then selectedLabel = label end

		local hitbox = Instance.new("TextButton", a)
		hitbox.Size = UDim2.fromScale(1, 1); hitbox.BackgroundTransparency = 1
		hitbox.BorderSizePixel = 0; hitbox.Text = ""; hitbox.ZIndex = 10; hitbox.AutoButtonColor = false

		hitbox.MouseButton1Click:Connect(function()
			if selectedLabel == label then return end
			if selectedLabel then TS:Create(selectedLabel, tweenInfo, { TextColor3 = normalColor }):Play() end
			TS:Create(label, tweenInfo, { TextColor3 = selectedColor }):Play()
			selectedLabel = label
			if props.OnSelected then props.OnSelected(item, i) end
		end)
	end

	local ind = Instance.new("Frame", ct)
	ind.Size = UDim2.fromOffset(36, 36)
	ind.BackgroundColor3 = dark; ind.BackgroundTransparency = 0.08
	Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
	local ii = Instance.new("ImageLabel", ind)
	ii.Size = UDim2.fromOffset(18, 18); ii.Position = UDim2.fromOffset(9, 9)
	ii.BackgroundTransparency = 1; ii.Image = "rbxassetid://103603118195781"
	ii.ImageColor3 = white; ii.ScaleType = Enum.ScaleType.Fit; ii.ZIndex = 3

	local obj = { Type = "EditMenu", __instance = em }
	function obj.Parent(p) em.Parent = p end
	return obj
end