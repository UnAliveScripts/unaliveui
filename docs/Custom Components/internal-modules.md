# Internal Modules

UnAlive exposes several internal modules that custom components can use.

## Accessing Modules

Modules are available through the UnAlive instance passed to your component function:

```luau
return function(self, properties)
    local theme = self.Theme      -- Current theme config
    local icons = self.Icons       -- Icon asset IDs
    local services = self.Services -- Roblox services
    local utility = self.Utility   -- Helper functions
    local creator = self.Creator   -- Instance creation utilities
    local animation = self.Animation -- Pre-built animations
    
    -- Build your component...
end
```

## Module Reference

| Module      | Description                                      |
| ----------- | ------------------------------------------------ |
| `Theme`     | Current theme configuration table                |
| `Icons`     | Pre-defined icon asset ID mappings               |
| `Services`  | Roblox service references (TweenService, etc.)   |
| `Utility`   | Helper functions for tweens, corners, strokes    |
| `Creator`   | Instance creation with property tables           |
| `Animation` | Pre-built animation functions                    |
| `Blur`      | Background blur effect system                    |
