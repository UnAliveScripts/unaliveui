# Example

View an example application that can be made with UnAlive.

!!! note
    You can view a larger test application here which has full keybind minimization and mobile resize already added: [tests/standalone_demo.client.luau](https://github.com/UnAliveScripts/unaliveui/blob/main/tests/standalone_demo.client.luau)

## Creating a basic app

### Code

```luau
-- Create our main application window.
local window = UnAlive:New("Window", {
    Title = "My Window",
    Size = Vector2.new(540, 400),
})

do -- Make a card container
    local card = UnAlive:New("Card", {
        Size = UDim2.fromOffset(496, 280),
        Parent = window.Instance,
    })

    do -- Add a label
        local label = UnAlive:New("Label", {
            Text = "Welcome to UnAlive",
            TextSize = 24,
            Parent = card.Instance,
        })
    end

    do -- Add a toggle
        local toggle = UnAlive:New("Toggle", {
            Text = "Dark Mode",
            Value = true,
            Parent = card.Instance,
            ValueChanged = function(self, value)
                print("Toggle changed:", value)
            end,
        })
    end

    do -- Add a button
        local button = UnAlive:New("Button", {
            Text = "Action",
            Label = "Click me",
            Parent = card.Instance,
            Pushed = function(self)
                print("Button pushed!")
            end,
        })
    end
end
```

### Result

The code above creates a window with a card containing a label, toggle, and button.
