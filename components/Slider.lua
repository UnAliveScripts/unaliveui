local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}; props.Minimum = props.Minimum or 0; props.Maximum = props.Maximum or 100; props.Value = props.Value or 0
    local theme = self.Theme.Controls.Slider; local parent = self.__container or self.__instance or self
    local structures = {}; local dragging = false

    local body = create("Frame")({ Name = "Slider", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 24), Parent = parent })
    local track = create("Frame")({ Name = "Track", BorderSizePixel = 0, Position = UDim2.fromOffset(0, 10), Size = UDim2.new(1, 0, 0, 4), Parent = body.__instance,
        __dynamicKeys = { BackgroundColor3 = theme.Track[1], BackgroundTransparency = theme.Track[2] }, create("UICorner")({ CornerRadius = UDim.new(0, 2) }) })
    local fill = create("Frame")({ Name = "Fill", BorderSizePixel = 0, Size = UDim2.fromOffset(0, 4), Parent = body.__instance,
        __dynamicKeys = { BackgroundColor3 = self.Theme.Controls.Selection[1] }, create("UICorner")({ CornerRadius = UDim.new(0, 2) }) })
    local thumb = create("ImageButton")({ Name = "Thumb", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 2), Size = UDim2.fromOffset(20, 20), ZIndex = 2, Parent = body.__instance,
        __dynamicKeys = { ImageColor3 = theme.Thumb[1], ImageTransparency = theme.Thumb[2] },
        create("UICorner")({ CornerRadius = UDim.new(1, 0) }),
        create("UIStroke")({ ApplyStrokeMode = Enum.ApplyStrokeMode.Border, __dynamicKeys = { Color = theme.ThumbStroke[1], Transparency = theme.ThumbStroke[2] } }) })

    structures.Body = body.__instance; structures.Track = track.__instance; structures.Fill = fill.__instance; structures.Thumb = thumb.__instance

    local function setPosition(val)
        local range = props.Maximum - props.Minimum; if range <= 0 then return end
        local pct = (val - props.Minimum) / range; local w = body.AbsoluteSize.X - 20; local x = math.floor(pct * w)
        structures.Thumb.Position = UDim2.fromOffset(x, 2); structures.Fill.Size = UDim2.fromOffset(x + 10, 4)
    end

    structures.Thumb.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    structures.Thumb.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    structures.Thumb.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local w = body.AbsoluteSize.X - 20; local x = math.clamp(i.Position.X - 10, 0, w)
            local pct = w > 0 and x / w or 0; props.Value = props.Minimum + pct * (props.Maximum - props.Minimum)
            setPosition(props.Value); if props.ValueChanged then task.spawn(props.ValueChanged, object, props.Value) end
        end
    end)
    task.wait(); setPosition(props.Value)
    local object = { Type = "Slider", Theme = self.Theme, Structures = structures, __instance = body.__instance }
    function object:SetValue(val) props.Value = val; setPosition(val) end
    return object
end