-- Figma-accurate Notification component
-- From Figma: 386x64, 24px corner radius, Clear Glass, icon + Title + Description
local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}
    props.Title = props.Title or "UnAlive"
    props.Description = props.Description or "Welcome to UnAlive"
    props.Duration = props.Duration or 5
    props.Icon = props.Icon or icons.UnAlivelogo

    local body = create("Frame")({
        Name = "Notification", BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(386, 64), ZIndex = 100,

        create("Frame")({ Name = "Shadow", Visible = false,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8,
            BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0,
            create("UICorner")({ CornerRadius = UDim.new(0, 24) }),
        }),

        create("Frame")({
            Name = "Glass", BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.92, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 1,
            create("UICorner")({ CornerRadius = UDim.new(0, 24) }),
            create("UIStroke")({ Color = Color3.fromRGB(80, 80, 90), Transparency = 0.6, Thickness = 0.5 }),
        }),

        create("Frame")({
            Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 2,
            create("ImageLabel")({ Name = "Icon", BackgroundTransparency = 1, BorderSizePixel = 0,
                Image = props.Icon, Position = UDim2.fromOffset(16, 20),
                Size = UDim2.fromOffset(24, 24), ZIndex = 3 }),
            create("TextLabel")({ Name = "Title", BackgroundTransparency = 1,
                FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold),
                Text = props.Title, TextSize = 15, TextColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.fromOffset(52, 12), Size = UDim2.new(0, 300, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 }),
            create("TextLabel")({ Name = "Description", BackgroundTransparency = 1,
                FontFace = Font.new("rbxassetid://12187365364"),
                Text = props.Description, TextSize = 13,
                TextColor3 = Color3.fromRGB(180, 180, 190),
                Position = UDim2.fromOffset(52, 34), Size = UDim2.new(0, 300, 0, 18),
                TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 }),
            create("ImageButton")({ Name = "Close", BackgroundTransparency = 1,
                Image = icons.xmark, ImageColor3 = Color3.fromRGB(180, 180, 190),
                Position = UDim2.new(1, -36, 0, 12), Size = UDim2.fromOffset(16, 16), ZIndex = 4 }),
        }),
    })

    body.Position = UDim2.new(1, 50, 1, 0)
    task.wait(0.05)
    TweenService:Create(body.__instance, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(1, -420, 1, 0) }):Play()

    local closeBtn = body.__instance:FindFirstChild("Content"):FindFirstChild("Close")
    local function closeNotification()
        TweenService:Create(body.__instance, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Position = UDim2.new(1, 50, 1, 0), BackgroundTransparency = 1 }):Play()
        task.delay(0.45, function() pcall(function() if props.Closed then props.Closed() end; body.__instance:Destroy() end) end)
    end

    closeBtn.MouseButton1Click:Connect(closeNotification)

    if props.Duration and props.Duration > 0 then
        task.delay(props.Duration, function() if body.__instance and body.__instance.Parent then closeNotification() end end)
    end

    local obj = { Type = "Notification", Theme = self and self.Theme, __instance = body.__instance }
    function obj:Close() closeNotification() end
    function obj.Parent(p) body.Parent = p end
    function obj:SetTitle(text) body.__instance:FindFirstChild("Content"):FindFirstChild("Title").Text = text end
    function obj:SetDescription(text) body.__instance:FindFirstChild("Content"):FindFirstChild("Description").Text = text end
    return obj
end