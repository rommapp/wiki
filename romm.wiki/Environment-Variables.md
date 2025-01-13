This is a complete list of available environment variables; required variables are marked with a `✓`.

## Application settings

|Variable|Description|Required|Default|
|---|---|:---:|---|
|ROMM_AUTH_SECRET_KEY|Generate a key with `openssl rand -hex 32`|✓||
|DISABLE_CSRF_PROTECTION|Disables [CSRF protection](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) (not recommended)||`false`|
|DISABLE_DOWNLOAD_ENDPOINT_AUTH|Disable auth on download endpoint (WebRcade, Tinfoil)||`false`|
|DISABLE_USERPASS_LOGIN|Disables login with username and password (when using OIDC)||`false`|
|UPLOAD_TIMEOUT|Timeout for file uploads (in seconds)||`600`|
|SCAN_TIMEOUT|Timeout for the background scan/rescan tasks (in seconds)||`14400`|
|DISABLE_EMULATOR_JS|Disables playing in browser with [EmulatorJS](https://github.com/rommapp/romm/wiki/EmulatorJS-Player)||`false`|
|DISABLE_RUFFLE_RS|Disables playing flash games with [RuffleRS](https://github.com/rommapp/romm/wiki/RuffleRS-Player)||`false`|
|TZ|Sets the timezone||`UTC`|
|GUNICORN_WORKERS|Number of processes running the app||`2`|
|ROMM_BASE_PATH|Base folder path for library, resources and assets||`/romm`|
|LOGLEVEL|Logging level for the app||`INFO`|
|FORCE_COLOR|Forces color output||`false`|
|NO_COLOR|Disables color output||`false`|

## Dependencies

|Variable|Description|Required|Default|
|---|---|:---:|---|
|DB_HOST|Host name of database instance|✓|`127.0.0.1`|
|DB_PORT|Port number of database instance||`3306`|
|DB_NAME|Should match MYSQL_DATABASE in mariadb||`romm`|
|DB_USER|Database username (in MariaDB, should match MARIADB_USER)|✓||
|DB_PASSWD|Database password (in MariaDB, should match MARIADB_PASSWORD)|✓||
|ROMM_DB_DRIVER|Database driver to use (options: `mariadb`, `mysql`, `postgres`)||`mariadb`|
|REDIS_HOST|Host name of Redis/Valkey instance||`127.0.0.1`|
|REDIS_PORT|Port number of Redis/Valkey instance||`6379`|
|REDIS_USERNAME|Username for Redis/Valkey instance|||
|REDIS_PASSWORD|Password for Redis/Valkey instance|||
|REDIS_DB|Database number for Redis/Valkey instance||`0`|
|REDIS_SSL|Enable SSL for Redis instance||`false`|
|SENTRY_DSN|DSN for Sentry error tracking|||

## Metadata providers

|Variable|Description|Required|Default|
|---|---|:---:|---|
|IGDB_CLIENT_ID|Client ID for IGDB API|||
|IGDB_CLIENT_SECRET|Client secret for IGDB API|||
|MOBYGAMES_API_KEY|Mobygames secret API key|||
|STEAMGRIDDB_API_KEY|SteamGridDB secret API key|||

## Authentication

|Variable|Description|Required|Default|
|---|---|:---:|---|
|OIDC_ENABLED|Enable OpenID Connect (OIDC) authentication||`false`|
|OIDC_PROVIDER|Name of the OIDC provider in use|||
|OIDC_CLIENT_ID|Client ID for OIDC authentication|||
|OIDC_CLIENT_SECRET|Client secret for OIDC authentication|||
|OIDC_REDIRECT_URI|Absolute redirect URI for OIDC authentication|||
|OIDC_SERVER_APPLICATION_URL|Absolute URL of the OIDC server application|||
|OIDC_TLS_CACERTFILE|Path to a file containing trusted CA certificates|||

## Background tasks

|Variable|Description|Required|Default|
|---|---|:---:|---|
|ENABLE_RESCAN_ON_FILESYSTEM_CHANGE|Enable rescanning of library when filesystem changes||`false`|
|RESCAN_ON_FILESYSTEM_CHANGE_DELAY|Delay in minutes before rescanning library when filesystem changes||`5`|
|ENABLE_SCHEDULED_RESCAN|Enable scheduled rescanning of library||`false`|
|SCHEDULED_RESCAN_CRON|Cron expression for scheduled rescanning||`"0 3 * * *"`|
|ENABLE_SCHEDULED_UPDATE_SWITCH_TITLEDB|Enable scheduled updating of Switch TitleDB index||`false`|
|SCHEDULED_UPDATE_SWITCH_TITLEDB_CRON|Cron expression for scheduled updating of Switch TitleDB||`"0 4 * * *"`|


> [!TIP]
> You can also set environment variables with a `_FILE` suffix, which will load the contents of the file specified in the variable into the variable without the suffix. For example, setting `ROMM_AUTH_SECRET_KEY_FILE=/run/secrets/romm_auth_secret_key` and creating a file with the secret key at the specified path will set `ROMM_AUTH_SECRET_KEY` to the contents of the file. [Learn more.](https://docs.docker.com/compose/how-tos/use-secrets/)
