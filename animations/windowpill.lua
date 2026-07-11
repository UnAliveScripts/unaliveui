local TS = game:GetService("TweenService")

return {
	-- Myriad 1:1 WindowPill hover glow animation
	--   pill: ImageButton (180x5, Image "rbxassetid://93520763686656")
	-- Returns { connect, disconnect }
	Create = function(pill)
		local ct
		local function onEnter()
			if ct then ct:Cancel() end
			ct = TS:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.15 })
			ct:Play()
		end
		local function onLeave()
			if ct then ct:Cancel() end
			ct = TS:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.5 })
			ct:Play()
		end
		local connEnter = pill.MouseEnter:Connect(onEnter)
		local connLeave = pill.MouseLeave:Connect(onLeave)
		return {
			disconnect = function()
				connEnter:Disconnect()
				connLeave:Disconnect()
			end
		}
	end,
}
