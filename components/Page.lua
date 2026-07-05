local create = _G.__unaliveui_creator.Create
return function(self, props)
    props = props or {}
    local frame = create("ScrollingFrame")({
        Name = "Page", AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1, BorderSizePixel = 0,
        CanvasSize = UDim2.new(), ClipsDescendants = false,
        ScrollBarImageColor3 = Color3.fromRGB(150, 150, 160),
        ScrollBarImageTransparency = 0.6, ScrollBarThickness = 7,
        Size = UDim2.fromScale(1, 1),
        create("UIListLayout")({ Name = "Layout", Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder }),
        create("UIPadding")({ PaddingBottom = UDim.new(0, 17), PaddingLeft = UDim.new(0, 17), PaddingRight = UDim.new(0, 17), PaddingTop = UDim.new(0, 17) }),
    })
    local s = { Frame = frame, Layout = frame.__instance:FindFirstChild("Layout") }
    local obj = { Type = "Page", Theme = self and self.Theme, Structures = s, __instance = frame.__instance }
    function obj.Parent(p) frame.Parent = p end
    obj.__container = frame.__instance
    return obj
end