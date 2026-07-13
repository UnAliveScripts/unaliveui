# Components

UnAlive provides a growing library of macOS-inspired components.

## Available Components

- [Window](Window.md) — A draggable macOS-style window
- [Card](Card.md) — A content container with shadow
- [SubCard](SubCard.md) — A smaller card container
- [Page](Page.md) — A scrolling page container
- [Row](Row.md) — A labeled info row
- [Label](Label.md) — Text label
- [Icon](Icon.md) — Image label for icons
- [Button](Button.md) — Action button with hover
- [Toggle](Toggle.md) — On/off switch
- [Stepper](Stepper.md) — Increment/decrement control
- [Slider](Slider.md) — Range slider
- [TextField](TextField.md) — Text input field
- [Notification](Notification.md) — Popup notification
- [EditMenu](EditMenu.md) — Tabbed edit menu bar
- [WindowPill](WindowPill.md) — macOS minimize pill

## Common Properties

Every component inherits these base properties:

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Parent` | `Instance` | Parent GUI instance |
| `Visible` | `boolean?` | Visibility state |

## Common Methods

| Method | Description |
| ------ | ----------- |
| `:Parent(parent)` | Set the parent instance |
| `:Destroy()` | Clean up the component |

## Common Return Values

| Field | Type | Description |
| ----- | ---- | ----------- |
| `Type` | `string` | The component type name |
| `Instance` | `Instance` | The root Roblox instance |
