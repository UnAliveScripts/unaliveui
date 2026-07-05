local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}
    props.Minimum = props.Minimum or 0; props.Maximum = props.Maximum or 100
    props.Step = props.Step or 1; props.Value = props.Value or 0; props.Fielded = props.Fielded ~= false
    
    local container = create("Frame")({ Name = "Stepper", BackgroundTransparency = 1, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 23) })
    
    if props.Fielded then
        local field = create("TextBox")({ Name = "Field", BackgroundColor3 = Color3.fromRGB(44, 44, 50), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"), PlaceholderColor3 = Color3.fromRGB(120, 120, 130), Text = tostring(props.Value), TextSize = 15, TextColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromOffset(50, 23), TextXAlignment = Enum.TextXAlignment.Center, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
        field.Parent = container.__instance
    end
    
    local upBtn = create("ImageButton")({ Name = "Up", BackgroundColor3 = Color3.fromRGB(44, 44, 50), AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(props.Fielded and 56 or 0, 0), Size = UDim2.fromOffset(22, 23), Image = icons["chevron-up"] or "rbxassetid://137296891812002", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
    upBtn.Parent = container.__instance
    
    local downBtn = create("ImageButton")({ Name = "Down", BackgroundColor3 = Color3.fromRGB(44, 44, 50), AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(props.Fielded and 80 or 22, 0), Size = UDim2.fromOffset(22, 23), Image = icons["chevron-down"] or "rbxassetid://84215348315149", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
    downBtn.Parent = container.__instance
    
    local s = { Container = container, Up = upBtn.__instance, Down = downBtn.__instance }
    
    upBtn.MouseButton1Down:Connect(function() TweenService:Create(upBtn.__instance, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), { ImageTransparency = 0 }):Play() end)
    upBtn.MouseButton1Up:Connect(function() TweenService:Create(upBtn.__instance, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { ImageTransparency = 0.3 }):Play() end)
    upBtn.MouseButton1Click:Connect(function() props.Value = math.min(props.Value + props.Step, props.Maximum); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end end)
    
    downBtn.MouseButton1Down:Connect(function() TweenService:Create(downBtn.__instance, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), { ImageTransparency = 0 }):Play() end)
    downBtn.MouseButton1Up:Connect(function() TweenService:Create(downBtn.__instance, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { ImageTransparency = 0.3 }):Play() end)
    downBtn.MouseButton1Click:Connect(function() props.Value = math.max(props.Value - props.Step, props.Minimum); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end end)
    
    local obj = { Type = "Stepper", Theme = self and self.Theme, Structures = s, __instance = container.__instance }
    obj.Parent = function(p) container.Parent = p end; obj.Value = props.Value; obj.ValueChanged = props.ValueChanged
    return obj
end