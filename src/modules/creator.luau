local Creator = {}

function Creator.New(className, properties)
	local instance = Instance.new(className)
	for key, value in pairs(properties) do
		if key ~= "Parent" then
			pcall(function()
				instance[key] = value
			end)
		end
	end
	if properties.Parent then
		instance.Parent = properties.Parent
	end
	return instance
end

function Creator.Corner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = parent
	return corner
end

function Creator.Stroke(parent, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 255, 255)
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

function Creator.Padding(parent, left, right, top, bottom)
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, left or 0)
	padding.PaddingRight = UDim.new(0, right or 0)
	padding.PaddingTop = UDim.new(0, top or 0)
	padding.PaddingBottom = UDim.new(0, bottom or 0)
	padding.Parent = parent
	return padding
end

function Creator.Gradient(parent, color, rotation)
	local gradient = Instance.new("UIGradient")
	if color then
		gradient.Color = color
	end
	gradient.Rotation = rotation or 0
	gradient.Parent = parent
	return gradient
end

return Creator
