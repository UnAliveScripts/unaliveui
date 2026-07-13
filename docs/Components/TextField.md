<!-- markdownlint-disable MD056 -->

# TextField

A `TextField` is an input field that lets people enter or edit text.

## Summary

### Properties

| Property      | Type              | Description                             |
| ------------- | ----------------- | --------------------------------------- |
| `Text`        | `#!luau string?`  | The label text displayed next to the field. |
| `Placeholder` | `#!luau string?`  | Placeholder text shown when the field is empty. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature                                            | Description                                                                        |
| -------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `ValueChanged` | `#!luau ((self: TextField, text: string) -> unknown)?` | A callback function triggered when text is submitted via enter. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type TextFieldProperties = Frame & {
    Text: string?,
    Placeholder: string?,
    ValueChanged: ((self: TextField, text: string) -> unknown)?,
}

type TextField = BaseComponent & Components & TextFieldProperties
```

### Function Signature

```luau
function(self, properties: TextFieldProperties?): TextField
```

## Example

```luau
local textField = UnAlive:New("TextField", {
    Text = "Username",
    Placeholder = "Enter username...",
    Parent = card.Instance,
    ValueChanged = function(self, text: string)
        print("Submitted:", text)
    end,
})

print(textField:IsA("Frame")) --> true
print(textField.Type) --> "TextField"
```
