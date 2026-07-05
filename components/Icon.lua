local create = _G.__unaliveui_creator.Create
local icons = _G.__unaliveui_icons or {}

return function(self, props)
    props = props or {}
    local iconName = props.Icon or "circle"
    local iconId = icons[iconName] or icons.circle
    local img = create("ImageLabel")({ Name = "Icon", BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = iconId, Size = UDim2.fromOffset(20, 20), ImageColor3 = props.Color or Color3.fromRGB(255, 255, 255) })
    if props.Size then img.Size = props.Size end
    if props.ImageTransparency then img.ImageTransparency = props.ImageTransparency end
    local obj = { Type = "Icon", __instance = img.__instance }
    function obj.Parent(p) img.Parent = p end
    function obj:SetIcon(v) local id = icons[v] or v; img.Image = id end
    return obj
end