# Stepper

A `Stepper` is an increment/decrement control with +/- buttons.

## Summary

### Properties

| Property   | Type                   | Description                |
| ---------- | ---------------------- | -------------------------- |
| `Value`    | `number?`              | Initial value              |
| `Min`      | `number?`              | Minimum value              |
| `Max`      | `number?`              | Maximum value              |
| `Step`     | `number?`              | Step amount                |
| `OnChange` | `((number) -> ())?`   | Callback on value change   |
| `Parent`   | `Instance?`            | The parent GUI instance    |

### Methods

| Method | Signature | Description |
| ------ | --------- | ----------- |
| `Set`  | `(value: number) -> ()` | Set the value |
| `Get`  | `() -> number`          | Get the value |

## Example

```luau
local stepper = UnAlive:New("Stepper", {
    Value = 5000,
    Min = 0,
    Max = 99999,
    Parent = card.Instance,
    OnChange = function(value)
        print("Value:", value)
    end,
})
```
