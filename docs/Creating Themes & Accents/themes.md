# Themes

Themes define the complete visual appearance of all components.

## Structure

```luau
local theme = {
    Window = {
        Background = Color3.fromRGB(12, 12, 14),
        Border = Color3.fromRGB(34, 34, 40),
        CornerRadius = 16,
    },
    TitleBar = {
        Height = 34,
        Background = Color3.fromRGB(16, 16, 19),
        TextColor = Color3.fromRGB(190, 190, 198),
    },
    -- ... more component styles
}
```

## Creating a Theme

Copy the Dark theme and modify the values to create a new look.
