--[[
	UnAliveUI — LiquidGlassButton Component
	
	60×28 pill button with liquid glass effect and clicky animations.
	
	Usage:
		local btn = UI.LiquidGlassButton({ Text = "Label" })
		btn:Parent(gui)
		
		btn:SetText("New")
		btn:SetCallback(function() print("Clicked!") end)
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}
	local label = props.Text or "Label"

	local btn = Instance.new("Frame")
	btn.Name = "LiquidGlassBtn"; btn.Size = UDim2.fromOffset(60, 28)
	btn.BackgroundTransparency = 1; btn.ZIndex = 30

	local scale = Instance.new("UIScale", btn); scale.Scale = 1

	local bg = Instance.new("Frame", btn); bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0); bg.BackgroundTransparency = 0.75
	bg.BorderSizePixel = 0; bg.ZIndex = 30
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 14)
	Instance.new("UIStroke", bg).Color = Color3.fromRGB(255, 255, 255)
	bg.UIStroke.Transparency = 0.8; bg.UIStroke.Thickness = 0.5

	local glass = Instance.new("Frame", btn)
	glass.Size = UDim2.fromScale(1, 1); glass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	glass.BackgroundTransparency = 0.75; glass.BorderSizePixel = 0; glass.ZIndex = 31
	Instance.new("UICorner", glass).CornerRadius = UDim.new(0, 14)

	local txt = Instance.new("TextLabel", btn)
	txt.Size = UDim2.fromScale(1, 1); txt.BackgroundTransparency = 1
	txt.FontFace = Font.new("rbxassetid://12187365364")
	txt.Text = label; txt.TextSize = 15; txt.TextColor3 = Color3.fromRGB(230, 230, 230)
	txt.TextXAlignment = Enum.TextXAlignment.Center; txt.TextYAlignment = Enum.TextYAlignment.Center
	txt.ZIndex = 32

	local hit = Instance.new("TextButton", btn)
	hit.Size = UDim2.fromScale(1, 1); hit.BackgroundTransparency = 1
	hit.BorderSizePixel = 0; hit.Text = ""; hit.ZIndex = 33; hit.AutoButtonColor = false

	local callback = props.Callback

	hit.MouseButton1Down:Connect(function()
		TS:Create(scale, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 0.92 })
		TS:Create(bg, TweenInfo.new(0.06), { BackgroundTransparency = 0.6 })
		TS:Create(txt, TweenInfo.new(0.06), { TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16 })
	end)

	hit.MouseButton1Up:Connect(function()
		TS:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.5), { Scale = 1 })
		TS:Create(bg, TweenInfo.new(0.12), { BackgroundTransparency = 0.75 })
		TS:Create(txt, TweenInfo.new(0.12), { TextColor3 = Color3.fromRGB(230, 230, 230), TextSize = 15 })
	end)

	hit.MouseLeave:Connect(function()
		TS:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
		TS:Create(bg, TweenInfo.new(0.1), { BackgroundTransparency = 0.75 })
		TS:Create(txt, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(230, 230, 230), TextSize = 15 })
	end)

	hit.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)

	local obj = { Type = "LiquidGlassButton", __instance = btn }
	function obj:Parent(p) btn.Parent = p end
	function obj:SetText(t) txt.Text = t end
	function obj:SetCallback(cb) callback = cb end
	return obj
end