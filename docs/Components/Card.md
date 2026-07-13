<!-- markdownlint-disable MD056 -->

# Card

A `Card` is a rounded content container with a border and optional drop shadow.

## Summary

### Properties

| Property   | Type              | Description                        |
| ---------- | ----------------- | ---------------------------------- |
| `Size`     | `#!luau UDim2?`  | The size of the card.              |
| `Position` | `#!luau UDim2?`  | The position of the card.          |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type CardProperties = Frame & {
    Size: UDim2?,
    Position: UDim2?,
}

type Card = BaseComponent & Components & CardProperties
```

### Function Signature

```luau
function(self, properties: CardProperties?): Card
```

## Example

```luau
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(496, 280),
    Parent = window.Instance,
})

print(card:IsA("Frame")) --> true
print(card.Type) --> "Card"
```
