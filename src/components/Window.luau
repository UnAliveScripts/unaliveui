local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function createTween(obj, props, duration, style, direction)
	TweenService:Create(
		obj,
		TweenInfo.new(duration or 0.25, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
		props
	):Play()
end

return function(self, properties)
	properties = properties or {}
	local theme = self.Theme
	local windowConfig = theme.Window
	local titleBarConfig = theme.TitleBar
	local dragConfig = properties.Drag or { Smoothness = 0.15, ScaleDown = 0.97, ScaleDuration = 0.15 }

	local player = game:GetService("Players").LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local existing = playerGui:FindFirstChild("UnAliveUI")
	if existing then existing:Destroy() end

	local width = properties.Size and properties.Size.X or windowConfig.Width
	local height = properties.Size and properties.Size.Y or windowConfig.Height
	local title = properties.Title or titleBarConfig.Text

	local gui = Instance.new("ScreenGui")
	gui.Name = "UnAliveUI"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 999
	gui.Parent = playerGui

	local uiScale = Instance.new("UIScale")
	uiScale.Name = "UIScale"
	uiScale.Parent = gui

	local window = Instance.new("Frame")
	window.Name = "Window"
	window.Size = UDim2.new(0, width, 0, height)
	window.AnchorPoint = Vector2.new(0.5, 0.5)
	window.Position = UDim2.fromScale(0.5, 0.5)
	window.BackgroundColor3 = windowConfig.Background
	window.BorderSizePixel = 0
	window.ClipsDescendants = false
	window.ZIndex = 2
	window.Parent = gui

	local windowCorner = Instance.new("UICorner")
	windowCorner.CornerRadius = UDim.new(0, windowConfig.CornerRadius)
	windowCorner.Parent = window

	local windowStroke = Instance.new("UIStroke")
	windowStroke.Color = windowConfig.Border
	windowStroke.Thickness = windowConfig.BorderThickness
	windowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	windowStroke.Parent = window

	-- Shadow
	if windowConfig.Shadow.Enabled then
		local shadow = Instance.new("Frame")
		shadow.Name = "Shadow"
		shadow.Size = UDim2.new(1, 6, 1, 6)
		shadow.Position = UDim2.new(0, -3, 0, -3)
		shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		shadow.BackgroundTransparency = windowConfig.Shadow.Transparency
		shadow.BorderSizePixel = 0
		shadow.ZIndex = 1
		shadow.Parent = window

		local shadowCorner = Instance.new("UICorner")
		shadowCorner.CornerRadius = UDim.new(0, windowConfig.CornerRadius)
		shadowCorner.Parent = shadow
	end

	-- Title Bar
	local titleBarHeight = titleBarConfig.Height
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, titleBarHeight)
	titleBar.BackgroundColor3 = titleBarConfig.Background
	titleBar.BorderSizePixel = 0
	titleBar.ZIndex = 10
	titleBar.Parent = window

	local titleBarCorner = Instance.new("UICorner")
	titleBarCorner.CornerRadius = UDim.new(0, windowConfig.CornerRadius)
	titleBarCorner.Parent = titleBar

	local titleBarMask = Instance.new("Frame")
	titleBarMask.Name = "BottomMask"
	titleBarMask.Size = UDim2.new(1, 0, 0, windowConfig.CornerRadius)
	titleBarMask.Position = UDim2.new(0, 0, 1, -windowConfig.CornerRadius)
	titleBarMask.BackgroundColor3 = titleBarConfig.Background
	titleBarMask.BorderSizePixel = 0
	titleBarMask.ZIndex = 10
	titleBarMask.Parent = titleBar

	local titleBarLine = Instance.new("Frame")
	titleBarLine.Name = "Hairline"
	titleBarLine.Size = UDim2.new(1, 0, 0, 1)
	titleBarLine.Position = UDim2.new(0, 0, 1, -1)
	titleBarLine.BackgroundColor3 = titleBarConfig.Line
	titleBarLine.BorderSizePixel = 0
	titleBarLine.ZIndex = 11
	titleBarLine.Parent = titleBar

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(0, 200, 0, titleBarConfig.TextSize)
	titleLabel.AnchorPoint = Vector2.new(0, 0.5)
	titleLabel.Position = UDim2.new(0, titleBarConfig.TextLeft, 0.5, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.Font = titleBarConfig.Font
	titleLabel.TextSize = titleBarConfig.TextSize
	titleLabel.TextColor3 = titleBarConfig.TextColor
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextYAlignment = Enum.TextYAlignment.Center
	titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	titleLabel.ZIndex = 11
	titleLabel.Parent = titleBar

	-- Traffic Light Dots
	local dotConfig = theme.Dots
	if dotConfig.Enabled then
		local dotData = {
			{ Name = "Exit", Color = dotConfig.Close, Icon = "rbxassetid://94781753558308" },
			{ Name = "Minimize", Color = dotConfig.Minimize, Icon = "rbxassetid://118368309445367" },
		}

		local dotIcons = {}
		for index, data in ipairs(dotData) do
			local offset = dotConfig.RightOffset + dotConfig.Size / 2 + (2 - index) * (dotConfig.Size + dotConfig.Spacing)

			local dot = Instance.new("ImageButton")
			dot.Name = data.Name
			dot.AnchorPoint = Vector2.new(0.5, 0.5)
			dot.Position = UDim2.new(1, -offset, 0.5, 0)
			dot.AutoButtonColor = false
			dot.BackgroundTransparency = 1
			dot.BorderSizePixel = 0
			dot.Image = "rbxassetid://132228700346004"
			dot.ImageColor3 = data.Color
			dot.ImageTransparency = 0
			dot.Size = UDim2.fromOffset(dotConfig.Size, dotConfig.Size)
			dot.ZIndex = 15
			dot.Parent = titleBar

			local icon = Instance.new("ImageLabel")
			icon.Name = "Icon"
			icon.AnchorPoint = Vector2.new(0.5, 0.5)
			icon.BackgroundTransparency = 1
			icon.BorderSizePixel = 0
			icon.Image = data.Icon
			icon.ImageColor3 = Color3.fromRGB(0, 0, 0)
			icon.ImageTransparency = 0.50
			icon.Position = UDim2.fromScale(0.5, 0.5)
			icon.Size = UDim2.fromScale(1, 1)
			icon.Visible = false
			icon.Parent = dot

			dot.MouseEnter:Connect(function()
				icon.Visible = true
			end)
			dot.MouseLeave:Connect(function()
				icon.Visible = false
			end)

			table.insert(dotIcons, { Button = dot, Icon = icon, Name = data.Name })
		end
	end

	-- Drag System
	local isDragging = false
	local dragStart, dragPosition
	local targetPosition = window.Position
	local dragConnection

	local function startDrag(input)
		isDragging = true
		dragStart = input.Position
		dragPosition = window.Position
		targetPosition = dragPosition

		createTween(uiScale, { Scale = dragConfig.ScaleDown }, dragConfig.ScaleDuration)

		local shadow = window:FindFirstChild("Shadow")
		if shadow and shadow:IsA("Frame") then
			local darker = math.max(0, windowConfig.Shadow.Transparency - 0.15)
			createTween(shadow, { BackgroundTransparency = darker }, dragConfig.ScaleDuration)
		end

		if dragConnection then dragConnection:Disconnect() end
		dragConnection = RunService.Heartbeat:Connect(function()
			if not isDragging then
				dragConnection:Disconnect()
				dragConnection = nil
				return
			end
			window.Position = window.Position:Lerp(targetPosition, dragConfig.Smoothness)
		end)
	end

	local function onInputBegan(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			startDrag(input)
		end
	end

	titleBar.InputBegan:Connect(onInputBegan)

	UserInputService.InputChanged:Connect(function(input)
		if not isDragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			targetPosition = UDim2.new(
				dragPosition.X.Scale, dragPosition.X.Offset + delta.X,
				dragPosition.Y.Scale, dragPosition.Y.Offset + delta.Y
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if isDragging then
				isDragging = false
				createTween(uiScale, { Scale = 1 }, dragConfig.ScaleDuration, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				local shadow = window:FindFirstChild("Shadow")
				if shadow and shadow:IsA("Frame") then
					createTween(shadow, { BackgroundTransparency = windowConfig.Shadow.Transparency }, dragConfig.ScaleDuration)
				end
			end
		end
	end)

	return {
		Type = "Window",
		Instance = window,
		Gui = gui,
		TitleBar = titleBar,
		UIScale = uiScale,
		SetTitle = function(newTitle)
			titleLabel.Text = newTitle
		end,
		Destroy = function()
			gui:Destroy()
		end,
	}
end
