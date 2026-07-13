# Slider

A `Slider` is a range control with track, fill, and value display.

## Summary

### Properties

| Property   | Type                   | Description                |
| ---------- | ---------------------- | -------------------------- |
| `Text`     | `string?`              | The label text             |
| `Min`      | `number?`              | Minimum value              |
| `Max`      | `number?`              | Maximum value              |
| `Value`    | `number?`              | Initial value              |
| `Suffix`   | `string?`              | Value suffix text          |
| `OnChange` | `((number) -> ())?`   | Callback on value change   |
| `Parent`   | `Instance?`            | The parent GUI instance    |

### Methods

| Method | Signature | Description |
| ------ | --------- | ----------- |
| `Set`  | `(value: number) -> ()` | Set the slider value |
| `Get`  | `() -> number`          | Get the slider value |

## Example

```luau
local slider = UnAlive:New("Slider", {
    Text = "Volume",
    Min = 0,
    Max = 100,
    Value = 75,
    Suffix = "%",
    Parent = card.Instance,
    OnChange = function(value)
        print("Volume:", value)
    end,
})
```
