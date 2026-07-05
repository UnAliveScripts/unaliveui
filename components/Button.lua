local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.State = props.State or "Primary"
    props.Label = props.Label or "Button"

    local parent = self.__container or self.__instance or self
    local theme = self.Theme.Controls.Button
    local structures = {}

    structures.Body = create("TextButton")({
        Name = "Button", AutoButtonColor = false,
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Text = "", Parent = parent,

        create("UICorner")({ CornerRadius = UDim.new(0, 5) }),
        create("Frame")({ Name = "ShadowLayer1", BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 0,
            create("UICorner")({ CornerRadius = UDim.new(0, 5) }),
            create("UIStroke")({ Name = "Shadow", ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Transparency = 0.95, __dynamicKeys = { Color = theme.Shadow } }),
        }),
        create("Frame")({ Name = "ShadowLayer2", BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = -1,
            create("UICorner")({ CornerRadius = UDim.new(0, 5) }),
            create("UIStroke")({ Name = "Shadow", ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Thickness = 2, Transparency = 0.98, __dynamicKeys = { Color = theme.Shadow } }),
        }),
        create("Frame")({ Name = "PressOverlay",
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 2,
            create("UICorner")({ CornerRadius = UDim.new(0, 5) }),
        }),
    })

    structures.Shadow1 = structures.Body.__instance:FindFirstChild("ShadowLayer1"):FindFirstChild("Shadow")
    structures.Shadow2 = structures.Body.__instance:FindFirstChild("ShadowLayer2"):FindFirstChild("Shadow")
    structures.PressOverlay = structures.Body.__instance:FindFirstChild("PressOverlay")

    structures.Label = create("TextLabel")({
        Size = UDim2.fromScale(1, 1), Name = "Label",
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364"),
        RichText = true, TextSize = 14, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = structures.Body.__instance,
        __dynamicKeys = {
            TextColor3 = self.Theme.Text.SelectionPrimary[1],
            TextTransparency = self.Theme.Text.SelectionPrimary[2],
        },
        create("UIPadding")({
            PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 7),
            PaddingRight = UDim.new(0, 7), PaddingTop = UDim.new(0, 3),
        }),
    })

    structures.Fill = create("UIGradient")({
        Name = "Fill", Rotation = 90, Parent = structures.Body.__instance,
        __dynamicKeys = { Color = theme.FillPrimary },
    })

    structures.Label.TextColor3 = props.State == "Primary" and self.Theme.Text.SelectionPrimary[1].Value or props.State == "Secondary" and self.Theme.Text.Primary[1].Value or self.Theme.Accents.Red[1].Value
    structures.Label.TextTransparency = props.State == "Primary" and self.Theme.Text.SelectionPrimary[2].Value or props.State == "Secondary" and self.Theme.Text.Primary[2].Value or self.Theme.Accents.Red[2].Value
    if props.Label then structures.Label.Text = props.Label end

    local function animatePress()
        TweenService:Create(structures.PressOverlay, TweenInfo.new(0.12, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundTransparency = 0.8 }):Play()
    end
    local function animateRelease()
        TweenService:Create(structures.PressOverlay, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
    end

    structures.Body.MouseButton1Down:Connect(animatePress)
    structures.Body.MouseButton1Up:Connect(animateRelease)
    structures.Body.MouseLeave:Connect(animateRelease)
    structures.Body.MouseButton1Click:Connect(function() if props.Pushed then task.spawn(props.Pushed, object) end end)

    local object = { Type = "Button", Theme = self.Theme, Structures = structures, __instance = structures.Body.__instance }
    function object:SetLabel(text) structures.Label.Text = text end
    function object:SetState(state) props.State = state; structures.Label.TextColor3 = getTextColor(); structures.Label.TextTransparency = getTextTransparency() end
    return object
end