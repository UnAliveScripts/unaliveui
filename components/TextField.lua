local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Placeholder = props.Placeholder or "Search"
    
    local container = create("Frame")({ Name = "TextField", BackgroundColor3 = Color3.fromRGB(44, 44, 50), BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 23), create("UICorner")({ CornerRadius = UDim.new(0, 6) }) })
    local box = create("TextBox")({ Name = "Input", BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"), PlaceholderText = props.Placeholder, PlaceholderColor3 = Color3.fromRGB(120, 120, 130), Text = props.Value or "", TextSize = 15, TextColor3 = Color3.fromRGB(255, 255, 255), TextEditable = true, Size = UDim2.fromOffset(200, 23), Position = UDim2.fromOffset(8, 0), ClearTextOnFocus = false })
    box.Parent = container.__instance
    
    local s = { Container = container, Box = box.__instance }
    
    box.Focused:Connect(function()
        TweenService:Create(container.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(50, 50, 58) }):Play()
    end)
    box.FocusLost:Connect(function()
        TweenService:Create(container.__instance, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { BackgroundColor3 = Color3.fromRGB(44, 44, 50) }):Play()
        if props.ValueChanged then props.Value = box.Text; task.spawn(props.ValueChanged, obj, box.Text) end
    end)
    box:GetPropertyChangedSignal("Text"):Connect(function()
        if props.TextChanged then task.spawn(props.TextChanged, obj, box.Text) end
    end)
    
    local obj = { Type = "TextField", Theme = self and self.Theme, Structures = s, __instance = container.__instance }
    obj.Parent = function(p) container.Parent = p end
    obj.Value = function(v) box.Text = v end
    obj.Placeholder = function(v) box.PlaceholderText = v end
    return obj
end