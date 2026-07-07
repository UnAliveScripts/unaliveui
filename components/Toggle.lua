--[[
	UnAliveUI — Toggle Component
	
	Figma 1:1 toggle switch with ON/OFF side indicators.
	62×26 pill, green/gray, knob slides, indicators on opposite sides.
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}; props.Value = props.Value == true

	local tg = Instance.new("Frame")
	tg.Name = "Toggle"; tg.Size = UDim2.fromOffset(62, 26)
	tg.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
	tg.BorderSizePixel = 0; tg.ZIndex = 50; tg.ClipsDescendants = true
	Instance.new("UICorner", tg).CornerRadius = UDim.new(0, 13)

	-- Knob 39×24
	local knob = Instance.new("Frame", tg); knob.Name = "Knob"
	knob.Size = UDim2.fromOffset(39, 24); knob.Position = UDim2.fromOffset(21, 1)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.ZIndex = 2
	Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 12)

	-- ON indicator: left side, 19×10 at (2, 8), vertical line icon
	local onInd = Instance.new("Frame", tg); onInd.Name = "OnIndicator"
	onInd.Size = UDim2.fromOffset(19, 10); onInd.Position = UDim2.fromOffset(2, 8)
	onInd.BackgroundTransparency = 1; onInd.BorderSizePixel = 0
	local onLine = Instance.new("Frame", onInd); onLine.Name = "Icon"
	onLine.Size = UDim2.fromOffset(1, 10); onLine.Position = UDim2.fromOffset(9, 0)
	onLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255); onLine.BorderSizePixel = 0

	-- OFF indicator: right side, 21×10 at (41, 9), circle icon
	local offInd = Instance.new("Frame", tg); offInd.Name = "OffIndicator"
	offInd.Size = UDim2.fromOffset(21, 10); offInd.Position = UDim2.fromOffset(41, 9)
	offInd.BackgroundTransparency = 1; offInd.BorderSizePixel = 0; offInd.Visible = false
	local offIcon = Instance.new("ImageLabel", offInd); offIcon.Name = "Icon"
	offIcon.Size = UDim2.fromOffset(10, 10); offIcon.Position = UDim2.fromOffset(5.5, 0)
	offIcon.BackgroundTransparency = 1; offIcon.BorderSizePixel = 0
	offIcon.Image = "rbxassetid://76608440057656"
	offIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	offIcon.ScaleType = Enum.ScaleType.Fit

	-- Hitbox
	local hitbox = Instance.new("TextButton", tg)
	hitbox.Size = UDim2.fromScale(1, 1); hitbox.BackgroundTransparency = 1
	hitbox.BorderSizePixel = 0; hitbox.Text = ""; hitbox.ZIndex = 10; hitbox.AutoButtonColor = false

	local function update(v, instant)
		local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		if instant then
			knob.Position = v and UDim2.fromOffset(21, 1) or UDim2.fromOffset(2, 1)
			tg.BackgroundColor3 = v and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(60, 60, 67)
			tg.BackgroundTransparency = v and 0 or 0.3
			onInd.Visible = v; offInd.Visible = not v; return
		end
		TS:Create(knob, ti, { Position = v and UDim2.fromOffset(21, 1) or UDim2.fromOffset(2, 1) }):Play()
		TS:Create(tg, ti, { BackgroundColor3 = v and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(60, 60, 67), BackgroundTransparency = v and 0 or 0.3 }):Play()
		onInd.Visible = v; offInd.Visible = not v
	end
	update(props.Value, true)

	hitbox.MouseButton1Click:Connect(function()
		props.Value = not props.Value; update(props.Value)
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "Toggle", __instance = tg }
	function obj:Parent(p) tg.Parent = p end
	function obj:SetValue(v) props.Value = v; update(v) end
	return obj
end