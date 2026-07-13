# Themes

UnAlive uses a theme system to control the visual appearance of all components.

## Dark Theme (Default)

The default theme uses the Alert color scheme with dark backgrounds and subtle borders.

## Theme Structure

```luau
local theme = {
    Window = { ... },
    TitleBar = { ... },
    Card = { ... },
    Input = { ... },
    Button = { ... },
    Toggle = { ... },
    Slider = { ... },
    TextField = { ... },
    Label = { ... },
}
```

## Accessing the Theme

```luau
local theme = UnAlive.Theme
local windowBg = theme.Window.Background
```
