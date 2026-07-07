--[[
	UnAliveUI — Notification Component
	
	macOS-style bottom-right notification with swipe-to-dismiss.
	Smooth entrance/exit animations. Fully configurable API.
	
	Usage:
		local n = UI:New("Notification", {
			Title = "UnAlive",
			Description = "Welcome to UnAlive",
			Icon = "rbxassetid://127922205331150",
			Duration = 5, -- seconds, 0 = manual dismiss
		})
		n:Parent(gui)
		
		-- API
		n.SetTitle("New Title")
		n.SetDescription("New description")
		n.SetIcon("rbxassetid://...")
		n.SetTimestamp("2m ago")
		n.Dismiss() -- manually dismiss
--]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Notification"
	props.Description = props.Description or ""
	props.Duration = props.Duration or 5
	props.Icon = props.Icon or "rbxassetid://127922205331150"

	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local closed = false; local dragging = false; local dragStart, dragStartPos
	local targetPos = UDim2.new(1, -12, 1, -12)

	local n = Instance.new("Frame")
	n.Name = "Notification"; n.Size = UDim2.fromOffset(386, 64)
	n.Position = UDim2.new(1, 50, 1, -12)
	n.BackgroundTransparency = 1; n.BorderSizePixel = 0; n.ZIndex = 100; n.ClipsDescendants = true
	Instance.new("UICorner", n).CornerRadius = UDim.new(0, 24)

	-- Shadow
	local shadow = Instance.new("Frame", n); shadow.Name = "Shadow"
	shadow.Size = UDim2.new(1, 4, 1, 4); shadow.Position = UDim2.fromOffset(-2, -2)
	shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0); shadow.BackgroundTransparency = 0.78
	shadow.BorderSizePixel = 0; shadow.ZIndex = -1
	Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 24)

	-- Canvas
	local canvas = Instance.new("Frame", n); canvas.Name = "Canvas"
	canvas.Size = UDim2.fromScale(1, 1)
	canvas.BackgroundColor3 = dark; canvas.BackgroundTransparency = 0.08
	canvas.BorderSizePixel = 0; canvas.ZIndex = 1
	Instance.new("UICorner", canvas).CornerRadius = UDim.new(0, 24)

	-- Blur
	local blurPane = Instance.new("Frame", n); blurPane.Name = "BlurPane"
	blurPane.Size = UDim2.new(1, -22, 1, -22); blurPane.Position = UDim2.fromOffset(11, 11)
	blurPane.BackgroundTransparency = 1; blurPane.BorderSizePixel = 0; blurPane.ZIndex = 0
	_G.__unaliveui_blur = _G.__unaliveui_blur or loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/core/blur.lua"))()
	if _G.__unaliveui_blur and blurPane then task.spawn(function() _G.__unaliveui_blur(blurPane) end) end

	-- Icon
	local icon = Instance.new("ImageLabel", canvas)
	icon.Size = UDim2.fromOffset(38, 38); icon.Position = UDim2.fromOffset(14, 13)
	icon.BackgroundTransparency = 1; icon.BorderSizePixel = 0
	icon.Image = props.Icon; icon.ZIndex = 3
	Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 10)

	-- Title
	local titleLbl = Instance.new("TextLabel", canvas)
	titleLbl.Size = UDim2.fromOffset(274, 17); titleLbl.Position = UDim2.fromOffset(62, 12)
	titleLbl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	titleLbl.Text = props.Title; titleLbl.TextSize = 15; titleLbl.TextColor3 = white
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left; titleLbl.TextYAlignment = Enum.TextYAlignment.Top
	titleLbl.RichText = true; titleLbl.BackgroundTransparency = 1; titleLbl.ZIndex = 3

	-- Description
	local descLbl = Instance.new("TextLabel", canvas)
	descLbl.Size = UDim2.fromOffset(274, 18); descLbl.Position = UDim2.fromOffset(62, 30)
	descLbl.FontFace = Font.new("rbxassetid://12187365364")
	descLbl.Text = props.Description; descLbl.TextSize = 15
	descLbl.TextColor3 = Color3.fromRGB(180, 180, 190)
	descLbl.TextXAlignment = Enum.TextXAlignment.Left; descLbl.TextYAlignment = Enum.TextYAlignment.Top
	descLbl.RichText = true; descLbl.BackgroundTransparency = 1; descLbl.ZIndex = 3
	descLbl.Visible = props.Description ~= ""

	-- Timestamp
	local timeLbl = Instance.new("TextLabel", canvas)
	timeLbl.Size = UDim2.fromOffset(26, 17); timeLbl.Position = UDim2.fromOffset(346, 12)
	timeLbl.FontFace = Font.new("rbxassetid://12187365364")
	timeLbl.Text = "now"; timeLbl.TextSize = 13
	timeLbl.TextColor3 = Color3.fromRGB(140, 140, 150)
	timeLbl.TextXAlignment = Enum.TextXAlignment.Right; timeLbl.TextYAlignment = Enum.TextYAlignment.Top
	timeLbl.BackgroundTransparency = 1; timeLbl.ZIndex = 3

	-- Animate in
	TS:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Position = targetPos
	}):Play()

	-- Auto-dismiss
	if props.Duration and props.Duration > 0 then
		task.delay(props.Duration, function()
			if not closed then dismiss() end
		end)
	end

	-- Dismiss function
	local function dismiss()
		if closed then return end; closed = true
		if props.Closed then task.spawn(props.Closed) end
		TS:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 50, 1, -12),
		}):Play()
		task.delay(0.4, function() if n.Parent then n:Destroy() end end)
	end

	-- Swipe to dismiss
	canvas.InputBegan:Connect(function(i, gp)
		if gp or closed then return end
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = i.Position; dragStartPos = n.Position
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if not dragging then return end
		if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
			local delta = i.Position.X - dragStart.X
			if delta > 0 then
				n.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta, dragStartPos.Y.Scale, dragStartPos.Y.Offset)
			end
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if not dragging then return end
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			local currentX = n.Position.X.Offset
			if currentX > 100 then
				dismiss()
			else
				TS:Create(n, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Position = targetPos
				}):Play()
			end
		end
	end)

	local obj = { Type = "Notification", __instance = n }
	function obj:Parent(p) n.Parent = p end
	obj.SetTitle = function(t) titleLbl.Text = t end
	obj.SetDescription = function(d) descLbl.Text = d; descLbl.Visible = d ~= "" end
	obj.SetIcon = function(id) icon.Image = id end
	obj.SetTimestamp = function(t) timeLbl.Text = t end
	obj.Dismiss = dismiss
	return obj
end