<!-- markdownlint-disable MD056 -->

# Icon

An `Icon` displays an image at a specified size with an optional color tint.

## Summary

### Properties

| Property | Type              | Description                        |
| -------- | ----------------- | ---------------------------------- |
| `Image`  | `#!luau string?`  | The image asset ID to display.     |
| `Color`  | `#!luau Color3?`  | The tint color applied to the image. |
| `Size`   | `#!luau UDim2?`   | The size of the icon.              |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-properties)

### Methods

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-methods)

### Events

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-events)

## Types

```luau
type IconProperties = ImageLabel & {
    Image: string?,
    Color: Color3?,
    Size: UDim2?,
}

type Icon = BaseComponent & Components & IconProperties
```

### Function Signature

```luau
function(self, properties: IconProperties?): Icon
```

## Example

```luau
local icon = UnAlive:New("Icon", {
    Image = "rbxassetid://127922205331150",
    Size = UDim2.fromOffset(24, 24),
    Parent = card.Instance,
})

print(icon:IsA("ImageLabel")) --> true
print(icon.Type) --> "Icon"
```
