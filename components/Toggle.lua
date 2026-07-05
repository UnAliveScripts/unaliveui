-- Figma-accurate Toggle/Switch
local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Value = props.Value or false
    props.Disabled = props.Disabled or false

    local theme = self and self.Theme and self.Theme.Toggle or {
        TrackOn = { Color3.fromRGB(52, 199, 89), 0 },
        TrackOff = { Color3.fromRGB(60, 60, 68), 0.3 },
        Thumb = { Color3.fromRGB(255, 255, 255), 0 },
    }

    local container = create("Frame")({
        Name = "Toggle", BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(63, 27),
    })

    local track = create("Frame")({
        Name = "Track", BackgroundColor3 = theme.TrackOff[1].Value,
        BackgroundTransparency = theme.TrackOff[2].Value, BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1), Parent = container.__instance,
        create("UICorner")({ CornerRadius = UDim.new(1, 0) }),
    })

    local knob = create("ImageButton")({
        Name = "Knob", BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0, BorderSizePixel = 0, AutoButtonColor = false,
        Position = UDim2.fromOffset(2, 2), Size = UDim2.fromOffset(39, 23),
        Parent = container.__instance, ZIndex = 2,
        create("UICorner")({ CornerRadius = UDim.new(1, 0) }),
        create("UIStroke")({ Color = Color3.fromRGB(0, 0, 0), Transparency = 0.92, Thickness = 0.5 }),
    })

    local structures = { Container = container, Track = track.__instance, Knob = knob.__instance }

    local function updateUI(val, instant)
        if instant then
            if val then
                structures.Track.BackgroundColor3 = theme.TrackOn[1].Value
                structures.Track.BackgroundTransparency = theme.TrackOn[2].Value
                structures.Knob.Position = UDim2.fromOffset(22, 2)
                structures.Container.Size = UDim2.fromOffset(62, 26)
            else
                structures.Track.BackgroundColor3 = theme.TrackOff[1].Value
                structures.Track.BackgroundTransparency = theme.TrackOff[2].Value
                structures.Knob.Position = UDim2.fromOffset(2, 2)
                structures.Container.Size = UDim2.fromOffset(63, 27)
            end
            return
        end
        if val then
            TweenService:Create(structures.Track, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundColor3 = theme.TrackOn[1].Value, BackgroundTransparency = theme.TrackOn[2].Value }):Play()
            TweenService:Create(structures.Knob, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(22, 2) }):Play()
            TweenService:Create(structures.Container, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(62, 26) }):Play()
        else
            TweenService:Create(structures.Track, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { BackgroundColor3 = theme.TrackOff[1].Value, BackgroundTransparency = theme.TrackOff[2].Value }):Play()
            TweenService:Create(structures.Knob, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(2, 2) }):Play()
            TweenService:Create(structures.Container, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(63, 27) }):Play()
        end
    end

    local function onRelease()
        if props.Disabled then return end
        props.Value = not props.Value
        updateUI(props.Value)
        TweenService:Create(structures.Knob, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(39, 23) }):Play()
        if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
    end

    structures.Knob.MouseButton1Down:Connect(function()
        if props.Disabled then return end
        TweenService:Create(structures.Knob, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(42, 25) }):Play()
    end)
    structures.Knob.MouseButton1Up:Connect(onRelease)
    structures.Knob.MouseLeave:Connect(function()
        TweenService:Create(structures.Knob, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(39, 23) }):Play()
    end)

    local trackBtn = Instance.new("ImageButton")
    trackBtn.Name = "TrackHitbox"; trackBtn.BackgroundTransparency = 1
    trackBtn.BorderSizePixel = 0; trackBtn.Size = UDim2.fromScale(1, 1); trackBtn.ZIndex = 1
    trackBtn.Parent = container.__instance
    trackBtn.MouseButton1Click:Connect(function()
        if props.Disabled then return end
        props.Value = not props.Value; updateUI(props.Value)
        if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
    end)

    updateUI(props.Value, true)

    local obj = { Type = "Toggle", Theme = self and self.Theme, Structures = structures, __instance = container.__instance }
    function obj:Toggle() props.Value = not props.Value; updateUI(props.Value); if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end end
    function obj:SetValue(val) props.Value = val; updateUI(props.Value) end
    function obj.Parent(p) container.Parent = p end
    return obj
end