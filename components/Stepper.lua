return function(self, props)
	props = props or {}
	props.Value = props.Value or 5000
	props.Step = props.Step or 500
	props.Minimum = props.Minimum or 0
	props.Maximum = props.Maximum or 99999

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local st = Instance.new("Frame")
	st.Name = "Stepper"; st.Size = UDim2.fromOffset(100, 24)
	st.BackgroundColor3 = dark; st.BackgroundTransparency = 0.08
	st.ClipsDescendants = true; st.BorderSizePixel = 0; st.ZIndex = 50
	Instance.new("UICorner", st).CornerRadius = UDim.new(0, 6)
	local sts = Instance.new("UIStroke", st); sts.Color = white; sts.Transparency = 0.85; sts.Thickness = 0.5

	local label = Instance.new("TextLabel", st)
	label.Size = UDim2.fromOffset(76, 16); label.Position = UDim2.fromOffset(8, 4)
	label.BackgroundTransparency = 1
	label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
	label.Text = tostring(props.Value); label.TextSize = 13; label.TextColor3 = white
	label.TextXAlignment = Enum.TextXAlignment.Left; label.ZIndex = 2

	local function update()
		label.Text = tostring(props.Value)
	end

	local up = Instance.new("ImageButton", st)
	up.Size = UDim2.fromOffset(20, 12); up.Position = UDim2.fromOffset(80, 0)
	up.BackgroundTransparency = 1; up.BorderSizePixel = 0; up.ZIndex = 3
	local upi = Instance.new("ImageLabel", up)
	upi.Size = UDim2.fromOffset(14, 14); upi.Position = UDim2.fromOffset(3, -1)
	upi.BackgroundTransparency = 1; upi.Image = "rbxassetid://137296891812002"
	upi.ImageColor3 = white; upi.ImageTransparency = 0.2

	local down = Instance.new("ImageButton", st)
	down.Size = UDim2.fromOffset(20, 12); down.Position = UDim2.fromOffset(80, 12)
	down.BackgroundTransparency = 1; down.BorderSizePixel = 0; down.ZIndex = 3
	local dni = Instance.new("ImageLabel", down)
	dni.Size = UDim2.fromOffset(14, 14); dni.Position = UDim2.fromOffset(3, -1)
	dni.BackgroundTransparency = 1; dni.Image = "rbxassetid://84215348315149"
	dni.ImageColor3 = white; dni.ImageTransparency = 0.2

	up.MouseButton1Click:Connect(function()
		props.Value = math.min(props.Value + props.Step, props.Maximum)
		update()
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)
	down.MouseButton1Click:Connect(function()
		props.Value = math.max(props.Value - props.Step, props.Minimum)
		update()
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
	end)

	local obj = { Type = "Stepper", __instance = st }
	function obj.Parent(p) st.Parent = p end
	function obj:SetValue(v) props.Value = v; update() end
	function obj:GetValue() return props.Value end
	return obj
end