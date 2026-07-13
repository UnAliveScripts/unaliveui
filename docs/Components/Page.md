<!-- markdownlint-disable MD056 -->

# Page

A `Page` is a scrolling container for organizing content sections.

## Summary

### Properties

| Property | Type              | Description                        |
| -------- | ----------------- | ---------------------------------- |
| `Size`   | `#!luau UDim2?`  | The size of the page.              |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `ScrollingFrame`](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame#summary-properties)

### Methods

[View all inherited from `ScrollingFrame`](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame#summary-methods)

### Events

[View all inherited from `ScrollingFrame`](https://create.roblox.com/docs/reference/engine/classes/ScrollingFrame#summary-events)

## Types

```luau
type PageProperties = ScrollingFrame & {
    Size: UDim2?,
}

type Page = BaseComponent & Components & PageProperties
```

### Function Signature

```luau
function(self, properties: PageProperties?): Page
```

## Example

```luau
local page = UnAlive:New("Page", {
    Size = UDim2.fromScale(1, 1),
    Parent = card.Instance,
})

print(page:IsA("ScrollingFrame")) --> true
print(page.Type) --> "Page"
```
