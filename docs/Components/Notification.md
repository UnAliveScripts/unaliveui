# Notification

A `Notification` is a popup alert with title, subtitle, and accent color.

## Summary

### Properties

| Property   | Type        | Description                    |
| ---------- | ----------- | ------------------------------ |
| `Title`    | `string?`   | The notification title         |
| `Subtitle` | `string?`   | The notification subtitle      |
| `Duration` | `number?`   | Auto-close duration in seconds |
| `Type`     | `string?`   | info, success, warning, error  |
| `Parent`   | `Instance?` | The parent GUI instance        |

### Methods

| Method  | Signature | Description |
| ------- | --------- | ----------- |
| `Close` | `() -> ()` | Close the notification |

## Example

```luau
local notification = UnAlive:New("Notification", {
    Title = "Success!",
    Subtitle = "Operation completed.",
    Type = "success",
    Duration = 4,
    Parent = gui,
})
```
