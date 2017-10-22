# Don't Starve Together
> Dockerfile for building a [Don't Starve Together][website] dedicated-server image.

[![Build Status](https://img.shields.io/travis/dst-academy/docker-dontstarvetogether/develop.svg)](https://travis-ci.org/dst-academy/docker-dontstarvetogether)
[![GitHub Release](https://img.shields.io/github/release/dst-academy/docker-dontstarvetogether.svg)](https://github.com/dst-academy/docker-dontstarvetogether/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/dstacademy/dontstarvetogether.svg)](https://hub.docker.com/r/dstacademy/dontstarvetogether/)
[![License](https://img.shields.io/github/license/dst-academy/docker-dontstarvetogether.svg)](https://github.com/dst-academy/docker-dontstarvetogether/blob/develop/LICENSE.md)
[![Slack](https://img.shields.io/badge/slack-join-E01563.svg)](https://slack.dst.academy/)
[![Steam](https://img.shields.io/badge/steam-join-1b2838.svg)](https://steamcommunity.com/groups/dst-academy)

---

This repository provides a `Dockerfile` for building the DST:A Dedicated Server
for the online multi-player survival game [*Don't Starve Together*][website].

## Features
- [x] Configuration via **ENV** variables.
- [x] Customized **world generation** via `leveldataoverride.lua`.
- [x] Mods and custom **mod-configuration**.
- [x] Connected worlds via **sharding**.
- [x] Control the server directly on the **CLI**.
- [x] **World-persistence** on container destruction.
- [ ] Automatic update of game files.
- [ ] Automatic update of mod files.
- [x] **Sharing** game and mod-files between instances.

## Documentation
- [Setup][docs-setup]
- [Configuration][docs-configuration]
- [Usage][docs-usage]
- [Examples][docs-examples]

## Contribution
Do you want to contribute to the project?
Check out our [contribution guide][contribution-guide].

## Frequently Asked Questions

- **Why does Steam take so long to update the game?**  
  It can happen that Steam takes a really long time to update the game. This is a known problem with
  SteamCMD - sort of a bug. One solution is to install a DNS cache on your system, which was reported
  to help regarding download speed.

## References and Links
- [Dedicated Server Discussion (Klei Forums)][reference-dedicated]
- [Shards and Migration Portals (Klei Forums)][reference-shards]
- [Dedicated Server Guide (Wikia)][reference-guide]
- [Server Console Commands (Wikia)][reference-commands]

---

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

[docs-setup]: /docs/setup.md
[docs-configuration]: /docs/configuration.md
[docs-usage]: /docs/usage.md
[docs-examples]: /docs/examples/
[website]: http://www.dontstarvetogether.com/
[contribution-guide]: /CONTRIBUTING.md
[docker-kitematic]: https://kitematic.com/
[docker-toolbox]: https://www.docker.com/docker-toolbox
[reference-dedicated]: http://forums.kleientertainment.com/forum/83-dont-starve-together-beta-dedicated-server-discussion/
[reference-shards]: http://forums.kleientertainment.com/topic/59174-understanding-shards-and-migration-portals/
[reference-guide]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers
[reference-commands]: http://dont-starve-game.wikia.com/wiki/Console/Don't_Starve_Together_Commands
