--[[
	UnAliveUI — Card Component
	
	Content card with dark bg, rounded corners, border, and shadow.
	
	Usage:
		local card = UI.Card({ Width = 496, Height = 330 })
		card:Parent(gui)
		
		-- Card acts as a container — add components inside
		local btn = UI.Button({ Label = "Hi" })
		btn:Parent(card.__instance)
--]]

return function(self, props)
	props = props or {}
	local w = props.Width or 496
	local h = props.Height or 330

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.Size = UDim2.fromOffset(w, h)
	card.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	card.BorderSizePixel = 0
	card.ZIndex = 5
	card.ClipsDescendants = true

	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)

	local stroke = Instance.new("UIStroke", card)
	stroke.Color = Color3.fromRGB(38, 38, 46)
	stroke.Thickness = 1
	stroke.Transparency = 0

	local shadow = Instance.new("ImageLabel", card)
	shadow.Name = "Shadow"
	shadow.Size = UDim2.new(1, 30, 1, 30)
	shadow.Position = UDim2.new(0, -15, 0, -15)
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://6015897843"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.7
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(49, 49, 50, 50)
	shadow.ZIndex = 4

	local obj = { Type = "Card", __instance = card }
	function obj:Parent(p) card.Parent = p end
	return obj
end