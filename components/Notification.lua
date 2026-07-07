local TS = game:GetService("TweenService")
local blur = _G.__unaliveui_blur

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Notification"
	props.Subtitle = props.Subtitle or ""
	props.Duration = props.Duration or 6

	local dark = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)
	local closed = false

	local body = Instance.new("Frame")
	body.Name = "Notification"
	body.BackgroundTransparency = 1
	body.BorderSizePixel = 0
	body.AnchorPoint = Vector2.new(1, 1)
	body.Size = UDim2.fromOffset(386, 64)
	body.ZIndex = 10

	local shadow = Instance.new("Frame", body)
	shadow.Size = UDim2.new(1, 4, 1, 4); shadow.Position = UDim2.fromOffset(-2, -2)
	shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0); shadow.BackgroundTransparency = 0.78
	shadow.BorderSizePixel = 0; shadow.ZIndex = -1
	Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 24)

	local canvas = Instance.new("Frame", body)
	canvas.Size = UDim2.fromScale(1, 1)
	canvas.BackgroundColor3 = dark; canvas.BackgroundTransparency = 0.08
	canvas.BorderSizePixel = 0; canvas.ZIndex = 1
	Instance.new("UICorner", canvas).CornerRadius = UDim.new(0, 24)

	local blurPane = Instance.new("Frame", body)
	blurPane.Size = UDim2.new(1, -22, 1, -22)
	blurPane.Position = UDim2.fromOffset(11, 11)
	blurPane.BackgroundTransparency = 1; blurPane.BorderSizePixel = 0; blurPane.ZIndex = 0

	if blur and blurPane then task.spawn(function() blur(blurPane) end) end

	local icon = Instance.new("ImageLabel", canvas)
	icon.Size = UDim2.fromOffset(38, 38); icon.Position = UDim2.fromOffset(14, 13)
	icon.BackgroundTransparency = 1; icon.Image = "rbxassetid://127922205331150"; icon.ZIndex = 3
	Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel", canvas)
	title.Size = UDim2.fromOffset(274, 17); title.Position = UDim2.fromOffset(62, 12)
	title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	title.Text = props.Title; title.TextSize = 15; title.TextColor3 = white
	title.TextXAlignment = Enum.TextXAlignment.Left; title.TextYAlignment = Enum.TextYAlignment.Top
	title.RichText = true; title.BackgroundTransparency = 1; title.ZIndex = 3

	local subtitle = Instance.new("TextLabel", canvas)
	subtitle.Size = UDim2.fromOffset(274, 18); subtitle.Position = UDim2.fromOffset(62, 30)
	subtitle.FontFace = Font.new("rbxassetid://12187365364")
	subtitle.Text = props.Subtitle; subtitle.TextSize = 15
	subtitle.TextColor3 = Color3.fromRGB(180, 180, 190)
	subtitle.TextXAlignment = Enum.TextXAlignment.Left; subtitle.TextYAlignment = Enum.TextYAlignment.Top
	subtitle.RichText = true; subtitle.BackgroundTransparency = 1; subtitle.ZIndex = 3
	subtitle.Visible = props.Subtitle ~= ""

	local timestamp = Instance.new("TextLabel", canvas)
	timestamp.Size = UDim2.fromOffset(26, 17); timestamp.Position = UDim2.fromOffset(346, 12)
	timestamp.FontFace = Font.new("rbxassetid://12187365364")
	timestamp.Text = "now"; timestamp.TextSize = 13
	timestamp.TextColor3 = Color3.fromRGB(140, 140, 150)
	timestamp.TextXAlignment = Enum.TextXAlignment.Right; timestamp.TextYAlignment = Enum.TextYAlignment.Top
	timestamp.BackgroundTransparency = 1; timestamp.ZIndex = 3

	body.Position = UDim2.new(1, 187.5, 1, 0)
	TS:Create(body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { Position = UDim2.new(1, -12, 1, -12) }):Play()

	local function close()
		if closed then return end; closed = true
		if props.Closed then task.spawn(props.Closed) end
		TS:Create(body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { Position = body.Position + UDim2.fromOffset(350, 0) }):Play()
		task.delay(0.4, function() if body.Parent then body:Destroy() end end)
	end

	if props.Duration and props.Duration > 0 then
		task.delay(props.Duration, function() if body.Parent then close() end end)
	end

	local obj = { Type = "Notification", __instance = body }
	function obj.Parent(p) body.Parent = p end
	function obj:Close() close() end
	function obj:SetTitle(v) title.Text = v end
	function obj:SetSubtitle(v) subtitle.Text = v; subtitle.Visible = v ~= "" end
	return obj
end