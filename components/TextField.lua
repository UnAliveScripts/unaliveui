--[[
	UnAliveUI — SearchField Component
	
	Figma 1:1 search bar with pill shape, magnifier icon, clear button.
	Dark Alert theme (#12141a at 8%).
	
	Usage:
		local sf = UI:New("TextField", { Placeholder = "Search" })
		sf:Parent(gui)
--]]

local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}; props.Placeholder = props.Placeholder or "Search"

	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)

	local c = C("Frame")({
		Name = "SearchField", Size = UDim2.fromOffset(122, 26),
		BackgroundColor3 = dark, BackgroundTransparency = 0.08,
		BorderSizePixel = 0, ZIndex = 50, ClipsDescendants = true,
		C("UICorner")({ CornerRadius = UDim.new(0, 13) }),
		C("UIStroke")({ Color = white, Transparency = 0.92, Thickness = 0.5 }),
		-- Search icon
		C("ImageLabel")({ Name = "Icon", Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(8, 5),
			BackgroundTransparency = 1, BorderSizePixel = 0,
			Image = icons.search or "rbxassetid://117204739779559",
			ImageColor3 = Color3.fromRGB(200, 200, 200), ScaleType = Enum.ScaleType.Fit, ZIndex = 2 }),
		-- Text
		C("TextLabel")({ Name = "Label", Size = UDim2.fromOffset(74, 16), Position = UDim2.fromOffset(26, 5),
			BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"),
			Text = props.Placeholder, TextSize = 13, TextColor3 = Color3.fromRGB(245, 245, 245),
			TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 2 }),
		-- Clear button
		C("ImageButton")({ Name = "Clear", Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(100, 5),
			BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false, ZIndex = 2,
			Image = "rbxassetid://78668603799563",
			ImageColor3 = Color3.fromRGB(138, 138, 138), ScaleType = Enum.ScaleType.Fit }),
	})

	local inst = c.__instance
	local clearBtn = inst:FindFirstChild("Clear")
	local label = inst:FindFirstChild("Label")

	clearBtn.MouseButton1Click:Connect(function()
		if props.ValueChanged then task.spawn(props.ValueChanged, obj, "") end
	end)

	local obj = { Type = "TextField", __instance = inst }
	function obj:Parent(p) c.Parent = p end
	function obj:SetPlaceholder(v) label.Text = v end
	return obj
end