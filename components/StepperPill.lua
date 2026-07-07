local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}
	props.Value = props.Value or 0
	props.Step = props.Step or 1
	props.Minimum = props.Minimum or -math.huge
	props.Maximum = props.Maximum or math.huge

	local darkBg = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local c = C("Frame")({
		Name = "StepperPill",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(92, 32),
		ZIndex = 50,

		C("Frame")({
			Name = "Container",
			BackgroundColor3 = darkBg,
			BackgroundTransparency = 0.08,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = true,

			C("UICorner")({ CornerRadius = UDim.new(0, 16) }),
			C("UIStroke")({ Color = white, Transparency = 0.92, Thickness = 0.5 }),

			-- Decrement half
			C("ImageButton")({
				Name = "Decrement",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(0, 0),
				Size = UDim2.fromOffset(46, 32),
				ZIndex = 2,

				C("ImageLabel")({
					Name = "Icon",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = icons.minus,
					ImageColor3 = white,
					Size = UDim2.fromOffset(22, 22),
					Position = UDim2.fromOffset(12, 5),
				}),
			}),

			-- Increment half
			C("ImageButton")({
				Name = "Increment",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(46, 0),
				Size = UDim2.fromOffset(46, 32),
				ZIndex = 2,

				C("ImageLabel")({
					Name = "Icon",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = icons.plus,
					ImageColor3 = white,
					Size = UDim2.fromOffset(22, 22),
					Position = UDim2.fromOffset(12, 5),
				}),
			}),

			-- Separator
			C("Frame")({
				Name = "Separator",
				BackgroundColor3 = Color3.fromRGB(235, 235, 245),
				BackgroundTransparency = 0.7,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(45.5, 4),
				Size = UDim2.fromOffset(1, 24),

				C("UICorner")({ CornerRadius = UDim.new(0, 8) }),
			}),
		}),
	})

	local container = c.__instance:FindFirstChild("Container")
	local dec = container:FindFirstChild("Decrement")
	local inc = container:FindFirstChild("Increment")

	dec.MouseButton1Click:Connect(function()
		props.Value = math.max(props.Value - props.Step, props.Minimum)

		if props.ValueChanged then
			task.spawn(props.ValueChanged, obj, props.Value)
		end
	end)

	inc.MouseButton1Click:Connect(function()
		props.Value = math.min(props.Value + props.Step, props.Maximum)

		if props.ValueChanged then
			task.spawn(props.ValueChanged, obj, props.Value)
		end
	end)

	local obj = { Type = "StepperPill", __instance = c.__instance }

	function obj.Parent(p) c.Parent = p end
	function obj:SetValue(v) props.Value = v end
	function obj:GetValue() return props.Value end

	return obj
end