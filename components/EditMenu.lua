-- Figma-accurate EditMenu component
-- From Figma: Edit Menu (1:308) with Glass Effect + Fill+Shadow + 6 action items
local TweenService = game:GetService("TweenService")
local Animate = _G.__unaliveui_animation or require(script.Parent.Parent.animations.init)
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}
    props.Items = props.Items or {
        { Label = "Farm" }, { Label = "Shop" }, { Label = "Steal" },
        { Label = "Spawn", Destructive = true }, { Label = "Config" }, { Label = "Settings" },
    }
    props.OnSelected = props.OnSelected or nil

    local theme = _G.__unaliveui_themes_Dark.EditMenu
    local structures = {}
    local itemButtons = {}

    local body = create("Frame")({
        Name = "EditMenu", BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(488, 44), AutomaticSize = Enum.AutomaticSize.XY,

        create("Frame")({
            Name = "FillShadow", BackgroundColor3 = Color3.fromRGB(204, 204, 204),
            BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0,
            create("UICorner")({ CornerRadius = UDim.new(0, 34) }),
        }),

        create("Frame")({
            Name = "Glass", BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.996, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 1,
            create("UICorner")({ CornerRadius = UDim.new(0, 34) }),
            create("UIStroke")({ Color = Color3.fromRGB(255, 255, 255), Transparency = 0.95, Thickness = 0.5 }),
        }),

        create("Frame")({
            Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 2,
            create("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0) }),
            create("UIPadding")({ PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 4) }),
        }),
    })

    local content = body.__instance:FindFirstChild("Content")

    for i, item in ipairs(props.Items) do
        if i > 1 then
            create("Frame")({
                Name = "Separator", BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.8, BorderSizePixel = 0,
                Size = UDim2.fromOffset(1, 18), Parent = content,
            })
        end

        local actionFrame = create("Frame")({
            Name = "Action" .. i, BackgroundTransparency = 1, BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY, Parent = content,

            create("TextLabel")({
                Name = "Label", BackgroundTransparency = 1, BorderSizePixel = 0,
                FontFace = Font.new("rbxassetid://12187365364"),
                Text = item.Label, TextSize = 15,
                TextColor3 = item.Destructive and Color3.fromRGB(255, 69, 88) or Color3.fromRGB(245, 245, 245),
                AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 18),
            }),

            create("UIPadding")({ PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16) }),
        })

        local hitbox = Instance.new("ImageButton")
        hitbox.Name = "Hitbox"; hitbox.BackgroundTransparency = 1
        hitbox.BorderSizePixel = 0; hitbox.Size = UDim2.fromScale(1, 1); hitbox.ZIndex = 10
        hitbox.Parent = actionFrame.__instance

        local hoverOverlay = Instance.new("Frame")
        hoverOverlay.Name = "Hover"; hoverOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hoverOverlay.BackgroundTransparency = 1; hoverOverlay.BorderSizePixel = 0
        hoverOverlay.Size = UDim2.fromScale(1, 1); hoverOverlay.ZIndex = 9
        hoverOverlay.Parent = actionFrame.__instance
        Instance.new("UICorner", hoverOverlay).CornerRadius = UDim.new(0, 6)

        hitbox.MouseEnter:Connect(function()
            TweenService:Create(hoverOverlay, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 0.92 }):Play()
        end)
        hitbox.MouseLeave:Connect(function()
            TweenService:Create(hoverOverlay, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
        end)
        hitbox.MouseButton1Down:Connect(function()
            TweenService:Create(hoverOverlay, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundTransparency = 0.85 }):Play()
        end)
        hitbox.MouseButton1Up:Connect(function()
            TweenService:Create(hoverOverlay, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
            if props.OnSelected then props.OnSelected(item, i) end
        end)

        table.insert(itemButtons, { Frame = actionFrame, Label = actionFrame.__instance:FindFirstChild("Label"), Hitbox = hitbox, Hover = hoverOverlay, Data = item })
    end

    create("Frame")({
        Name = "Spacer", BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.new(1, -130, 0, 0), Parent = content,
    })

    local menuIndicator = create("Frame")({
        Name = "MenuIndicator", BackgroundColor3 = Color3.fromRGB(18, 18, 18),
        BorderSizePixel = 0, Size = UDim2.fromOffset(36, 36), ZIndex = 3, Parent = content,
        create("UICorner")({ CornerRadius = UDim.new(1, 0) }),
        create("TextLabel")({
            BackgroundTransparency = 1, BorderSizePixel = 0,
            FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold),
            Text = "??", TextSize = 15, TextColor3 = Color3.fromRGB(245, 245, 245),
            Size = UDim2.fromScale(1, 1), TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 4,
        }),
    })

    body.Position = UDim2.fromOffset(0, -20); body.BackgroundTransparency = 1
    task.wait()
    TweenService:Create(body.__instance, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(0, 0), BackgroundTransparency = 0 }):Play()

    local obj = { Type = "EditMenu", Theme = self and self.Theme, Structures = { Body = body, Items = itemButtons, Indicator = menuIndicator }, __instance = body.__instance, Items = itemButtons }
    function obj.Parent(p) body.Parent = p end
    return obj
end