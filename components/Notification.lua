local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    
    local icon, closeBtn, titleLabel, descLabel
    
    local frame = create("Frame")({
        Name = "Notification",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.92, BorderSizePixel = 0,
        Position = UDim2.new(1, -400, 1, 0), Size = UDim2.fromOffset(386, 64), ZIndex = 100,
        create("UICorner")({ CornerRadius = UDim.new(0, 24) }),
        create("UIStroke")({ Color = Color3.fromRGB(80, 80, 90), Transparency = 0.6, Thickness = 0.5 }),
    })
    
    icon = create("ImageLabel")({ Name = "Icon", BackgroundTransparency = 1, Image = props.Icon or "rbxassetid://127922205331150", Position = UDim2.fromOffset(16, 20), Size = UDim2.fromOffset(24, 24), Parent = frame.__instance })
    titleLabel = create("TextLabel")({ Name = "Title", BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold), Text = props.Title or "UnAlive", TextSize = 15, TextColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(52, 12), Size = UDim2.new(0, 300, 0, 20), TextXAlignment = Enum.TextXAlignment.Left, Parent = frame.__instance })
    descLabel = create("TextLabel")({ Name = "Description", BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365364"), Text = props.Description or "Welcome to UnAlive", TextSize = 13, TextColor3 = Color3.fromRGB(180, 180, 190), Position = UDim2.fromOffset(52, 34), Size = UDim2.new(0, 300, 0, 18), TextXAlignment = Enum.TextXAlignment.Left, Parent = frame.__instance })
    closeBtn = create("ImageButton")({ Name = "Close", BackgroundTransparency = 1, Image = "rbxassetid://93520763686656", Position = UDim2.new(1, -36, 0, 12), Size = UDim2.fromOffset(16, 16), ImageColor3 = Color3.fromRGB(180, 180, 190), Parent = frame.__instance })
    
    -- Slide in animation
    frame.Position = UDim2.new(1, 50, 1, 0)
    task.wait(0.05)
    TweenService:Create(frame.__instance, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.new(1, -420, 1, 0) }):Play()
    
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(frame.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), { Position = UDim2.new(1, 50, 1, 0), BackgroundTransparency = 1 }):Play()
        task.delay(0.4, function() pcall(function() frame.__instance:Destroy() end) end)
        if props.Closed then props.Closed() end
    end)
    
    local duration = props.Duration or 4
    if duration > 0 then
        task.delay(duration, function()
            if frame.__instance and frame.__instance.Parent then
                TweenService:Create(frame.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), { Position = UDim2.new(1, 50, 1, 0), BackgroundTransparency = 1 }):Play()
                task.delay(0.4, function() pcall(function() frame.__instance:Destroy() end) end)
            end
        end)
    end
    
    local s = { Frame = frame, Icon = icon, Title = titleLabel, Description = descLabel, CloseBtn = closeBtn }
    local obj = { Type = "Notification", Theme = self and self.Theme, Structures = s, __instance = frame.__instance }
    obj.Close = function() closeBtn.MouseButton1Click:Fire() end
    obj.Parent = function(p) frame.Parent = p end
    return obj
end