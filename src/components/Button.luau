local TweenService = game:GetService("TweenService")

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local text = properties.Text or "Button"
	local buttonState = properties.State or "Primary"
	local onClick = properties.OnClick or nil

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
	label.Size = UDim2.new(1, -90, 1, 0)
	label.Position = UDim2.fromOffset(12, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = theme.Label.Primary
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.Parent = frame

	local button = Instance.new("TextButton")
	button.Size = UDim2.fromOffset(70, 28)
	button.Position = UDim2.new(1, -82, 0.5, -14)
	button.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
	button.BackgroundTransparency = 0
	button.BorderSizePixel = 0
	button.Text = "Run"
	button.Font = Enum.Font.GothamSemibold
	button.TextSize = 13
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.AutoButtonColor = false
	button.Parent = frame

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 6)
	buttonCorner.Parent = button

	if onClick then
		button.MouseButton1Click:Connect(onClick)
	end

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(10, 132, 255)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
	end)

	return {
		Type = "Button",
		Instance = frame,
		Button = button,
		SetText = function(newText)
			label.Text = newText
		end,
		SetButtonText = function(newText)
			button.Text = newText
		end,
		OnClick = function(callback)
			button.MouseButton1Click:Connect(callback)
		end,
		Parent = function(parent)
			frame.Parent = parent
		end,
	}
end
