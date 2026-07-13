local TweenService = game:GetService("TweenService")

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = theme.Label.Primary
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = properties.Text or "Label"

	if properties.Size then
		label.Size = properties.Size
	end

	if properties.Font then
		label.Font = properties.Font
	end

	if properties.TextSize then
		label.TextSize = properties.TextSize
	end

	if properties.Color then
		label.TextColor3 = properties.Color
	end

	if properties.Parent then
		label.Parent = properties.Parent
	end

	label.TextTransparency = properties.TextTransparency or 0

	return {
		Type = "Label",
		Instance = label,
		SetText = function(text)
			label.Text = text
		end,
		SetColor = function(color)
			label.TextColor3 = color
		end,
		Parent = function(parent)
			label.Parent = parent
		end,
	}
end
