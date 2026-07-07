--[[
	UnAliveUI — Notification Component
	
	Slide-in notification with title, subtitle, icon, timestamp, and blur.
	
	Usage:
		local notif = UI.Components.Notification(UI, {
			Title = "UnAlive",
			Subtitle = "Welcome to UnAlive",
			Duration = 6,
		})
		notif.Parent(frame)
--]]

local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Notification"
	props.Subtitle = props.Subtitle or ""
	props.Duration = props.Duration or 6

	local darkAlert = Color3.fromRGB(18, 20, 26)
	local white = Color3.fromRGB(255, 255, 255)
	local struct = {}
	local closed = false

	local body = C("Frame")({
		Name = "Notification",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 1),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(1, 187.5, 1, 0),
		Size = UDim2.fromOffset(386, 64),

		C("Frame")({
			Name = "Shadow",
			Size = UDim2.new(1, 4, 1, 4),
			Position = UDim2.fromOffset(-2, -2),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.78,
			BorderSizePixel = 0,
			ZIndex = -1,
			C("UICorner")({ CornerRadius = UDim.new(0, 24) }),
		}),

		C("Frame")({
			Name = "Canvas",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = darkAlert,
			BackgroundTransparency = 0.08,
			BorderSizePixel = 0,

			C("UICorner")({ CornerRadius = UDim.new(0, 24) }),
		}),

		C("Frame")({
			Name = "BlurPane",
			Size = UDim2.new(1, -24, 1, -24),
			Position = UDim2.fromOffset(12, 12),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 0,
		}),
	})

	struct.Body = body.__instance
	local canvas = struct.Body:FindFirstChild("Canvas")
	local blurPane = struct.Body:FindFirstChild("BlurPane")

	-- Apply blur
	local blur = _G.__unaliveui_blur
	if blur and blurPane then
		task.spawn(function() blur(blurPane) end)
	end

	-- Icon
	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.fromOffset(38, 38)
	icon.Position = UDim2.fromOffset(14, 13)
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Image = icons.UnAlivelogo or "rbxassetid://127922205331150"
	icon.ZIndex = 3
	Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 10)
	icon.Parent = canvas

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.fromOffset(274, 17)
	title.Position = UDim2.fromOffset(62, 12)
	title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	title.Text = props.Title
	title.TextSize = 15
	title.TextColor3 = white
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextYAlignment = Enum.TextYAlignment.Top
	title.RichText = true
	title.BackgroundTransparency = 1
	title.BorderSizePixel = 0
	title.ZIndex = 3
	title.Parent = canvas

	-- Subtitle
	local subtitle = Instance.new("TextLabel")
	subtitle.Size = UDim2.fromOffset(274, 18)
	subtitle.Position = UDim2.fromOffset(62, 30)
	subtitle.FontFace = Font.new("rbxassetid://12187365364")
	subtitle.Text = props.Subtitle
	subtitle.TextSize = 15
	subtitle.TextColor3 = Color3.fromRGB(180, 180, 190)
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.TextYAlignment = Enum.TextYAlignment.Top
	subtitle.RichText = true
	subtitle.BackgroundTransparency = 1
	subtitle.BorderSizePixel = 0
	subtitle.ZIndex = 3
	subtitle.Visible = props.Subtitle ~= ""
	subtitle.Parent = canvas

	-- Timestamp
	local timestamp = Instance.new("TextLabel")
	timestamp.Size = UDim2.fromOffset(26, 17)
	timestamp.Position = UDim2.fromOffset(346, 12)
	timestamp.FontFace = Font.new("rbxassetid://12187365364")
	timestamp.Text = "now"
	timestamp.TextSize = 13
	timestamp.TextColor3 = Color3.fromRGB(140, 140, 150)
	timestamp.TextXAlignment = Enum.TextXAlignment.Right
	timestamp.TextYAlignment = Enum.TextYAlignment.Top
	timestamp.BackgroundTransparency = 1
	timestamp.BorderSizePixel = 0
	timestamp.ZIndex = 3
	timestamp.Parent = canvas

	-- Animate in
	body.Position = UDim2.new(1, 187.5, 1, 0)
	TS:Create(struct.Body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -12, 1, -12),
	}):Play()

	local function close()
		if closed then return end
		closed = true
		if props.Closed then task.spawn(props.Closed) end
		TS:Create(struct.Body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = struct.Body.Position + UDim2.fromOffset(350, 0),
		}):Play()
		task.delay(0.4, function()
			if struct.Body and struct.Body.Parent then struct.Body:Destroy() end
		end)
	end

	if props.Duration and props.Duration > 0 then
		task.delay(props.Duration, function()
			if struct.Body and struct.Body.Parent then close() end
		end)
	end

	local obj = {
		Type = "Notification",
		Theme = self and self.Theme,
		Structures = struct,
		__instance = struct.Body,
	}
	function obj:Close() close() end
	function obj:SetTitle(v) title.Text = v end
	function obj:SetSubtitle(v) subtitle.Text = v; subtitle.Visible = v ~= "" end
	return obj
end