# SubCard

A `SubCard` is a smaller card container with rounded corners and border.

## Summary

### Properties

| Property   | Type       | Description                    |
| ---------- | ---------- | ------------------------------ |
| `Size`     | `UDim2?`   | The card size                  |
| `Position` | `UDim2?`   | The card position              |
| `Parent`   | `Instance?`| The parent GUI instance        |

## Example

```luau
local subCard = UnAlive:New("SubCard", {
    Size = UDim2.fromOffset(200, 140),
    Parent = window.Instance,
})
```
