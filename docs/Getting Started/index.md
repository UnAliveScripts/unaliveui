# Getting Started

Welcome to UnAliveUI! This guide will walk you through importing the library and creating your first interface.

## Quick Start

```luau
local UnAlive = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/UnAliveScripts/unaliveui/main/src/init.luau"
))()

local window = UnAlive:New("Window", {
    Title = "My App",
    Size = Vector2.new(540, 400),
})
```

## Next Steps

- [Interface Guidelines](interface-guidelines.md) — Design principles and conventions
- [Importing the Library](importing-the-library.md) — Detailed import instructions
- [Building From Source](building-from-source.md) — Build from the repository
- [Example](example.md) — A complete example
- [The API](The%20API/index.md) — Full API reference
