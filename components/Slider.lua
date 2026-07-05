local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
return function(self, props)
    props = props or {}
    props.Minimum = props.Minimum or 0; props.Maximum = props.Maximum or 100
    props.Value = props.Value or 50
    local container = create("Frame")({ Name = "Slider", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 24) })
    local track = create("Frame")({ Name = "Track", BackgroundColor3 = Color3.fromRGB(60, 60, 68), BorderSizePixel = 0, Position = UDim2.fromOffset(0, 10), Size = UDim2.new(1, 0, 0, 4), create("UICorner")({ CornerRadius = UDim.new(0, 2) }) })
    track.Parent = container.__instance
    local fill = create("Frame")({ Name = "Fill", BackgroundColor3 = Color3.fromRGB(10, 132, 255), BorderSizePixel = 0, Size = UDim2.fromOffset(0, 4), create("UICorner")({ CornerRadius = UDim.new(0, 2) }) })
    fill.Parent = container.__instance
    local thumb = create("ImageButton")({ Name = "Thumb", BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, AutoButtonColor = false, Position = UDim2.fromOffset(0, 2), Size = UDim2.fromOffset(20, 20), ImageColor3 = Color3.fromRGB(200, 200, 200), ZIndex = 2, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) })
    thumb.Parent = container.__instance
    local s = { Container = container, Track = track.__instance, Fill = fill.__instance, Thumb = thumb.__instance }
    local function setPosition(val)
        local pct = (val - props.Minimum) / (props.Maximum - props.Minimum)
        local w = container.AbsoluteSize.X - 20; local x = math.floor(pct * w)
        s.Thumb.Position = UDim2.fromOffset(x, 2); s.Fill.Size = UDim2.fromOffset(x + 10, 4)
    end
    local dragging = false
    s.Thumb.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
    s.Thumb.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    s.Thumb.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local w = container.AbsoluteSize.X - 20; local x = math.clamp(i.Position.X - 10, 0, w)
            local pct = x / w; props.Value = props.Minimum + pct * (props.Maximum - props.Minimum)
            setPosition(props.Value); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
        end
    end)
    task.wait(); setPosition(props.Value)
    local obj = { Type = "Slider", Theme = self and self.Theme, Structures = s, __instance = container.__instance }
    function obj.Parent(p) container.Parent = p end; obj.Value = props.Value; obj.ValueChanged = props.ValueChanged
    return obj
end