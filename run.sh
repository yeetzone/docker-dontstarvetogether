#!/usr/bin/env bash

# Update game and mods.
/home/steam/steamcmd.sh \
  +@ShutdownOnFailedCommand 1 \
  +@NoPromptForPassword 1 \
  +login anonymous \
  +force_install_dir /home/steam/DoNotStarveTogether \
  +app_update 343050 validate \
  +quit

# Create the settings.ini file.
FILE_SETTINGS="/home/steam/.klei/DoNotStarveTogether/settings.ini"
if [ ! -f $FILE_SETTINGS ]; then
cat <<- EOF > $FILE_SETTINGS
	[network]
	default_server_name = $DEFAULT_SERVER_NAME
	default_server_description = $DEFAULT_SERVER_DESCRIPTION
	server_port = $SERVER_PORT
	server_password = $SERVER_PASSWORD
	offline_server = $OFFLINE_SERVER
	max_players = $MAX_PLAYERS
	whitelist_slots = $WHITELIST_SLOTS
	pvp = $PVP
	game_mode = $GAME_MODE
	server_intention = $SERVER_INTENTION
	enable_autosaver = $ENABLE_AUTOSAVER
	tick_rate = $TICK_RATE
	connection_timeout = $CONNECTION_TIMEOUT
	enable_vote_kick = $ENABLE_VOTE_KICK
	pause_when_empty = $PAUSE_WHEN_EMPTY
	steam_authentication_port = $STEAM_AUTHENTICATION_PORT
	steam_master_server_port = $STEAM_MASTER_SERVER_PORT
	steam_group_id = $STEAM_GROUP_ID
	steam_group_only = $STEAM_GROUP_ONLY
	steam_group_admins = $STEAM_GROUP_ADMINS

	[account]
	server_token = $SERVER_TOKEN

	[misc]
	console_enabled = $CONSOLE_ENABLED
	autocompiler_enabled = $AUTOCOMPILER_ENABLED
	mods_enabled = $MODS_ENABLED

	[shard]
	shard_enable = $SHARD_ENABLE
	shard_name = $SHARD_NAME
	shard_id = $SHARD_ID
	is_master = $IS_MASTER
	master_ip = $MASTER_IP
	master_port = $MASTER_PORT
	bind_ip = $BIND_IP
	cluster_key = $CLUSTER_KEY

	[steam]
	disablecloud = $DISABLECLOUD
EOF
fi

# Create the adminlist.txt file.
FILE_ADMINLIST="/home/steam/.klei/DoNotStarveTogether/save/adminlist.txt"
if [ -n "$ADMINLIST" ] && [ ! -f $FILE_ADMINLIST ]; then
  echo $ADMINLIST | tr , '\n' > $FILE_ADMINLIST
fi

# Create the whitelist.txt file.
FILE_WHITELIST="/home/steam/.klei/DoNotStarveTogether/save/whitelist.txt"
if [ -n "$WHITELIST" ] && [ ! -f $FILE_WHITELIST ]; then
  echo $WHITELIST | tr , '\n' > $FILE_WHITELIST
fi

# Create the blocklist.txt file.
FILE_BLOCKLIST="/home/steam/.klei/DoNotStarveTogether/save/blocklist.txt"
if [ -n "$BLOCKLIST" ] && [ ! -f $FILE_BLOCKLIST ]; then
  echo $BLOCKLIST | tr , '\n' > $FILE_BLOCKLIST
fi

# Configure the world preset.
FILE_WORLD="/home/steam/.klei/DoNotStarveTogether/worldgenoverride.lua"
if [ -n "$WORLD_PRESET" ] && [ ! -f $FILE_WORLD ]; then
cat <<- EOF > $FILE_WORLD
	return {
	    override_enabled = true,
	    preset = "$WORLD_PRESET",
	}
EOF
fi

# Install mods.
FILE_MODS="/home/steam/DoNotStarveTogether/mods/dedicated_server_mods_setup.lua"
if [ -n "$MODS" ]; then

  > $FILE_MODS

  IFS=","
  for MOD in $MODS; do
    echo "ServerModSetup(\"$MOD\")" >> $FILE_MODS
  done
fi

# Configure Mods.
FILE_MODS_OVERRIDES="/home/steam/.klei/DoNotStarveTogether/modoverrides.lua"
if [ -n "$MODS" ] && [ -n "$MODS_OVERRIDES" ] && [ ! -f $FILE_MODS_OVERRIDES ]; then
  echo "$MODS_OVERRIDES" > $FILE_MODS_OVERRIDES
elif [ -n "$MODS" ] && [ ! -f $FILE_MODS_OVERRIDES ]; then
  echo "return {" >> $FILE_MODS_OVERRIDES

  for MOD in $MODS; do
    echo "[\"workshop-$MOD\"] = { enabled = true }," >> $FILE_MODS_OVERRIDES
  done

  echo "}" >> $FILE_MODS_OVERRIDES
fi

# Run the DST executable.
/home/steam/DoNotStarveTogether/bin/dontstarve_dedicated_server_nullrenderer $@
