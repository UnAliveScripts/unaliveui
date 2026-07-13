# The API

UnAlive provides a simple and consistent API for building macOS-style user interfaces.

## Core Concepts

- **UnAlive**: The main module that provides access to all components.
- **Components**: Individual UI elements (Window, Button, Toggle, etc.)
- **Themes**: Visual styling definitions for the entire UI.
- **Icons**: A collection of pre-defined icon asset IDs.

## Module Structure

- `UnAlive:New(name, properties)` — Create any component
- `UnAlive.ComponentName(properties)` — Direct access to a component
- `UnAlive.Theme` — Access the current theme
- `UnAlive.Icons` — Access the icons table
- `UnAlive.Services` — Access Roblox services
