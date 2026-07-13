return function(self, properties)
	properties = properties or {}

	local page = Instance.new("ScrollingFrame")
	page.Size = properties.Size or UDim2.fromScale(1, 1)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 6
	page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
	page.CanvasSize = UDim2.fromScale(0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y

	if properties.Parent then
		page.Parent = properties.Parent
	end

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 16)
	padding.PaddingBottom = UDim.new(0, 16)
	padding.PaddingLeft = UDim.new(0, 16)
	padding.PaddingRight = UDim.new(0, 16)
	padding.Parent = page

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.Parent = page

	return {
		Type = "Page",
		Instance = page,
		Layout = layout,
		Parent = function(parent)
			page.Parent = parent
		end,
	}
end
