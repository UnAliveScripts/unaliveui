local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}; props.Items = props.Items or {}

    local structures = { ItemButtons = {} }

    local body = create("Frame")({
        Name = "EditMenu", BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(488, 44), AutomaticSize = Enum.AutomaticSize.XY,
        create("Frame")({ Name = "FillShadow", BackgroundColor3 = Color3.fromRGB(204, 204, 204),
            BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0,
            create("UICorner")({ CornerRadius = UDim.new(0, 34) }) }),
        create("Frame")({ Name = "Glass", BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.996, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 1,
            create("UICorner")({ CornerRadius = UDim.new(0, 34) }),
            create("UIStroke")({ Name = "Border", Color = Color3.fromRGB(255, 255, 255), Transparency = 0.95, Thickness = 0.5 }) }),
        create("Frame")({ Name = "Content", BackgroundTransparency = 1, BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1), ZIndex = 2,
            create("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0) }),
            create("UIPadding")({ PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 4) }) }),
    })

    local content = body.__instance:FindFirstChild("Content")

    for i, item in ipairs(props.Items) do
        if i > 1 then
            local sep = Instance.new("Frame")
            sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255); sep.BackgroundTransparency = 0.8
            sep.BorderSizePixel = 0; sep.Size = UDim2.fromOffset(1, 18); sep.Parent = content
        end
        local action = Instance.new("Frame")
        action.BackgroundTransparency = 1; action.BorderSizePixel = 0
        action.AutomaticSize = Enum.AutomaticSize.XY; action.Name = "Action" .. i; action.Parent = content
        local text = Instance.new("TextLabel")
        text.BackgroundTransparency = 1; text.BorderSizePixel = 0
        text.FontFace = Font.new("rbxassetid://12187365364"); text.Text = item.Label; text.TextSize = 15
        text.TextColor3 = item.Destructive and Color3.fromRGB(255, 69, 88) or Color3.fromRGB(245, 245, 245)
        text.AutomaticSize = Enum.AutomaticSize.XY; text.Size = UDim2.fromOffset(0, 18); text.Name = "Label"; text.Parent = action
        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 16); pad.PaddingRight = UDim.new(0, 16); pad.Parent = action
        local hitbox = Instance.new("ImageButton")
        hitbox.Name = "Hitbox"; hitbox.BackgroundTransparency = 1; hitbox.BorderSizePixel = 0
        hitbox.Size = UDim2.fromScale(1, 1); hitbox.ZIndex = 10; hitbox.Parent = action
        local hover = Instance.new("Frame")
        hover.Name = "Hover"; hover.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        hover.BackgroundTransparency = 1; hover.BorderSizePixel = 0
        hover.Size = UDim2.fromScale(1, 1); hover.ZIndex = 9; hover.Parent = action
        Instance.new("UICorner", hover).CornerRadius = UDim.new(0, 6)
        hitbox.MouseEnter:Connect(function() TweenService:Create(hover, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 0.92 }):Play() end)
        hitbox.MouseLeave:Connect(function() TweenService:Create(hover, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play() end)
        hitbox.MouseButton1Down:Connect(function() TweenService:Create(hover, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { BackgroundTransparency = 0.85 }):Play() end)
        hitbox.MouseButton1Up:Connect(function() TweenService:Create(hover, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play(); if props.OnSelected then props.OnSelected(item, i) end end)
        table.insert(structures.ItemButtons, { Frame = action, Label = text, Hitbox = hitbox, Hover = hover, Data = item })
    end

    local indicator = Instance.new("Frame")
    indicator.BackgroundColor3 = Color3.fromRGB(18, 18, 18); indicator.BorderSizePixel = 0
    indicator.Size = UDim2.fromOffset(36, 36); indicator.Parent = content
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    local indText = Instance.new("TextLabel")
    indText.BackgroundTransparency = 1; indText.BorderSizePixel = 0
    indText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
    indText.Text = "??"; indText.TextSize = 15; indText.TextColor3 = Color3.fromRGB(245, 245, 245)
    indText.Size = UDim2.fromScale(1, 1); indText.TextXAlignment = Enum.TextXAlignment.Center
    indText.TextYAlignment = Enum.TextYAlignment.Center; indText.Parent = indicator

    local object = { Type = "EditMenu", Theme = self and self.Theme, Structures = structures, __instance = body.__instance }
    function object.Parent(p) body.Parent = p end
    return object
end