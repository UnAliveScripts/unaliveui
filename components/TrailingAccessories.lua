local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}
	props.Label = props.Label or "Label"

	local textColor = Color3.fromRGB(246, 246, 246)

	local c = C("Frame")({
		Name = "TrailingAccessories",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(60, 16),
		ZIndex = 50,

		C("TextLabel")({
			Name = "Label",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			FontFace = Font.new("rbxassetid://12187365364"),
			Size = UDim2.fromOffset(35, 16),
			Position = UDim2.fromOffset(-1, 0),
			Text = props.Label,
			TextSize = 15,
			TextColor3 = textColor,
			TextTransparency = 0.16,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
		}),

		C("ImageLabel")({
			Name = "InfoIcon",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = icons.info or "rbxassetid://134900376381669",
			ImageColor3 = textColor,
			ImageTransparency = 0.16,
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(44, 0),
		}),
	})

	local obj = { Type = "TrailingAccessories", __instance = c.__instance }

	function obj.Parent(p) c.Parent = p end
	function obj:SetLabel(v)
		c.__instance:FindFirstChild("Label").Text = v
	end

	return obj
end