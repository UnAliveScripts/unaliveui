[stars]: https://github.com/UnAliveScripts/unaliveui/stargazers
[lastrel]: https://github.com/UnAliveScripts/unaliveui/releases/latest
[lastcom]: https://github.com/UnAliveScripts/unaliveui/commits
[publish]: https://github.com/UnAliveScripts/unaliveui/actions/workflows/publish.yml

[badges/stars]: https://img.shields.io/github/stars/UnAliveScripts/unaliveui?label=Stars&logo=GitHub&style=for-the-badge
[badges/lastrel]: https://img.shields.io/github/v/release/UnAliveScripts/unaliveui?include_prereleases&label=Latest%20Release
[badges/lastcom]: https://img.shields.io/github/last-commit/UnAliveScripts/unaliveui?label=Last%20Modified
[badges/publish]: https://img.shields.io/github/actions/workflow/status/UnAliveScripts/unaliveui/.github%2Fworkflows%2Fpublish.yml?label=Publish%20Docs

<div align="center">

  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/unalive_span_dark.png">
    <source media="(prefers-color-scheme: light)" srcset="assets/unalive_span_light.png">
    <img alt="UnAlive span" src="assets/unalive_span_light.png" width="300">
  </picture>

  <br/>

[![Stars][badges/stars]][stars]
[![Latest Release][badges/lastrel]][lastrel]
[![Last Modified][badges/lastcom]][lastcom]
[![Publish docs][badges/publish]][publish]

UnAliveUI is a Luau UI library based on macOS Sequoia design principles.

</div>

## Overview

UnAliveUI is a retained-mode, user-centric UI library designed to be both easy for developers and beautiful for users. Its API is consistent across all components, so once you learn one, you can use them all without constantly referencing documentation.

## Usage

Reference the [UnAliveUI documentation](https://unalivescripts.github.io/unaliveui/) for more.

- [Importing the Library](https://unalivescripts.github.io/unaliveui/Getting%20Started/importing-the-library/)
- [The API](https://unalivescripts.github.io/unaliveui/Getting%20Started/the-api/)
- [Components](https://unalivescripts.github.io/unaliveui/Components/)

## Building from Source

```bash
git clone https://github.com/UnAliveScripts/unaliveui.git
cd unaliveui
aftman install
rojo build default.project.json -o unaliveui.rbxm
```
