# Row

A `Row` displays a label with an optional value in a styled row.

## Summary

### Properties

| Property     | Type        | Description                    |
| ------------ | ----------- | ------------------------------ |
| `Text`       | `string?`   | The label text                 |
| `Value`      | `string?`   | The value text                 |
| `ValueColor` | `Color3?`   | The value text color           |
| `Parent`     | `Instance?` | The parent GUI instance        |

## Example

```luau
local row = UnAlive:New("Row", {
    Text = "Status",
    Value = "Online",
    ValueColor = Color3.fromRGB(52, 199, 89),
    Parent = card.Instance,
})
```
