local blur = _G.__unaliveui_blur

return function(self, props)
	props = props or {}
	props.Title = props.Title or "UnAlive"
	props.Description = props.Description or ""
	props.Buttons = props.Buttons or {}

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local body = Instance.new("Frame")
	body.Name = "Alert"
	body.Size = UDim2.fromOffset(260, 140)
	body.BackgroundTransparency = 1
	body.ZIndex = 100
	Instance.new("UICorner", body).CornerRadius = UDim.new(0, 10)

	local shadow = Instance.new("Frame", body)
	shadow.Size = UDim2.new(1, 4, 1, 4); shadow.Position = UDim2.fromOffset(-2, -2)
	shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0); shadow.BackgroundTransparency = 0.78
	shadow.BorderSizePixel = 0; shadow.ZIndex = 98
	Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 26)

	local bg = Instance.new("Frame", body)
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = dark; bg.BackgroundTransparency = 0.08
	bg.BorderSizePixel = 0; bg.ZIndex = 100
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 26)
	local stroke = Instance.new("UIStroke", bg)
	stroke.Color = white; stroke.Transparency = 0.88; stroke.Thickness = 1

	local blurPane = Instance.new("Frame", body)
	blurPane.Size = UDim2.new(1, -20, 1, -20)
	blurPane.Position = UDim2.fromOffset(10, 10)
	blurPane.BackgroundTransparency = 1; blurPane.BorderSizePixel = 0; blurPane.ZIndex = 99
	if blur and blurPane then task.spawn(function() blur(blurPane) end) end

	local titleLbl = Instance.new("TextLabel", bg)
	titleLbl.Size = UDim2.fromOffset(216, 16); titleLbl.Position = UDim2.fromOffset(22, 20)
	titleLbl.BackgroundTransparency = 1
	titleLbl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold)
	titleLbl.Text = props.Title; titleLbl.TextSize = 13; titleLbl.TextColor3 = white
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.TextYAlignment = Enum.TextYAlignment.Center
	titleLbl.RichText = true; titleLbl.ZIndex = 102

	local descLbl = Instance.new("TextLabel", bg)
	descLbl.Size = UDim2.fromOffset(216, 28); descLbl.Position = UDim2.fromOffset(22, 46)
	descLbl.BackgroundTransparency = 1
	descLbl.FontFace = Font.new("rbxassetid://12187365364")
	descLbl.Text = props.Description; descLbl.TextSize = 11
	descLbl.TextColor3 = Color3.fromRGB(180, 180, 190)
	descLbl.TextXAlignment = Enum.TextXAlignment.Left; descLbl.TextYAlignment = Enum.TextYAlignment.Top
	descLbl.RichText = true; descLbl.ZIndex = 102

	for i, btn in ipairs(props.Buttons) do
		local x = 16 + (i - 1) * 118
		local dest = btn.Destructive or false

		local b = Instance.new("TextButton", bg)
		b.AutoButtonColor = false; b.Size = UDim2.fromOffset(110, 32); b.Position = UDim2.fromOffset(x, 92)
		b.BackgroundTransparency = 1; b.BorderSizePixel = 0; b.Text = ""; b.ZIndex = 102
		Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

		local bb = Instance.new("Frame", b)
		bb.Size = UDim2.fromScale(1, 1); bb.BorderSizePixel = 0; bb.ZIndex = 101
		bb.BackgroundColor3 = dest and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(230, 230, 230)
		bb.BackgroundTransparency = dest and 0.77 or 0
		Instance.new("UICorner", bb).CornerRadius = UDim.new(1, 0)

		local bl = Instance.new("TextLabel", b)
		bl.Size = UDim2.fromScale(1, 1); bl.BackgroundTransparency = 1
		bl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
		bl.Text = btn.Label; bl.TextSize = 13
		bl.TextColor3 = dest and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(0, 0, 0)
		bl.TextXAlignment = Enum.TextXAlignment.Center; bl.TextYAlignment = Enum.TextYAlignment.Center
		bl.ZIndex = 102

		if btn.Pushed then
			b.MouseButton1Click:Connect(function() task.spawn(btn.Pushed) end)
		end
	end

	local obj = { Type = "Alert", __instance = body }
	function obj.Parent(p) body.Parent = p end
	function obj:SetTitle(v) titleLbl.Text = v end
	function obj:SetDescription(v) descLbl.Text = v end
	return obj
end