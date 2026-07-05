local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    
    -- Store children references directly
    local titleLabel
    local closeBtn
    local minimizeBtn
    local contentFrame
    local titleBar
    
    local body = create("Frame")({
        Name = "Window",
        BackgroundColor3 = Color3.fromRGB(28, 28, 32),
        BorderSizePixel = 0, ClipsDescendants = true,
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Size = UDim2.fromOffset(400, 300),
        
        create("UICorner")({ CornerRadius = UDim.new(0, 12) }),
    })
    
    -- TitleBar
    titleBar = create("Frame")({
        Name = "TitleBar", BackgroundColor3 = Color3.fromRGB(30, 30, 35),
        BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 38), ZIndex = 2,
        Parent = body.__instance,
        create("UICorner")({ CornerRadius = UDim.new(0, 12) }),
        create("UIStroke")({ Color = Color3.fromRGB(50, 50, 55), Transparency = 0.4 }),
    })
    
    closeBtn = create("Frame")({ Name = "Close", BackgroundColor3 = Color3.fromRGB(255, 95, 87), BorderSizePixel = 0, Position = UDim2.fromOffset(12, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, Parent = titleBar.__instance, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) })
    minimizeBtn = create("Frame")({ Name = "Minimize", BackgroundColor3 = Color3.fromRGB(255, 189, 46), BorderSizePixel = 0, Position = UDim2.fromOffset(30, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, Parent = titleBar.__instance, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) })
    create("Frame")({ Name = "Zoom", BackgroundColor3 = Color3.fromRGB(39, 201, 63), BorderSizePixel = 0, Position = UDim2.fromOffset(48, 13), Size = UDim2.fromOffset(12, 12), ZIndex = 3, Parent = titleBar.__instance, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) })
    
    titleLabel = create("TextLabel")({ Name = "Title", BackgroundTransparency = 1, Text = props.Title or "Window", FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold), TextSize = 13, TextColor3 = Color3.fromRGB(255, 255, 255), TextTransparency = 0.4, Position = UDim2.fromOffset(0, 11), Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 2, Parent = titleBar.__instance })
    
    contentFrame = create("Frame")({ Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, 38), Size = UDim2.new(1, 0, 1, -38), Parent = body.__instance })
    
    -- Dragging
    local dragging, dragStart, windowStart
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position
            windowStart = Vector2.new(body.Position.X.Offset, body.Position.Y.Offset)
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            body.Position = UDim2.new(0.5, windowStart.X + delta.X, 0.5, windowStart.Y + delta.Y)
        end
    end)
    
    -- Window controls
    closeBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            body.Visible = false
            if props.Closed then props.Closed() end
        end
    end)
    minimizeBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then body.Visible = false end
    end)
    
    local s = { Body = body, TitleBar = titleBar, Content = contentFrame, Title = titleLabel, CloseBtn = closeBtn, MinimizeBtn = minimizeBtn }
    
    local obj = { Type = "Window", Theme = self and self.Theme, Structures = s, __instance = body.__instance, Body = body }
    obj.Parent = function(p) body.Parent = p end
    obj.Title = function(v) titleLabel.Text = v end
    obj.__container = contentFrame.__instance
    return obj
end