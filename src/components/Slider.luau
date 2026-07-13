local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local text = properties.Text or "Slider"
	local minValue = properties.Min or 0
	local maxValue = properties.Max or 100
	local currentValue = properties.Value or minValue
	local suffix = properties.Suffix or ""
	local onChange = properties.OnChange or nil

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 56)
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
	label.Size = UDim2.new(1, -70, 0, 22)
	label.Position = UDim2.fromOffset(12, 6)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = theme.Label.Primary
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.Parent = frame

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.fromOffset(60, 22)
	valueLabel.Position = UDim2.new(1, -72, 0, 5)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 13
	valueLabel.TextColor3 = theme.Label.Secondary
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Text = tostring(currentValue) .. suffix
	valueLabel.Parent = frame

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, -28, 0, 4)
	track.Position = UDim2.fromOffset(14, 44)
	track.BackgroundColor3 = theme.Slider.Track
	track.BorderSizePixel = 0
	track.Parent = frame

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = track

	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale((currentValue - minValue) / (maxValue - minValue), 1)
	fill.BackgroundColor3 = theme.Slider.Fill
	fill.BorderSizePixel = 0
	fill.Parent = track

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local isDragging = false

	local function updateValue(inputPosition)
		local absolutePosition = track.AbsolutePosition
		local absoluteSize = track.AbsoluteSize.X
		local relativeX = math.clamp(inputPosition.X - absolutePosition.X, 0, absoluteSize)
		local percentage = relativeX / absoluteSize
		currentValue = math.floor(minValue + (maxValue - minValue) * percentage)
		fill.Size = UDim2.fromScale(percentage, 1)
		valueLabel.Text = tostring(currentValue) .. suffix
		if onChange then onChange(currentValue) end
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			updateValue(input.Position)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateValue(input.Position)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)

	return {
		Type = "Slider",
		Instance = frame,
		Set = function(value)
			currentValue = value
			local percentage = (value - minValue) / (maxValue - minValue)
			fill.Size = UDim2.fromScale(percentage, 1)
			valueLabel.Text = tostring(value) .. suffix
		end,
		Get = function() return currentValue end,
		Parent = function(parent)
			frame.Parent = parent
		end,
	}
end
