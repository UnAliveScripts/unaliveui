local TweenService = game:GetService("TweenService")

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local value = properties.Value or 5000
	local minValue = properties.Min or 0
	local maxValue = properties.Max or 99999
	local stepAmount = properties.Step or 1
	local onChange = properties.OnChange or nil

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromOffset(140, 34)
	frame.BackgroundColor3 = Color3.fromRGB(44, 44, 46)
	frame.BackgroundTransparency = 0.05
	frame.BorderSizePixel = 0

	if properties.Parent then
		frame.Parent = properties.Parent
	end

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 10)
	frameCorner.Parent = frame

	local decrement = Instance.new("TextButton")
	decrement.Size = UDim2.fromOffset(32, 34)
	decrement.Position = UDim2.fromOffset(0, 0)
	decrement.BackgroundTransparency = 1
	decrement.Text = "-"
	decrement.Font = Enum.Font.Gotham
	decrement.TextSize = 18
	decrement.TextColor3 = Color3.fromRGB(255, 255, 255)
	decrement.AutoButtonColor = false
	decrement.ZIndex = 6
	decrement.Parent = frame

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.fromOffset(76, 34)
	valueLabel.Position = UDim2.fromOffset(32, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 15
	valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	valueLabel.Text = tostring(value)
	valueLabel.Parent = frame

	local increment = Instance.new("TextButton")
	increment.Size = UDim2.fromOffset(32, 34)
	increment.Position = UDim2.fromOffset(108, 0)
	increment.BackgroundTransparency = 1
	increment.Text = "+"
	increment.Font = Enum.Font.Gotham
	increment.TextSize = 18
	increment.TextColor3 = Color3.fromRGB(255, 255, 255)
	increment.AutoButtonColor = false
	increment.ZIndex = 6
	increment.Parent = frame

	local function updateValue(newValue)
		value = math.clamp(newValue, minValue, maxValue)
		valueLabel.Text = tostring(value)
		if onChange then onChange(value) end
	end

	decrement.MouseButton1Click:Connect(function()
		updateValue(value - stepAmount)
	end)

	increment.MouseButton1Click:Connect(function()
		updateValue(value + stepAmount)
	end)

	return {
		Type = "Stepper",
		Instance = frame,
		Set = function(newValue) updateValue(newValue) end,
		Get = function() return value end,
		Parent = function(parent)
			frame.Parent = parent
		end,
	}
end
