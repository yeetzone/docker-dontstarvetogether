# Change Log

## [next]

### Added
- Add `UPDATE_ON_BOOT` variable to configure update-behavior on boot.
- Add `SERVER_NAME_PREFIX` variable to configure a prefix for the server's name.

### Changed
- Generate a random server name if no name was configured.
- Use the Debian base image instead of Ubuntu.

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

[next]: https://github.com/dst-academy/server/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/dst-academy/server/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/dst-academy/server/compare/da19beb5479033b82dd6dc1200bb0cf6724904c3...v0.1.0
