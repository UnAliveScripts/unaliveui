# Themes

UnAlive uses a theme system to control the visual appearance of all components.

## Dark Theme (Default)

The default theme uses the Alert color scheme with dark backgrounds and subtle borders.

## Theme Structure

```luau
type Theme = {
    _id: string,
    Window: {
        Width: number,
        Height: number,
        CornerRadius: number,
        BorderThickness: number,
        Background: Color3,
        Border: Color3,
        Shadow: { Enabled: boolean, Transparency: number },
    },
    TitleBar: {
        Height: number,
        Background: Color3,
        Line: Color3,
        Text: string,
        TextColor: Color3,
        Font: Font,
        TextSize: number,
    },
    Card: {
        MarginLeft: number,
        MarginRight: number,
        MarginTop: number,
        MarginBottom: number,
        CornerRadius: number,
        Background: Color3,
        Border: Color3,
    },
    -- ... additional component styles
}
```

## Accessing the Theme

```luau
local theme = UnAlive.Theme
local windowBg = theme.Window.Background
```
