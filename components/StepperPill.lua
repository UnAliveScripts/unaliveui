--[[
	UnAliveUI — StepperPill Component
	
	Pill-style stepper with −/+ icons. Dark Alert theme.
	
	Usage:
		local sp = UI:New("StepperPill")
		sp:Parent(gui)
--]]

local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Value = props.Value or 0; props.Step = props.Step or 1
	props.Minimum = props.Minimum or -math.huge; props.Maximum = props.Maximum or math.huge

	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)

	local c = C("Frame")({
		Name = "StepperPill", Size = UDim2.fromOffset(92, 32),
		BackgroundColor3 = dark, BackgroundTransparency = 0.08,
		BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 50,
		C("UICorner")({ CornerRadius = UDim.new(0, 16) }),
		C("UIStroke")({ Color = white, Transparency = 0.92, Thickness = 0.5 }),
		C("ImageButton")({ Name = "Decrement", Size = UDim2.fromOffset(46, 32), Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
			C("ImageLabel")({ Name = "Icon", Size = UDim2.fromOffset(22, 22), Position = UDim2.fromOffset(12, 5),
				BackgroundTransparency = 1, Image = "rbxassetid://110147285593118", ImageColor3 = white }) }),
		C("ImageButton")({ Name = "Increment", Size = UDim2.fromOffset(46, 32), Position = UDim2.fromOffset(46, 0),
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
			C("ImageLabel")({ Name = "Icon", Size = UDim2.fromOffset(22, 22), Position = UDim2.fromOffset(12, 5),
				BackgroundTransparency = 1, Image = "rbxassetid://126761302820331", ImageColor3 = white }) }),
		C("Frame")({ Name = "Separator", Size = UDim2.fromOffset(1, 24), Position = UDim2.fromOffset(45.5, 4),
			BackgroundColor3 = Color3.fromRGB(235, 235, 245), BackgroundTransparency = 0.7, BorderSizePixel = 0,
			C("UICorner")({ CornerRadius = UDim.new(0, 8) }) }),
	})

	local inst = c.__instance
	local dec = inst:FindFirstChild("Decrement")
	local inc = inst:FindFirstChild("Increment")

	dec.MouseButton1Click:Connect(function()
		props.Value = math.max(props.Value - props.Step, props.Minimum)
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)
	inc.MouseButton1Click:Connect(function()
		props.Value = math.min(props.Value + props.Step, props.Maximum)
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "StepperPill", __instance = inst }
	function obj:Parent(p) c.Parent = p end
	function obj:SetValue(v) props.Value = v end
	function obj:GetValue() return props.Value end
	return obj
end