--[[
	UnAliveUI — EditMenu Component
	Horizontal edit menu with single-selection items.
--]]
local TS = game:GetService("TweenService"); local C = _G.__unaliveui_creator.Create; local blur = _G.__unaliveui_blur
return function(self, props)
	props = props or {}; props.Items = props.Items or {}
	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local normalColor = Color3.fromRGB(245, 245, 245); local selectedColor = Color3.fromRGB(255, 66, 84)
	local selectedLabel = nil; local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local body = C("Frame")({ Name = "EditMenu", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(488, 44),
		C("Frame")({ Name = "FillShadow", Size = UDim2.new(1, 4, 1, 4), Position = UDim2.fromOffset(-2, -2), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.82, BorderSizePixel = 0, ZIndex = -1, C("UICorner")({ CornerRadius = UDim.new(0, 34) }) }),
		C("Frame")({ Name = "Glass", Size = UDim2.fromScale(1, 1), BackgroundColor3 = dark, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 1, C("UICorner")({ CornerRadius = UDim.new(0, 34) }), C("UIStroke")({ Color = white, Transparency = 0.88, Thickness = 1 }) }),
		C("Frame")({ Name = "BlurPane", Size = UDim2.new(1, -34, 1, -34), Position = UDim2.fromOffset(17, 17), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 0 }),
		C("Frame")({ Name = "Content", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 3,
			C("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 0) }),
			C("UIPadding")({ PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 4) }) }),
	})
	local content = body.__instance:FindFirstChild("Content"); local blurPane = body.__instance:FindFirstChild("BlurPane")
	if blur and blurPane then task.spawn(function() blur(blurPane) end) end
	for i, item in ipairs(props.Items) do
		if i > 1 then local sep = Instance.new("Frame"); sep.Size = UDim2.fromOffset(1, 18); sep.BackgroundColor3 = white; sep.BackgroundTransparency = 0.8; sep.BorderSizePixel = 0; sep.ZIndex = 3; sep.Parent = content end
		local a = Instance.new("Frame"); a.Size = UDim2.fromOffset(item.Width or 70, 18); a.BackgroundTransparency = 1; a.BorderSizePixel = 0; a.Parent = content
		local label = Instance.new("TextLabel"); label.Size = UDim2.fromOffset(item.TextWidth or a.Size.X.Offset, 18); label.Position = UDim2.fromOffset(item.SeparatorOffset or 0, 0)
		label.BackgroundTransparency = 1; label.FontFace = Font.new("rbxassetid://12187365364"); label.Text = item.Label; label.TextSize = 15
		label.TextColor3 = i == 1 and selectedColor or normalColor; label.TextXAlignment = Enum.TextXAlignment.Left; label.TextYAlignment = Enum.TextYAlignment.Center; label.ZIndex = 3; label.Parent = a
		if i == 1 then selectedLabel = label end
		local hitbox = Instance.new("TextButton"); hitbox.Size = UDim2.fromScale(1, 1); hitbox.BackgroundTransparency = 1; hitbox.BorderSizePixel = 0; hitbox.Text = ""; hitbox.ZIndex = 10; hitbox.AutoButtonColor = false; hitbox.Parent = a
		hitbox.MouseButton1Click:Connect(function() if selectedLabel == label then return end; if selectedLabel then TS:Create(selectedLabel, tweenInfo, { TextColor3 = normalColor }):Play() end; TS:Create(label, tweenInfo, { TextColor3 = selectedColor }):Play(); selectedLabel = label; if props.OnSelected then props.OnSelected(item, i) end end)
	end
	local ind = Instance.new("Frame"); ind.Size = UDim2.fromOffset(36, 36); ind.BackgroundColor3 = Color3.fromRGB(12, 12, 14); ind.BackgroundTransparency = 0; ind.Parent = content; Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)
	local ii = Instance.new("ImageLabel"); ii.Size = UDim2.fromOffset(18, 18); ii.Position = UDim2.fromOffset(9, 9); ii.BackgroundTransparency = 1; ii.Image = "rbxassetid://103603118195781"; ii.ImageColor3 = white; ii.ScaleType = Enum.ScaleType.Fit; ii.ZIndex = 3; ii.Parent = ind
	local obj = { Type = "EditMenu", __instance = body.__instance }; function obj.Parent(p) body.Parent = p end; return obj
end