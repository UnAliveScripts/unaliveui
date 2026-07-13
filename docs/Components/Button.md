<!-- markdownlint-disable MD056 -->

# Button

A `Button` initiates an instantaneous action.

## Summary

### Properties

| Property | Type                                                  | Description                                                                                  |
| -------- | ----------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `State`  | `#!luau ("Primary" or "Secondary" or "Destructive")?` | Determines the weight of the button. Suggests to the user its impact on surrounding content. |
| `Text`   | `#!luau string?`                                      | The label text displayed on the button row.                                                  |
| `Label`  | `#!luau string?`                                      | The text content of the action button.                                                       |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event    | Signature                            | Description                                                                             |
| -------- | ------------------------------------ | --------------------------------------------------------------------------------------- |
| `Pushed` | `#!luau ((self: Button) -> unknown)?` | A callback function that is triggered when the button has been fully clicked or tapped. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type ButtonProperties = Frame & {
    State: ("Primary" | "Secondary" | "Destructive")?,
    Text: string?,
    Label: string?,
    Pushed: ((self: Button) -> unknown)?,
}

type Button = BaseComponent & Components & ButtonProperties
```

### Function Signature

```luau
function(self, properties: ButtonProperties?): Button
```

## Example

```luau
local button = UnAlive:New("Button", {
    Text = "Action",
    Label = "Run",
    Parent = card.Instance,
    Pushed = function(self)
        print("Pushed")
    end,
})

print(button:IsA("Frame")) --> true
print(button.Type) --> "Button"
```
