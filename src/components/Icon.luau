return function(self, properties)
	properties = properties or {}

	local icon = Instance.new("ImageLabel")
	icon.Size = properties.Size or UDim2.fromOffset(24, 24)
	icon.BackgroundTransparency = 1
	icon.Image = properties.Image or ""
	icon.ImageColor3 = properties.Color or Color3.fromRGB(255, 255, 255)
	icon.ScaleType = Enum.ScaleType.Fit

	if properties.Parent then
		icon.Parent = properties.Parent
	end

	return {
		Type = "Icon",
		Instance = icon,
		SetImage = function(imageId)
			icon.Image = imageId
		end,
		SetColor = function(color)
			icon.ImageColor3 = color
		end,
		Parent = function(parent)
			icon.Parent = parent
		end,
	}
end
