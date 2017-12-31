# Commands

Commands are used to start the server with specific options,
control it and get information about it, while it's running.

## `start`
Start the DST server.

**Options**
* `--update=[none|all|game|mods]` Enable or disable running updates on boot.
* `--keep-configuration=[token|cluster|server|world|mods|adminlist|whitelist|blocklist]` Configure overwriting of files.

**Examples**
* `dst-server start` Start the server, do not run updates and overwrite existing configuration files.
* `dst-server start --update=all` Start the server and update the game and mods on every boot/reboot.
* `dst-server start --update=game` Start the server and update the game on every boot/reboot only.
* `dst-server start --update=mods` Start the server and update installed mods on every boot/reboot.
* `dst-server start --update=none` Start the server and don't update the game or mods.
* `dst-server start --keep-configuration` Start the server and do not overwrite any existing files.
* `dst-server start --keep-configuration=token` Start the server and overwrite existing files except the token-file.
* `dst-server start --keep-configuration=token,world` Start the server without overwriting token and world files.

## `version`
Print the game's version.

**Options**
* `--local` Print the current running version of the game.
* `--upstream` Print the current released version of the game.
* `--check` Check if the upstream version is newer than the local running one.

**Examples**
* `dst-server version` Print the current running version and the available upstream version.
* `dst-server version --local` Print the current running version of the game.
* `dst-server version --upstream` Print the current available, released version of the game.
* `dst-server version --check` Check if the upstream version is newer than the running version.

## `log`
Read contents of various game-server log files.

**Options**
* `--server` Print the server log.
* `--chat` Print the chat log

**Examples**
* `dst-server log --server` Print the server log.
* `dst-server log --chat` Print the chat log.

## `console`
Execute a command on the in-game server-console.

**Examples**
* `dst-server console c_reset()` Run `c_reset()` on the console which resets the world.
* `dst-server console c_announce('Hello!')` Run `c_announce('Hello!')` on the console which broadcasts a message.
