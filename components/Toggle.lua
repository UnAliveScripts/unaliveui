local TweenService = game:GetService("TweenService")
local create = _G.__unaliveui_creator.Create

return function(self, props)
    props = props or {}
    props.Value = props.Value == true

    local parent = self.__container or self.__instance or self
    local theme = self.Theme.Controls.Toggle
    local structures = {}

    structures.Body = create("Frame")({
        Name = "Toggle",
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.fromOffset(28, 16), Parent = parent,

        create("ImageButton")({
            Name = "Switch", AutoButtonColor = false,
            BackgroundTransparency = 1, BorderSizePixel = 0,
            Image = "rbxassetid://104426531889908",
            Size = UDim2.fromOffset(28, 16),
            __dynamicKeys = {
                ImageColor3 = theme.SwitchOff[1],
                ImageTransparency = theme.SwitchOff[2],
            },
            create("ImageLabel")({
                Name = "Knob",
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1, BorderSizePixel = 0,
                Image = "rbxassetid://99107881432922",
                Position = UDim2.new(0, 1, 0.5, 0),
                Size = UDim2.fromOffset(14, 14),
                __dynamicKeys = {
                    ImageColor3 = theme.Knob[1],
                    ImageTransparency = theme.Knob[2],
                },
                create("ImageLabel")({
                    Name = "Effects",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1, BorderSizePixel = 0,
                    Image = "rbxassetid://138042641797315",
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(16, 16),
                    __dynamicKeys = {
                        ImageColor3 = theme.KnobEffects[1],
                        ImageTransparency = theme.KnobEffects[2],
                    },
                }),
            }),
            create("UIGradient")({
                Name = "Depth", Rotation = 90,
                __dynamicKeys = { Color = theme.DepthEffect },
            }),
        }),
    })

    structures.Switch = structures.Body.__instance:FindFirstChild("Switch")
    structures.Knob = structures.Switch:FindFirstChild("Knob")

    local function updateValue(val, instant)
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        local knobGoal = { Position = val and UDim2.new(0, 13, 0.5, 0) or UDim2.new(0, 1, 0.5, 0) }
        local switchColor = val and theme.SwitchOn[1].Value or theme.SwitchOff[1].Value
        local switchTrans = val and theme.SwitchOn[2].Value or theme.SwitchOff[2].Value

        if instant then
            structures.Knob.Position = knobGoal.Position
            structures.Switch.ImageColor3 = switchColor
            structures.Switch.ImageTransparency = switchTrans
            return
        end
        TweenService:Create(structures.Knob, tweenInfo, knobGoal):Play()
        TweenService:Create(structures.Switch, tweenInfo, { ImageColor3 = switchColor, ImageTransparency = switchTrans }):Play()
    end

    updateValue(props.Value, true)

    structures.Switch.MouseButton1Click:Connect(function()
        props.Value = not props.Value
        updateValue(props.Value)
        if props.ValueChanged then task.spawn(props.ValueChanged, object, props.Value) end
    end)

    local object = { Type = "Toggle", Theme = self.Theme, Structures = structures, __instance = structures.Body.__instance }
    function object:SetValue(val) props.Value = val; updateValue(val) end
    return object
end