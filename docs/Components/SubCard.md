<!-- markdownlint-disable MD056 -->

# SubCard

A `SubCard` is a smaller card container with rounded corners and a border.

## Summary

### Properties

| Property   | Type              | Description                        |
| ---------- | ----------------- | ---------------------------------- |
| `Size`     | `#!luau UDim2?`  | The size of the sub card.          |
| `Position` | `#!luau UDim2?`  | The position of the sub card.      |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type SubCardProperties = Frame & {
    Size: UDim2?,
    Position: UDim2?,
}

type SubCard = BaseComponent & Components & SubCardProperties
```

### Function Signature

```luau
function(self, properties: SubCardProperties?): SubCard
```

## Example

```luau
local subCard = UnAlive:New("SubCard", {
    Size = UDim2.fromOffset(200, 140),
    Parent = window.Instance,
})

print(subCard:IsA("Frame")) --> true
print(subCard.Type) --> "SubCard"
```
