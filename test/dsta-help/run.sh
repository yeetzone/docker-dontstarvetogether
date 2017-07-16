#!/usr/bin/env bash

clean() {
	rm -f $file1 $file2
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`

# dst-server
cat > $file1 <<- EOF
usage: dst-server [--help] <command> [<args>]

The commands are:
   start    Start the server
   console  Execute commands on the server console
   update   Update game and/or mods
   log      Show a log
   version  Show the current server version

See 'dst-server help <command>' to read about a specific command.
EOF

docker run --rm -e NAME=bar $1 dst-server > $file2 && exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --foo 2> $file2 && exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server foo 2> $file2 && exit 1
diff $file1 $file2 || exit 1

# dst-server start
cat > $file1 <<- EOF
usage: dst-server start [--update=all|none|game|mods]
                        [--keep-configuration=<value[,otherValue>]...>]

   --update=none
      Update nothing, just start the server. This is the default behaviour.
   --update=all
      Update the game and the mods before launch the server.
   --update=game
      Update just the game (no the mods) and launch the server.
   --update=mods
      Update the mods and launch the server.
   --keep-configuration
      Select which configuration you don't want to overwrite.
      You must provide one or more of these values separated by commas:
      - token
      - cluster
      - server
      - world
      - adminlist
      - blocklist
      - whitelist
      - mods
EOF

docker run --rm -e NAME=bar $1 dst-server help start > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --help start > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server start --help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server start --help foo > $file2 || exit 1
diff $file1 $file2 || exit 1

# dst-server update
cat > $file1 <<- EOF
usage: dst-server update [--all|--game|--mods]
EOF

docker run --rm -e NAME=bar $1 dst-server help update > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --help update > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server update --help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server update --help foo > $file2 || exit 1
diff $file1 $file2 || exit 1

# dst-server log
cat > $file1 <<- EOF
usage: dst-server log [--server|--chat]
EOF

docker run --rm -e NAME=bar $1 dst-server help log > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --help log > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server log --help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server log --help foo > $file2 || exit 1
diff $file1 $file2 || exit 1

# dst-server log
cat > $file1 <<- EOF
usage: dst-server console [command ...]

The console utility executes commands in the Don't Starve Together server console.
The commands are executed in command-line order.
If command is a single dash ('-') or absent, console reads from the standard input.
EOF

docker run --rm -e NAME=bar $1 dst-server help console > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server --help console > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server console --help > $file2 || exit 1
diff $file1 $file2 || exit 1

docker run --rm -e NAME=bar $1 dst-server console --help foo > $file2 || exit 1
diff $file1 $file2 || exit 1
