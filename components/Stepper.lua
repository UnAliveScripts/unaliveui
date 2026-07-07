local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}
	props.Minimum = props.Minimum or 0
	props.Maximum = props.Maximum or 100
	props.Step = props.Step or 1
	props.Value = props.Value or 0

	local c = C("Frame")({
		Name = "Stepper",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.fromOffset(0, 23),
	})

	local dn = C("ImageButton")({
		Name = "Down",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(44, 44, 50),
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.fromOffset(22, 23),
		Image = icons["chevron-down"] or "rbxassetid://84215348315149",
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ImageTransparency = 0.3,
		Parent = c.__instance,

		C("UICorner")({ CornerRadius = UDim.new(0, 6) }),
	})

	local v = C("TextLabel")({
		Name = "Value",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364"),
		Text = tostring(props.Value),
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Position = UDim2.fromOffset(22, 0),
		Size = UDim2.fromOffset(36, 23),
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = c.__instance,
	})

	local up = C("ImageButton")({
		Name = "Up",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(44, 44, 50),
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(58, 0),
		Size = UDim2.fromOffset(22, 23),
		Image = icons["chevron-up"] or "rbxassetid://137296891812002",
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ImageTransparency = 0.3,
		Parent = c.__instance,

		C("UICorner")({ CornerRadius = UDim.new(0, 6) }),
	})

	local function ud()
		v.Text = tostring(props.Value)
	end

	up.MouseButton1Down:Connect(function()
		TS:Create(up.__instance, TweenInfo.new(0.08), { ImageTransparency = 0 }):Play()
	end)

	up.MouseButton1Up:Connect(function()
		TS:Create(up.__instance, TweenInfo.new(0.12), { ImageTransparency = 0.3 }):Play()
	end)

	up.MouseButton1Click:Connect(function()
		props.Value = math.min(props.Value + props.Step, props.Maximum)
		ud()

		if props.ValueChanged then
			task.spawn(props.ValueChanged, obj, props.Value)
		end
	end)

	dn.MouseButton1Down:Connect(function()
		TS:Create(dn.__instance, TweenInfo.new(0.08), { ImageTransparency = 0 }):Play()
	end)

	dn.MouseButton1Up:Connect(function()
		TS:Create(dn.__instance, TweenInfo.new(0.12), { ImageTransparency = 0.3 }):Play()
	end)

	dn.MouseButton1Click:Connect(function()
		props.Value = math.max(props.Value - props.Step, props.Minimum)
		ud()

		if props.ValueChanged then
			task.spawn(props.ValueChanged, obj, props.Value)
		end
	end)

	local obj = { Type = "Stepper", __instance = c.__instance }

	function obj.Parent(p) c.Parent = p end
	function obj:SetValue(v) props.Value = v; ud() end

	return obj
end