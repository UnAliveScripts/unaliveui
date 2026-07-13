# Standalone API

Every component in UnAlive can be used standalone without a parent window.

## Usage

```luau
local toggle = UnAlive:New("Toggle", {
    Text = "Standalone Toggle",
    Value = false,
    Parent = someFrame,
})
```

## Component Properties

Every component accepts `Parent` to place it directly in any frame.

## Return Values

Each component returns a table with:
- `Type` — The component type name
- `Instance` — The root Roblox instance
- Component-specific methods and properties
