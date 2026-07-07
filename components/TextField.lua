local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Placeholder = props.Placeholder or "Search"

	local c = C("Frame")({
		Name = "TextField",
		BackgroundColor3 = Color3.fromRGB(44, 44, 50),
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.fromOffset(0, 23),
		C("UICorner")({ CornerRadius = UDim.new(0, 6) })
	})

	local b = C("TextBox")({
		Name = "Input",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364"),
		PlaceholderText = props.Placeholder,
		PlaceholderColor3 = Color3.fromRGB(120, 120, 130),
		Text = props.Value or "",
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextEditable = true,
		Size = UDim2.fromOffset(200, 23),
		Position = UDim2.fromOffset(8, 0),
		ClearTextOnFocus = false,
		Parent = c.__instance,
	})

	b.Focused:Connect(function()
		TS:Create(c.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
			BackgroundColor3 = Color3.fromRGB(50, 50, 58)
		}):Play()
	end)

	b.FocusLost:Connect(function()
		TS:Create(c.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
			BackgroundColor3 = Color3.fromRGB(44, 44, 50)
		}):Play()

		if props.ValueChanged then
			props.Value = b.Text
			task.spawn(props.ValueChanged, obj, b.Text)
		end
	end)

	local obj = { Type = "TextField", __instance = c.__instance }

	function obj.Parent(p) c.Parent = p end
	function obj:SetValue(v) b.Text = v end
	function obj:SetPlaceholder(v) b.PlaceholderText = v end
	return obj
end