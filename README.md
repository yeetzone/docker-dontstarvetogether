# Don't Starve Together
> Dockerfile for building a [Don't Starve Together][website] dedicated-server image.

[![Build Status](https://img.shields.io/travis/dst-academy/server/develop.svg)](https://travis-ci.org/dst-academy/server)
[![GitHub Release](https://img.shields.io/github/release/dst-academy/server.svg)](https://github.com/dst-academy/server/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/dstacademy/server.svg)](https://hub.docker.com/r/dstacademy/server/)
[![License](https://img.shields.io/github/license/dst-academy/server.svg?maxAge=2592000?style=flat-square)](https://github.com/dst-academy/server/blob/develop/LICENSE.md)
[![Slack](https://img.shields.io/badge/slack-join-E01563.svg)](https://slack.dst.academy/)
[![Steam](https://img.shields.io/badge/steam-join-1b2838.svg)](https://steamcommunity.com/groups/dst-academy)

---

This repository provides a `Dockerfile` for building the DST:A Dedicated Server
for the online multi-player survival game [*Don't Starve Together*][website].

## Features
- [x] Configuration via ENV variables.
- [x] World presets including caves.
- [x] Customized world generation.
- [x] Mods and custom mod-configuration.
- [x] Connected worlds via sharding.
- [x] Control the server directly on the CLI.
- [x] World-persistence on container destruction.
- [ ] Automatic update of game files.
- [ ] Automatic update of mod files.
- [x] Sharing game and mod-files between instances.

## Documentation
- [Setup][docs-setup]
- [Configuration][docs-configuration]
- [Usage][docs-usage]

## Contribution
Do you want to contribute to the project?
Check out our [contribution guide][contribution-guide].

## Frequently Asked Questions

- **On which operating systems can I run Docker and the DST:A Dedicated Server?**  
  Docker runs natively on Linux, but there are official solutions for running Docker on Windows and OSX.
  Have a look at Docker's [Kitematic][docker-kitematic] and Docker's [Toolbox][docker-kitematic].

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
[website]: http://www.dontstarvetogether.com/
[contribution-guide]: /CONTRIBUTING.md
[docker-kitematic]: https://kitematic.com/
[docker-toolbox]: https://www.docker.com/docker-toolbox
[reference-dedicated]: http://forums.kleientertainment.com/forum/83-dont-starve-together-beta-dedicated-server-discussion/
[reference-shards]: http://forums.kleientertainment.com/topic/59174-understanding-shards-and-migration-portals/
[reference-guide]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers
[reference-commands]: http://dont-starve-game.wikia.com/wiki/Console/Don't_Starve_Together_Commands
