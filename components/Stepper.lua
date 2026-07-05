local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}
return function(self, props)
    props = props or {}; props.Minimum = props.Minimum or 0; props.Maximum = props.Maximum or 100
    props.Step = props.Step or 1; props.Value = props.Value or 0; props.Fielded = props.Fielded ~= false
    local container = create("Frame")({ Name = "Stepper", BackgroundTransparency = 1, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 23) })
    if props.Fielded then
        create("TextBox")({ Name = "Field", BackgroundColor3 = Color3.fromRGB(44, 44, 50), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365364"), PlaceholderColor3 = Color3.fromRGB(120, 120, 130), Text = tostring(props.Value), TextSize = 15, TextColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.fromOffset(50, 23), TextXAlignment = Enum.TextXAlignment.Center, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) }).Parent = container.__instance
    end
    create("ImageButton")({ Name = "Up", BackgroundColor3 = Color3.fromRGB(44, 44, 50), AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(props.Fielded and 56 or 0, 0), Size = UDim2.fromOffset(22, 23), Image = icons["chevron-up"] or "rbxassetid://137296891812002", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) }).Parent = container.__instance
    create("ImageButton")({ Name = "Down", BackgroundColor3 = Color3.fromRGB(44, 44, 50), AutoButtonColor = false, BorderSizePixel = 0, Position = UDim2.fromOffset(props.Fielded and 80 or 22, 0), Size = UDim2.fromOffset(22, 23), Image = icons["chevron-down"] or "rbxassetid://84215348315149", ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.3, create("UICorner")({ CornerRadius = UDim.new(0, 6) }) }).Parent = container.__instance
    local obj = { Type = "Stepper", Theme = self and self.Theme, __instance = container.__instance }
    function obj.Parent(p) container.Parent = p end
    return obj
end