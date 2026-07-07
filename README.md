# UnAliveUI

Roblox UI library with dark Alert theme, blur effects, and Figma-inspired components.

## Usage

```lua
local UI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
))()
```

### Key System (gated entry)

```lua
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/loader.lua"
))()
```

### Components API

```lua
-- Method 1: UI:New("ComponentName", props)
local menu = UI:New("EditMenu", { Items = { { Label = "Farm" }, { Label = "Shop" } } })
menu:Parent(gui)

-- Method 2: UI.ComponentName(props)
local stepper = UI.Stepper({ Value = 5000, Step = 500 })
stepper:Parent(gui)
```

### All Components

| Component | Description |
|-----------|-------------|
| Window | Main window with title bar, shadow, blur |
| WindowPill | Draggable top handle bar |
| EditMenu | Horizontal menu with single-selection |
| Stepper | 100×24 numeric stepper |
| StepperPill | 92×32 pill-style stepper |
| Pulldown | Dropdown with scrolling items |
| TrailingAccessories | Label + info icon |
| Notification | Slide-in alert notification |
| Alert | Dialog with title, description, buttons |
| Button | Gradient button with press effects |
| Toggle | iOS-style toggle switch |
| Slider | Draggable slider |
| Label | Text label |
| TextField | Input field |
| Icon | Image icon from library |
| Page | Scrollable page |
| Row | Horizontal layout row |

### Dark Alert Theme

All components use `Color3.fromRGB(18, 20, 26)` at 8% transparency with white text/icons and blur effects where applicable.

## Repository

https://github.com/UnAliveScripts/unaliveui