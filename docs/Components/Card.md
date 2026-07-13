# Card

A `Card` is a content container with rounded corners, border, and optional shadow.

## Summary

### Properties

| Property   | Type       | Description                    |
| ---------- | ---------- | ------------------------------ |
| `Size`     | `UDim2?`   | The card size                  |
| `Position` | `UDim2?`   | The card position              |
| `Parent`   | `Instance?`| The parent GUI instance        |

## Example

```luau
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(496, 280),
    Parent = window.Instance,
})
```
