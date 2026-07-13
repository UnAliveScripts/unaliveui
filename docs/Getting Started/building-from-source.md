# Building From Source

## Prerequisites

- [Rojo](https://rojo.space/) for Roblox project syncing
- [aftman](https://github.com/LPGhatguy/aftman) for toolchain management

## Build Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/UnAliveScripts/unaliveui.git
   ```

2. Install toolchain:
   ```bash
   aftman install
   ```

3. Build the project:
   ```bash
   rojo build default.project.json -o unaliveui.rbxm
   ```

## Development

For development, use Rojo's serve mode:

```bash
rojo serve
```

Then connect via the Roblox Studio plugin to sync changes in real time.

The source is located in the `src/` directory. After making changes, rebuild the model file.
