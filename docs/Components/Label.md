<!-- markdownlint-disable MD056 -->

# Label

A `Label` displays static text content.

## Summary

### Properties

| Property     | Type              | Description                       |
| ------------ | ----------------- | --------------------------------- |
| `Text`       | `#!luau string?`  | The text content of the label.    |
| `TextSize`   | `#!luau number?`  | The font size of the text.        |
| `Color`      | `#!luau Color3?`  | The text color.                   |
| `Font`       | `#!luau Font?`    | The font used for the text.       |
| `TextTransparency` | `#!luau number?` | The transparency of the text. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-properties)

### Methods

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-methods)

### Events

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-events)

## Types

```luau
type LabelProperties = TextLabel & {
    Text: string?,
    TextSize: number?,
    Color: Color3?,
    Font: Font?,
}

type Label = BaseComponent & Components & LabelProperties
```

### Function Signature

```luau
function(self, properties: LabelProperties?): Label
```

## Example

```luau
local label = UnAlive:New("Label", {
    Text = "Hello, World!",
    TextSize = 24,
    Parent = card.Instance,
})

print(label:IsA("TextLabel")) --> true
print(label.Type) --> "Label"
```
