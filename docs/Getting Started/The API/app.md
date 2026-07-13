# App

You can create a new app by calling the `New` method from the UnAlive API on the `Window` component. This returns a custom object merged with a `Frame`.

The returned object exposes methods for UI composition.

## Summary

### Properties

| Property | Type              | Description                                           |
| -------- | ----------------- | ----------------------------------------------------- |
| `Title`  | `#!luau string?`  | The title displayed in the window title bar.          |
| `Size`   | `#!luau Vector2?` | The window size. Defaults to `540, 400`.              |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method      | Signature | Description |
| ----------- | --------- | ----------- |
| `SetTitle`  | `#!luau (self: Window, title: string) -> ()` | Updates the window title. |
| `Destroy`   | `#!luau (self: Window) -> ()` | Destroys the window and its GUI. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type WindowProperties = Frame & {
    Title: string?,
    Size: Vector2?,
}

type Window = Frame & {
    Type: "Window",
    Instance: Frame,
    Gui: ScreenGui,
    TitleBar: Frame,
    UIScale: UIScale,
    SetTitle: (self: Window, title: string) -> (),
    Destroy: (self: Window) -> (),
}
```

### Function Signature

```luau
function(properties: WindowProperties?): Window
```

## Example

```luau
local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})
```
