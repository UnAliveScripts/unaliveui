--[[
	UnAliveUI — Notification Component
	
	macOS-style bottom-right notification with original design:
	- Shadow (4px oversized, 78% black)
	- Dark canvas (#12141a at 8%)
	- Blur effect (24px inset)
	- Icon (38×38, 10px rounded)
	- Title (SF Pro SemiBold 15px)
	- Description (SF Pro 15px)
	- Timestamp
	- Smooth slide-in animation
	- 12-second auto-dismiss
	
	Usage:
		local n = UI:New("Notification", {
			Title = "UnAlive",
			Description = "Welcome to UnAlive",
			Icon = "rbxassetid://127922205331150",
			Duration = 12,
		})
		n:Parent(gui)
		n.SetTitle("New Title")
		n.SetDescription("New description")
		n.Dismiss()
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Notification"
	props.Description = props.Description or ""
	props.Duration = props.Duration or 12
	props.Icon = props.Icon or "rbxassetid://127922205331150"

	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local blur = _G.__unaliveui_blur
	if not blur then
		blur = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/core/blur.lua"))()
	end

	local n = Instance.new("Frame")
	n.Name = "Notification"; n.Size = UDim2.fromOffset(386, 64)
	n.AnchorPoint = Vector2.new(1, 1)
	n.Position = UDim2.new(1, 30, 1, -12)
	n.BackgroundTransparency = 1; n.BorderSizePixel = 0; n.ZIndex = 999; n.ClipsDescendants = true
	Instance.new("UICorner", n).CornerRadius = UDim.new(0, 24)

	-- Shadow (4px oversized, black 78%)
	local ns = Instance.new("Frame", n); ns.Name = "Shadow"
	ns.Size = UDim2.new(1, 4, 1, 4); ns.Position = UDim2.fromOffset(-2, -2)
	ns.BackgroundColor3 = Color3.fromRGB(0, 0, 0); ns.BackgroundTransparency = 0.78
	ns.BorderSizePixel = 0; ns.ZIndex = -1
	Instance.new("UICorner", ns).CornerRadius = UDim.new(0, 24)

	-- Canvas (dark bg at 8%)
	local nc = Instance.new("Frame", n); nc.Name = "Canvas"
	nc.Size = UDim2.fromScale(1, 1)
	nc.BackgroundColor3 = dark; nc.BackgroundTransparency = 0.08
	nc.BorderSizePixel = 0; nc.ZIndex = 1
	Instance.new("UICorner", nc).CornerRadius = UDim.new(0, 24)

	-- Blur pane (24px inset at 12,12)
	local nb = Instance.new("Frame", n); nb.Name = "BlurPane"
	nb.Size = UDim2.new(1, -24, 1, -24); nb.Position = UDim2.fromOffset(12, 12)
	nb.BackgroundTransparency = 1; nb.BorderSizePixel = 0; nb.ZIndex = 0
	if blur then task.spawn(function() blur(nb) end) end

	-- Icon (38×38, rounded 10px)
	local ni = Instance.new("ImageLabel", n); ni.Name = "Icon"
	ni.Size = UDim2.fromOffset(38, 38); ni.Position = UDim2.fromOffset(14, 13)
	ni.BackgroundTransparency = 1; ni.BorderSizePixel = 0
	ni.Image = props.Icon; ni.ZIndex = 3
	Instance.new("UICorner", ni).CornerRadius = UDim.new(0, 10)

	-- Title
	local nt = Instance.new("TextLabel", n); nt.Name = "Title"
	nt.Size = UDim2.fromOffset(274, 17); nt.Position = UDim2.fromOffset(62, 12)
	nt.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	nt.Text = props.Title; nt.TextSize = 15; nt.TextColor3 = white
	nt.TextXAlignment = Enum.TextXAlignment.Left; nt.TextYAlignment = Enum.TextYAlignment.Top
	nt.RichText = true; nt.BackgroundTransparency = 1; nt.BorderSizePixel = 0; nt.ZIndex = 3

	-- Description
	local nd = Instance.new("TextLabel", n); nd.Name = "Description"
	nd.Size = UDim2.fromOffset(274, 18); nd.Position = UDim2.fromOffset(62, 30)
	nd.FontFace = Font.new("rbxassetid://12187365364")
	nd.Text = props.Description; nd.TextSize = 15
	nd.TextColor3 = Color3.fromRGB(180, 180, 190)
	nd.TextXAlignment = Enum.TextXAlignment.Left; nd.TextYAlignment = Enum.TextYAlignment.Top
	nd.RichText = true; nd.BackgroundTransparency = 1; nd.BorderSizePixel = 0; nd.ZIndex = 3
	nd.Visible = props.Description ~= ""

	-- Timestamp
	local nx = Instance.new("TextLabel", n); nx.Name = "Timestamp"
	nx.Size = UDim2.fromOffset(26, 17); nx.Position = UDim2.fromOffset(346, 12)
	nx.FontFace = Font.new("rbxassetid://12187365364")
	nx.Text = "now"; nx.TextSize = 13
	nx.TextColor3 = Color3.fromRGB(140, 140, 150)
	nx.TextXAlignment = Enum.TextXAlignment.Right; nx.TextYAlignment = Enum.TextYAlignment.Top
	nx.BackgroundTransparency = 1; nx.BorderSizePixel = 0; nx.ZIndex = 3

	-- Animate in from right
	TS:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -12, 1, -12)
	}):Play()

	-- Auto-dismiss
	local closed = false
	local function dismiss()
		if closed then return end; closed = true
		if props.Closed then task.spawn(props.Closed) end
		TS:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 50, 1, -12),
		}):Play()
		task.delay(0.4, function() if n.Parent then n:Destroy() end end)
	end

	if props.Duration and props.Duration > 0 then
		task.delay(props.Duration, function() if not closed then dismiss() end end)
	end

	local obj = { Type = "Notification", __instance = n }
	function obj:Parent(p) n.Parent = p end
	obj.SetTitle = function(t) nt.Text = t end
	obj.SetDescription = function(d) nd.Text = d; nd.Visible = d ~= "" end
	obj.SetIcon = function(id) ni.Image = id end
	obj.SetTimestamp = function(t) nx.Text = t end
	obj.Dismiss = dismiss
	return obj
end