local C = _G.__unaliveui_creator.Create
return function(self, props)
    props = props or {}; props.Text = props.Text or "Label"
    local l = C("TextLabel")({ Name = "Label", AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0,
        FontFace = Font.new("rbxassetid://12187365364"), RichText = true, Text = props.Text, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left,
        __dynamicKeys = { TextColor3 = self.Theme.Text.Primary[1], TextTransparency = self.Theme.Text.Primary[2] } })
    if props.TextColor3 then l.TextColor3 = props.TextColor3 end; if props.TextSize then l.TextSize = props.TextSize end
    local obj = { Type = "Label", __instance = l.__instance }; function obj.Parent(p) l.Parent = p end; function obj:SetText(v) l.Text = v end; return obj
end