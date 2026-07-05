local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Text = props.Text or "Label"
    
    local label = create("TextLabel")({
        Name = "Label", AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364"),
        RichText = true, Text = props.Text, TextSize = 15,
        TextColor3 = Color3.fromRGB(180, 180, 190), TextWrapped = true,
    })
    
    if props.TextColor3 then label.TextColor3 = props.TextColor3 end
    if props.TextSize then label.TextSize = props.TextSize end
    if props.TextXAlignment then label.TextXAlignment = props.TextXAlignment end
    
    local obj = { Type = "Label", Theme = self and self.Theme, __instance = label.__instance }
    obj.Parent = function(p) label.Parent = p end
    obj.Text = function(v) label.Text = v end
    return obj
end