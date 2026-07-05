local C = _G.__unaliveui_creator.Create; local icons = _G.__unaliveui_icons or {}
return function(self, props)
    props = props or {}; local id = icons[props.Icon or "circle"] or icons.circle
    local img = C("ImageLabel")({ Name = "Icon", BackgroundTransparency = 1, BorderSizePixel = 0,
        Image = id, Size = props.Size or UDim2.fromOffset(20,20), ImageColor3 = props.Color or Color3.fromRGB(255,255,255) })
    if props.ImageTransparency then img.ImageTransparency = props.ImageTransparency end
    local obj = { Type = "Icon", __instance = img.__instance }
    function obj.Parent(p) img.Parent = p end; function obj:SetIcon(v) local id = icons[v] or v; img.Image = id end; return obj
end