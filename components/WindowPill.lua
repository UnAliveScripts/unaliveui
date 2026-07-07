--[[
	UnAliveUI — WindowPill Component
	
	Draggable window pill (top handle bar).
	
	Usage:
		local wp = UI.Components.WindowPill(UI)
		wp.Parent(frame)
--]]

local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}

	local body = C("ImageButton")({
		Name = "WindowPill",
		AnchorPoint = Vector2.new(0.5, 0),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxassetid://93520763686656",
		ImageTransparency = 0.5,
		ImageColor3 = Color3.fromRGB(245, 245, 245),
		Position = UDim2.new(0.5, 0, 0, 10),
		Size = UDim2.fromOffset(180, 5),
		ZIndex = 999,

		C("UICorner")({ CornerRadius = UDim.new(1, 0) }),
	})

	local ct = nil

	body.MouseEnter:Connect(function()
		if ct then ct:Cancel() end
		ct = TS:Create(body.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
			ImageTransparency = 0.15,
		})
		ct:Play()
	end)

	body.MouseLeave:Connect(function()
		if ct then ct:Cancel() end
		ct = TS:Create(body.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
			ImageTransparency = 0.5,
		})
		ct:Play()
	end)

	local obj = { Type = "WindowPill", __instance = body.__instance }
	function obj.Parent(p) body.Parent = p end
	return obj
end