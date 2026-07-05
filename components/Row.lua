local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    local body = create("Frame")({
        Name = "Row", AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0),
        create("Frame")({ Name = "LeftAccessory", AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(0, 200, 1, 0),
            create("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }),
            create("UIPadding")({ PaddingBottom = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) }) }),
        create("Frame")({ Name = "RightAccessory", AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0, 1),
            create("UIListLayout")({ FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }),
            create("UIPadding")({ PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 11), PaddingTop = UDim.new(0, 10) }) }),
        create("Frame")({ Name = "Divider", AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(55, 55, 62), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1) }) })
    local structures = { Body = body.__instance, Left = body.__instance:FindFirstChild("LeftAccessory"), Right = body.__instance:FindFirstChild("RightAccessory") }
    local obj = { Type = "Row", Theme = self and self.Theme, Structures = structures, __instance = body.__instance }
    function obj.Parent(p) body.Parent = p end
    function obj:Left() local c = table.clone(obj); c.__container = structures.Left; return c end
    function obj:Right() local c = table.clone(obj); c.__container = structures.Right; return c end
    return obj
end