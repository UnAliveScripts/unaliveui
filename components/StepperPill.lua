return function(self, props)
	props = props or {}
	props.Value = props.Value or 0
	props.Step = props.Step or 1

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local sp = Instance.new("Frame")
	sp.Name = "StepperPill"; sp.Size = UDim2.fromOffset(92, 32)
	sp.BackgroundColor3 = dark; sp.BackgroundTransparency = 0.08
	sp.ClipsDescendants = true; sp.BorderSizePixel = 0; sp.ZIndex = 50
	Instance.new("UICorner", sp).CornerRadius = UDim.new(0, 16)
	local sps = Instance.new("UIStroke", sp); sps.Color = white; sps.Transparency = 0.92; sps.Thickness = 0.5

	local dec = Instance.new("ImageButton", sp)
	dec.Size = UDim2.fromOffset(46, 32); dec.Position = UDim2.fromOffset(0, 0)
	dec.BackgroundTransparency = 1; dec.BorderSizePixel = 0; dec.ZIndex = 2
	local dci = Instance.new("ImageLabel", dec)
	dci.Size = UDim2.fromOffset(22, 22); dci.Position = UDim2.fromOffset(12, 5)
	dci.BackgroundTransparency = 1; dci.Image = "rbxassetid://110147285593118"; dci.ImageColor3 = white

	local inc = Instance.new("ImageButton", sp)
	inc.Size = UDim2.fromOffset(46, 32); inc.Position = UDim2.fromOffset(46, 0)
	inc.BackgroundTransparency = 1; inc.BorderSizePixel = 0; inc.ZIndex = 2
	local ici = Instance.new("ImageLabel", inc)
	ici.Size = UDim2.fromOffset(22, 22); ici.Position = UDim2.fromOffset(12, 5)
	ici.BackgroundTransparency = 1; ici.Image = "rbxassetid://126761302820331"; ici.ImageColor3 = white

	local sep = Instance.new("Frame", sp)
	sep.Size = UDim2.fromOffset(1, 24); sep.Position = UDim2.fromOffset(45.5, 4)
	sep.BackgroundColor3 = Color3.fromRGB(235, 235, 245); sep.BackgroundTransparency = 0.7
	sep.BorderSizePixel = 0
	Instance.new("UICorner", sep).CornerRadius = UDim.new(0, 8)

	dec.MouseButton1Click:Connect(function()
		props.Value = props.Value - props.Step
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)
	inc.MouseButton1Click:Connect(function()
		props.Value = props.Value + props.Step
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "StepperPill", __instance = sp }
	function obj.Parent(p) sp.Parent = p end
	function obj:SetValue(v) props.Value = v end
	function obj:GetValue() return props.Value end
	return obj
end