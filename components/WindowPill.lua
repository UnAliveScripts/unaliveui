local TS = game:GetService("TweenService")

return function(self, props)
	local body = Instance.new("ImageButton")
	body.Name = "WindowPill"
	body.AnchorPoint = Vector2.new(0.5, 0)
	body.AutoButtonColor = false
	body.BackgroundTransparency = 1
	body.BorderSizePixel = 0
	body.Image = "rbxassetid://93520763686656"
	body.ImageTransparency = 0.5
	body.ImageColor3 = Color3.fromRGB(245, 245, 245)
	body.Position = UDim2.new(0.5, 0, 0, 10)
	body.Size = UDim2.fromOffset(180, 5)
	body.ZIndex = 999
	Instance.new("UICorner", body).CornerRadius = UDim.new(1, 0)

	local ct = nil
	body.MouseEnter:Connect(function()
		if ct then ct:Cancel() end
		ct = TS:Create(body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.15 })
		ct:Play()
	end)
	body.MouseLeave:Connect(function()
		if ct then ct:Cancel() end
		ct = TS:Create(body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.5 })
		ct:Play()
	end)

	local obj = { Type = "WindowPill", __instance = body }
	function obj.Parent(p) body.Parent = p end
	return obj
end