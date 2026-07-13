local TweenService = game:GetService("TweenService")

return function(self, properties)
	properties = properties or {}

	local player = game:GetService("Players").LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local existingPill = playerGui:FindFirstChild("UnAliveUI_Pill")
	if existingPill then existingPill:Destroy() end

	local pillGui = Instance.new("ScreenGui")
	pillGui.Name = "UnAliveUI_Pill"
	pillGui.ResetOnSpawn = false
	pillGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pillGui.DisplayOrder = 200
	pillGui.IgnoreGuiInset = true
	pillGui.Parent = playerGui

	local pill = Instance.new("ImageButton")
	pill.Name = "WindowPill"
	pill.AnchorPoint = Vector2.new(0.5, 0)
	pill.AutoButtonColor = false
	pill.BackgroundTransparency = 1
	pill.BorderSizePixel = 0
	pill.Image = "rbxassetid://93520763686656"
	pill.ImageTransparency = 0.5
	pill.Position = UDim2.new(0.5, 0, 0, 10)
	pill.Size = UDim2.fromOffset(180, 5)
	pill.ZIndex = 999
	pill.Parent = pillGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = pill

	local hoverConnection
	local enterConnection
	local leaveConnection

	local function connectHover()
		local tween
		enterConnection = pill.MouseEnter:Connect(function()
			if tween then tween:Cancel() end
			tween = TweenService:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.15 })
			tween:Play()
		end)
		leaveConnection = pill.MouseLeave:Connect(function()
			if tween then tween:Cancel() end
			tween = TweenService:Create(pill, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { ImageTransparency = 0.5 })
			tween:Play()
		end)
	end

	connectHover()

	return {
		Type = "WindowPill",
		Instance = pill,
		Gui = pillGui,
		OnClick = function(callback)
			if hoverConnection then hoverConnection:Disconnect() end
			hoverConnection = pill.MouseButton1Click:Connect(callback)
		end,
		Destroy = function()
			if enterConnection then enterConnection:Disconnect() end
			if leaveConnection then leaveConnection:Disconnect() end
			if hoverConnection then hoverConnection:Disconnect() end
			pillGui:Destroy()
		end,
	}
end
