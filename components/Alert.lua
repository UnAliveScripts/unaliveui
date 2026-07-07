--[[
	UnAliveUI — Alert Component
	
	Centered alert dialog with expand/contract animation.
	Configurable title, description, and buttons with callbacks.
	Blur effect controlled via SetIntensity.
	
	Usage:
		local a = UI:New("Alert")
		a:Parent(gui)
		
		a.Show("Title", "Description", "Btn1", "Btn2",
			function() print("Btn1 clicked") end,
			function() print("Btn2 clicked") end
		)
		a.Dismiss()
		a.SetTitle("New Title")
		a.SetDescription("New desc")
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}
	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local blurFn = _G.__unaliveui_blur
	if not blurFn then blurFn = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/core/blur.lua"))() end

	local a = Instance.new("Frame")
	a.Name = "Alert"; a.Size = UDim2.fromOffset(260, 140)
	a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.5, 0)
	a.BackgroundTransparency = 1; a.BorderSizePixel = 0; a.ZIndex = 1000; a.Visible = false

	-- Shadow
	local sh = Instance.new("Frame", a); sh.Name = "Shadow"
	sh.Size = UDim2.new(1,4,1,4); sh.Position = UDim2.fromOffset(-2,-2)
	sh.BackgroundColor3 = Color3.fromRGB(0,0,0); sh.BackgroundTransparency = 0.78
	sh.BorderSizePixel = 0; sh.ZIndex = 998
	Instance.new("UICorner", sh).CornerRadius = UDim.new(0, 26)

	-- Background
	local bg = Instance.new("Frame", a); bg.Name = "Background"
	bg.Size = UDim2.fromScale(1,1); bg.BackgroundColor3 = dark; bg.BackgroundTransparency = 0.08
	bg.BorderSizePixel = 0; bg.ZIndex = 1000; bg.ClipsDescendants = true
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 26)
	local st = Instance.new("UIStroke", bg); st.Color = white; st.Transparency = 0.88; st.Thickness = 1

	-- Blur
	local bp = Instance.new("Frame", bg); bp.Name = "BlurPane"
	bp.Size = UDim2.new(1, -20, 1, -20); bp.Position = UDim2.fromOffset(10, 10)
	bp.BackgroundTransparency = 1; bp.BorderSizePixel = 0; bp.ZIndex = 999
	local bc = blurFn and blurFn(bp)
	if bc then bc.SetVisibility(false); bc.SetIntensity(1000) end

	-- Title
	local t = Instance.new("TextLabel", bg)
	t.Size = UDim2.fromOffset(216,16); t.Position = UDim2.fromOffset(22,20)
	t.BackgroundTransparency = 1; t.FontFace = Font.new("rbxassetid://12187365364",Enum.FontWeight.Bold)
	t.Text = "UnAlive"; t.TextSize = 13; t.TextColor3 = white
	t.TextXAlignment = Enum.TextXAlignment.Left; t.TextYAlignment = Enum.TextYAlignment.Center; t.RichText = true; t.ZIndex = 1002

	-- Description
	local d = Instance.new("TextLabel", bg)
	d.Size = UDim2.fromOffset(216,28); d.Position = UDim2.fromOffset(22,46)
	d.BackgroundTransparency = 1; d.FontFace = Font.new("rbxassetid://12187365364")
	d.Text = ""; d.TextSize = 11; d.TextColor3 = Color3.fromRGB(180,180,190)
	d.TextXAlignment = Enum.TextXAlignment.Left; d.TextYAlignment = Enum.TextYAlignment.Top; d.RichText = true; d.ZIndex = 1002

	-- Button maker
	local function mkBtn(x, text, dest, cb)
		local b = Instance.new("TextButton", bg)
		b.AutoButtonColor = false; b.Size = UDim2.fromOffset(110,32); b.Position = UDim2.fromOffset(x,92)
		b.BackgroundTransparency = 1; b.BorderSizePixel = 0; b.Text = ""; b.ZIndex = 1002
		Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
		local bb = Instance.new("Frame", b); bb.Size = UDim2.fromScale(1,1); bb.BorderSizePixel = 0; bb.ZIndex = 1001
		bb.BackgroundColor3 = dest and Color3.fromRGB(255,56,60) or Color3.fromRGB(230,230,230)
		bb.BackgroundTransparency = dest and 0.77 or 0; Instance.new("UICorner", bb).CornerRadius = UDim.new(1,0)
		local bl = Instance.new("TextLabel", b); bl.Size = UDim2.fromScale(1,1); bl.BackgroundTransparency = 1
		bl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium); bl.Text = text; bl.TextSize = 13
		bl.TextColor3 = dest and Color3.fromRGB(255,56,60) or Color3.fromRGB(0,0,0)
		bl.TextXAlignment = Enum.TextXAlignment.Center; bl.TextYAlignment = Enum.TextYAlignment.Center; bl.ZIndex = 1002
		b.MouseButton1Click:Connect(function() if cb then cb() end; hide() end)
	end

	-- Hide (local function, NOT on instance)
	local hide = function()
		if bc then bc.SetIntensity(1000); bc.SetVisibility(false) end
		TS:Create(bg, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Size = UDim2.fromOffset(0, 0) }):Play()
		TS:Create(sh, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play()
		task.delay(0.25, function() a.Visible = false; bg.Size = UDim2.fromScale(1,1); sh.BackgroundTransparency = 0.78 end)
	end

	-- Show (local function, NOT on instance)
	local show = function(title, desc, btn1, btn2, cb1, cb2)
		for _, c in pairs(bg:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
		t.Text = title or "UnAlive"; d.Text = desc or ""; d.Visible = (desc or "") ~= ""
		mkBtn(16, btn1 or "Turn OFF", true, cb1); mkBtn(134, btn2 or "Keep On", false, cb2)
		bg.Size = UDim2.fromOffset(0, 0); a.Visible = true
		TS:Create(bg, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 1) }):Play()
		if bc then bc.SetIntensity(0.1); bc.SetVisibility(true) end
	end

	-- Return obj with API functions
	local obj = { Type = "Alert", __instance = a }
	obj.Show = show
	obj.Dismiss = hide
	obj.SetTitle = function(v) t.Text = v end
	obj.SetDescription = function(v) d.Text = v; d.Visible = v ~= "" end
	function obj:Parent(p) a.Parent = p end
	return obj
end