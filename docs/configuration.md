# Configuration

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

## Environment Variables
Environment variables can be used to customize certain settings of the server. Most of the
available environment variables correspond to the `settings.ini` variables used by DST.

### Application
Sets application-specific options.

**STORAGE_ROOT**  
Configures the root path of the save directory. Should not be changed under most circumstances.
- *text* *[default: /home/steam/.klei/]*

**CONF_DIR**  
Defines an alternative directory-name for writing and reading server configuration and save-games.
- *text* *[default: DoNotStarveTogether]*

**UPDATE_ON_BOOT**  
Enables/disables checking for game and mod updates on boot.
- true *[default]*
- false

### Account
Sets account-related options.

**SERVER_TOKEN**  *required*  
Defines the server's token which is needed to run it.
To [generate a token][howto-token] you need a copy of DST.
- *text*

### Network
Configures network-related settings.

**DEFAULT_SERVER_NAME**  
Sets the server's name. Shows up on the public server-list and in-game.
Setting a custom server-name is not required but highly recommended.
If no name is configured, a random name will be generated.
- *text* *[default: *RANDOM*]*

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

### Misc
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

### Shard
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

### Steam
Sets Steam-related options.

**DISABLECLOUD**  
Enables/diables the Steam Cloud synchronization.
- true *[default]*
- false

### World
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

### Mods
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

[howto-token]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers#Server_Tokens
