local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Untitled"
	props.Size = props.Size or UDim2.fromOffset(850, 530)
	props.UIBlur = props.UIBlur ~= false
	props.Draggable = props.Draggable ~= false

	local theme = self.Theme.Controls
	local parent = self.__container or self.__instance or self
	local struct = {}
	local dragging, dragStart, winStart

	local window = C("Frame")({
		Name = "Window",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Parent = parent,
	})

	struct.Body = C("Frame")({
		Name = "Body",
		BorderSizePixel = 0,
		ClipsDescendants = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = props.Size,
		Parent = window.__instance,

		__dynamicKeys = {
			BackgroundColor3 = theme.Window.Background[1],
			BackgroundTransparency = theme.Window.Background[2],
		},

		__contextKeys = {
			BackgroundTransparency = function()
				return props.UIBlur and theme.Window.Background[2].Value or 0
			end,
		},

		C("UICorner")({ CornerRadius = UDim.new(0, 10) }),

		C("UIStroke")({
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			__dynamicKeys = { Color = theme.Window.Border[1], Transparency = theme.Window.Border[2] },
		}),
	})

	local titlebar = C("Frame")({
		Name = "Titlebar",
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 38),
		ZIndex = 2,
		Parent = struct.Body.__instance,

		__dynamicKeys = {
			BackgroundColor3 = theme.Titlebar[1],
			BackgroundTransparency = theme.Titlebar[2],
		},

		C("UICorner")({ CornerRadius = UDim.new(0, 10) }),

		C("Frame")({
			Name = "Clip",
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 10),
			Size = UDim2.new(1, 0, 1, -10),
			ZIndex = 2,
		}),
	})

	local closeBtn = C("ImageButton")({
		Name = "Close",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxassetid://17650834774",
		ImageRectOffset = Vector2.new(0, 0),
		ImageRectSize = Vector2.new(12, 12),
		Position = UDim2.fromOffset(10, 13),
		Size = UDim2.fromOffset(12, 12),
		ZIndex = 3,
		Parent = titlebar.__instance,
		__dynamicKeys = { ImageColor3 = theme.Exit[1] },
	})

	local minBtn = C("ImageButton")({
		Name = "Minimize",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxassetid://17650834774",
		ImageRectOffset = Vector2.new(12, 0),
		ImageRectSize = Vector2.new(12, 12),
		Position = UDim2.fromOffset(28, 13),
		Size = UDim2.fromOffset(12, 12),
		ZIndex = 3,
		Parent = titlebar.__instance,
		__dynamicKeys = { ImageColor3 = theme.Minimize[1] },
	})

	local zoomBtn = C("ImageButton")({
		Name = "Zoom",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "rbxassetid://17650834774",
		ImageRectOffset = Vector2.new(24, 0),
		ImageRectSize = Vector2.new(12, 12),
		Position = UDim2.fromOffset(46, 13),
		Size = UDim2.fromOffset(12, 12),
		ZIndex = 3,
		Parent = titlebar.__instance,
		__dynamicKeys = { ImageColor3 = theme.Zoom[1] },
	})

	local title = C("TextLabel")({
		Name = "Title",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold),
		Text = props.Title,
		TextSize = 13,
		Position = UDim2.fromOffset(0, 11),
		Size = UDim2.new(1, 0, 0, 16),
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = 2,
		Parent = titlebar.__instance,

		__dynamicKeys = {
			TextColor3 = self.Theme.Text.Primary[1],
			TextTransparency = self.Theme.Text.Primary[2],
		},
	})

	local content = C("Frame")({
		Name = "Content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(1, 0, 1, -38),
		Parent = struct.Body.__instance,
	})

	struct.Content = content.__instance

	titlebar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 and props.Draggable then
			dragging = true
			dragStart = i.Position
			winStart = Vector2.new(
				struct.Body.Position.X.Offset,
				struct.Body.Position.Y.Offset
			)

			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	titlebar.InputChanged:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local d = i.Position - dragStart
			struct.Body.Position = UDim2.new(
				0.5, winStart.X + d.X,
				0.5, winStart.Y + d.Y
			)
		end
	end)

	local function dh(btn)
		local oc = btn.ImageColor3

		btn.MouseEnter:Connect(function()
			TS:Create(btn.__instance, TweenInfo.new(0.15), {
				ImageColor3 = Color3.new(1, 1, 1),
			}):Play()
		end)

		btn.MouseLeave:Connect(function()
			TS:Create(btn.__instance, TweenInfo.new(0.2), {
				ImageColor3 = oc,
			}):Play()
		end)
	end

	dh(closeBtn)
	dh(minBtn)
	dh(zoomBtn)

	closeBtn.MouseButton1Click:Connect(function()
		if props.Closed then props.Closed() end
	end)

	minBtn.MouseButton1Click:Connect(function()
		if props.Minimized then props.Minimized() end
	end)

	zoomBtn.MouseButton1Click:Connect(function()
		if props.Zoomed then props.Zoomed() end
	end)

	if props.UIBlur and _G.__unaliveui_blur then
		task.spawn(function()
			local blur = _G.__unaliveui_blur(struct.Body)
			struct.Blur = blur
		end)
	end

	local obj = {
		Type = "Window",
		Theme = self.Theme,
		Structures = struct,
		__instance = struct.Body,
	}

	function obj.Parent(p) window.Parent = p end
	function obj:SetTitle(v) title.Text = v end

	obj.__container = content.__instance
	return obj
end