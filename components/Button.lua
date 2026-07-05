-- Figma-accurate Button component
-- States: Primary, Secondary, Destructive
local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.State = props.State or "Primary"
    props.Label = props.Label or "Button"

    local overlay, labelObj, gradient

    local body = create("TextButton")({
        Name = "Button", AutoButtonColor = false,
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1, BorderSizePixel = 0, Text = "",
        Size = UDim2.fromOffset(0, 32),
    })

    gradient = create("UIGradient")({
        Name = "Fill", Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(66, 66, 72)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 56)),
        }), Parent = body.__instance,
    })

    create("UICorner")({ CornerRadius = UDim.new(1, 0) }).Parent = body.__instance

    overlay = create("Frame")({
        Name = "PressOverlay", BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = body.__instance,
        create("UICorner")({ CornerRadius = UDim.new(1, 0) }),
    })

    labelObj = create("TextLabel")({
        Name = "Label", AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium),
        RichText = true, Text = props.Label, TextSize = 13,
        TextColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 3, Parent = body.__instance,
        create("UIPadding")({
            PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 3),
        }),
    })

    local function applyState()
        if props.State == "Destructive" then
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 40)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 40, 30)),
            })
            labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
        elseif props.State == "Secondary" then
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 44, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 44)),
            })
            labelObj.TextColor3 = Color3.fromRGB(200, 200, 210)
        else
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(66, 66, 72)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 56)),
            })
            labelObj.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    applyState()

    local function animatePress()
        TweenService:Create(overlay.__instance, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundTransparency = 0.75 }):Play()
        TweenService:Create(body.__instance, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(body.AbsoluteSize.X, 30) }):Play()
    end
    local function animateRelease()
        TweenService:Create(overlay.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
        TweenService:Create(body.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(body.AbsoluteSize.X, 32) }):Play()
    end

    body.MouseButton1Down:Connect(animatePress)
    body.MouseButton1Up:Connect(animateRelease)
    body.MouseLeave:Connect(animateRelease)
    body.MouseButton1Click:Connect(function() if props.Pushed then task.spawn(props.Pushed, obj) end end)

    local obj = { Type = "Button", Theme = self and self.Theme, Structures = { Body = body, Overlay = overlay, Label = labelObj }, __instance = body.__instance }
    function obj.Parent(p) body.Parent = p end
    function obj:SetLabel(text) labelObj.Text = text end
    function obj:SetState(state) props.State = state; applyState() end
    return obj
end