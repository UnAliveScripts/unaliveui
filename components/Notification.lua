local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
	props = props or {}
	props.Title = props.Title or "Notification"
	props.Subtitle = props.Subtitle or ""
	props.Duration = props.Duration or 6

	local theme = self.Theme.Controls.Notification
	local parent = self.__container or self.__instance or self
	local struct = {}
	local closed = false

	local body = C("Frame")({
		Name = "Notification",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 1),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.new(1, -12, 1, -12),
		Size = UDim2.fromOffset(325, 0),
		Parent = parent,

		C("Frame")({
			Name = "Canvas",
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.fromScale(1, 0),

			__dynamicKeys = {
				BackgroundColor3 = theme.Background[1],
				BackgroundTransparency = theme.Background[2],
			},

			C("UICorner")({ CornerRadius = UDim.new(0, 12) }),
			C("UIStroke")({
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				__dynamicKeys = { Color = theme.Border[1], Transparency = theme.Border[2] },
			}),

			C("UIListLayout")({
				Padding = UDim.new(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			C("UIPadding")({
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12),
				PaddingTop = UDim.new(0, 12),
			}),
		}),
	})

	struct.Body = body.__instance
	local canvas = struct.Body:FindFirstChild("Canvas")

	local content = Instance.new("Frame")
	content.Name = "Content"
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.AutomaticSize = Enum.AutomaticSize.Y
	content.Size = UDim2.fromScale(1, 0)
	content.LayoutOrder = 1
	content.Parent = canvas

	local tc = Instance.new("Frame")
	tc.Name = "TitleContainer"
	tc.BackgroundTransparency = 1
	tc.BorderSizePixel = 0
	tc.AutomaticSize = Enum.AutomaticSize.XY
	tc.Size = UDim2.fromScale(1, 0)
	tc.Parent = content

	local tll = Instance.new("UIListLayout", tc)
	tll.FillDirection = Enum.FillDirection.Horizontal
	tll.Padding = UDim.new(0, 5)
	tll.SortOrder = Enum.SortOrder.LayoutOrder
	tll.VerticalAlignment = Enum.VerticalAlignment.Center

	local icon = Instance.new("ImageLabel")
	icon.Name = "Icon"
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.LayoutOrder = 1
	icon.Size = UDim2.fromOffset(18, 18)
	icon.Visible = false
	icon.Parent = tc

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.BackgroundTransparency = 1
	title.BorderSizePixel = 0
	title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold)
	title.LineHeight = 0
	title.Size = UDim2.new(1, 0, 0, 20)
	title.Text = props.Title
	title.TextSize = 13
	title.TextWrapped = true
	title.RichText = true
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.AutomaticSize = Enum.AutomaticSize.Y
	title.Parent = tc

	local sub = Instance.new("TextLabel")
	sub.Name = "Subtitle"
	sub.BackgroundTransparency = 1
	sub.BorderSizePixel = 0
	sub.FontFace = Font.new("rbxassetid://12187365364")
	sub.RichText = true
	sub.Size = UDim2.fromScale(1, 0)
	sub.Text = props.Subtitle
	sub.TextSize = 13
	sub.TextWrapped = true
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.AutomaticSize = Enum.AutomaticSize.Y
	sub.Visible = props.Subtitle ~= ""
	sub.Parent = content

	local exitBtn = Instance.new("ImageButton")
	exitBtn.Name = "Exit"
	exitBtn.AutoButtonColor = false
	exitBtn.BackgroundTransparency = 1
	exitBtn.BorderSizePixel = 0
	exitBtn.Image = "rbxassetid://15814246897"
	exitBtn.Size = UDim2.fromOffset(18, 18)
	exitBtn.LayoutOrder = 2
	exitBtn.Parent = canvas

	local exitIcon = Instance.new("ImageLabel")
	exitIcon.Name = "Icon"
	exitIcon.BackgroundTransparency = 1
	exitIcon.BorderSizePixel = 0
	exitIcon.Image = icons.xmark
	exitIcon.Size = UDim2.fromOffset(10, 10)
	exitIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	exitIcon.Position = UDim2.fromScale(0.5, 0.5)
	exitIcon.Parent = exitBtn

	local exitStroke = Instance.new("UIStroke")
	exitStroke.Name = "Stroke"
	exitStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	exitStroke.Transparency = 0.96
	exitStroke.Parent = exitBtn

	body.Position = UDim2.new(1, 187.5, 1, 0)

	TS:Create(struct.Body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -12, 1, -12),
	}):Play()

	local function close()
		if closed then return end
		closed = true

		if props.Closed then
			task.spawn(props.Closed)
		end

		TS:Create(struct.Body, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = struct.Body.Position + UDim2.fromOffset(350, 0),
		}):Play()

		task.delay(0.4, function()
			if struct.Body and struct.Body.Parent then
				struct.Body:Destroy()
			end
		end)
	end

	exitBtn.MouseButton1Click:Connect(close)

	if props.Duration and props.Duration > 0 then
		task.delay(props.Duration, function()
			if struct.Body and struct.Body.Parent then
				close()
			end
		end)
	end

	local obj = {
		Type = "Notification",
		Theme = self.Theme,
		Structures = struct,
		__instance = struct.Body,
	}

	function obj:Close() close() end
	function obj:SetTitle(v) title.Text = v end
	function obj:SetSubtitle(v) sub.Text = v; sub.Visible = v ~= "" end

	return obj
end