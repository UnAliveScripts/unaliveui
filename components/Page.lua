local C = _G.__unaliveui_creator.Create
return function(self, props)
    props = props or {}
    local f = C("ScrollingFrame")({ Name = "Page", AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0,
        CanvasSize = UDim2.new(), ClipsDescendants = false, ScrollBarImageColor3 = Color3.fromRGB(150,150,160), ScrollBarImageTransparency = 0.6, ScrollBarThickness = 7,
        Size = UDim2.fromScale(1,1),
        C("UIListLayout")({ Name = "Layout", Padding = UDim.new(0,9), SortOrder = Enum.SortOrder.LayoutOrder }),
        C("UIPadding")({ PaddingBottom = UDim.new(0,17), PaddingLeft = UDim.new(0,17), PaddingRight = UDim.new(0,17), PaddingTop = UDim.new(0,17) }) })
    local obj = { Type = "Page", __instance = f.__instance }; function obj.Parent(p) f.Parent = p end; obj.__container = f.__instance; return obj
end