local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Title = props.Title or "Window"
    props.Size = props.Size or UDim2.fromOffset(850, 530)
    props.UIBlur = props.UIBlur ~= false
    props.Resizable = props.Resizable ~= false
    props.Draggable = props.Draggable ~= false

    local theme = self.Theme.Controls.Window
    local structures = {}
    local dragging, dragStart, windowStart

    local window = create("Frame")({
        Name = "Window",
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
    })

    local body = create("Frame")({
        Name = "Body", BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = props.Size, ClipsDescendants = true,
        Parent = window.__instance,

        __dynamicKeys = {
            BackgroundColor3 = theme.Background[1],
            BackgroundTransparency = theme.Background[2],
        },

        create("UICorner")({ CornerRadius = UDim.new(0, 10) }),

        create("UIStroke")({
            Name = "Border",
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            __dynamicKeys = {
                Color = theme.Border[1],
                Transparency = theme.Border[2],
            },
        }),
    })

    local titlebar = create("Frame")({
        Name = "Titlebar", BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
        ZIndex = 2, Parent = body.__instance,

        __dynamicKeys = {
            BackgroundColor3 = theme.Titlebar[1],
            BackgroundTransparency = theme.Titlebar[2],
        },

        create("UICorner")({ CornerRadius = UDim.new(0, 10) }),

        create("Frame")({
            Name = "CornerClip", BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 10),
            Size = UDim2.new(1, 0, 1, -10),
            ZIndex = 2,
        }),
    })

    local closeBtn = create("ImageButton")({
        Name = "Close", AutoButtonColor = false,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = "rbxassetid://17650834774", ImageRectOffset = Vector2.new(0, 0),
        ImageRectSize = Vector2.new(12, 12),
        Position = UDim2.fromOffset(10, 13), Size = UDim2.fromOffset(12, 12),
        ZIndex = 3, Parent = titlebar.__instance,
        __dynamicKeys = { ImageColor3 = theme.Exit[1] },
    })

    local minimizeBtn = create("ImageButton")({
        Name = "Minimize", AutoButtonColor = false,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = "rbxassetid://17650834774", ImageRectOffset = Vector2.new(12, 0),
        ImageRectSize = Vector2.new(12, 12),
        Position = UDim2.fromOffset(28, 13), Size = UDim2.fromOffset(12, 12),
        ZIndex = 3, Parent = titlebar.__instance,
        __dynamicKeys = { ImageColor3 = theme.Minimize[1] },
    })

    local zoomBtn = create("ImageButton")({
        Name = "Zoom", AutoButtonColor = false,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = "rbxassetid://17650834774", ImageRectOffset = Vector2.new(24, 0),
        ImageRectSize = Vector2.new(12, 12),
        Position = UDim2.fromOffset(46, 13), Size = UDim2.fromOffset(12, 12),
        ZIndex = 3, Parent = titlebar.__instance,
        __dynamicKeys = { ImageColor3 = theme.Zoom[1] },
    })

    local titleLabel = create("TextLabel")({
        Name = "Title", BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold),
        Text = props.Title, TextSize = 13,
        Position = UDim2.fromOffset(0, 11), Size = UDim2.new(1, 0, 0, 16),
        TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 2,
        Parent = titlebar.__instance,
        __dynamicKeys = {
            TextColor3 = self.Theme.Text.Primary[1],
            TextTransparency = self.Theme.Text.Primary[2],
        },
    })

    local contentFrame = create("Frame")({
        Name = "Content", BackgroundTransparency = 1,
        BorderSizePixel = 0, ClipsDescendants = true,
        Position = UDim2.fromOffset(0, 38),
        Size = UDim2.new(1, 0, 1, -38),
        Parent = body.__instance,
    })

    structures.Body = body.__instance
    structures.Titlebar = titlebar.__instance
    structures.Content = contentFrame.__instance
    structures.Title = titleLabel.__instance

    titlebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and props.Draggable then
            dragging = true
            dragStart = input.Position
            windowStart = Vector2.new(body.Position.X.Offset, body.Position.Y.Offset)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    titlebar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            body.Position = UDim2.new(0.5, windowStart.X + delta.X, 0.5, windowStart.Y + delta.Y)
        end
    end)

    local function trafficLightHover(btn, defaultColor, hoverColor)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn.__instance, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = hoverColor }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { ImageColor3 = defaultColor }):Play()
        end)
    end
    trafficLightHover(closeBtn, theme.Exit[1].Value, Color3.fromRGB(255, 255, 255))
    trafficLightHover(minimizeBtn, theme.Minimize[1].Value, Color3.fromRGB(255, 255, 255))
    trafficLightHover(zoomBtn, theme.Zoom[1].Value, Color3.fromRGB(255, 255, 255))

    closeBtn.MouseButton1Click:Connect(function() if props.Closed then props.Closed() end end)
    minimizeBtn.MouseButton1Click:Connect(function() if props.Minimized then props.Minimized() end end)
    zoomBtn.MouseButton1Click:Connect(function() if props.Zoomed then props.Zoomed() end end)

    local obj = { Type = "Window", Theme = self.Theme, Structures = structures, __instance = body.__instance }
    function obj.Parent(p) window.Parent = p end
    function obj:SetTitle(v) titleLabel.Text = v end
    obj.__container = contentFrame.__instance
    return obj
end