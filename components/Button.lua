local TS = game:GetService("TweenService")
local C = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}; props.State = props.State or "Primary"; props.Label = props.Label or "Button"
    local theme = self.Theme.Controls.Button; local parent = self.__container or self.__instance or self; local struct = {}

    struct.Body = C("TextButton")({ Name = "Button", AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1, BorderSizePixel = 0, Text = "", Parent = parent,
        C("UICorner")({ CornerRadius = UDim.new(0,5) }),
        C("Frame")({ Name = "SL1", BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1,1), ZIndex = 0,
            C("UICorner")({ CornerRadius = UDim.new(0,5) }), C("UIStroke")({ Name = "S", ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Transparency = 0.95, __dynamicKeys = { Color = theme.Shadow } }) }),
        C("Frame")({ Name = "SL2", BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1,1), ZIndex = -1,
            C("UICorner")({ CornerRadius = UDim.new(0,5) }), C("UIStroke")({ Name = "S", ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.98, __dynamicKeys = { Color = theme.Shadow } }) }),
        C("Frame")({ Name = "Overlay", BackgroundColor3 = Color3.fromRGB(0,0,0), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1,1), ZIndex = 2, C("UICorner")({ CornerRadius = UDim.new(0,5) }) }),
    })

    struct.Overlay = struct.Body.__instance:FindFirstChild("Overlay")

    local label = C("TextLabel")({ Name = "Label", AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364"), RichText = true, Text = props.Label, TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center, Parent = struct.Body.__instance,
        __dynamicKeys = { TextColor3 = self.Theme.Text.SelectionPrimary[1], TextTransparency = self.Theme.Text.SelectionPrimary[2] },
        C("UIPadding")({ PaddingBottom = UDim.new(0,3), PaddingLeft = UDim.new(0,7), PaddingRight = UDim.new(0,7), PaddingTop = UDim.new(0,3) }) })

    C("UIGradient")({ Name = "Fill", Rotation = 90, Parent = struct.Body.__instance, __dynamicKeys = { Color = theme.FillPrimary } })

    struct.Body.MouseButton1Down:Connect(function() TS:Create(struct.Overlay, TweenInfo.new(0.1, Enum.EasingStyle.Cubic), { BackgroundTransparency = 0.8 }):Play() end)
    struct.Body.MouseButton1Up:Connect(function() TS:Create(struct.Overlay, TweenInfo.new(0.2, Enum.EasingStyle.Sine), { BackgroundTransparency = 1 }):Play() end)
    struct.Body.MouseLeave:Connect(function() TS:Create(struct.Overlay, TweenInfo.new(0.15, Enum.EasingStyle.Sine), { BackgroundTransparency = 1 }):Play() end)
    struct.Body.MouseButton1Click:Connect(function() if props.Pushed then task.spawn(props.Pushed, obj) end end)

    local obj = { Type = "Button", Theme = self.Theme, Structures = struct, __instance = struct.Body }
    function obj:SetLabel(v) label.Text = v end
    return obj
end