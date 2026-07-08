--[[
	UnAliveUI — Slider Component
	
	iOS 26-style slider with 5 tick values, click/drag interaction,
	bouncy snap animation, and turtle/rabbit icons.
	
	Usage:
		local sl = UI:New("Slider", {
			Value = 3, -- 1-5
			ValueChanged = function(v) print("Value:", v) end,
		})
		sl:Parent(gui)
--]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

return function(self, props)
	props = props or {}
	props.Value = math.max(1, math.min(5, props.Value or 3))

	local tickX = {0, 31, 62, 93, 124}
	local TO = 76; local TR = 60; local HK = 19
	local curVal = props.Value
	local ticks = {}

	local s = Instance.new("Frame")
	s.Name = "Slider"; s.Size = UDim2.fromOffset(280, 36)
	s.BackgroundTransparency = 1; s.ZIndex = 25

	-- Separator
	local sep = Instance.new("Frame", s)
	sep.Size = UDim2.fromOffset(248, 1); sep.Position = UDim2.fromOffset(16, 0)
	sep.BackgroundColor3 = Color3.fromRGB(26, 26, 26); sep.BorderSizePixel = 0

	-- Turtle (left)
	local tBtn = Instance.new("ImageButton", s); tBtn.Name = "Turtle"
	tBtn.Size = UDim2.fromOffset(32, 34); tBtn.Position = UDim2.fromOffset(16, 1)
	tBtn.BackgroundTransparency = 1; tBtn.AutoButtonColor = false; tBtn.ZIndex = 26
	tBtn.Image = "rbxassetid://71204780762950"
	tBtn.ImageColor3 = Color3.fromRGB(235, 235, 245); tBtn.ImageTransparency = 0.3; tBtn.ScaleType = Enum.ScaleType.Fit

	-- Rabbit (right)
	local rBtn = Instance.new("ImageButton", s); rBtn.Name = "Rabbit"
	rBtn.Size = UDim2.fromOffset(32, 34); rBtn.Position = UDim2.fromOffset(232, 1)
	rBtn.BackgroundTransparency = 1; rBtn.AutoButtonColor = false; rBtn.ZIndex = 26
	rBtn.Image = "rbxassetid://75864421459611"
	rBtn.ImageColor3 = Color3.fromRGB(235, 235, 245); rBtn.ImageTransparency = 0.3; rBtn.ScaleType = Enum.ScaleType.Fit

	-- Track
	local track = Instance.new("Frame", s)
	track.Size = UDim2.fromOffset(160, 6); track.Position = UDim2.fromOffset(60, 15)
	track.BackgroundColor3 = Color3.fromRGB(120, 120, 128); track.BackgroundTransparency = 0.64
	track.BorderSizePixel = 0; track.ZIndex = 26
	Instance.new("UICorner", track).CornerRadius = UDim.new(0, 3)

	-- Fill
	local fill = Instance.new("Frame", s)
	fill.Size = UDim2.fromOffset(0, 6); fill.Position = UDim2.fromOffset(60, 15)
	fill.BackgroundColor3 = Color3.fromRGB(0, 145, 255); fill.BorderSizePixel = 0; fill.ZIndex = 27
	Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)

	-- Ticks
	for i, ox in ipairs(tickX) do
		local tk = Instance.new("Frame", s); tk.Name = "Tick"..i
		tk.Size = UDim2.fromOffset(4, 4); tk.Position = UDim2.fromOffset(TO + ox - 2, 25)
		tk.BackgroundColor3 = Color3.fromRGB(235, 235, 245); tk.BackgroundTransparency = 0.84
		tk.BorderSizePixel = 0; tk.ZIndex = 27
		Instance.new("UICorner", tk).CornerRadius = UDim.new(0, 2)
		ticks[i] = tk
	end

	-- Knob
	local knob = Instance.new("Frame", s); knob.Name = "Knob"
	knob.Size = UDim2.fromOffset(38, 24); knob.Position = UDim2.fromOffset(TO + tickX[curVal] - HK, 6)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.ZIndex = 28
	Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 12)

	local kh = Instance.new("ImageButton", knob)
	kh.Size = UDim2.fromScale(1, 1); kh.BackgroundTransparency = 1
	kh.BorderSizePixel = 0; kh.ZIndex = 29; kh.AutoButtonColor = false

	-- Track hitbox
	local hb = Instance.new("TextButton", s)
	hb.Size = UDim2.fromOffset(160, 34); hb.Position = UDim2.fromOffset(60, 1)
	hb.BackgroundTransparency = 1; hb.BorderSizePixel = 0; hb.Text = ""; hb.ZIndex = 25; hb.AutoButtonColor = false

	-- Functions
	local function gpx(mx)
		return math.max(0, math.min(160, mx - track.AbsolutePosition.X))
	end
	local function gidx(px)
		return math.max(1, math.min(5, math.floor(px / 31 + 0.5) + 1))
	end

	local function updateTicks(idx)
		for i, tk in ipairs(ticks) do if tk then
			local a = i <= idx
			tk.BackgroundTransparency = a and 0 or 0.84
			tk.BackgroundColor3 = a and Color3.fromRGB(0, 145, 255) or Color3.fromRGB(235, 235, 245)
		end end
	end

	local function snap()
		local idx = gidx(gpx(props.Value))
		-- Actually use mouse position
		idx = gidx(gpx(UIS:GetMouseLocation().X))
		curVal = idx; local cx = tickX[idx]
		local fw = math.max(0, math.min(160, cx + TO - TR))
		TS:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.3), { Position = UDim2.fromOffset(TO + cx - HK, 6) }):Play()
		TS:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(fw, 6) }):Play()
		updateTicks(idx)
		if props.ValueChanged then task.spawn(props.ValueChanged, idx) end
	end

	local function snapTo(idx)
		idx = math.max(1, math.min(5, idx)); curVal = idx; local cx = tickX[idx]
		local fw = math.max(0, math.min(160, cx + TO - TR))
		TS:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.3), { Position = UDim2.fromOffset(TO + cx - HK, 6) }):Play()
		TS:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(fw, 6) }):Play()
		updateTicks(idx)
		if props.ValueChanged then task.spawn(props.ValueChanged, idx) end
	end

	local function dragTo(mx)
		local px = gpx(mx); local cx = math.max(0, math.min(160, px))
		local kl = math.max(TO - HK, math.min(TO + 128 - HK, TO + cx - HK))
		TS:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(kl, 6) }):Play()
		local fw = math.max(0, math.min(160, cx + TO - TR))
		TS:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(fw, 6) }):Play()
		updateTicks(gidx(px))
	end

	-- Connections
	hb.MouseButton1Click:Connect(function() snap() end)
	tBtn.MouseButton1Click:Connect(function() snapTo(curVal - 1) end)
	rBtn.MouseButton1Click:Connect(function() snapTo(curVal + 1) end)

	local dragging = false
	kh.MouseButton1Down:Connect(function() dragging = true end)
	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then dragTo(i.Position.X) end
	end)
	UIS.InputEnded:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false; snap()
		end
	end)

	-- Initial position
	local icx = tickX[curVal]
	knob.Position = UDim2.fromOffset(TO + icx - HK, 6)
	fill.Size = UDim2.fromOffset(math.max(0, math.min(160, icx + TO - TR)), 6)
	updateTicks(curVal)

	local obj = { Type = "Slider", __instance = s }
	function obj:Parent(p) s.Parent = p end
	function obj:GetValue() return curVal end
	function obj:SetValue(v) snapTo(v) end
	return obj
end