local TweenService = game:GetService("TweenService")

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local state = properties.State or false
	local text = properties.Text or "Toggle"
	local onChange = properties.OnChange or nil

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 44)
	frame.BackgroundColor3 = Color3.fromRGB(44, 44, 46)
	frame.BackgroundTransparency = 0.05
	frame.BorderSizePixel = 0

	if properties.Parent then
		frame.Parent = properties.Parent
	end

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 6)
	frameCorner.Parent = frame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 1, 0)
	label.Position = UDim2.fromOffset(12, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = theme.Label.Primary
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.Parent = frame

	local toggleBg = Instance.new("ImageButton")
	toggleBg.Size = UDim2.fromOffset(44, 24)
	toggleBg.Position = UDim2.new(1, -56, 0.5, -12)
	toggleBg.BackgroundColor3 = state and theme.Toggle.On or theme.Toggle.Off
	toggleBg.BorderSizePixel = 0
	toggleBg.AutoButtonColor = false
	toggleBg.Parent = frame

	local toggleBgCorner = Instance.new("UICorner")
	toggleBgCorner.CornerRadius = UDim.new(1, 0)
	toggleBgCorner.Parent = toggleBg

	local knob = Instance.new("Frame")
	knob.Name = "Knob"
	knob.Size = UDim2.fromOffset(20, 20)
	knob.Position = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
	knob.BackgroundColor3 = theme.Toggle.Knob
	knob.BorderSizePixel = 0
	knob.Parent = toggleBg

	local knobCorner = Instance.new("UICorner")
	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	local function updateState(newState)
		state = newState
		toggleBg.BackgroundColor3 = state and theme.Toggle.On or theme.Toggle.Off
		local target = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
		TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = target }):Play()
		if onChange then onChange(state) end
	end

	toggleBg.MouseButton1Click:Connect(function()
		updateState(not state)
	end)

	return {
		Type = "Toggle",
		Instance = frame,
		Set = updateState,
		Get = function() return state end,
		Parent = function(parent)
			frame.Parent = parent
		end,
	}
end
