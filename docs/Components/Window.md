# Window

A `Window` is a draggable macOS-style window with title bar and traffic light controls.

## Summary

### Properties

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Title`  | `string?` | The window title text |
| `Size`   | `Vector2?` | The window size |

### Methods

| Method | Signature | Description |
| ------ | --------- | ----------- |
| `SetTitle` | `(title: string) -> ()` | Update the window title |
| `Destroy`  | `() -> ()` | Remove the window |

## Example

```luau
local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})
```
