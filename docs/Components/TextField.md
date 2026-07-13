# TextField

A `TextField` is a text input field with label.

## Summary

### Properties

| Property      | Type                   | Description                |
| ------------- | ---------------------- | -------------------------- |
| `Text`        | `string?`              | The label text             |
| `Placeholder` | `string?`              | Placeholder text           |
| `OnChange`    | `((string) -> ())?`   | Callback on submit         |
| `Parent`      | `Instance?`            | The parent GUI instance    |

### Methods

| Method    | Signature | Description |
| --------- | --------- | ----------- |
| `SetText` | `(text: string) -> ()` | Set the input text |
| `GetText` | `() -> string`         | Get the input text |

## Example

```luau
local textField = UnAlive:New("TextField", {
    Text = "Username",
    Placeholder = "Enter username...",
    Parent = card.Instance,
    OnChange = function(text)
        print("Submitted:", text)
    end,
})
```
