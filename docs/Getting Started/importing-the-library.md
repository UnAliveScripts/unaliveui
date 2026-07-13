# Importing the Library

You can import UnAliveUI directly into your Roblox game using `loadstring` and `game:HttpGet`.

## Basic Import

```luau
local UnAlive = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
))()
```

## Creating an Application

Once imported, create a window to start building your UI:

```luau
local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})
```

## Using Components

Components can be created through the `UnAlive` object:

```luau
local toggle = UnAlive:New("Toggle", {
    Text = "Enable Feature",
    Value = true,
})
```

Or directly:

```luau
local label = UnAlive.Label({
    Text = "Hello, World!",
})
```
