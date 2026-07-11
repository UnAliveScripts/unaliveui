--[[
	UnAliveUI — SubCard Component
	
	A small card container for grouping components.
	Dark theme, rounded corners, border stroke.
	
	Usage:
		local sc = UI.SubCard({ Width = 200, Height = 140 })
		sc:Parent(gui)
		
		-- Add components inside
		local lbl = UI.Label({ Text = "Settings" })
		lbl:Parent(sc.__instance)
--]]

return function(self, props)
	props = props or {}
	local w = props.Width or 200
	local h = props.Height or 140

	local sc = Instance.new("Frame")
	sc.Name = "SubCard"
	sc.Size = UDim2.fromOffset(w, h)
	sc.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	sc.BorderSizePixel = 0
	sc.ZIndex = 10
	sc.ClipsDescendants = true

	Instance.new("UICorner", sc).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke", sc)
	stroke.Color = Color3.fromRGB(38, 38, 46)
	stroke.Thickness = 1

	local obj = { Type = "SubCard", __instance = sc }
	function obj:Parent(p) sc.Parent = p end
	return obj
end