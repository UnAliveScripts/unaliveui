# Icon

An `Icon` displays an image with a specified size and color.

## Summary

### Properties

| Property | Type        | Description                    |
| -------- | ----------- | ------------------------------ |
| `Image`  | `string?`   | The image asset ID             |
| `Color`  | `Color3?`   | The image tint color           |
| `Size`   | `UDim2?`    | The icon size                  |
| `Parent` | `Instance?` | The parent GUI instance        |

### Methods

| Method     | Signature | Description |
| ---------- | --------- | ----------- |
| `SetImage` | `(id: string) -> ()` | Change the icon image |
| `SetColor` | `(color: Color3) -> ()` | Change the icon color |

## Example

```luau
local icon = UnAlive:New("Icon", {
    Image = "rbxassetid://127922205331150",
    Size = UDim2.fromOffset(24, 24),
    Parent = frame,
})
```
