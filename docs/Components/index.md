# Components

UnAlive provides a growing library of macOS-inspired components to build your interfaces.

All components share a consistent API — once you learn one, you can use them all.

## List of Components

- [Window](Window.md) — A high-level container with drag support and title bar
- [Card](Card.md) — A rounded content container with shadow
- [SubCard](SubCard.md) — A smaller card container
- [Page](Page.md) — A scrolling page for content
- [Row](Row.md) — A labeled information row
- [Label](Label.md) — A static text label
- [Icon](Icon.md) — An image-based icon
- [Button](Button.md) — An action button with states
- [Toggle](Toggle.md) — An on/off switch
- [Stepper](Stepper.md) — A numeric increment/decrement control
- [Slider](Slider.md) — A draggable range slider
- [TextField](TextField.md) — A text input field
- [Notification](Notification.md) — A popup alert notification
- [EditMenu](EditMenu.md) — A glass-styled tab bar
- [WindowPill](WindowPill.md) — A minimize/restore pill

## BaseComponent

Every component inherits from `BaseComponent`, which provides core functionality.

### Properties

| Property | Type | Description |
| -------- | ---- | ----------- |
| `Parent` | `#!luau Instance?` | The parent GUI instance the component is placed in. |

### Methods

| Method     | Signature | Description |
| ---------- | --------- | ----------- |
| `Destroy`  | `#!luau (self: BaseComponent) -> ()` | Destroys the component and its instances. |

### Shared Return Values

Every component returns a table with these common fields:

| Field    | Type       | Description                         |
| -------- | ---------- | ----------------------------------- |
| `Type`   | `string`   | The component type name.            |
| `Instance`| `Instance` | The root Roblox instance.           |
