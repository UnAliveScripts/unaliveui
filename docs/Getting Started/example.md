# Example

Here is a complete example of creating a UnAlive UI window with components:

```luau
local UnAlive = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
))()

-- Create a window
local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})

-- Create a card container
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(496, 280),
    Parent = window.Instance,
})

-- Add a label
local label = UnAlive:New("Label", {
    Text = "Welcome to UnAliveUI",
    Parent = card.Instance,
})

-- Add a toggle
local toggle = UnAlive:New("Toggle", {
    Text = "Dark Mode",
    Value = true,
    Parent = card.Instance,
    OnChange = function(state)
        print("Toggle:", state)
    end,
})

-- Add a slider
local slider = UnAlive:New("Slider", {
    Text = "Volume",
    Min = 0,
    Max = 100,
    Value = 75,
    Suffix = "%",
    Parent = card.Instance,
    OnChange = function(value)
        print("Volume:", value)
    end,
})
```
