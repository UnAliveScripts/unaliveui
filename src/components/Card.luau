return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local card = Instance.new("Frame")
	card.Size = properties.Size or UDim2.fromOffset(496, 280)
	card.Position = properties.Position or UDim2.fromOffset(0, 0)
	card.BackgroundColor3 = theme.Card.Background
	card.BorderSizePixel = 0
	card.ZIndex = 5

	if properties.Parent then
		card.Parent = properties.Parent
	end

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, theme.Card.CornerRadius)
	cardCorner.Parent = card

	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = theme.Card.Border
	cardStroke.Thickness = theme.Card.BorderThickness
	cardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	cardStroke.Parent = card

	if theme.Card.Shadow.Enabled then
		local shadow = Instance.new("ImageLabel")
		shadow.Name = "Shadow"
		shadow.Size = UDim2.new(1, theme.Card.Shadow.Offset, 1, theme.Card.Shadow.Offset)
		shadow.Position = UDim2.new(0, -theme.Card.Shadow.Offset / 2, 0, -theme.Card.Shadow.Offset / 2)
		shadow.BackgroundTransparency = 1
		shadow.Image = theme.Card.Shadow.Image
		shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		shadow.ImageTransparency = theme.Card.Shadow.Transparency
		shadow.ScaleType = Enum.ScaleType.Slice
		shadow.SliceCenter = Rect.new(49, 49, 50, 50)
		shadow.ZIndex = 4
		shadow.Parent = card
	end

	return {
		Type = "Card",
		Instance = card,
		Parent = function(parent)
			card.Parent = parent
		end,
	}
end
