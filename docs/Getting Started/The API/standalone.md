# The Standalone API

The Standalone API lets you create individual UnAlive components without a full [Window](./app.md). This gives you access to the component primitives without the overhead of a window.

## Summary

### Properties

| Property | Type               | Description                                                       |
| -------- | ------------------ | ----------------------------------------------------------------- |
| Parent   | `#!luau Instance?` | Default parent for components created on this context.            |

## Types

```luau
type ComponentProperties = {
    Theme: Theme?,
    Parent: Instance?,
}

type ComponentContext = ComponentProperties & Components
```

### Function Signature

```luau
function(self, properties: ComponentProperties?): Component
```

## Examples

### Creating standalone components

```luau
-- Create a toggle standalone without a window
local toggle = UnAlive:New("Toggle", {
    Text = "Standalone Toggle",
    Value = true,
    Parent = someFrame,
    ValueChanged = function(self, value: boolean)
        print("Value changed:", value)
    end,
})

print(toggle.Type) --> "Toggle"
```

### Shared parent

```luau
-- Both components are automatically parented to someFrame
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(300, 200),
    Parent = someFrame,
})

local toggle = UnAlive:New("Toggle", {
    Text = "Inside Card",
    Value = false,
    Parent = card.Instance,
})
```

!!! note
    You can still override `Parent` for each component individually.
