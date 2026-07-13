<!-- markdownlint-disable MD056 -->

# Toggle

A `Toggle` lets people choose between a pair of opposing states, like on and off, using a different appearance to indicate each state.

## Summary

### Properties

| Property   | Type               | Description                                        |
| ---------- | ------------------ | -------------------------------------------------- |
| `Value`    | `#!luau boolean?`  | The toggle's state. `false` for off, `true` for on |
| `Text`     | `#!luau string?`   | The label text displayed next to the toggle.       |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature                                            | Description                                                                        |
| -------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `ValueChanged` | `#!luau ((self: Toggle, value: boolean) -> unknown)?` | A callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type ToggleProperties = Frame & {
    Value: boolean?,
    Text: string?,
    ValueChanged: ((self: Toggle, value: boolean) -> unknown)?,
}

type Toggle = BaseComponent & Components & ToggleProperties
```

### Function Signature

```luau
function(self, properties: ToggleProperties?): Toggle
```

## Example

```luau
local toggle = UnAlive:New("Toggle", {
    Text = "Dark Mode",
    Value = true,
    Parent = card.Instance,
    ValueChanged = function(self, value: boolean)
        print("Value changed:", value)
    end,
})

print(toggle:IsA("Frame")) --> true
print(toggle.Type) --> "Toggle"
```
