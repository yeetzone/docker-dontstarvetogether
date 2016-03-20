# Change Log

## [next]

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

[next]: https://github.com/dst-academy/server/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/dst-academy/server/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/dst-academy/server/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/dst-academy/server/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/dst-academy/server/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/dst-academy/server/compare/da19beb5479033b82dd6dc1200bb0cf6724904c3...v0.1.0
