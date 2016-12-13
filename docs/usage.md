# Usage

Server-lifecycle is controlled via default [Docker Engine][engine-cli] or [Docker Compose][compose-cli]
commands. Every time the server is restarted manually it performs an update-task to check if the
game or installed mods provide updates and will download and install them. Thus it can take some
minutes before the server shows up on the server-list.

## Basic Commands
Basic commands to maintain the DST:A Dedicated Server.

**Start the Server**  
Starts the server. On boot the game-server checks for updates and performs them.  
Docker Engine:
`docker run -itd -p 10999:10999/udp -e TOKEN="server-token" dstacademy/dontstarvetogether`  
Docker Compose:
`docker-compose up -d`

**Stop the Server**  
Stops the server.  
Docker Engine:
`docker stop <container>`  
Docker Compose:
`docker-compose stop`

**Restart the Server**  
Restarts the server. On boot the game-server checks for updates and performs them.  
Docker Engine:
`docker restart <container>`  
Docker Compose:
`docker-compose restart`

**Remove the Server**  
Deletes the server.  
Docker Engine:
`docker rm -f <container>`  
Docker Compose:
`docker-compose rm -f`

**Execute console command**  
Runs commands on the game's console.  
Docker Engine:
`docker exec <container> dst-server console "c_announce('Having fun?')"`

**Print default log**  
Prints the server's default log.  
Docker Engine:
`docker exec <container> dst-server log`

**Print chat log**  
Prints the server's chat log.  
Docker Engine:
`docker exec <container> dst-server log --chat`

## Advanced Commands
More advanced commands to maintain the server-image and other stuff.

**Update the Server-Image**  
Updates the [`dstacademy/dontstarvetogether`][image] image from the Docker Hub if updates are available.  
Docker Engine:
`docker pull dstacademy/dontstarvetogether`  
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
`docker attach <container>`

**Execute custom command**  
Runs a custom command in the container.  
Docker Engine:
`docker exec <container> echo "Running my custom command."`

[engine-cli]: https://docs.docker.com/engine/reference/commandline/
[compose-cli]: https://docs.docker.com/compose/reference/
[reference-commands]: http://dont-starve-game.wikia.com/wiki/Console/Don't_Starve_Together_Commands
[image]: https://hub.docker.com/r/dstacademy/dontstarvetogether/
