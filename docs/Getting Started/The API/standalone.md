# Standalone

Every component in UnAlive can be used standalone without a parent window.

## Usage

Components accept a `Parent` property to place them in any GUI container:

```luau
local toggle = UnAlive:New("Toggle", {
    Text = "Standalone Toggle",
    Value = false,
    Parent = someFrame,
})
```

## Return Values

Each component returns a table with:

| Field    | Type       | Description                         |
| -------- | ---------- | ----------------------------------- |
| `Type`   | `string`   | The component type name.            |
| `Instance`| `Instance` | The root Roblox instance.           |
| `Parent` | `function` | Method to reparent the component.   |

## Example

```luau
-- Create components without a Window
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(300, 200),
    Parent = playerGui,
})

local label = UnAlive:New("Label", {
    Text = "Standalone component",
    Parent = card.Instance,
})
```
