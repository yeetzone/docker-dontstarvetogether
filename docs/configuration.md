# Configuration

Configuration of the server happens through environment variables, which can be passed to
the `docker run` call via CLI directly or using a separate file. Optionally it's recommended
to use `docker-compose` instead, which makes it easier to configure all environment variables.

**Example**:
```sh
docker run -itd -p 10999:10999/udp -e TOKEN="token" -e NAME="name" -e MAX_PLAYERS=10 yeetzone/dontstarvetogether
```

You can chain as many variables as you need. If you want to pass lots of them, it's easier and more
convenient to create an `.env` file and pass it's path to the command.

**Examples**:
```sh
docker run -itd --env-file=.env yeetzone/dontstarvetogether
```

An `.env` file's contents must look like this and can hold all needed variables:
```ini
TOKEN=token
NAME=name
MAX_PLAYERS=10
```

## Environment Variables
Environment variables can be used to customize certain settings of the server. Most of the
available environment variables correspond to the `settings.ini` variables used by DST.

**TOKEN** *required*  
Defines the server's token which is needed to run it.
To [generate a token][howto-token] you need a copy of DST.
- *string*

**NAME**  
Sets the server's name. Shows up on the public server-list and in-game.
Setting a custom server-name is not required but highly recommended.
If no name is configured, a random name will be generated.
- *string* *[default: *RANDOM*]*

**NAME_PREFIX**  
Defines text to prepend to the server's name.
- *string*

**DESCRIPTION**  
Sets the server's description. Shows up on the public server-list and in-game.
- *string* *[default: Powered by DST-Academy.]*

**LANGUAGE**
Sets the server's language.
- en *[default]*
- de
- it
- fr
- es
- pt
- pl
- ru
- ko
- zh
- zhr

**PASSWORD**  
Defines a server password so only players knowing the password can connect.
- *string*

**SERVER_PORT**  
Defines the port on which the game-server runs inside the Docker container.
- *number* *[default: 10999]*

**OFFLINE_ENABLE**  
Controls if the server is listed and accessible publicly.
- true
- false *[default]*

**LAN_ONLY**  
Controls if the server is accessible from LAN only.
- true
- false *[default]*

**MAX_PLAYERS**  
Sets the maximum number of allowed players to connect and play simultaneously. Heavily influences
overall performance and gameplay-experience of the server. Be sure the hardware has enough power
to provide a smooth experience for the configured number of players.
- *number* *[default: 16]*

**WHITELIST_SLOTS**  
Reserves player-slots for administrator and/or other players and adds up to the total number of
players which can connect to the server. The sum of `MAX_PLAYERS` and `WHITELIST_SLOTS` determines
how many players can connect to the server simultaneously.
- *number* *[default: 0]*

**ADMINLIST**  
Klei UserIDs to add to the adminlist.txt file. Gives players in the list Administrator priveliges.
A players Klei UserID can be found my clicking "Account" in the bottom right of the main menu.
- *CSV of Klei UserIDs*  
  *Example:* `KU_G_cla3ou,KU_yDc5M7bx,KU_ad39dik`

**WHITELIST**  
Klei UserIDs to add to the whitelist.txt file.
A players Klei UserID can be found my clicking "Account" in the bottom right of the main menu.
- *CSV of Klei UserIDs*  
  *Example:* `KU_G_cla3ou,KU_yDc5M7bx,KU_ad39dik`

**BLOCKLIST**  
Klei UserIDs to add to the blocklist.txt file.
A players Klei UserID can be found my clicking "Account" in the bottom right of the main menu.
- *CSV of Klei UserIDs*  
  *Example:* `KU_G_cla3ou,KU_yDc5M7bx,KU_ad39dik`

**PVP_ENABLE**  
Enables/disables PVP, which basically defines if players can attack each other.
- true
- false *[default]*

**GAME_MODE**  
Defines which game-mode the server runs on.
- survival *[default]*
- endless
- wilderness

**INTENTION**  
Configures the server's gameplay-intention for players. The default value depends on **GAME_MODE**.
- social
- cooperative
- competitive
- madness

**AUTOSAVER_ENABLE**  
Enables/disables automatic saving of the world's state after each in-game day.
- true *[default]*
- false

**TICK_RATE**  
Sets the servers tick-rate. A higher tick-rate means a smoother
gameplay but also more bandwidth is needed and more CPU-power is used.
- 15 *[default]*
- 20
- 30
- 60

**VOTE_ENABLE**  
Enables/disables voting on the server.
- true *[default]*
- false

**VOTE_KICK_ENABLE**  
Enables/disables the possibility to kick players via voting.
- true *[default]*
- false

**PAUSE_WHEN_EMPTY**  
Enables/disables pausing of the world when no player is connected.
- true
- false *[default]*

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

**CONSOLE_ENABLE**  
Disables/enables the ingame-console for administrators.
- true *[default]*
- false

**SHARD_ENABLE**  
Enables/disables sharding for connecting multiple servers to one big world.
- true
- false *[default]*

**SHARD_NAME**  
Sets a unique name for this server-shard.
- *string*

**SHARD_ID**  
Sets a unique shard ID for this server-shard.
- *number*  
  *Example:* `1`

**SHARD_IS_MASTER**  
Defines whether this server is the main server.
- true
- false *[default]*

**SHARD_MASTER_IP**  
Defines the master-server's ip-address for slave-servers.
- *ip-address*

**SHARD_MASTER_PORT**  
Defines the master-server's port. This needs to be set to
the same port for the master-server and all slave-servers.
- *port-number* *[default: 10888]*

**SHARD_BIND_IP**  
Configures the IP-address for which to allow incoming shard-connections from.
Generally this should not be changed to work with Docker properly.
- *ip-address* *[default: 0.0.0.0]*  

**SHARD_CLUSTER_KEY**  
Sets a unique and secret cluster key for validating incoming shard-connections.
This needs to be the same for the master-server and all slave-servers.
- *string*  
  *Example:* `secret-and-equal-for-all-shards`

**WORLD_PRESET**  
Sets a pre-defined preset in the `worldgenoverride.lua` file.
- SURVIVAL_TOGETHER_CLASSIC
- SURVIVAL_TOGETHER *[default]*
- SURVIVAL_DEFAULT_PLUS
- DST_CAVE
- DST_CAVE_PLUS
- COMPLETE_DARKNESS
- MOD_MISSING

**WORLD_CONFIGURATION**  
Sets the configuration for world generation. Basically it's just the content for the
`worldgenoverride.lua` file. As this value can be pretty large it's recommended to put the
configuration into a separate file and read it into the variable beforehand.
- *string*

**MODS_OVERRIDES**  
Sets the overrides-configuration for all mods. Basically it's just the content for the
`modsoverrides.lua` file. As this value can be pretty large it's recommended to put the
configuration into a separate file and read it into the variable beforehand.
- *string*

**BACKUP_LOG_COUNT**  
Enables the backup of server logs when rebooting the server.
- *number* *[default: 0]*

**ENCODE_USER_PATH**  
Enables path encoding to be compatible with case-insensitive operating systems.
- true *[default]*
- false

[howto-token]: https://dontstarve.fandom.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers#Server_Tokens
