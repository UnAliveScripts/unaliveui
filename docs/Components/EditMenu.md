<!-- markdownlint-disable MD056 -->

# EditMenu

An `EditMenu` is a glass-styled tab bar for organizing edit actions.

## Summary

### Properties

| Property   | Type              | Description                        |
| ---------- | ----------------- | ---------------------------------- |
| `Position` | `#!luau UDim2?`  | The position of the edit menu.     |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type EditMenuProperties = Frame & {
    Position: UDim2?,
}

type EditMenu = BaseComponent & Components & EditMenuProperties
```

### Function Signature

```luau
function(self, properties: EditMenuProperties?): EditMenu
```

## Example

```luau
local editMenu = UnAlive:New("EditMenu", {
    Position = UDim2.fromOffset(4, 276),
    Parent = card.Instance,
})

print(editMenu:IsA("Frame")) --> true
print(editMenu.Type) --> "EditMenu"
```
