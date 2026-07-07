--[[
	UnAliveUI — Stepper Component
	
	Numeric stepper with up/down arrows. Dark Alert theme (#12141a).
	
	Usage:
		local st = UI:New("Stepper", { Value = 5000, Step = 500 })
		st:Parent(gui)
--]]

local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Minimum = props.Minimum or 0
	props.Maximum = props.Maximum or 99999
	props.Step = props.Step or 500
	props.Value = props.Value or 5000

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local c = C("Frame")({
		Name = "Stepper", Size = UDim2.fromOffset(100, 24),
		BackgroundColor3 = dark, BackgroundTransparency = 0.08,
		BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 50,
		C("UICorner")({ CornerRadius = UDim.new(0, 6) }),
		C("UIStroke")({ Color = white, Transparency = 0.85, Thickness = 0.5 }),
		C("TextLabel")({ Name = "Value", Size = UDim2.fromOffset(76, 16), Position = UDim2.fromOffset(8, 4),
			BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium),
			Text = tostring(props.Value), TextSize = 13, TextColor3 = white, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }),
		C("ImageButton")({ Name = "Up", Size = UDim2.fromOffset(20, 12), Position = UDim2.fromOffset(80, 0),
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 3,
			C("ImageLabel")({ Name = "Icon", Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(3, -1),
				BackgroundTransparency = 1, Image = "rbxassetid://137296891812002", ImageColor3 = white, ImageTransparency = 0.2 }) }),
		C("ImageButton")({ Name = "Down", Size = UDim2.fromOffset(20, 12), Position = UDim2.fromOffset(80, 12),
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 3,
			C("ImageLabel")({ Name = "Icon", Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(3, -1),
				BackgroundTransparency = 1, Image = "rbxassetid://84215348315149", ImageColor3 = white, ImageTransparency = 0.2 }) }),
	})

	local inst = c.__instance
	local valLbl = inst:FindFirstChild("Value")
	local upBtn = inst:FindFirstChild("Up")
	local downBtn = inst:FindFirstChild("Down")
	local function update() valLbl.Text = tostring(props.Value) end

	upBtn.MouseButton1Click:Connect(function()
		props.Value = math.min(props.Value + props.Step, props.Maximum)
		update(); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)
	downBtn.MouseButton1Click:Connect(function()
		props.Value = math.max(props.Value - props.Step, props.Minimum)
		update(); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "Stepper", __instance = inst }
	function obj:Parent(p) c.Parent = p end
	function obj:SetValue(v) props.Value = v; update() end
	function obj:GetValue() return props.Value end
	return obj
end