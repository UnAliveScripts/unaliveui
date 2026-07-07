local TS = game:GetService("TweenService"); local C = _G.__unaliveui_creator.Create; local icons = _G.__unaliveui_icons or {}
return function(self, props)
    props = props or {}; props.Items = props.Items or {}; props.Label = props.Label or "Pulldown"
    local white = Color3.fromRGB(255, 255, 255); local blue = Color3.fromRGB(0, 136, 255); local darkText = Color3.fromRGB(220, 220, 220)
    local selectedLabel = nil; local isOpen = false; local itemButtons = {}

    local c = C("Frame")({ Name = "Pulldown", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(100, 260), ZIndex = 50,
        -- Button
        C("TextButton")({ Name = "PullDownButton", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(30, 32, 38), BorderSizePixel = 0,
            Size = UDim2.fromOffset(100, 24), Text = "", ZIndex = 51,
            C("UICorner")({ CornerRadius = UDim.new(0, 6) }),
            C("UIStroke")({ Color = white, Transparency = 0.85, Thickness = 0.5 }),
            C("TextLabel")({ Name = "Label", BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"),
                Size = UDim2.fromOffset(56, 24), Position = UDim2.fromOffset(12, 0), Text = props.Label, TextSize = 13,
                TextColor3 = white, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center }),
            C("ImageLabel")({ Name = "Chevron", BackgroundTransparency = 1, BorderSizePixel = 0, Image = icons["chevron-down"],
                ImageColor3 = white, Size = UDim2.fromOffset(24, 24), Position = UDim2.fromOffset(76, 0) }) }),

        -- Menu
        C("Frame")({ Name = "Menu", BackgroundColor3 = Color3.fromRGB(18, 20, 26), BackgroundTransparency = 0.08, BorderSizePixel = 0,
            Size = UDim2.fromOffset(95, 0), Position = UDim2.fromOffset(0, 30), Visible = false, ClipsDescendants = true, ZIndex = 51,
            C("UICorner")({ CornerRadius = UDim.new(0, 13) }),
            C("UIStroke")({ Color = white, Transparency = 0.88, Thickness = 0.5 }),
            C("Frame")({ Name = "Glass", BackgroundColor3 = Color3.fromRGB(18, 20, 26), BackgroundTransparency = 0.85, BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1), ZIndex = 51,
                C("UICorner")({ CornerRadius = UDim.new(0, 13) }) }),
            -- Scroller
            C("ScrollingFrame")({ Name = "ItemsScroller", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -4, 1, 0),
                Position = UDim2.fromOffset(2, 0), ZIndex = 52, ScrollBarThickness = 4,
                ScrollBarImageColor3 = Color3.fromRGB(160, 160, 160), ScrollBarImageTransparency = 0.2,
                TopImage = "rbxasset://textures/ui/ScrollBar/top.png", MidImage = "rbxasset://textures/ui/ScrollBar/mid.png",
                BottomImage = "rbxasset://textures/ui/ScrollBar/bottom.png", ScrollingDirection = Enum.ScrollingDirection.Y,
                ElasticBehavior = Enum.ElasticBehavior.Never, ClipsDescendants = true,
                C("UIListLayout")({ Padding = UDim.new(0, 0), HorizontalAlignment = Enum.HorizontalAlignment.Center }),
                C("UIPadding")({ PaddingTop = UDim.new(0, 5) }) })
        })
    })

    local menu = c.__instance:FindFirstChild("Menu")
    local scroller = menu:FindFirstChild("ItemsScroller")
    local btn = c.__instance:FindFirstChild("PullDownButton")
    local chev = btn:FindFirstChild("Chevron")

    -- Auto-canvas resize
    local layout = scroller:FindFirstChildOfClass("UIListLayout")
    local function uc() scroller.CanvasSize = UDim2.fromOffset(0, math.max(layout.AbsoluteContentSize.Y + 10, scroller.AbsoluteSize.Y + 10)) end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(uc)

    function c.__instance:AddItem(name, selectIt)
        local item = Instance.new("TextButton", scroller)
        item.Size = UDim2.fromOffset(71, 24); item.Text = ""; item.AutoButtonColor = false
        item.BackgroundTransparency = 1; item.BorderSizePixel = 0; item.ZIndex = 53

        local selBg = Instance.new("Frame", item); selBg.Name = "SelBg"
        selBg.Size = UDim2.fromOffset(85, 24); selBg.Position = UDim2.fromOffset(-7, 0)
        selBg.BackgroundColor3 = blue; selBg.BackgroundTransparency = selectIt and 0.2 or 1
        selBg.BorderSizePixel = 0; selBg.ZIndex = 53
        Instance.new("UICorner", selBg).CornerRadius = UDim.new(0, 8)

        local label = Instance.new("TextLabel", item)
        label.Size = UDim2.fromOffset(71, 24); label.BackgroundTransparency = 1; label.BorderSizePixel = 0; label.ZIndex = 54
        label.Font = Enum.Font.SourceSans; label.Text = name; label.TextSize = 13
        label.TextColor3 = selectIt and white or darkText
        label.TextXAlignment = Enum.TextXAlignment.Left; label.TextYAlignment = Enum.TextYAlignment.Center

        if selectIt then selectedLabel = label end

        item.MouseButton1Click:Connect(function()
            if selectedLabel and selectedLabel ~= label then
                selectedLabel.TextColor3 = darkText
                local bg = selectedLabel.Parent:FindFirstChild("SelBg")
                if bg then bg.BackgroundTransparency = 1 end
            end
            if selectedLabel ~= label then
                label.TextColor3 = white; selBg.BackgroundTransparency = 0.2; selectedLabel = label
                if props.OnSelected then task.spawn(props.OnSelected, name) end
            end
        end)
        uc(); return item
    end

    -- Populate items
    for _, data in ipairs(props.Items) do
        local name = type(data) == "string" and data or data.Label
        local sel = type(data) == "table" and data.Selected or false
        c.__instance:AddItem(name, sel)
    end
    uc()

    -- Toggle
    local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            menu.Size = UDim2.fromOffset(95, 0); menu.Visible = true
            TS:Create(menu, ti, {Size = UDim2.fromOffset(95, 226)}):Play()
            if chev then TS:Create(chev, ti, {Rotation = 180}):Play() end
        else
            local t = TS:Create(menu, ti, {Size = UDim2.fromOffset(95, 0)})
            t.Completed:Connect(function() menu.Visible = false end); t:Play()
            if chev then TS:Create(chev, ti, {Rotation = 0}):Play() end
        end
    end)

    local obj = { Type = "Pulldown", __instance = c.__instance }
    function obj.Parent(p) c.Parent = p end
    function obj:AddItem(name, sel) c.__instance:AddItem(name, sel) end
    return obj
end