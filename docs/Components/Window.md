<!-- markdownlint-disable MD056 -->

# Window

`Window` is a high-level container that handles all base interaction with the user for you. Usually this is the first component called and most components stem from here.

## Summary

### Properties

| Property   | Type              | Description                                           |
| ---------- | ----------------- | ----------------------------------------------------- |
| `Title`    | `#!luau string?`  | Title displayed in the window title bar.              |
| `Size`     | `#!luau Vector2?` | The window size. Defaults to `540, 400`.              |
| `Draggable`| `#!luau boolean?` | Enables window dragging via mouse or touch device.    |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type WindowProperties = Frame & {
    Title: string?,
    Size: Vector2?,
    Draggable: boolean?,
}

type Window = BaseComponent & Components & WindowProperties
```

### Function Signature

```luau
function(self, properties: WindowProperties?): Window
```

## Example

```luau
local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})

print(window:IsA("Frame")) --> true
print(window.Type) --> "Window"
```
