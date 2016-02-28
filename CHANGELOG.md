# Change Log

## [next]

### Added
- Add the `-backup_logs` argument to create a backup of the old logs.
- Implement a environment variable validation.
- Add environment variables: `LAN_ONLY` and `MAX_SNAPSHOTS`.

### Changed
- Adopt the new file structure based on clusters.
- Rename environment variable `SERVER_TOKEN` to `TOKEN`.
- Move the token outside the settings files.
- Set a default value for `SHARD_MASTER_PORT`: 10888.
- Rename environment variables: `SERVER_NAME` to `NAME`, `SERVER_DESCRIPTION` to `DESCRIPTION`, `SERVER_NAME_PREFIX` to `NAME_PREFIX`, `SERVER_PASSWORD` to `PASSWORD` and `SERVER_INTENTION` to `INTENTION`.

### Removed
- Remove environment variables: `AUTOCOMPILER_ENABLE`, `CONNECTION_TIMEOUT`, `MODS_ENABLE` and `STEAM_CLOUD_DISABLE`.

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

[next]: https://github.com/dst-academy/server/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/dst-academy/server/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/dst-academy/server/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/dst-academy/server/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/dst-academy/server/compare/da19beb5479033b82dd6dc1200bb0cf6724904c3...v0.1.0
