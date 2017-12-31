# Examples
> Configuration examples for setting up, running, and maintaining a DST:A Dedicated Server.

Provided in this section are several common Docker Compose configurations for your
DST:A Dedicated Server setup. Those also act as reference and best-practices on how to
configure the Docker containers/services to run the DST:A Dedicated Server.

Feel free to choose an existing configuration which matches your desired server-setup and
adapt it to your needs. By running `docker-compose up -d` the server gets started with
settings defined in the particular `docker-compose.yml` file.

For a more advanced setup you can have a look at the [configuration][dsta-servers] of our hosted servers.

## Configurations

### [Basic Server][setup-basic]
The *Basic Server* configuration provides a setup in it's simplest form.
It defines a single server with a very minimalistic configuration.

### [Multiple Servers][setup-multiple]
The *Multiple Servers* configuration defines multiple independent servers.
Each server has it's own configuration and separate public port-binding.

### [Modded Server][setup-mods]
The *Modded Server* configuration shows how to enable mods with custom configurations.

### [Sharded Server][setup-shard]
The *Sharded Server* configuration defines a simple sharded server setup. It will spin up a
tree-world (overworld) master-server and a caves-world (underworld) slave-server, which are
connected to each other via sinkholes and stairs in each world.

### [World Generation][setup-world]
The *World Generation* configuration defines custom world generation rules. Configuration
is loaded from the `leveldataoverride.yml` file and passed to the start command.

[dsta-servers]: https://github.com/dst-academy/deployment-servers
[setup-basic]: ./basic/
[setup-multiple]: ./multiple/
[setup-mods]: ./mods/
[setup-shard]: ./shard/
[setup-world]: ./world/
