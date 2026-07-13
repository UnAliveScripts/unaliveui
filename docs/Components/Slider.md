<!-- markdownlint-disable MD056 -->

# Slider

A `Slider` is a horizontal track with a control, called a thumb, that people can adjust between a minimum and maximum value.

## Summary

### Properties

| Property   | Type              | Description                              |
| ---------- | ----------------- | ---------------------------------------- |
| `Minimum`  | `#!luau number?`  | The minimum value the slider can go.     |
| `Maximum`  | `#!luau number?`  | The maximum value the slider can reach.  |
| `Value`    | `#!luau number?`  | The slider's current value.              |
| `Text`     | `#!luau string?`  | The label text displayed above the slider.|
| `Suffix`   | `#!luau string?`  | Text appended to the value display.      |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature                                           | Description                                                                        |
| -------------- | --------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `ValueChanged` | `#!luau ((self: Slider, value: number) -> unknown)?` | A callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type SliderProperties = Frame & {
    Minimum: number?,
    Maximum: number?,
    Value: number?,
    Text: string?,
    Suffix: string?,
    ValueChanged: ((self: Slider, value: number) -> unknown)?,
}

type Slider = BaseComponent & Components & SliderProperties
```

### Function Signature

```luau
function(self, properties: SliderProperties?): Slider
```

## Example

```luau
local slider = UnAlive:New("Slider", {
    Text = "Volume",
    Minimum = 0,
    Maximum = 100,
    Value = 75,
    Suffix = "%",
    Parent = card.Instance,
    ValueChanged = function(self, value: number)
        print("Value changed:", value)
    end,
})

print(slider:IsA("Frame")) --> true
print(slider.Type) --> "Slider"
```
