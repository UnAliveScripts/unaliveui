<!-- markdownlint-disable MD056 -->

# Notification

A `Notification` is a popup alert that displays a title, subtitle, and accent color.

## Summary

### Properties

| Property   | Type              | Description                                  |
| ---------- | ----------------- | -------------------------------------------- |
| `Title`    | `#!luau string?`  | The title text displayed in the notification.|
| `Subtitle` | `#!luau string?`  | The subtitle text displayed in the notification. |
| `Duration` | `#!luau number?`  | Auto-close duration in seconds. `0` for persistent. |
| `Type`     | `#!luau ("info" or "success" or "warning" or "error")?` | The notification's accent color style. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type NotificationProperties = Frame & {
    Title: string?,
    Subtitle: string?,
    Duration: number?,
    Type: ("info" | "success" | "warning" | "error")?,
}

type Notification = BaseComponent & Components & NotificationProperties
```

### Function Signature

```luau
function(self, properties: NotificationProperties?): Notification
```

## Example

```luau
local notification = UnAlive:New("Notification", {
    Title = "Success!",
    Subtitle = "Operation completed successfully.",
    Type = "success",
    Duration = 4,
    Parent = gui,
})

print(notification:IsA("Frame")) --> true
print(notification.Type) --> "Notification"
```
