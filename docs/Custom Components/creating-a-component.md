# Creating a Component

To create a custom component, follow the pattern of existing components.

## Component Structure

```luau
return function(self, properties)
    properties = properties or {}
    
    local instance = Instance.new("Frame")
    -- Build your component here
    
    return {
        Type = "MyComponent",
        Instance = instance,
        Parent = function(parent)
            instance.Parent = parent
        end,
    }
end
```
