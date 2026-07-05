local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}; props.Minimum = props.Minimum or 0; props.Maximum = props.Maximum or 100
    props.Step = props.Step or 1; props.Value = props.Value or 0

    local container = create("Frame")({ Name = "Stepper", BackgroundTransparency = 1, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 23) })
    create("ImageButton")({ Name = "Down", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(44, 44, 50), BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(22, 23),
        Image = icons["chevron-down"] or "rbxassetid://84215348315149", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3,
        Parent = container.__instance, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
    create("TextLabel")({ Name = "Value", BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364"), Text = tostring(props.Value), TextSize = 15,
        TextColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(22, 0), Size = UDim2.fromOffset(36, 23),
        TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center, Parent = container.__instance })
    local upBtn = create("ImageButton")({ Name = "Up", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(44, 44, 50), BorderSizePixel = 0,
        Position = UDim2.fromOffset(58, 0), Size = UDim2.fromOffset(22, 23),
        Image = icons["chevron-up"] or "rbxassetid://137296891812002", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3,
        Parent = container.__instance, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })

    local function updateDisplay() container.__instance:FindFirstChild("Value").Text = tostring(props.Value) end

    upBtn.MouseButton1Down:Connect(function() TweenService:Create(upBtn.__instance, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), { ImageTransparency = 0 }):Play() end)
    upBtn.MouseButton1Up:Connect(function() TweenService:Create(upBtn.__instance, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { ImageTransparency = 0.3 }):Play() end)
    upBtn.MouseButton1Click:Connect(function() props.Value = math.min(props.Value + props.Step, props.Maximum); updateDisplay(); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end end)

    local downInst = container.__instance:FindFirstChild("Down")
    downInst.MouseButton1Down:Connect(function() TweenService:Create(downInst, TweenInfo.new(0.08, Enum.EasingStyle.Cubic), { ImageTransparency = 0 }):Play() end)
    downInst.MouseButton1Up:Connect(function() TweenService:Create(downInst, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { ImageTransparency = 0.3 }):Play() end)
    downInst.MouseButton1Click:Connect(function() props.Value = math.max(props.Value - props.Step, props.Minimum); updateDisplay(); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end end)

    local obj = { Type = "Stepper", Theme = self and self.Theme, __instance = container.__instance }
    function obj.Parent(p) container.Parent = p end
    function obj:SetValue(v) props.Value = v; updateDisplay() end
    return obj
end