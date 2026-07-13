# Creating a Component

To create a custom component, follow the pattern of existing components.

## Component Structure

```luau
return function(self, properties)
    properties = properties or {}
    
    -- Access the theme
    local theme = self.Theme
    
    -- Create the root instance
    local instance = Instance.new("Frame")
    instance.Size = properties.Size or UDim2.fromOffset(200, 100)
    instance.BackgroundColor3 = theme.Card.Background
    instance.BorderSizePixel = 0
    
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    
    -- Add corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = instance
    
    -- Return the component interface
    return {
        Type = "MyComponent",
        Instance = instance,
        Parent = function(parent)
            instance.Parent = parent
        end,
        Destroy = function()
            instance:Destroy()
        end,
    }
end
```

## Registering a Component

To make your component available through `UnAlive:New()`, add it to the module:

```luau
UnAlive.MyComponent = function(props)
    local ok, result = pcall(myComponentFunction, UnAlive, props or {})
    if ok then return result end
    return nil
end
```
