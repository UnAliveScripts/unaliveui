return function(self, properties)
	properties = properties or {}
	local theme = self.Theme

	local title = properties.Title or "Notification"
	local subtitle = properties.Subtitle or ""
	local duration = properties.Duration or 4
	local notifType = properties.Type or "info"
	local icon = properties.Icon
	local appIcon = properties.AppIcon

	local colorMap = {
		info = Color3.fromRGB(0, 122, 255),
		success = Color3.fromRGB(52, 199, 89),
		warning = Color3.fromRGB(255, 189, 46),
		error = Color3.fromRGB(255, 95, 87),
	}
	local accentColor = colorMap[notifType] or colorMap.info

	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromOffset(325, 0)
	frame.AnchorPoint = Vector2.new(1, 1)
	frame.BackgroundColor3 = Color3.fromRGB(44, 44, 46)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = true
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.ZIndex = 100

	if properties.Parent then
		frame.Parent = properties.Parent
	end

	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 12)
	frameCorner.Parent = frame

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(1, 0, 0, 3)
	accent.BackgroundColor3 = accentColor
	accent.BorderSizePixel = 0
	accent.Parent = frame

	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, -24, 0, 0)
	content.Position = UDim2.fromOffset(12, 12)
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.AutomaticSize = Enum.AutomaticSize.Y
	content.Parent = frame

	local contentLayout = Instance.new("UIListLayout")
	contentLayout.Padding = UDim.new(0, 4)
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Parent = content

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 20)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 13
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Text = title
	titleLabel.Parent = content

	if subtitle ~= "" then
		local subtitleLabel = Instance.new("TextLabel")
		subtitleLabel.Size = UDim2.new(1, 0, 0, 18)
		subtitleLabel.BackgroundTransparency = 1
		subtitleLabel.Font = Enum.Font.Gotham
		subtitleLabel.TextSize = 12
		subtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		subtitleLabel.TextTransparency = 0.45
		subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		subtitleLabel.TextWrapped = true
		subtitleLabel.Text = subtitle
		subtitleLabel.Parent = content
	end

	local closeButton = Instance.new("ImageButton")
	closeButton.AnchorPoint = Vector2.new(1, 0)
	closeButton.Position = UDim2.new(1, -4, 0, 4)
	closeButton.Size = UDim2.fromOffset(18, 18)
	closeButton.AutoButtonColor = false
	closeButton.BackgroundColor3 = Color3.fromRGB(44, 44, 46)
	closeButton.BackgroundTransparency = 0.1
	closeButton.BorderSizePixel = 0
	closeButton.ZIndex = 101
	closeButton.Parent = frame

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(1, 0)
	closeCorner.Parent = closeButton

	local closeIcon = Instance.new("ImageLabel")
	closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	closeIcon.Position = UDim2.fromScale(0.5, 0.5)
	closeIcon.Size = UDim2.fromOffset(12, 12)
	closeIcon.BackgroundTransparency = 1
	closeIcon.Image = "rbxassetid://72660323302468"
	closeIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	closeIcon.ImageTransparency = 0.5
	closeIcon.Parent = closeButton

	closeButton.MouseButton1Click:Connect(function()
		frame:Destroy()
	end)

	if duration and duration > 0 then
		task.delay(duration, function()
			if frame.Parent then
				frame:Destroy()
			end
		end)
	end

	return {
		Type = "Notification",
		Instance = frame,
		Close = function() frame:Destroy() end,
	}
end
