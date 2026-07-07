--[[
	UnAliveUI — TextField Component
	
	Input field with placeholder, focus glow, and search icon. Dark Alert theme.
--]]

local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}; props.Placeholder = props.Placeholder or "Search"

	local dark = Color3.fromRGB(18, 20, 26)

	local c = C("Frame")({ Name = "TextField", BackgroundColor3 = dark, BackgroundTransparency = 0.08,
		BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 23),
		C("UICorner")({ CornerRadius = UDim.new(0, 6) }),
		C("ImageLabel")({ Name = "Icon", BackgroundTransparency = 1, BorderSizePixel = 0,
			Image = icons.search or "rbxassetid://117204739779559",
			Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(6, 4.5), ImageColor3 = Color3.fromRGB(82, 82, 100) }),
		C("TextBox")({ Name = "Input", BackgroundTransparency = 1, BorderSizePixel = 0,
			FontFace = Font.new("rbxassetid://12187365364"),
			PlaceholderText = props.Placeholder, PlaceholderColor3 = Color3.fromRGB(72, 72, 88),
			Text = props.Value or "", TextSize = 13, TextColor3 = Color3.fromRGB(225, 225, 234), TextEditable = true,
			Size = UDim2.fromOffset(170, 23), Position = UDim2.fromOffset(24, 0), ClearTextOnFocus = false }),
	})

	local input = c.__instance:FindFirstChild("Input")
	local icon = c.__instance:FindFirstChild("Icon")

	input.Focused:Connect(function()
		TS:Create(c.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
			BackgroundColor3 = Color3.fromRGB(30, 32, 38),
		}):Play()
		if icon then TS:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(118, 118, 142) }):Play() end
	end)
	input.FocusLost:Connect(function()
		TS:Create(c.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
			BackgroundColor3 = dark, BackgroundTransparency = 0.08,
		}):Play()
		if icon then TS:Create(icon, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(82, 82, 100) }):Play() end
		if props.ValueChanged then props.Value = input.Text; task.spawn(props.ValueChanged, obj, input.Text) end
	end)

	local obj = { Type = "TextField", __instance = c.__instance }
	function obj:Parent(p) c.Parent = p end
	function obj:SetValue(v) input.Text = v end
	function obj:SetPlaceholder(v) input.PlaceholderText = v end
	return obj
end