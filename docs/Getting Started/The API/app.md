# App

The `App` concept allows you to create and manage multiple windows and components together.

## Creating an App

```luau
local app = UnAlive:New("Window", {
    Title = "My Application",
    Size = Vector2.new(540, 400),
})
```

## Properties

| Property | Type     | Description              |
| -------- | -------- | ------------------------ |
| `Title`  | `string` | The window title text.   |
| `Size`   | `Vector2`| The window size in pixels. |

## Methods

| Method      | Description                    |
| ----------- | ------------------------------ |
| `:SetTitle` | Update the window title.       |
| `:Destroy`  | Remove the window and GUI.     |
