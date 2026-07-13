<!-- markdownlint-disable MD056 -->

# Stepper

A `Stepper` is a control that lets people increment or decrement a numeric value.

## Summary

### Properties

| Property   | Type              | Description                                |
| ---------- | ----------------- | ------------------------------------------ |
| `Value`    | `#!luau number?`  | The stepper's current value.               |
| `Minimum`  | `#!luau number?`  | The minimum value the stepper can go.      |
| `Maximum`  | `#!luau number?`  | The maximum value the stepper can reach.   |
| `Step`     | `#!luau number?`  | The amount the value changes per step.     |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature                                            | Description                                                                        |
| -------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `ValueChanged` | `#!luau ((self: Stepper, value: number) -> unknown)?` | A callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type StepperProperties = Frame & {
    Value: number?,
    Minimum: number?,
    Maximum: number?,
    Step: number?,
    ValueChanged: ((self: Stepper, value: number) -> unknown)?,
}

type Stepper = BaseComponent & Components & StepperProperties
```

### Function Signature

```luau
function(self, properties: StepperProperties?): Stepper
```

## Example

```luau
local stepper = UnAlive:New("Stepper", {
    Value = 5000,
    Minimum = 0,
    Maximum = 99999,
    Parent = card.Instance,
    ValueChanged = function(self, value: number)
        print("Value changed:", value)
    end,
})

print(stepper:IsA("Frame")) --> true
print(stepper.Type) --> "Stepper"
```
