return function(self, props)
	props = props or {}
	props.Label = props.Label or "Label"

	local ta = Instance.new("Frame")
	ta.Name = "TrailingAccessories"
	ta.Size = UDim2.fromOffset(60, 16)
	ta.BackgroundTransparency = 1; ta.ZIndex = 50

	local lbl = Instance.new("TextLabel", ta)
	lbl.Size = UDim2.fromOffset(40, 16); lbl.Position = UDim2.fromOffset(-1, 0)
	lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.SourceSans
	lbl.Text = props.Label; lbl.TextSize = 15
	lbl.TextColor3 = Color3.fromRGB(246, 246, 246); lbl.TextTransparency = 0.16
	lbl.TextXAlignment = Enum.TextXAlignment.Right; lbl.TextYAlignment = Enum.TextYAlignment.Center

	local icon = Instance.new("ImageLabel", ta)
	icon.Size = UDim2.fromOffset(16, 16); icon.Position = UDim2.fromOffset(44, 0)
	icon.BackgroundTransparency = 1; icon.Image = "rbxassetid://134900376381669"
	icon.ImageColor3 = Color3.fromRGB(246, 246, 246); icon.ImageTransparency = 0.16

	local obj = { Type = "TrailingAccessories", __instance = ta }
	function obj.Parent(p) ta.Parent = p end
	function obj:SetLabel(v) lbl.Text = v end
	return obj
end