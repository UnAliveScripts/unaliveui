# EditMenu

An `EditMenu` is a tabbed edit menu bar with glass-style background.

## Summary

### Properties

| Property   | Type       | Description                    |
| ---------- | ---------- | ------------------------------ |
| `Position` | `UDim2?`   | The menu position              |
| `Parent`   | `Instance?`| The parent GUI instance        |

## Example

```luau
local editMenu = UnAlive:New("EditMenu", {
    Position = UDim2.fromOffset(4, 276),
    Parent = card.Instance,
})
```
