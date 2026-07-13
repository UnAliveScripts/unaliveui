# The API

UnAlive is a retained-mode UI library. Its API is designed to be simple, consistent, and intuitive.

## Core Concepts

- **UnAlive**: The main module that provides access to all components via `:New()` or direct calls.
- **Components**: Individual UI elements (Window, Button, Toggle, etc.) that return a table with `Type`, `Instance`, and component-specific methods.
- **Themes**: Visual styling definitions that control the appearance of all components.
- **Icons**: Pre-defined icon asset IDs for common symbols.

## Module Structure

- `UnAlive:New(name, properties)` — Create any component by name
- `UnAlive.ComponentName(properties)` — Direct access to a component constructor
- `UnAlive.Theme` — Access the current theme configuration
- `UnAlive.Icons` — Access the icons table
- `UnAlive.Services` — Access Roblox service references
- `UnAlive.VERSION` — Current library version string
