<<<<<<< HEAD
--[[
    UnAliveUI — Gag2 Layout
    Example layout using the UnAliveUI library.

    Usage:
        local UnAlive = loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
        ))()

        local window = UnAlive:New("Window", {
            Title = "My App",
            Size = Vector2.new(540, 400),
        })
--]]

local UnAlive = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
))()

-- Create main window
local window = UnAlive:New("Window", {
    Title = "Gag2",
    Size = Vector2.new(540, 400),
})

-- Create card container
local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(496, 280),
    Parent = window.Instance,
})

-- Title
local title = UnAlive:New("Label", {
    Text = "Gag2 Layout",
    TextSize = 24,
    Parent = card.Instance,
})

-- Subtitle
local subtitle = UnAlive:New("Label", {
    Text = "UnAliveUI powered interface",
    TextSize = 14,
    TextColor3 = Color3.fromRGB(180, 180, 190),
    Parent = card.Instance,
})

-- Toggle
local toggle = UnAlive:New("Toggle", {
    Text = "Enable Feature",
    Value = false,
    Parent = card.Instance,
    ValueChanged = function(self, value)
        print("Toggle:", value)
    end,
})

-- Slider
local slider = UnAlive:New("Slider", {
    Text = "Volume",
    Minimum = 0,
    Maximum = 100,
    Value = 75,
    Suffix = "%",
    Parent = card.Instance,
    ValueChanged = function(self, value)
        print("Slider:", value)
    end,
})

-- Button
local button = UnAlive:New("Button", {
    Text = "Action",
    Label = "Run",
    Parent = card.Instance,
    Pushed = function()
        print("Button pushed!")
    end,
})

-- Notification
local notification = UnAlive:New("Notification", {
    Title = "Layout Ready",
    Subtitle = "Gag2 layout loaded successfully.",
    Type = "success",
    Duration = 4,
    Parent = window.Instance,
})

-- WindowPill (minimize/restore pill)
local pill = UnAlive:New("WindowPill")

print("[Gag2] Layout loaded")
=======
gag2
>>>>>>> b5aa80591d3d0bbb842490035b539eb19f0de85e
