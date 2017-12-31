# Configuration

Configuration of the server happens through environment variables, which can be passed to
the `docker run` call via CLI directly or using a separate file. Optionally it's recommended
to use `docker-compose` instead, which makes it easier to configure all environment variables.

**Example**:
```sh
docker run -itd -p 10999:10999/udp -e TOKEN="Token" -e NAME="Name" -e MAX_PLAYERS=10 dstacademy/dontstarvetogether
```

You can chain as many variables as you need. If you want to pass lots of them, it's easier and more
convenient to create an `.env` file and pass it's path to the command.

**Examples**:
```sh
docker run -itd --env-file=".env" dstacademy/dontstarvetogether
```

An `.env` file's contents must look like this and can hold all needed variables:
```ini
# This is a comment
TOKEN=Token
NAME=Name
MAX_PLAYERS=10
```

## Build Arguments

**MODS**  
Defines mods to install and enable.
- *CSV of workshop IDs*  
  *Example:* `378160973,492173795,407705132`

## Environment Variables
Environment variables can be used to customize certain settings of the server. Most of the
available environment variables correspond to the `settings.ini` variables used by DST.

**TOKEN** *required*  
Defines the server's token which is needed to run it.
To [generate a token][howto-token] you need a copy of DST.
- *text*

**NAME**  
Sets the server's name. Shows up on the public server-list and in-game.
Setting a custom server-name is not required but highly recommended.
If no name is configured, a random name will be generated.
- *text* *[default: *RANDOM*]*

**NAME_PREFIX**  
Defines text to prepend to the server's name.
- *text*

**DESCRIPTION**  
Sets the server's description. Shows up on the public server-list and in-game.
- *text* *[default: Powered by DST-Academy.]*

**LANGUAGE**
Sets the server's language.
- brazilian
- bulgarian
- czech
- danish
- dutch
- english *[default]*
- finnish
- french
- german
- greek
- hungarian
- italian
- japanese
- korean
- norwegian
- polish
- portuguese
- romanian
- russian
- schinese
- spanish
- swedish
- tchinese
- thai
- turkish
- ukrainian

**PASSWORD**  
Defines a server password so only players knowing the password can connect.
- *text*

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
- *text*

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
- *text*  
  *Example:* `secret-and-equal-for-all-shards`

**LEVELDATA_OVERRIDES**  
Sets the overrides-configuration for level-data. Basically it's just the content for the
`leveldataoverride.lua` file. As this value can be pretty large it's recommended to put the
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

[howto-token]: http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers#Server_Tokens
