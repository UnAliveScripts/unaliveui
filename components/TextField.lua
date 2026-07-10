--[[
	UnAliveUI — TextField Component
	
	Mini text field with dark Alert theme, animated border focus,
	blue cursor, and placeholder. Length is configurable.
	
	Usage:
		local tf = UI.TextField({ Placeholder = "Value", Width = 120 })
		tf:Parent(gui)
		
		tf:SetValue("text")
		tf:GetValue() -- returns text
		tf:SetPlaceholder("new")
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}
	local phText = props.Placeholder or "Value"
	local width = props.Width or 120
	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)

	local tf = Instance.new("Frame")
	tf.Name = "TextField"; tf.Size = UDim2.fromOffset(width, 16)
	tf.BackgroundTransparency = 1; tf.ZIndex = 30

	local bg = Instance.new("Frame", tf)
	bg.Size = UDim2.fromScale(1, 1); bg.BorderSizePixel = 0
	bg.BackgroundColor3 = dark; bg.BackgroundTransparency = 0.08; bg.ZIndex = 30
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 4)

	local border = Instance.new("UIStroke", bg)
	border.Color = white; border.Thickness = 0.5; border.Transparency = 0.92

	local ph = Instance.new("TextLabel", tf)
	ph.Size = UDim2.fromOffset(width - 8, 16); ph.Position = UDim2.fromOffset(6, 0)
	ph.BackgroundTransparency = 1; ph.FontFace = Font.new("rbxassetid://12187365364")
	ph.Text = phText; ph.TextSize = 10; ph.TextColor3 = Color3.fromRGB(180, 180, 180)
	ph.TextXAlignment = Enum.TextXAlignment.Left; ph.TextYAlignment = Enum.TextYAlignment.Center; ph.ZIndex = 31

	local input = Instance.new("TextBox", tf)
	input.Size = UDim2.fromOffset(width - 8, 16); input.Position = UDim2.fromOffset(6, 0)
	input.BackgroundTransparency = 1; input.BorderSizePixel = 0; input.ZIndex = 32
	input.FontFace = Font.new("rbxassetid://12187365364"); input.Text = ""; input.TextSize = 10
	input.TextColor3 = Color3.fromRGB(180, 180, 180)
	input.TextXAlignment = Enum.TextXAlignment.Left; input.TextYAlignment = Enum.TextYAlignment.Center
	input.ClearTextOnFocus = false

	local cursor = Instance.new("Frame", tf)
	cursor.Size = UDim2.fromOffset(2, 14); cursor.Position = UDim2.fromOffset(6, 1)
	cursor.BackgroundColor3 = Color3.fromRGB(0, 145, 255); cursor.BorderSizePixel = 0; cursor.ZIndex = 32
	cursor.Visible = false
	Instance.new("UICorner", cursor).CornerRadius = UDim.new(0, 1)

	local function updateCursor()
		local cx = math.min(6 + input.TextBounds.X, width - 4)
		cursor.Position = UDim2.fromOffset(cx, 1)
	end

	input:GetPropertyChangedSignal("Text"):Connect(function()
		ph.Visible = (input.Text == ""); updateCursor()
	end)

	input.Focused:Connect(function()
		ph.Visible = false
		TS:Create(border, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Color = Color3.fromRGB(200, 200, 200), Transparency = 0.5, Thickness = 1 }):Play()
		cursor.Visible = true; updateCursor()
		task.spawn(function()
			local b = false
			while cursor.Visible do task.wait(0.5); b = not b; cursor.BackgroundTransparency = b and 0 or 1 end
		end)
	end)

	input.FocusLost:Connect(function()
		TS:Create(border, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Color = white, Transparency = 0.92, Thickness = 0.5 }):Play()
		cursor.Visible = false; ph.Visible = (input.Text == "")
	end)

	local obj = { Type = "TextField", __instance = tf }
	function obj:Parent(p) tf.Parent = p end
	obj.SetValue = function(v) input.Text = v end
	obj.GetValue = function() return input.Text end
	obj.SetPlaceholder = function(v) ph.Text = v end
	return obj
end