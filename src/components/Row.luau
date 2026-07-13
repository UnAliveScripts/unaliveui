return function(self, properties)
	properties = properties or {}

	local row = Instance.new("Frame")
	row.Size = properties.Size or UDim2.new(1, 0, 0, 38)
	row.BackgroundColor3 = Color3.fromRGB(44, 44, 46)
	row.BackgroundTransparency = 0.05
	row.BorderSizePixel = 0

	if properties.Parent then
		row.Parent = properties.Parent
	end

	local rowCorner = Instance.new("UICorner")
	rowCorner.CornerRadius = UDim.new(0, 6)
	rowCorner.Parent = row

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, -16, 1, 0)
	label.Position = UDim2.fromOffset(12, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = properties.Text or "Label"
	label.Parent = row

	if properties.Value then
		local valueLabel = Instance.new("TextLabel")
		valueLabel.Size = UDim2.new(0.4, -12, 1, 0)
		valueLabel.Position = UDim2.new(0.6, 4, 0, 0)
		valueLabel.BackgroundTransparency = 1
		valueLabel.Font = Enum.Font.Gotham
		valueLabel.TextSize = 13
		valueLabel.TextColor3 = properties.ValueColor or Color3.fromRGB(10, 130, 255)
		valueLabel.TextXAlignment = Enum.TextXAlignment.Right
		valueLabel.TextTruncate = Enum.TextTruncate.AtEnd
		valueLabel.Text = properties.Value
		valueLabel.Parent = row
	end

	return {
		Type = "Row",
		Instance = row,
		Parent = function(parent)
			row.Parent = parent
		end,
	}
end
