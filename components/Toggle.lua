--[[
	UnAliveUI — Toggle Component
	
	iOS-style toggle switch. Dark Alert theme.
--]]

local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}; props.Value = props.Value == true

	local c = C("Frame")({ Name = "Toggle", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(28, 16),
		C("ImageButton")({ Name = "Switch", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
			Image = "rbxassetid://104426531889908", Size = UDim2.fromOffset(28, 16),
			C("ImageLabel")({ Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0,
				Image = "rbxassetid://99107881432922", Position = UDim2.new(0, 1, 0.5, 0), Size = UDim2.fromOffset(14, 14),
				C("ImageLabel")({ Name = "FX", AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0,
					Image = "rbxassetid://138042641797315", Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(16, 16) }) }),
			C("UIGradient")({ Name = "Depth", Rotation = 90, Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
				ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			}) }) }),
	})

	local sw = c.__instance:FindFirstChild("Switch")
	local knob = sw:FindFirstChild("Knob")

	local function update(v, instant)
		local ti = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		local kp = { Position = v and UDim2.new(0, 13, 0.5, 0) or UDim2.new(0, 1, 0.5, 0) }
		local sc = v and Color3.fromRGB(71, 140, 246) or Color3.fromRGB(122, 122, 122)
		local st = v and 0 or 0.6
		if instant then knob.Position = kp.Position; sw.ImageColor3 = sc; sw.ImageTransparency = st; return end
		TS:Create(knob, ti, kp):Play(); TS:Create(sw, ti, { ImageColor3 = sc, ImageTransparency = st }):Play()
	end
	update(props.Value, true)

	sw.MouseButton1Click:Connect(function()
		props.Value = not props.Value; update(props.Value)
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "Toggle", __instance = c.__instance }
	function obj:Parent(p) c.Parent = p end
	function obj:SetValue(v) props.Value = v; update(v) end
	return obj
end