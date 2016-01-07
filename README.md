# DST:A Dedicated Server [![Build Status](https://travis-ci.org/dst-academy/server.svg?branch=develop)](https://travis-ci.org/dst-academy/server) [![Docker Pulls](https://img.shields.io/docker/pulls/dstacademy/server.svg)](https://hub.docker.com/r/dstacademy/server/)
> Don't Starve Together Academy Dedicated Server for Docker.

This repository provides a `Dockerfile` for building the DST:A Dedicated Server
for the online multi-player survival game [*Don't Starve Together*][website].

If you want to set up your own server, have a look at the [DST:A Suite][suite].

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

## Frequently Asked Questions

- **Does Docker automatically restart a running DST:A Dedicated Server when the host-system is rebooted?**  
  Yes.

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

[docs-setup]: /docs/setup.md
[docs-configuration]: /docs/configuration.md
[docs-usage]: /docs/usage.md
[website]: http://www.dontstarvetogether.com/
[suite]: https://github.com/dst-academy/suite
[docker-kitematic]: https://kitematic.com/
[docker-toolbox]: https://www.docker.com/docker-toolbox
[reference-dedicated]: http://forums.kleientertainment.com/forum/83-dont-starve-together-beta-dedicated-server-discussion/
[reference-shards]: http://forums.kleientertainment.com/topic/59174-understanding-shards-and-migration-portals/
[reference-guide]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers
[reference-commands]: http://dont-starve-game.wikia.com/wiki/Console/Don't_Starve_Together_Commands
