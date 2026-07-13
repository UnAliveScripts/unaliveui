<!-- markdownlint-disable MD056 -->

# WindowPill

A `WindowPill` is a macOS-style minimize pill displayed at the top center of the screen.

## Summary

### Properties

No configurable properties.

[View all inherited from `ImageButton`](https://create.roblox.com/docs/reference/engine/classes/ImageButton#summary-properties)

### Methods

| Method    | Signature | Description |
| --------- | --------- | ----------- |
| `OnClick` | `#!luau ((self: WindowPill) -> ())` | Sets a callback for when the pill is clicked. |

[View all inherited from `ImageButton`](https://create.roblox.com/docs/reference/engine/classes/ImageButton#summary-methods)

### Events

[View all inherited from `ImageButton`](https://create.roblox.com/docs/reference/engine/classes/ImageButton#summary-events)

## Types

```luau
type WindowPillProperties = ImageButton & {}

type WindowPill = BaseComponent & Components & WindowPillProperties
```

### Function Signature

```luau
function(self, properties: WindowPillProperties?): WindowPill
```

## Example

```luau
local pill = UnAlive:New("WindowPill")
pill:OnClick(function()
    print("Pill clicked — toggle minimize")
end)

print(pill:IsA("ImageButton")) --> true
print(pill.Type) --> "WindowPill"
```
