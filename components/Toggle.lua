local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Value = props.Value or false
    
    local container = create("Frame")({ Name = "Toggle", BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(51, 31) })
    local track = create("Frame")({ Name = "Track", BackgroundColor3 = Color3.fromRGB(60, 60, 68), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), create("UICorner")({ CornerRadius = UDim.new(0, 15.5) }) })
    track.Parent = container.__instance
    local thumb = create("ImageButton")({ Name = "Thumb", BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(2, 2), Size = UDim2.fromOffset(27, 27), Image = "rbxassetid://109321922977357", ImageTransparency = 0.3, create("UICorner")({ CornerRadius = UDim.new(1, 0) }) })
    thumb.Parent = container.__instance
    
    local s = { Container = container, Track = track.__instance, Thumb = thumb.__instance }
    
    local function updateUI(val)
        if val then
            TweenService:Create(s.Track, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(52, 199, 89) }):Play()
            TweenService:Create(s.Thumb, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(22, 2) }):Play()
        else
            TweenService:Create(s.Track, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(60, 60, 68) }):Play()
            TweenService:Create(s.Thumb, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(2, 2) }):Play()
        end
    end
    
    s.Thumb.MouseButton1Click:Connect(function()
        props.Value = not props.Value
        updateUI(props.Value)
        if props.ValueChanged then task.spawn(props.ValueChanged, obj, props.Value) end
    end)
    updateUI(props.Value)
    
    local obj = { Type = "Toggle", Theme = self and self.Theme, Structures = s, __instance = container.__instance }
    obj.Parent = function(p) container.Parent = p end
    obj.Value = props.Value
    obj.ValueChanged = props.ValueChanged
    return obj
end