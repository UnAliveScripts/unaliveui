--[[
	UnAliveUI — Alert Component
	
	Centered alert dialog with fade in/out animations.
	Configurable title, description, and buttons with callbacks.
	
	Usage:
		local a = UI:New("Alert")
		a:Parent(gui)
		
		a:Show("Title", "Description", "Btn1", "Btn2",
			function() print("Btn1 clicked") end,
			function() print("Btn2 clicked") end
		)
		
		-- Manual API
		a.SetTitle("New Title")
		a.SetDescription("New description")
		a.Dismiss()
--]]

local TS = game:GetService("TweenService")

return function(self, props)
	props = props or {}

	local dark = Color3.fromRGB(18, 20, 26); local white = Color3.fromRGB(255, 255, 255)
	local blur = _G.__unaliveui_blur
	if not blur then
		blur = loadstring(game:HttpGet("https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/core/blur.lua"))()
	end

	local a = Instance.new("Frame")
	a.Name = "Alert"; a.Size = UDim2.fromOffset(260, 140)
	a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.5, 0)
	a.BackgroundTransparency = 1; a.BorderSizePixel = 0; a.ZIndex = 1000; a.ClipsDescendants = true
	a.Visible = false
	Instance.new("UICorner", a).CornerRadius = UDim.new(0, 10)

	-- Shadow
	local aShadow = Instance.new("Frame", a); aShadow.Name = "Shadow"
	aShadow.Size = UDim2.new(1, 4, 1, 4); aShadow.Position = UDim2.fromOffset(-2, -2)
	aShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0); aShadow.BackgroundTransparency = 0.78
	aShadow.BorderSizePixel = 0; aShadow.ZIndex = 98
	Instance.new("UICorner", aShadow).CornerRadius = UDim.new(0, 26)

	-- Background
	local aBg = Instance.new("Frame", a); aBg.Name = "Background"
	aBg.Size = UDim2.fromScale(1, 1)
	aBg.BackgroundColor3 = dark; aBg.BackgroundTransparency = 0.08
	aBg.BorderSizePixel = 0; aBg.ZIndex = 100
	Instance.new("UICorner", aBg).CornerRadius = UDim.new(0, 26)

	-- Border
	local aStroke = Instance.new("UIStroke", aBg)
	aStroke.Color = white; aStroke.Transparency = 0.88; aStroke.Thickness = 1

	-- Blur
	local aBlur = Instance.new("Frame", a); aBlur.Name = "BlurPane"
	aBlur.Size = UDim2.new(1, -20, 1, -20); aBlur.Position = UDim2.fromOffset(10, 10)
	aBlur.BackgroundTransparency = 1; aBlur.BorderSizePixel = 0; aBlur.ZIndex = 99
	if blur then task.spawn(function() blur(aBlur) end) end

	-- Title
	local aTitle = Instance.new("TextLabel", aBg)
	aTitle.Size = UDim2.fromOffset(216, 16); aTitle.Position = UDim2.fromOffset(22, 20)
	aTitle.BackgroundTransparency = 1; aTitle.BorderSizePixel = 0
	aTitle.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold)
	aTitle.Text = "UnAlive"; aTitle.TextSize = 13; aTitle.TextColor3 = white
	aTitle.TextXAlignment = Enum.TextXAlignment.Left; aTitle.TextYAlignment = Enum.TextYAlignment.Center
	aTitle.RichText = true; aTitle.ZIndex = 102

	-- Description
	local aDesc = Instance.new("TextLabel", aBg)
	aDesc.Size = UDim2.fromOffset(216, 28); aDesc.Position = UDim2.fromOffset(22, 46)
	aDesc.BackgroundTransparency = 1; aDesc.BorderSizePixel = 0
	aDesc.FontFace = Font.new("rbxassetid://12187365364")
	aDesc.Text = ""; aDesc.TextSize = 11
	aDesc.TextColor3 = Color3.fromRGB(180, 180, 190)
	aDesc.TextXAlignment = Enum.TextXAlignment.Left; aDesc.TextYAlignment = Enum.TextYAlignment.Top
	aDesc.RichText = true; aDesc.ZIndex = 102

	-- Button maker
	local function makeBtn(x, text, destructive, callback)
		local b = Instance.new("TextButton", aBg)
		b.AutoButtonColor = false; b.Size = UDim2.fromOffset(110, 32); b.Position = UDim2.fromOffset(x, 92)
		b.BackgroundTransparency = 1; b.BorderSizePixel = 0; b.Text = ""; b.ZIndex = 102
		Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

		local bBg = Instance.new("Frame", b)
		bBg.Size = UDim2.fromScale(1, 1); bBg.BorderSizePixel = 0; bBg.ZIndex = 101
		bBg.BackgroundColor3 = destructive and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(230, 230, 230)
		bBg.BackgroundTransparency = destructive and 0.77 or 0
		Instance.new("UICorner", bBg).CornerRadius = UDim.new(1, 0)

		local bLbl = Instance.new("TextLabel", b)
		bLbl.Size = UDim2.fromScale(1, 1); bLbl.BackgroundTransparency = 1; bLbl.BorderSizePixel = 0
		bLbl.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium)
		bLbl.Text = text; bLbl.TextSize = 13
		bLbl.TextColor3 = destructive and Color3.fromRGB(255, 56, 60) or Color3.fromRGB(0, 0, 0)
		bLbl.TextXAlignment = Enum.TextXAlignment.Center; bLbl.TextYAlignment = Enum.TextYAlignment.Center
		bLbl.ZIndex = 102

		b.MouseButton1Click:Connect(function()
			if callback then callback() end
			dismiss()
		end)
		return b
	end

	-- Dismiss with fade out
	local function dismiss()
		for _, c in pairs(a:GetDescendants()) do
			if c:IsA("TextLabel") or c:IsA("TextButton") then
				TS:Create(c, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
			end
		end
		TS:Create(a, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(0, 0),
		}):Play()
		task.delay(0.3, function()
			a.Visible = false
			a.Size = UDim2.fromOffset(260, 140)
			a.BackgroundTransparency = 1
			for _, c in pairs(a:GetDescendants()) do
				if c:IsA("TextLabel") or c:IsA("TextButton") then c.TextTransparency = 0 end
			end
		end)
	end

	-- Show with fade in
	function a:Show(title, desc, btn1Label, btn2Label, btn1Cb, btn2Cb)
		for _, c in pairs(aBg:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end

		aTitle.Text = title or "UnAlive"
		aDesc.Text = desc or ""
		aDesc.Visible = (desc or "") ~= ""

		makeBtn(16, btn1Label or "Turn OFF", true, btn1Cb)
		makeBtn(134, btn2Label or "Keep On", false, btn2Cb)

		a.Size = UDim2.fromOffset(260, 140)
		a.BackgroundTransparency = 1
		a.Visible = true

		TS:Create(a, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0,
		}):Play()

		for _, c in pairs(a:GetDescendants()) do
			if c:IsA("TextLabel") or c:IsA("TextButton") then
				c.TextTransparency = 1
				TS:Create(c, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
			end
		end
	end

	-- Static API
	a.Dismiss = dismiss
	a.SetTitle = function(t) aTitle.Text = t end
	a.SetDescription = function(d) aDesc.Text = d; aDesc.Visible = d ~= "" end

	local obj = { Type = "Alert", __instance = a }
	function obj:Parent(p) a.Parent = p end
	obj.Show = a.Show
	obj.Dismiss = a.Dismiss
	obj.SetTitle = a.SetTitle
	obj.SetDescription = a.SetDescription
	return obj
end