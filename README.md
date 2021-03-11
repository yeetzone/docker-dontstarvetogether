# Don't Starve Together
> Dockerfile for building a `[Don't Starve Together][website]` dedicated server image.

---

This repository provides a `Dockerfile` for building a dedicated server
for the online multi-player survival game [*Don't Starve Together*][website].

`Docker Hub` hosts our image [`yeetzone/dontstarvetogether`][hub].

## Features
- Configuration via **environment** variables.
- **World** generation via default **presets**.
- **World** generation via **custom** level data.
- **Mods** with custom **configuration**.
- Connected worlds via **sharding**.
- Control the server directly on the **CLI**.
- World **persistence** via volumes.

## Documentation
- [Configuration][docs-configuration] · *Overview of options for customizing the server.*
- [Commands][docs-commands] · *List of available CLI commands to manage the server.*
- [Recipes][docs-recipes] · *Collection of pre-defined server setups.*

## Support
- [Discord][support-discord] · *Join our Discord server if you have questions.*
- [Discussions][support-github] · *Use GitHub discussions to suggest changes or ask questions.*

---

[![forthebadge](https://forthebadge.com/images/badges/open-source.svg)](https://forthebadge.com/)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com/)

[docs-configuration]: /docs/configuration.md
[docs-commands]: /docs/commands.md
[docs-recipes]: /docs/recipes.md
[support-discord]: https://go.yeet.zone/discord
[support-github]: https://github.com/yeetzone/docker-dontstarvetogether/discussions
[hub]: https://hub.docker.com/r/yeetzone/dontstarvetogether
[website]: https://www.dontstarvetogether.com/
