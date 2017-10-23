# Change Log

## [next]

### Added
- Add support for the `leveldataoverride.lua` file via the `LEVELDATA_OVERRIDES` env-variable.
- Configure the Docker `HEALTHCHECK` command running `dst-server version --check`.
- Add a `keep-configuration` boot option to define how existing configuration files should be handled.

### Changed
- Update the base-image to `dstacademy/steamcmd:0.3`.
- Overwrite configuration files by default when starting a container.
- Do not expose/configure a default port in the `Dockerfile` anymore.

### Removed
- Remove the `WORLD_OVERRIDES` env-variable and `worldgenoverride.lua` file.
- Remove support for the `WORLD_PRESET` env-variable in favor of `LEVELDATA_OVERRIDES`.

## [0.7.1]

### Added
- Add the label `academy.dst.config.update` to the image for supporting auto-update strategies.

## [0.7.0]

### Added
- Add `DST_BRANCH` and `DST_BRANCH_PASSWORD` build arguments to enable building beta-branch images.
- Support providing options only on the Docker `CMD` command.
- Document the `SERVER_PORT` configuration variable.

### Changed
- Update the base-image to `dstacademy/steamcmd:0.2.1`.
- Rename the repository name on GitHub and on Docker Hub.
- Do not update the game and mods by default when starting a server/container.
- Remove default value for `MAX_PLAYERS` to use the game's default value.
- Remove default value for `GAME_MODE` to use the game's default value.
- Remove default value for `VOTE_KICK_ENABLE` to use the game's default value.
- Remove default value for `PAUSE_WHEN_EMPTY` to use the game's default value.
- Optimize configuration creation script to handle some options better.

### Removed
- Remove the `Vagrantfile`.

### Fixed
- Update examples documentation to use correct configuration variables.
- Do not overwrite mod configuration files when the game-files get updated.
- Use the correct configuration variable for enabling/disabling vote-kicking.
- Rename obsolete setting `offline_server` to `offline_cluster`.

## [0.6.0]

### Added
- Add `BACKUP_LOG_COUNT` environment variable to configure backups for the log files.
- Add `VOTE_ENABLE` environment variable for configuring voting.
- Add `LANGUAGE` environment variable for setting the server's language.
- Implement the `version` command.

### Changed
- Update gosu to version 1.9.
- Use our own `steamcmd` image as base-image.

### Removed
- Remove the Vagrantfile.
- Remove deprecated console arguments `console` and `backup_logs`.

## [0.5.0]

### Added
- Add the `backup_logs` argument to create a backup of the old logs.
- Implement validation for environment variables.
- Add the environment variable `LAN_ONLY`.
- Add the environment variable `MAX_SNAPSHOTS`.

### Changed
- Adopt the new file structure based on clusters.
- Move the token outside the settings files.
- Set a default of `10888` for `SHARD_MASTER_PORT`.
- Use `boxcutter/ubuntu1510` as the Vagrant base-box.
- Change the Vagrant base-box name to be compatible with more providers.
- Rename environment variable `SERVER_TOKEN` to `TOKEN`.
- Rename environment variable `SERVER_NAME` to `NAME`.
- Rename environment variable `SERVER_DESCRIPTION` to `DESCRIPTION`.
- Rename environment variable `SERVER_NAME_PREFIX` to `NAME_PREFIX`.
- Rename environment variable `SERVER_PASSWORD` to `PASSWORD`.
- Rename environment variable `SERVER_INTENTION` to `INTENTION`.

### Removed
- Remove environment variable `AUTOCOMPILER_ENABLE`.
- Remove environment variable `CONNECTION_TIMEOUT`.
- Remove environment variable `MODS_ENABLE`.
- Remove environment variable `STEAM_CLOUD_DISABLE`.

## [0.4.0]

### Added
- Add test cases to ensure code functionality.
- Introduce sub-commands `start`, `update`, `log` and `console`.
- Add `MODS_FORCE` variable to enable mods for development.

### Changed
- Relocate DST files in the image.
- Rename some environment variables for a more consistent naming scheme.
- Set `AUTOCOMPILER_ENABLE` to `false` by default.

### Removed
- Remove `UPDATE_ON_BOOT` environment variable.
- Remove `WORKDIR` directive from the Dockerfile.

## [0.3.0]

### Added
- Add `UPDATE_ON_BOOT` variable to configure update-behavior on boot.
- Add `SERVER_NAME_PREFIX` variable to configure a prefix for the server's name.

### Changed
- Generate a random server name if no name was configured.
- Use the Debian base image instead of Ubuntu.
- Relocate Steam and DST files in the image.
- Create separate users for running Steam and the DST server.

### Removed
- Remove the `CONF_DIR` environment variable.
- Remove the `STORAGE_ROOT` environment variable.
- Remove the `STEAM_APP_ID` environment variable.

## [0.2.0]

### Added
- Make the null-renderer `conf_dir` argument configurable.
- Make world generation configurable via the `WORLD_OVERRIDES` variable.
- Make the Steam App-ID configurable via the `STEAM_APP_ID` variable.
- Support volume-mounting.

### Changed
- Improve the `docker-compose.yml` configuration.
- Improve the entrypoint script.

## [0.1.0]

### Added
- Initial release.

[next]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.7.1...HEAD
[0.7.1]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/dst-academy/docker-dontstarvetogether/compare/da19beb5479033b82dd6dc1200bb0cf6724904c3...v0.1.0
