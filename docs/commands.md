# Commands

Commands are used to start the server with specific options,
control it and get information about it, while it's running.

## `start`
Start the DST server.

**Options**
* `--update` Enable or disable running updates on boot.

**Examples**
* `dontstarvetogether start` Start the server, do not update.
* `dontstarvetogether start --update` Start the server and update the game files.

## `version`
Print the game's version.

**Options**
* `--local` Print the current running version of the game.
* `--upstream` Print the current released version of the game.
* `--check` Check if the upstream version is newer than the local running one.

**Examples**
* `dontstarvetogether version` Print the current running version and the available upstream version.
* `dontstarvetogether version --local` Print the current running version of the game.
* `dontstarvetogether version --upstream` Print the current available, released version of the game.
* `dontstarvetogether version --check` Check if the upstream version is newer than the running version.

## `log`
Read contents of various game-server log files.

**Options**
* `--server` Print the server log.
* `--chat` Print the chat log

**Examples**
* `dontstarvetogether log --server` Print the server log.
* `dontstarvetogether log --chat` Print the chat log.

## `console`
Execute a command on the in-game server-console.

**Examples**
* `dontstarvetogether console c_reset()` Run `c_reset()` on the console which resets the world.
* `dontstarvetogether console c_announce('Hello!')` Run `c_announce('Hello!')` on the console which broadcasts a message.
