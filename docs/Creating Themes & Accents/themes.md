# Themes

Themes define the complete visual appearance of all components.

## Theme Structure

```luau
local Theme = {
    _id = "Dark",  -- Theme identifier
    Window = {
        Width = 540,
        Height = 400,
        CornerRadius = 16,
        BorderThickness = 1,
        Background = Color3.fromRGB(12, 12, 14),
        Border = Color3.fromRGB(34, 34, 40),
        Shadow = { Enabled = true, Transparency = 0.65 },
    },
    TitleBar = {
        Height = 34,
        Background = Color3.fromRGB(16, 16, 19),
        Line = Color3.fromRGB(36, 36, 42),
        Text = "UnAlive",
        TextColor = Color3.fromRGB(190, 190, 198),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextLeft = 14,
    },
    Card = {
        MarginLeft = 22,
        MarginRight = 22,
        MarginTop = 18,
        MarginBottom = 18,
        CornerRadius = 16,
        BorderThickness = 1,
        Background = Color3.fromRGB(20, 20, 24),
        Border = Color3.fromRGB(38, 38, 46),
        Shadow = { Enabled = true, Image = "rbxassetid://6015897843", Transparency = 0.7, Offset = 30 },
    },
    Input = {
        Height = 46,
        CornerRadius = 10,
        BorderThickness = 1,
        IconSize = 16,
        Background = Color3.fromRGB(24, 24, 28),
        Border = Color3.fromRGB(42, 42, 50),
        BorderFocus = Color3.fromRGB(64, 64, 78),
        BorderError = Color3.fromRGB(185, 50, 50),
    },
    Button = {
        Height = 46,
        CornerRadius = 10,
        Background = Color3.fromRGB(30, 30, 36),
        Border = Color3.fromRGB(48, 48, 58),
        HoverBackground = Color3.fromRGB(38, 38, 46),
        HoverBorder = Color3.fromRGB(64, 64, 78),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
    Toggle = {
        On = Color3.fromRGB(71, 140, 246),
        Off = Color3.fromRGB(58, 58, 60),
        Knob = Color3.fromRGB(255, 255, 255),
        Size = 44,
    },
    Slider = {
        Track = Color3.fromRGB(44, 44, 46),
        Fill = Color3.fromRGB(0, 122, 255),
    },
    Label = {
        Primary = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(180, 180, 190),
        Muted = Color3.fromRGB(135, 135, 150),
    },
}
```

## Creating a Custom Theme

Copy the Dark theme above and modify the values to create a new look.

## Applying a Theme

Currently, UnAlive uses the Dark theme by default. Future releases will support runtime theme switching.
