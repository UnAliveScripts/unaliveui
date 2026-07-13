local TweenService = game:GetService("TweenService")

local Utility = {}

function Utility.Tween(obj, properties, duration, easingStyle, easingDirection)
	TweenService:Create(
		obj,
		TweenInfo.new(
			duration or 0.25,
			easingStyle or Enum.EasingStyle.Quad,
			easingDirection or Enum.EasingDirection.Out
		),
		properties
	):Play()
end

function Utility.AddCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = parent
	return corner
end

function Utility.AddStroke(parent, color, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 255, 255)
	stroke.Thickness = thickness or 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

function Utility.New(className, properties)
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

function Utility.MapRange(value, inputMin, inputMax, outputMin, outputMax)
	return (value - inputMin) * (outputMax - outputMin) / (inputMax - inputMin) + outputMin
end

function Utility.Clamp(value, min, max)
	return math.max(min, math.min(max, value))
end

function Utility.Lerp(a, b, t)
	return a + (b - a) * t
end

function Utility.Round(number, decimals)
	local multiplier = 10 ^ (decimals or 0)
	return math.floor(number * multiplier + 0.5) / multiplier
end

return Utility
