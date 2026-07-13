# WindowPill

A `WindowPill` is a macOS-style minimize restore pill shown at the top of the screen.

## Summary

### Properties

No configurable properties.

### Methods

| Method    | Signature | Description |
| --------- | --------- | ----------- |
| `OnClick` | `(callback: () -> ()) -> ()` | Set click handler for minimize/restore |
| `Destroy` | `() -> ()` | Remove the pill |

## Example

```luau
local pill = UnAlive:New("WindowPill")
pill:OnClick(function()
    print("Pill clicked — toggle minimize")
end)
```
