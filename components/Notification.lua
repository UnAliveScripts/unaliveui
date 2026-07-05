local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}
    props.Title = props.Title or "Notification"
    props.Subtitle = props.Subtitle or ""
    props.Duration = props.Duration or 6

    local parent = self.__container or self.__instance or self
    local theme = self.Theme.Controls.Notification
    local structures = {}

    local body = create("Frame")({
        Name = "Notification",
        AnchorPoint = Vector2.new(1, 1),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Position = UDim2.new(1, -12, 1, -12),
        Size = UDim2.fromOffset(325, 0),
        Parent = parent,

        create("Frame")({
            Name = "Canvas", AnchorPoint = Vector2.new(0, 0),
            AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.fromScale(1, 0),
            BorderSizePixel = 0,
            __dynamicKeys = { BackgroundColor3 = theme.Background[1], BackgroundTransparency = theme.Background[2] },
            create("UICorner")({ CornerRadius = UDim.new(0, 12) }),
            create("UIStroke")({ ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                __dynamicKeys = { Color = theme.Border[1], Transparency = theme.Border[2] } }),
            create("UIListLayout")({ Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }),
            create("UIPadding")({ PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 12) }),
        }),
    })

    structures.Body = body.__instance; structures.Canvas = body.__instance:FindFirstChild("Canvas")

    local content = Instance.new("Frame")
    content.Name = "Content"; content.BackgroundTransparency = 1; content.BorderSizePixel = 0
    content.AutomaticSize = Enum.AutomaticSize.Y; content.Size = UDim2.fromScale(1, 0); content.LayoutOrder = 1; content.Parent = structures.Canvas

    local titleContainer = Instance.new("Frame")
    titleContainer.Name = "TitleContainer"; titleContainer.BackgroundTransparency = 1; titleContainer.BorderSizePixel = 0
    titleContainer.AutomaticSize = Enum.AutomaticSize.XY; titleContainer.Size = UDim2.fromScale(1, 0); titleContainer.Parent = content

    local titleLayout = Instance.new("UIListLayout")
    titleLayout.FillDirection = Enum.FillDirection.Horizontal; titleLayout.Padding = UDim.new(0, 5)
    titleLayout.SortOrder = Enum.SortOrder.LayoutOrder; titleLayout.VerticalAlignment = Enum.VerticalAlignment.Center; titleLayout.Parent = titleContainer

    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"; icon.BackgroundTransparency = 1; icon.BorderSizePixel = 0
    icon.LayoutOrder = 1; icon.Size = UDim2.fromOffset(18, 18); icon.Visible = false; icon.Parent = titleContainer

    local title = Instance.new("TextLabel")
    title.Name = "Title"; title.BackgroundTransparency = 1; title.BorderSizePixel = 0
    title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold); title.LineHeight = 0
    title.Size = UDim2.new(1, 0, 0, 20); title.Text = props.Title; title.TextSize = 13
    title.TextWrapped = true; title.RichText = true; title.TextXAlignment = Enum.TextXAlignment.Left
    title.LayoutOrder = 2; title.AutomaticSize = Enum.AutomaticSize.Y; title.Parent = titleContainer

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"; subtitle.BackgroundTransparency = 1; subtitle.BorderSizePixel = 0
    subtitle.FontFace = Font.new("rbxassetid://12187365364"); subtitle.LayoutOrder = 1
    subtitle.RichText = true; subtitle.Size = UDim2.fromScale(1, 0); subtitle.Text = props.Subtitle
    subtitle.TextSize = 13; subtitle.TextWrapped = true; subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.AutomaticSize = Enum.AutomaticSize.Y; subtitle.Visible = props.Subtitle ~= ""; subtitle.Parent = content

    local exitBtn = Instance.new("ImageButton")
    exitBtn.Name = "Exit"; exitBtn.AutoButtonColor = false; exitBtn.BackgroundTransparency = 1
    exitBtn.BorderSizePixel = 0; exitBtn.Image = "rbxassetid://15814246897"
    exitBtn.Size = UDim2.fromOffset(18, 18); exitBtn.LayoutOrder = 2; exitBtn.Parent = structures.Canvas

    local exitIcon = Instance.new("ImageLabel")
    exitIcon.Name = "Icon"; exitIcon.BackgroundTransparency = 1; exitIcon.BorderSizePixel = 0
    exitIcon.Image = icons.xmark; exitIcon.Size = UDim2.fromOffset(10, 10)
    exitIcon.AnchorPoint = Vector2.new(0.5, 0.5); exitIcon.Position = UDim2.fromScale(0.5, 0.5)
    exitIcon.Parent = exitBtn

    local exitStroke = Instance.new("UIStroke")
    exitStroke.Name = "Stroke"; exitStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    exitStroke.Transparency = 0.96; exitStroke.Parent = exitBtn

    body.Position = UDim2.new(1, 187.5, 1, 0)
    TweenService:Create(body.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(1, -12, 1, -12) }):Play()

    local closed = false
    local function closeNotification()
        if closed then return end; closed = true
        if props.Closed then task.spawn(props.Closed) end
        TweenService:Create(body.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = body.Position + UDim2.fromOffset(350, 0) }):Play()
        task.delay(0.4, function() if body.__instance and body.__instance.Parent then body.__instance:Destroy() end end)
    end

    exitBtn.MouseButton1Click:Connect(closeNotification)
    if props.Duration and props.Duration > 0 then
        task.delay(props.Duration, function() if body.__instance and body.__instance.Parent then closeNotification() end end)
    end

    local object = { Type = "Notification", Theme = self.Theme, Structures = structures, __instance = body.__instance }
    function object:Close() closeNotification() end
    function object:SetTitle(v) title.Text = v end
    function object:SetSubtitle(v) subtitle.Text = v; subtitle.Visible = v ~= "" end
    return object
end