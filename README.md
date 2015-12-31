# DST-Academy Don't Starve Together Server
> Don't Starve Together Dedicated Server for Docker.

## Configuration
Configuration of the server happens through environment variables,
which can be passed to the `docker run` call via CLI directly or using a separate file.

### Environment Variables

#### Account
Sets account-related options.

**SERVER_TOKEN**  
Defines the server's token which is needed to run it.
To generate a token you need a copy of DST.
- *text*

#### Network
Configures network-related settings.

**DEFAULT_SERVER_NAME**  
Sets the server's name. Shows up on the public server-list and ingame.
- *text*

**DEFAULT_SERVER_DESCRIPTION**  
Sets the server's description. Shows up on the public server-list and ingame.
- *text*

**SERVER_PORT**  
Defines the server's public port for players to connect to.
- 10999 *[default]* or
- *port-number*

**SERVER_PASSWORD**  
Defines the server's password which is needed for players to connect.
- *text* or none

**OFFLINE_SERVER**  
Controls if the server should be listed publicly.
- true
- false

**MAX_PLAYERS**  
Sets the maximum number of allowed players to connect and play simultaneously.
- 1-64

**WHITELIST_SLOTS**
Reserves player-slots for administrator and/or other players.
- *number*

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
- cooperative
- competitive
- madness

**ENABLE_AUTOSAVER**  
Enables/disables automatic saving of the world's state after each ingame-day.
- true
- false

**TICK_RATE**  
Sets the servers tick-rate. A higher tick-rate means a smoother
gameplay but also more bandwidth is needed and more CPU-power is used.
- 15 *[default]*
- 30
- 60

**CONNECTION_TIMEOUT**  
Defines the time in milliseconds after a non-responding player gets disconnected.
- *number*

**ENABLE_VOTE_KICK**  
Enables/disables the possibility to kick players via voting.
- true
- false

**PAUSE_WHEN_EMPTY**  
Enables/disables pausing of the world when no player is connected.
- true
- false

**STEAM_AUTHENTICATION_PORT**  
Sets the authentication port-number for Steam.
- *number* *[default: 8766]*

**STEAM_MASTER_SERVER_PORT**  
Sets the master-server port-number for Steam.
- *number* *[default: 27016]*

**STEAM_GROUP_ID**  
Relates the server to a corresponding steam-group.
- *number*

**STEAM_GROUP_ONLY**  
Enables/disables joining for steam-group members only.
- true
- false

**STEAM_GROUP_ADMINS**  
Enables/disables promoting steam-group officers to server administrators.
- true
- false

#### Misc
Defines various other configuration options.

**CONSOLE_ENABLED**  
Disables/enables the ingame-console for administrators.
- true
- false

**AUTOCOMPILER_ENABLED**  
- true
- false

**MODS_ENABLED**  
Enables/disables mod-support.
- true
- false

#### Shard
Configures server-sharding.

**SHARD_ENABLE**  
Enables/disables sharding for connecting multiple servers to one big world.
- true
- false

**SHARD_NAME**  
Sets a unique name for this server-shard.
- *text*

**SHARD_ID**  
Sets a unique shard ID for this server-shard.
- *number*

**IS_MASTER**  
Defines whether this server is the main server.
- true
- false

**MASTER_IP**  
Defines the master-server's ip-address for slave-servers.
- *ip-address*

**MASTER_PORT**  
Defines the master-server's port. This needs to be set to
the same port for the master-server and all slave-servers.
- *port-number*

**BIND_IP**  
Configures the IP-address for which to allow incoming
shard-connections from. Use `0.0.0.0` to allow any connection.
- 127.0.0.1 *[default]* or
- *ip-address*

**CLUSTER_KEY**  
Sets a unique and secret cluster key for validating incoming shard-connections.
This needs to be the same for the master-server and all slave-servers.
- *text*

#### Steam
Sets Steam-related options.

**DISABLECLOUD**  
Enables/diables the Steam Cloud synchronization.
- true
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

#### Mods
Mods-related settings.

**MODS**  
Defines mods to install and enable.
- *CSV of workshop IDs*

**MODS_OVERRIDES**  
Sets the overrides-configuration for all mods.
Basically it's just the content for the `modsoverrides.lua` file.
- *string*
