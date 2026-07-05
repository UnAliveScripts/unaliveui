local V = _G.__unaliveui_creator.Value
local function c4(c, a)
    local clr = typeof(c) == "Color3" and c or typeof(c) == "string" and Color3.fromHex(c)
    return { V(clr), V(1 - (a or 100) / 100) }
end

return {
    _id = "Dark",
    Text = {
        Primary = c4("FFFFFF", 85),
        Secondary = c4("FFFFFF", 55),
        SelectionPrimary = c4("FFFFFF", 100),
    },
    Accents = { Red = c4("FF453A", 100) },
    Controls = {
        Background = c4("1C1C1E", 100),
        View = c4("1F1F21", 100),
        ViewBorder = c4("FFFFFF", 5),
        Sidebar = c4("202023", 84),
        ScrollBar = c4("FFFFFF", 35),
        Separator = { Background = c4("000000", 50), Shadow = c4("FFFFFF", 0) },
        Titlebar = c4("363636", 100),
        Exit = c4("FF5F57", 100),
        Minimize = c4("FEBC2E", 100),
        Zoom = c4("28C840", 100),
        Selection = c4("007AFF", 100),
        Toggle = {
            Knob = c4("FFFFFF", 100), KnobEffects = c4("FFFFFF", 100),
            SwitchOff = c4("7a7a7a", 40), SwitchOn = c4("478cf6", 100),
            DepthEffect = V(ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
                ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
            })),
        },
        Slider = { Track = c4("2C2C2E", 100), TrackFill = V(Color3.fromRGB(10, 132, 255)), Thumb = c4("FFFFFF", 100), ThumbStroke = c4("000000", 20) },
        Button = {
            Shadow = V(Color3.fromRGB(0, 0, 0)),
            FillPrimary = V(ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 148, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 110, 255)) })),
            FillSecondary = V(ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55)) })),
        },
        Notification = { Background = c4("2C2C2E", 92), Border = c4("FFFFFF", 8) },
        Window = { Titlebar = c4("2A2A2E", 100), Background = c4("1C1C1E", 100), Border = c4("FFFFFF", 5) },
        EditMenu = { Background = c4("000000", 33), Border = c4("FFFFFF", 5), Separator = c4("FFFFFF", 20), Text = c4("F5F5F5", 100), TextDestructive = c4("FF4558", 100) },
    },
}