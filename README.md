# UnAliveUI

Roblox UI library with dark Alert theme (`#12141a`), blur effects, and Figma-inspired components.

## Quick Start

```lua
local UI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
))()
```

### Key System (gated)

```lua
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/loader.lua"
))()
```

### Main UI (no gate)

```lua
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"
))()
```

## Component API

Two ways to create components:

```lua
-- Method 1: UI:New("ComponentName", props)
local menu = UI:New("EditMenu", { Items = { { Label = "Farm" } } })
menu:Parent(gui)

-- Method 2: UI.ComponentName(props)
local stepper = UI.Stepper({ Value = 5000, Step = 500 })
stepper:Parent(gui)
```

---

## Components

### Window
```lua
UI.Window({ Title = "UnAlive" })
```
Main window with title bar, traffic light dots (close/minimize), drag, and shadow.

### Card
```lua
UI.Card({ Width = 496, Height = 330 })
```
Content card with dark bg, 16px rounded corners, border, and drop shadow.

### SubCard
```lua
UI.SubCard({ Width = 200, Height = 140 })
```
Small grouped card container with 12px rounded corners and border.

### EditMenu
```lua
UI.EditMenu({ Items = {
	{ Label = "Farm", Width = 50, TextWidth = 34 },
	{ Label = "Shop", Width = 68, TextWidth = 35, SeparatorOffset = 17 },
}})
```
Horizontal menu with animated single-selection, red text for selected item, and chevron indicator.

### Stepper
```lua
UI.Stepper({ Value = 5000, Step = 500, Minimum = 0, Maximum = 99999 })
```
100×24 numeric stepper with up/down arrows. `SetValue(v)` / `GetValue()`.

### StepperPill
```lua
UI.StepperPill({ Value = 0, Step = 1 })
```
92×32 pill-style stepper with −/+ icons. `SetValue(v)` / `GetValue()`.

### Pulldown
```lua
UI.Pulldown({ Label = "Pets", Items = { "Ice Serpent", "Black Dragon" }, OnSelected = function(name) end })
```
Dropdown with scrolling item list, single selection (white highlight + black text). `:AddItem(name, sel)`.

### Toggle
```lua
UI.Toggle({ Value = true })
```
iOS-style toggle, 62×26 pill, green/gray, + icon (rotated) for ON, circle for OFF.

### Slider
```lua
UI.Slider({ Value = 3, ValueChanged = function(v) end })
```
iOS 26-style slider with 5 tick values, turtle/rabbit icons, smooth drag with bouncy snap. `GetValue()` / `SetValue(v)`.

### TextField
```lua
UI.TextField({ Placeholder = "Value", Width = 120 })
```
Mini text field with dark Alert bg, animated border focus, blue cursor, and configurable width. `SetValue()` / `GetValue()` / `SetPlaceholder()`.

### SearchField
```lua
UI.SearchField({ Placeholder = "Search" })
```
122×26 search bar with pill shape, magnifier icon, clear button, focus glow.

### Notification
```lua
UI.Notification({ Title = "UnAlive", Description = "Welcome", Duration = 12 })
```
macOS-style bottom-right notification with shadow, blur, icon, and swipe-to-dismiss. `SetTitle()` / `SetDescription()` / `SetIcon()` / `Dismiss()`.

### Alert
```lua
local a = UI.Alert()
a:Parent(gui)
a:Show("Title", "Description", "Btn1", "Btn2", cb1, cb2)
```
Centered dialog with expand/contract animation, blur, and configurable buttons. `Dismiss()`.

### LiquidGlassButton
```lua
UI.LiquidGlassButton({ Text = "Label", Callback = function() end })
```
60×28 pill button with liquid glass effect, center click animation (UIScale 0.92). `SetText()` / `SetCallback()`.

### TrailingAccessories
```lua
UI.TrailingAccessories({ Label = "Label" })
```
60×16 label + info icon accessory.

### WindowPill
```lua
UI.WindowPill()
```
180×5 draggable top handle bar with hover glow.

### Button
```lua
UI.Button({ Label = "Click", Pushed = function() end })
```
Gradient button with press effects.

### Label
```lua
UI.Label({ Text = "Hello" })
```
Text label with theme colors. `SetText()`.

### Icon
```lua
UI.Icon({ Icon = "minus" })
```
Image icon from icon library. `SetIcon()`.

---

## Dark Alert Theme

All components use `Color3.fromRGB(18, 20, 26)` at 8% transparency with white text/icons and blur effects where applicable.

## Repository

https://github.com/UnAliveScripts/unaliveui