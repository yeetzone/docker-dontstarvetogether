# Don't Starve Together
> Dockerfile for building a [Don't Starve Together][website] dedicated server image.

---

This repository provides a `Dockerfile` for building a dedicated server
for the online multi-player survival game [*Don't Starve Together*][website].

The image is hosted on `Docker Hub` named [`yeetzone/dontstarvetogether`][hub].

## Features
- Configuration via **environment** variables.
- **World** generation via default **presets**.
- **World** generation via **custom** level data.
- **Mods** with custom **configuration**.
- Connected worlds via **sharding**.
- Control the server directly on the **CLI**.
- World **persistence** via volumes.

## Documentation
- [Configuration][docs-configuration]
- [Commands][docs-commands]
- [Recipes][docs-recipes]

---

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

[docs-configuration]: /docs/configuration.md
[docs-commands]: /docs/commands.md
[docs-recipes]: /docs/recipes.md
[hub]: https://hub.docker.com/r/yeetzone/dontstarvetogether
[website]: https://www.dontstarvetogether.com/
