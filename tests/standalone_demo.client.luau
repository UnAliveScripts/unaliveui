-- UnAliveUI Standalone Demo
-- Run this to test all components

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local UnAlive = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
))()

local window = UnAlive:New("Window", {
    Title = "UnAlive Demo",
    Size = Vector2.new(540, 400),
})

local card = UnAlive:New("Card", {
    Size = UDim2.fromOffset(496, 280),
    Parent = window.Instance,
})

local label = UnAlive:New("Label", {
    Text = "Welcome to UnAliveUI",
    TextSize = 24,
    Parent = card.Instance,
})

local toggle = UnAlive:New("Toggle", {
    Text = "Dark Mode",
    Value = true,
    Parent = card.Instance,
    OnChange = function(state)
        print("Dark Mode:", state)
    end,
})

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

print("UnAlive Demo Loaded")
