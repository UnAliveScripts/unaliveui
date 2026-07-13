# Button

A `Button` initiates an action when clicked.

## Summary

### Properties

| Property | Type                   | Description              |
| -------- | ---------------------- | ------------------------ |
| `Text`   | `string?`              | The label text           |
| `State`  | `string?`              | Button style (Primary/Secondary/Destructive) |
| `OnClick`| `(() -> ())?`         | Click callback           |
| `Parent` | `Instance?`            | The parent GUI instance  |

### Methods

| Method | Signature | Description |
| ------ | --------- | ----------- |
| `SetText` | `(text: string) -> ()` | Update the label |

## Example

```luau
local button = UnAlive:New("Button", {
    Text = "Click me",
    Parent = card.Instance,
    OnClick = function()
        print("Button clicked!")
    end,
})
```
