return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local text = properties.Text or ""
	local placeholder = properties.Placeholder or "Enter..."
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
	label.Size = UDim2.new(1, -160, 1, 0)
	label.Position = UDim2.fromOffset(12, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = theme.Label.Primary
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.Parent = frame

	local box = Instance.new("TextBox")
	box.Size = UDim2.fromOffset(140, 28)
	box.Position = UDim2.new(1, -152, 0.5, -14)
	box.BackgroundColor3 = theme.TextField.Background
	box.BorderSizePixel = 0
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = theme.TextField.Placeholder
	box.Font = Enum.Font.Gotham
	box.TextSize = 13
	box.TextColor3 = theme.TextField.TextColor
	box.ClearTextOnFocus = false
	box.Parent = frame

	if text ~= "" then
		box.Text = text
	end

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 6)
	boxCorner.Parent = box

	if onChange then
		box.FocusLost:Connect(function(enterPressed)
			if enterPressed then onChange(box.Text) end
		end)
	end

	return {
		Type = "TextField",
		Instance = frame,
		Box = box,
		SetText = function(newText)
			box.Text = newText
		end,
		GetText = function() return box.Text end,
		Parent = function(parent)
			frame.Parent = parent
		end,
	}
end
