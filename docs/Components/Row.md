<!-- markdownlint-disable MD056 -->

# Row

A `Row` displays a label with an optional value in a styled information row.

## Summary

### Properties

| Property     | Type              | Description                        |
| ------------ | ----------------- | ---------------------------------- |
| `Text`       | `#!luau string?`  | The label text.                    |
| `Value`      | `#!luau string?`  | The value text displayed on the right. |
| `ValueColor` | `#!luau Color3?`  | The color of the value text.       |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type RowProperties = Frame & {
    Text: string?,
    Value: string?,
    ValueColor: Color3?,
}

type Row = BaseComponent & Components & RowProperties
```

### Function Signature

```luau
function(self, properties: RowProperties?): Row
```

## Example

```luau
local row = UnAlive:New("Row", {
    Text = "Status",
    Value = "Online",
    ValueColor = Color3.fromRGB(52, 199, 89),
    Parent = card.Instance,
})

print(row:IsA("Frame")) --> true
print(row.Type) --> "Row"
```
