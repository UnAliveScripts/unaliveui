return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local card = Instance.new("Frame")
	card.Size = properties.Size or UDim2.fromOffset(200, 140)
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

	return {
		Type = "SubCard",
		Instance = card,
		Parent = function(parent)
			card.Parent = parent
		end,
	}
end
