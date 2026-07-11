local TS = game:GetService("TweenService")

return {
	-- Myriad 1:1 minimize/restore animation
	--   target: the main body/window Frame (AnchorPoint 0.5,0.5)
	--   uiScale: UIScale to animate (on the window, NOT the ScreenGui, so pills stay visible)
	-- Returns (toggleFn, getState)
	Create = function(target, uiScale)
		local mined = false
		local toggle = function()
			mined = not mined
			local tY = mined and target.AbsoluteSize.Y * 2 or 0
			TS:Create(target, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, 0, 0.5, tY)
			}):Play()
			TS:Create(uiScale, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Scale = mined and 0 or 1
			}):Play()
		end
		return toggle, function() return mined end
	end,
}
