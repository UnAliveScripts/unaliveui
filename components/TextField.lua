--[[
	UnAliveUI — SearchField Component
	
	Fully functional search bar with pill shape, magnifier icon,
	placeholder, text input, and clear button. Dark Alert theme.
	
	Usage:
		local sf = UI:New("TextField", { Placeholder = "Search" })
		sf:Parent(gui)
		sf.SetValue("text")
		sf.GetValue() -- returns text
		sf.SetPlaceholder("new placeholder")
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}; props.Placeholder = props.Placeholder or "Search"
	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)

	local sf = Instance.new("Frame")
	sf.Name = "SearchField"; sf.Size = UDim2.fromOffset(122, 26)
	sf.BackgroundColor3 = dark; sf.BackgroundTransparency = 0.08
	sf.BorderSizePixel = 0; sf.ZIndex = 50; sf.ClipsDescendants = true
	Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 13)

	-- Border
	local border = Instance.new("UIStroke", sf)
	border.Color = white; border.Transparency = 0.92; border.Thickness = 0.5

	-- Search icon
	local icon = Instance.new("ImageLabel", sf)
	icon.Size = UDim2.fromOffset(16, 16); icon.Position = UDim2.fromOffset(8, 5)
	icon.BackgroundTransparency = 1; icon.BorderSizePixel = 0; icon.ZIndex = 2
	icon.Image = "rbxassetid://117204739779559"
	icon.ImageColor3 = Color3.fromRGB(200, 200, 200); icon.ScaleType = Enum.ScaleType.Fit

	-- Placeholder
	local ph = Instance.new("TextLabel", sf)
	ph.Size = UDim2.fromOffset(74, 16); ph.Position = UDim2.fromOffset(26, 5)
	ph.BackgroundTransparency = 1; ph.BorderSizePixel = 0; ph.ZIndex = 2
	ph.FontFace = Font.new("rbxassetid://12187365364")
	ph.Text = props.Placeholder; ph.TextSize = 13
	ph.TextColor3 = Color3.fromRGB(245, 245, 245)
	ph.TextXAlignment = Enum.TextXAlignment.Left; ph.TextYAlignment = Enum.TextYAlignment.Center

	-- Text input
	local box = Instance.new("TextBox", sf)
	box.Size = UDim2.fromOffset(74, 16); box.Position = UDim2.fromOffset(26, 5)
	box.BackgroundTransparency = 1; box.BorderSizePixel = 0; box.ZIndex = 3
	box.FontFace = Font.new("rbxassetid://12187365364")
	box.Text = ""; box.TextSize = 13
	box.TextColor3 = Color3.fromRGB(245, 245, 245)
	box.TextXAlignment = Enum.TextXAlignment.Left; box.TextYAlignment = Enum.TextYAlignment.Center
	box.ClearTextOnFocus = false

	-- Clear button
	local clear = Instance.new("ImageButton", sf)
	clear.Size = UDim2.fromOffset(16, 16); clear.Position = UDim2.fromOffset(100, 5)
	clear.BackgroundTransparency = 1; clear.BorderSizePixel = 0; clear.AutoButtonColor = false; clear.ZIndex = 4
	clear.Image = "rbxassetid://78668603799563"
	clear.ImageColor3 = Color3.fromRGB(138, 138, 138); clear.ScaleType = Enum.ScaleType.Fit
	clear.Visible = false

	local function syncPH() ph.Visible = (box.Text == ""); clear.Visible = (box.Text ~= "") end
	box:GetPropertyChangedSignal("Text"):Connect(syncPH)

	box.Focused:Connect(function()
		ph.Visible = false
		TS:Create(border, TweenInfo.new(0.2), { Color = Color3.fromRGB(200, 200, 200), Transparency = 0.5 }):Play()
	end)
	box.FocusLost:Connect(function()
		syncPH()
		TS:Create(border, TweenInfo.new(0.2), { Color = white, Transparency = 0.92 }):Play()
		if props.ValueChanged then task.spawn(props.ValueChanged, box.Text) end
	end)

	clear.MouseButton1Click:Connect(function() box.Text = ""; box:CaptureFocus() end)

	syncPH()

	local obj = { Type = "TextField", __instance = sf }
	function obj:Parent(p) sf.Parent = p end
	obj.SetValue = function(v) box.Text = v end
	obj.GetValue = function() return box.Text end
	obj.SetPlaceholder = function(v) ph.Text = v end
	return obj
end