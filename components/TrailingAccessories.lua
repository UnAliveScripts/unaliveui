--[[
	UnAliveUI — TrailingAccessories Component
	
	Label + info icon accessory, 60×16.
	
	Usage:
		local ta = UI.Components.TrailingAccessories(UI, { Label = "Label" })
		ta.Parent(frame)
--]]

local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Label = props.Label or "Label"

	local textColor = Color3.fromRGB(246, 246, 246)

	local container = C("Frame")({
		Name = "TrailingAccessories",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(60, 16),
		ZIndex = 50,

		C("TextLabel")({
			Name = "Label",
			Size = UDim2.fromOffset(40, 16),
			Position = UDim2.fromOffset(-1, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			FontFace = Font.new("rbxassetid://12187365364"),
			Text = props.Label,
			TextSize = 15,
			TextColor3 = textColor,
			TextTransparency = 0.16,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
		}),

		C("ImageLabel")({
			Name = "InfoIcon",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(44, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = "rbxassetid://134900376381669",
			ImageColor3 = textColor,
			ImageTransparency = 0.16,
		}),
	})

	local inst = container.__instance
	local obj = { Type = "TrailingAccessories", __instance = inst }
	function obj.Parent(p) container.Parent = p end
	function obj:SetLabel(v) inst:FindFirstChild("Label").Text = v end
	return obj
end