# Toggle

A `Toggle` is an on/off switch with animated knob.

## Summary

### Properties

| Property   | Type                   | Description                |
| ---------- | ---------------------- | -------------------------- |
| `Text`     | `string?`              | The label text             |
| `Value`    | `boolean?`             | Initial toggle state       |
| `OnChange` | `((boolean) -> ())?`  | Callback on state change   |
| `Parent`   | `Instance?`            | The parent GUI instance    |

### Methods

| Method | Signature | Description |
| ------ | --------- | ----------- |
| `Set`  | `(value: boolean) -> ()` | Set the toggle state |
| `Get`  | `() -> boolean`          | Get the toggle state |

## Example

```luau
local toggle = UnAlive:New("Toggle", {
    Text = "Dark Mode",
    Value = true,
    Parent = card.Instance,
    OnChange = function(state)
        print("Dark Mode:", state)
    end,
})
```
