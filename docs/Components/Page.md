# Page

A `Page` is a scrolling page container for organizing content.

## Summary

### Properties

| Property   | Type       | Description                    |
| ---------- | ---------- | ------------------------------ |
| `Size`     | `UDim2?`   | The page size                  |
| `Parent`   | `Instance?`| The parent GUI instance        |

## Example

```luau
local page = UnAlive:New("Page", {
    Size = UDim2.fromScale(1, 1),
    Parent = card.Instance,
})
```
