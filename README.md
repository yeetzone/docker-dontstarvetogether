# DST:A Dedicated Server
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
- [ ] World-persistence on container destruction.
- [ ] Automatic update of the game and mods.
- [ ] Sharing game and mod-files between instances.

## Setup
Setting up the server is pretty easy if you got Docker already running.
Find a quick step-by-step guide how to setup the dedicated server below.

### Overview

1. Install [Docker Engine][engine-setup].
2. Install [Docker Compose][compose-setup]. *(optional but recommended)*
3. Configure a [`docker-compose.yml`][compose-file] configuration. *(optional but recommended)*
4. [Start a container][engine-run] i.e. [launch the service][compose-up].

The [DST:A Suite][suite] provides common Docker Compose configurations.

## Usage
Server-lifecycle is controlled via default [Docker Engine][engine-cli] or [Docker Compose][compose-cli]
commands. Every time the server is restarted manually it performs an update-task to check if the
game or installed mods provide updates and will download and install them. Thus it can take some
minutes before the server shows up on the server-list.

### Basic Commands
Basic commands to maintain the DST:A Dedicated Server.

**Start the Server**  
Starts the server. On boot the game-server checks for updates and performs them.  
Docker Engine:
`docker run -itd -p 10999:10999/udp --name="dst-server" -e SERVER_TOKEN="server-token" dstacademy/server`  
Docker Compose:
`docker-compose up -d`

**Stop the Server**  
Stops the server.  
Docker Engine:
`docker stop dst-server`  
Docker Compose:
`docker-compose stop`

**Restart the Server**  
Restarts the server. On boot the game-server checks for updates and performs them.  
Docker Engine:
`docker restart dst-server`  
Docker Compose:
`docker-compose restart`

**Remove the Server**  
Deletes the server.  
Docker Engine:
`docker rm -f dst-server`  
Docker Compose:
`docker-compose rm -f`

### Advanced Commands
More advanced commands to maintain the server-image and other stuff.

**Update the Server-Image**  
Updates the `dstacademy/server` image from the Docker Hub if updates are available.  
Docker Engine:
`docker pull dstacademy/server`  
Docker Compose:
`docker-compose pull`

**List all created servers/containers**  
Prints an overview of all available servers.  
Docker Engine:
`docker ps -a`  
Docker Compose:
`docker-compose ps`

**Attach to the Server**  
Attaches the terminal to a running server which enables input of server [commands][reference-commands]
and to observe the server output. To detach without stopping the server press `ctrl+p` followed by `ctrl+q`.  
Docker Engine:
`docker attach dst-server`

## Configuration
Configuration of the server happens through environment variables, which can be passed to
the `docker run` call via CLI directly or using a separate file. Optionally it's recommended
to use `docker-compose` instead, which makes it easier to configure all environment variables.

**Example**:
```sh
docker run -itd -e SERVER_TOKEN="Token" -e DEFAULT_SERVER_NAME="Name" -e MAX_PLAYERS=10 dstacademy/server
```

You can chain as many variables as you need. If you want to pass lots of them, it's easier and more
convenient to create an `.env` file and pass it's path to the command.

**Examples**:
```sh
docker run -itd --env-file=".env" dstacademy/server
```

An `.env` file's contents must look like this and can hold all needed variables:
```ini
# This is a comment
SERVER_TOKEN=Token
DEFAULT_SERVER_NAME=Name
MAX_PLAYERS=10
```

### Environment Variables
Environment variables can be used to customize certain settings of the server. Most of the
available environment variables correspond to the `settings.ini` variables used by DST.

#### Application
Sets application-specific options.

**STORAGE_ROOT**  
Configures the root path of the save directory. Should not be changed under most circumstances.
- *text* *[default: /home/steam/.klei/]*

**CONF_DIR**  
Defines an alternative directory-name for writing and reading server configuration and save-games.
- *text* *[default: DoNotStarveTogether]*

#### Account
Sets account-related options.

**SERVER_TOKEN**  *required*  
Defines the server's token which is needed to run it.
To [generate a token][howto-token] you need a copy of DST.
- *text*

#### Network
Configures network-related settings.

**DEFAULT_SERVER_NAME**  
Sets the server's name. Shows up on the public server-list and in-game.
Setting a custom server-name is not required but highly recommended.
- *text* *[default: Don't Starve Together]*

**DEFAULT_SERVER_DESCRIPTION**  
Sets the server's description. Shows up on the public server-list and in-game.
- *text* *[default: Powered by DST-Academy.]*

**SERVER_PORT**  
Defines the server's public port for players to connect to. Generally it's not needed to change
the server's port-number, because the external/public port-number can be configured via Docker.
-  *number* *[default: 10999]*

**SERVER_PASSWORD**  
Defines a server password so only players knowing the password can connect.
- *text*

**OFFLINE_SERVER**  
Controls if the server is listed and accessible publicly.
- true
- false *[default]*

**MAX_PLAYERS**  
Sets the maximum number of allowed players to connect and play simultaneously. Heavily influences
overall performance and gameplay-experience of the server. Be sure the hardware has enough power
to provide a smooth experience for the configured number of players.
- *number* *[default: 4]*

**WHITELIST_SLOTS**  
Reserves player-slots for administrator and/or other players and adds up to the total number of
players which can connect to the server. The sum of `MAX_PLAYERS` and `WHITELIST_SLOTS` determines
how many players can connect to the server simultaneously.
- *number* *[default: 0]*

**PVP**  
Enables/disables PVP, which basically defines if players can attack each other.
- true
- false *[default]*

**GAME_MODE**  
Defines which game-mode the server runs on.
- survival *[default]*
- endless
- wilderness

**SERVER_INTENTION**  
Configures the server's gameplay-intention for players.
- social
- cooperative *[default]*
- competitive
- madness

**ENABLE_AUTOSAVER**  
Enables/disables automatic saving of the world's state after each ingame-day.
- true *[default]*
- false

**TICK_RATE**  
Sets the servers tick-rate. A higher tick-rate means a smoother
gameplay but also more bandwidth is needed and more CPU-power is used.
- 15 *[default]*
- 30
- 60

**CONNECTION_TIMEOUT**  
Defines the time in milliseconds after a non-responding player gets disconnected.
- *number*  *[default: 5000]*  
  *Example:* `10000` *(10 seconds)*

**ENABLE_VOTE_KICK**  
Enables/disables the possibility to kick players via voting.
- true *[default]*
- false

**PAUSE_WHEN_EMPTY**  
Enables/disables pausing of the world when no player is connected.
- true *[default]*
- false

**STEAM_APP_ID**  
Sets the ID of the app to be installed. Generally it's not needed to change this.
- *number* *[default: 343050]*

**STEAM_AUTHENTICATION_PORT**  
Sets the authentication port-number for Steam. Generally it's not needed to change this.
- *number* *[default: 8766]*

**STEAM_MASTER_SERVER_PORT**  
Sets the master-server port-number for Steam. Generally it's not needed to change this.
- *number* *[default: 27016]*

**STEAM_GROUP_ID**  
Relates the server to a corresponding steam-group.
- *number*

**STEAM_GROUP_ONLY**  
Enables/disables joining for steam-group members only. Non-group members won't be able to join.
- true
- false *[default]*

**STEAM_GROUP_ADMINS**  
Enables/disables promoting steam-group officers to server administrators.
- true
- false *[default]*

#### Misc
Defines various other configuration options.

**CONSOLE_ENABLED**  
Disables/enables the ingame-console for administrators.
- true *[default]*
- false

**AUTOCOMPILER_ENABLED**  
- true *[default]*
- false

**MODS_ENABLED**  
Enables/disables mod-support.
- true *[default]*
- false

#### Shard
Configures server-sharding.

**SHARD_ENABLE**  
Enables/disables sharding for connecting multiple servers to one big world.
- true
- false *[default]*

**SHARD_NAME**  
Sets a unique name for this server-shard.
- *text*

**SHARD_ID**  
Sets a unique shard ID for this server-shard.
- *number*  
  *Example:* `1`

**IS_MASTER**  
Defines whether this server is the main server.
- true
- false *[default]*

**MASTER_IP**  
Defines the master-server's ip-address for slave-servers.
- *ip-address*

**MASTER_PORT**  
Defines the master-server's port. This needs to be set to
the same port for the master-server and all slave-servers.
- *port-number*

**BIND_IP**  
Configures the IP-address for which to allow incoming shard-connections from.
Generally this should not be changed to work with Docker properly.
- *ip-address* *[default: 0.0.0.0]*  

**CLUSTER_KEY**  
Sets a unique and secret cluster key for validating incoming shard-connections.
This needs to be the same for the master-server and all slave-servers.
- *text*  
  *Example:* `secret-and-equal-for-all-shards`

#### Steam
Sets Steam-related options.

**DISABLECLOUD**  
Enables/diables the Steam Cloud synchronization.
- true *[default]*
- false

#### World
Defines world-related settings.

**WORLD_PRESET**  
Defines some pre-configured world settings for the server.
- SURVIVAL_TOGETHER *[default]*
- SURVIVAL_TOGETHER_CLASSIC
- SURVIVAL_DEFAULT_PLUS
- COMPLETE_DARKNESS
- DST_CAVE

**WORLD_OVERRIDES**  
Sets the overrides-configuration for world generation. Basically it's just the content for the
`worldgenoverride.lua` file. As this value can be pretty large it's recommended to put the
configuration into a separate file and read it into the variable beforehand. When this is set
`WORLD_PRESET` has no effect.
- *string*

#### Mods
Mods-related settings.

**MODS**  
Defines mods to install and enable.
- *CSV of workshop IDs*  
  *Example:* `378160973,492173795,407705132`

**MODS_OVERRIDES**  
Sets the overrides-configuration for all mods. Basically it's just the content for the
`modsoverrides.lua` file. As this value can be pretty large it's recommended to put the
configuration into a separate file and read it into the variable beforehand.
- *string*

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

[website]: http://www.dontstarvetogether.com/
[suite]: https://github.com/dst-academy/suite
[image]: https://hub.docker.com/r/dstacademy/server/
[engine-setup]: https://docs.docker.com/engine/installation/
[compose-setup]: https://docs.docker.com/compose/install/
[compose-file]: https://docs.docker.com/compose/compose-file/
[engine-cli]: https://docs.docker.com/engine/reference/commandline/
[compose-cli]: https://docs.docker.com/compose/reference/
[engine-run]: https://docs.docker.com/engine/reference/run/
[compose-up]: https://docs.docker.com/compose/reference/up/
[howto-token]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers#Server_Tokens
[docker-kitematic]: https://kitematic.com/
[docker-toolbox]: https://www.docker.com/docker-toolbox
[reference-dedicated]: http://forums.kleientertainment.com/forum/83-dont-starve-together-beta-dedicated-server-discussion/
[reference-shards]: http://forums.kleientertainment.com/topic/59174-understanding-shards-and-migration-portals/
[reference-guide]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers
[reference-commands]: http://dont-starve-game.wikia.com/wiki/Console/Don't_Starve_Together_Commands
