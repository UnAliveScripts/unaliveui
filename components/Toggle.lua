local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Value = props.Value == true

	local theme = self.Theme.Controls.Toggle
	local parent = self.__container or self.__instance or self
	local struct = {}

	struct.Body = C("Frame")({
		Name = "Toggle",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(28, 16),
		Parent = parent,

		C("ImageButton")({
			Name = "Switch",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = "rbxassetid://104426531889908",
			Size = UDim2.fromOffset(28, 16),

			__dynamicKeys = {
				ImageColor3 = theme.SwitchOff[1],
				ImageTransparency = theme.SwitchOff[2],
			},

			C("ImageLabel")({
				Name = "Knob",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Image = "rbxassetid://99107881432922",
				Position = UDim2.new(0, 1, 0.5, 0),
				Size = UDim2.fromOffset(14, 14),

				__dynamicKeys = {
					ImageColor3 = theme.Knob[1],
					ImageTransparency = theme.Knob[2],
				},

				C("ImageLabel")({
					Name = "FX",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = "rbxassetid://138042641797315",
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(16, 16),

					__dynamicKeys = {
						ImageColor3 = theme.KnobEffects[1],
						ImageTransparency = theme.KnobEffects[2],
					},
				}),
			}),

			C("UIGradient")({
				Name = "Depth",
				Rotation = 90,
				__dynamicKeys = { Color = theme.DepthEffect },
			}),
		}),
	})

	local sw = struct.Body.__instance:FindFirstChild("Switch")
	local knob = sw:FindFirstChild("Knob")

	local function update(v, inst)
		local ti = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		local kp = {
			Position = v and UDim2.new(0, 13, 0.5, 0) or UDim2.new(0, 1, 0.5, 0),
		}
		local sc = v and theme.SwitchOn[1].Value or theme.SwitchOff[1].Value
		local st = v and theme.SwitchOn[2].Value or theme.SwitchOff[2].Value

		if inst then
			knob.Position = kp.Position
			sw.ImageColor3 = sc
			sw.ImageTransparency = st
			return
		end

		TS:Create(knob, ti, kp):Play()
		TS:Create(sw, ti, { ImageColor3 = sc, ImageTransparency = st }):Play()
	end

	update(props.Value, true)

	sw.MouseButton1Click:Connect(function()
		props.Value = not props.Value
		update(props.Value)

		if props.ValueChanged then
			task.spawn(props.ValueChanged, obj, props.Value)
		end
	end)

	local obj = {
		Type = "Toggle",
		Theme = self.Theme,
		Structures = struct,
		__instance = struct.Body,
	}

	function obj:SetValue(v) props.Value = v; update(v) end
	return obj
end