local value = _G.__unaliveui_creator.Value

local function color4(color, alpha)
    local parsedColor = typeof(color) == "Color3" and color or typeof(color) == "string" and Color3.fromHex(color)
    return { value(parsedColor), value(1 - (alpha or 100) / 100) }
end

return {
    _id = "Dark",
    Text = {
        Primary = color4("FFFFFF", 85),
        Secondary = color4("FFFFFF", 55),
        Tertiary = color4("FFFFFF", 25),
        SelectionPrimary = color4("FFFFFF", 100),
    },
    Accents = { Red = color4("FF453A", 100) },
    Controls = {
        Background = color4("1C1C1E", 100),
        View = color4("1F1F21", 100),
        ViewBorder = color4("FFFFFF", 5),
        Exit = color4("FF5F57", 100),
        Minimize = color4("FEBC2E", 100),
        Zoom = color4("28C840", 100),
        Selection = color4("007AFF", 100),
        Sidebar = color4("202023", 84),
        ScrollBar = color4("FFFFFF", 35),
        Titlebar = color4("363636", 100),
        Toggle = {
            Knob = color4("FFFFFF", 100),
            KnobEffects = color4("FFFFFF", 100),
            SwitchOff = color4("7a7a7a", 40),
            SwitchOn = color4("478cf6", 100),
            DepthEffect = value(ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
                ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
            })),
        },
        Slider = {
            Track = color4("2C2C2E", 100),
            Thumb = color4("FFFFFF", 100),
            ThumbStroke = color4("000000", 20),
        },
        Button = {
            Shadow = value(Color3.fromRGB(0, 0, 0)),
            FillPrimary = value(ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 148, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 110, 255)),
            })),
            FillSecondary = value(ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55)),
            })),
        },
        Notification = {
            Background = color4("2C2C2E", 80),
            Border = color4("FFFFFF", 8),
        },
        Stepper = {
            Background = color4("373737", 100),
            Separator = color4("FFFFFF", 10),
        },
        EditMenu = {
            Background = color4("000000", 60),
            Glass = color4("000000", 99.6),
            Border = color4("FFFFFF", 5),
            Separator = color4("FFFFFF", 20),
            Text = color4("F5F5F5", 100),
            TextDestructive = color4("FF4558", 100),
        },
        Window = {
            Titlebar = color4("2A2A2E", 100),
            Background = color4("1C1C1E", 100),
            Border = color4("FFFFFF", 5),
        },
    },
}