local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.State = props.State or "Primary"
    props.Label = props.Label or "Button"
    
    local overlay, labelObj
    
    local body = create("TextButton")({
        Name = "Button", AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Color3.fromRGB(56, 56, 62), BorderSizePixel = 0, Text = "",
        create("UICorner")({ CornerRadius = UDim.new(0, 6) }),
    })
    
    overlay = create("Frame")({ Name = "PressOverlay", BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = body.__instance, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
    labelObj = create("TextLabel")({ Name = "Label", AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"), RichText = true, Text = props.Label, TextSize = 14, TextColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 3, Parent = body.__instance, create("UIPadding")({ PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7), PaddingTop = UDim.new(0, 3) }) })
    create("UIGradient")({ Name = "Fill", Rotation = 90, Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(66, 66, 72)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 56)) }), Parent = body.__instance })
    
    -- Press animations
    body.MouseButton1Down:Connect(function()
        TweenService:Create(overlay.__instance, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundTransparency = 0.75 }):Play()
    end)
    body.MouseButton1Up:Connect(function()
        TweenService:Create(overlay.__instance, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
    end)
    body.MouseLeave:Connect(function()
        TweenService:Create(overlay.__instance, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
    end)
    
    -- State handling
    if props.State == "Destructive" then
        body.BackgroundColor3 = Color3.fromRGB(200, 50, 40)
        labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    elseif props.State == "Secondary" then
        body.BackgroundColor3 = Color3.fromRGB(44, 44, 50)
        labelObj.TextColor3 = Color3.fromRGB(180, 180, 190)
    end
    
    local obj = { Type = "Button", Theme = self and self.Theme, __instance = body.__instance }
    obj.Parent = function(p) body.Parent = p end
    obj.Label = function(v) labelObj.Text = v end
    obj.Pushed = props.Pushed
    
    body.MouseButton1Click:Connect(function()
        if props.Pushed then task.spawn(props.Pushed, obj) end
    end)
    
    return obj
end