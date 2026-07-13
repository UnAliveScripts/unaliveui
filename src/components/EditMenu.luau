return function(self, properties)
	properties = properties or {}

	local parent = properties.Parent or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromOffset(488, 44)
	frame.Position = properties.Position or UDim2.fromOffset(4, 276)
	frame.BackgroundTransparency = 1
	frame.ZIndex = 20
	frame.Parent = parent

	local shadow = Instance.new("Frame")
	shadow.Size = UDim2.new(1, 4, 1, 4)
	shadow.Position = UDim2.fromOffset(-2, -2)
	shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	shadow.BackgroundTransparency = 0.82
	shadow.BorderSizePixel = 0
	shadow.ZIndex = -1
	shadow.Parent = frame

	local shadowCorner = Instance.new("UICorner")
	shadowCorner.CornerRadius = UDim.new(0, 34)
	shadowCorner.Parent = shadow

	local glass = Instance.new("Frame")
	glass.Size = UDim2.fromScale(1, 1)
	glass.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
	glass.BackgroundTransparency = 0
	glass.BorderSizePixel = 0
	glass.ZIndex = 20
	glass.Parent = frame

	local glassCorner = Instance.new("UICorner")
	glassCorner.CornerRadius = UDim.new(0, 34)
	glassCorner.Parent = glass

	local glassStroke = Instance.new("UIStroke")
	glassStroke.Color = Color3.fromRGB(255, 255, 255)
	glassStroke.Transparency = 0.88
	glassStroke.Thickness = 1
	glassStroke.Parent = glass

	local content = Instance.new("Frame")
	content.Size = UDim2.fromScale(1, 1)
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.ZIndex = 22
	content.Parent = frame

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 0)
	layout.Parent = content

	local contentPadding = Instance.new("UIPadding")
	contentPadding.PaddingLeft = UDim.new(0, 20)
	contentPadding.PaddingRight = UDim.new(0, 4)
	contentPadding.Parent = content

	return {
		Type = "EditMenu",
		Instance = frame,
		Content = content,
		Parent = function(p)
			frame.Parent = p
		end,
	}
end
