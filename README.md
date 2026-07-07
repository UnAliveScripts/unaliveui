# UnaliveUI

A Roblox UI library with Figma-inspired components and dark theme.

## Usage

```lua
local UI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/init.lua"
))()

-- Create a window
local window = UI.Components.Window(UI, {
	Title = "My App",
	Size = UDim2.fromOffset(400, 300),
})
window.Parent(gui)

-- Add components inside window
local page = UI.Components.Page(UI)
page.Parent(window.__container)

local row = UI.Components.Row(UI)
row.Parent(page.__instance)

local label = UI.Components.Label(UI, { Text = "Hello World" })
label.Parent(row:Left().__container)
```

## Components

| Component | Description |
|-----------|-------------|
| Window | Draggable window with title bar, close/minimize/zoom |
| Button | Gradient button with press effects |
| Toggle | iOS-style toggle switch |
| Slider | Draggable slider with thumb |
| Label | Text label with theme colors |
| TextField | Input field with focus glow |
| Stepper | Increment/decrement with up/down arrows |
| StepperPill | 92×32 pill-style stepper with minus/plus |
| Pulldown | Dropdown menu with scrolling item list |
| TrailingAccessories | Label + info icon |
| Notification | Slide-in alert notification |
| Icon | Image icon from icon library |
| Page | Scrollable page with padding |
| Row | Horizontal layout row |
| EditMenu | Edit menu bar with items |

## Icons

```lua
UI.Icons.minus       -- "rbxassetid://110147285593118"
UI.Icons.plus        -- "rbxassetid://126761302820331"
UI.Icons.circle      -- "rbxassetid://108281361336741"
UI.Icons.search      -- "rbxassetid://117204739779559"
UI.Icons["chevron-right"] -- "rbxassetid://103603118195781"
UI.Icons["chevron-down"]  -- "rbxassetid://84215348315149"
UI.Icons["chevron-up"]    -- "rbxassetid://137296891812002"
UI.Icons["chevron-left"]  -- "rbxassetid://103603118195781"
```

## Usage

### Key System Loader (with key gate)

Shows a key verification window. On success, loads the main UI.

```lua
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/loader.lua"
))()
```

### Main UI (no key gate)

Loads the main application window directly:

```lua
loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/demo.lua"
))()
```

## License

MIT