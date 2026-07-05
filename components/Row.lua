local C = _G.__unaliveui_creator.Create
return function(self, props)
    props = props or {}
    local b = C("Frame")({ Name = "Row", AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1,0),
        C("Frame")({ Name = "Left", AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0,200,1,0),
            C("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0,10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }),
            C("UIPadding")({ PaddingBottom = UDim.new(0,10), PaddingRight = UDim.new(0,10), PaddingTop = UDim.new(0,10) }) }),
        C("Frame")({ Name = "Right", AnchorPoint = Vector2.new(1,0), AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0,
            LayoutOrder = 1, Position = UDim2.fromScale(1,0), Size = UDim2.fromScale(0,1),
            C("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0,10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }),
            C("UIPadding")({ PaddingBottom = UDim.new(0,10), PaddingLeft = UDim.new(0,11), PaddingTop = UDim.new(0,10) }) }),
        C("Frame")({ Name = "Divider", AnchorPoint = Vector2.new(0,1), BackgroundColor3 = Color3.fromRGB(55,55,62), BorderSizePixel = 0, Position = UDim2.fromScale(0,1), Size = UDim2.new(1,0,0,1) }) })
    local s = { Left = b.__instance:FindFirstChild("Left"), Right = b.__instance:FindFirstChild("Right") }
    local obj = { Type = "Row", Structures = s, __instance = b.__instance }
    function obj.Parent(p) b.Parent = p end
    function obj:Left() local c = table.clone(obj); c.__container = s.Left; return c end
    function obj:Right() local c = table.clone(obj); c.__container = s.Right; return c end
    return obj
end