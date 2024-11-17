This is a complete list of available environment variables; required variables are marked with a `✓`.

|Variable|Description|Required|Default|
|---|---|:---:|---|
|IGDB_CLIENT_ID|Client ID for IGDB API|||
|IGDB_CLIENT_SECRET|Client secret for IGDB API|||
|MOBYGAMES_API_KEY|Mobygames secret API key|||
|STEAMGRIDDB_API_KEY|SteamGridDB secret API key|||
|DB_HOST|Host name of MariaDB instance|✓|`localhost`|
|DB_PORT|Port number of MariaDB instance||`3306`|
|DB_NAME|Should match MYSQL_DATABASE in mariadb||`romm`|
|DB_USER|Should match MYSQL_USER in mariadb|✓||
|DB_PASSWD|Should match MYSQL_PASSWORD in mariadb|✓||
|ROMM_AUTH_SECRET_KEY|Generate a key with `openssl rand -hex 32`|✓||
|ROMM_HOST|Host name of ROMM instance||`localhost`|
|DISABLE_CSRF_PROTECTION|Disables [CSRF protection](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) (not recommended)||`false`|
|DISABLE_DOWNLOAD_ENDPOINT_AUTH|Disable auth on download endpoint (WebRcade, Tinfoil)||`false`|
|SCAN_TIMEOUT|Timeout for the background scan/rescan tasks (in seconds)||`14400`|
|ENABLE_RESCAN_ON_FILESYSTEM_CHANGE|Enable rescanning of library when filesystem changes||`false`|
|RESCAN_ON_FILESYSTEM_CHANGE_DELAY|Delay in minutes before rescanning library when filesystem changes||`5`|
|ENABLE_SCHEDULED_RESCAN|Enable scheduled rescanning of library||`false`|
|SCHEDULED_RESCAN_CRON|Cron expression for scheduled rescanning||`"0 3 * * *"`|
|ENABLE_SCHEDULED_UPDATE_SWITCH_TITLEDB|Enable scheduled updating of Switch TitleDB index||`false`|
|SCHEDULED_UPDATE_SWITCH_TITLEDB_CRON|Cron expression for scheduled updating of Switch TitleDB||`"0 4 * * *"`|
|ENABLE_SCHEDULED_UPDATE_MAME_XML|Enable scheduled updating of MAME XML index||`false`|
|SCHEDULED_UPDATE_MAME_XML_CRON|Cron expression for scheduled updating of MAME XML||`"0 5 * * *"`|
|DISABLE_EMULATOR_JS|Disables playing in browser with [EmulatorJS](https://github.com/rommapp/romm/wiki/EmulatorJS-Player)||`false`|
|DISABLE_RUFFLE_RS|Disables playing flash games with [RuffleRS](https://github.com/rommapp/romm/wiki/RuffleRS-Player)||`false`|
|TZ|Sets the timezone||`UTC`|
