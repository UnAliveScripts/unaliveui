local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    local body = create("Frame")({
        Name = "Window",
        BackgroundColor3 = Color3.fromRGB(28, 28, 32),
        BorderSizePixel = 0, ClipsDescendants = true,
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Size = UDim2.fromOffset(400, 300), Visible = false,
        create("UICorner")({ CornerRadius = UDim.new(0, 12) }),
        create("Frame")({
            Name = "TitleBar", BackgroundColor3 = Color3.fromRGB(30, 30, 35),
            BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 38), ZIndex = 2,
            create("UICorner")({ CornerRadius = UDim.new(0, 12) }),
            create("UIStroke")({ Color = Color3.fromRGB(50, 50, 55), Transparency = 0.4 }),
            create("Frame")({ Name = "Close", BackgroundColor3 = Color3.fromRGB(255, 95, 87), BorderSizePixel = 0, Position = UDim2.fromOffset(12, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) }),
            create("Frame")({ Name = "Minimize", BackgroundColor3 = Color3.fromRGB(255, 189, 46), BorderSizePixel = 0, Position = UDim2.fromOffset(30, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) }),
            create("Frame")({ Name = "Zoom", BackgroundColor3 = Color3.fromRGB(39, 201, 63), BorderSizePixel = 0, Position = UDim2.fromOffset(48, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) }),
            create("TextLabel")({ Name = "Title", BackgroundTransparency = 1, Text = props.Title or "Window", FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold), TextSize = 13, TextColor3 = Color3.fromRGB(255, 255, 255), TextTransparency = 0.4, Position = UDim2.fromOffset(0, 11), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 2 }),
        }),
        create("Frame")({ Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, 38), Size = UDim2.new(1, 0, 1, -38) }),
    })
    local s = { Body = body, TitleBar = body.__instance:FindFirstChild("TitleBar"), Content = body.__instance:FindFirstChild("Content"), Title = body.__instance:FindFirstChild("TitleBar"):FindFirstChild("Title"), CloseBtn = body.__instance:FindFirstChild("TitleBar"):FindFirstChild("Close"), MinimizeBtn = body.__instance:FindFirstChild("TitleBar"):FindFirstChild("Minimize"), ZoomBtn = body.__instance:FindFirstChild("TitleBar"):FindFirstChild("Zoom") }
    
    local dragging, dragStart, windowStart
    s.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position
            windowStart = Vector2.new(body.Position.X.Offset, body.Position.Y.Offset)
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    s.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            body.Position = UDim2.new(0.5, windowStart.X + delta.X, 0.5, windowStart.Y + delta.Y)
        end
    end)
    s.CloseBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            body.Visible = false
            if props.Closed then props.Closed() end
        end
    end)
    s.MinimizeBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then body.Visible = false end
    end)
    
    -- Animate in
    body.Visible = true
    body.Size = UDim2.fromOffset(0, 0)
    TweenService:Create(body.__instance, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(400, 300) }):Play()
    
    local obj = { Type = "Window", Theme = self and self.Theme, Structures = s, __instance = body.__instance, Body = body }
    obj.Parent = function(p) body.Parent = p end
    obj.Title = function(v) s.Title.Text = v end
    obj.__container = s.Content.__instance
    return obj
end