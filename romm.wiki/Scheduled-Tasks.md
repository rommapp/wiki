## Scheduled tasksa

Scheduled tasks can be enabled and configured with the following environment variables:

|Variable|Description|Value|
|---|---|:---:|
|ENABLE_SCHEDULED_RESCAN|Enable scheduled rescanning of library|`true`|
|SCHEDULED_RESCAN_CRON|Cron expression for scheduled rescanning|`"0 3 * * *"`|
|ENABLE_SCHEDULED_UPDATE_SWITCH_TITLEDB|Enable scheduled updating of Switch TitleDB index|`true`|
|SCHEDULED_UPDATE_SWITCH_TITLEDB_CRON|Cron expression for scheduled updating of Switch TitleDB|`"0 4 * * *"`|
|ENABLE_SCHEDULED_UPDATE_MAME_XML|Enable scheduled updating of MAME XML index|`true`|
|SCHEDULED_UPDATE_MAME_XML_CRON|Cron expression for scheduled updating of MAME XML|`"0 5 * * *"`|

### Scheduled rescan

Users can opt to enable scheduled rescans, and set the interval using cron notation. Not that the scan will **not completely rescan** every file, only catching those which have been added/updated.

### Switch titleDB update

Support was added for Nintendo Switch ROMs with filenames using the [titleid/programid format][titleid-program-id-url] (e.g. 0100000000010000.xci). If a file under the `switch` folder matches the regex, the scanner will use the index to attempt to match it to a game. If a match is found, the IGDB handler will use the matched name as the search term.

The associated task updates the `/fixtures/switch_titledb.json` file at a regular interval to support new game releases.

### MAME XML update

Support was also added for MAME arcade games with shortcode names (e.g. `actionhw.zip` -> ACTION HOLLYWOOD), and works in the same way as the titleid matcher (without the regex).

The associated task updates the `/fixtures/mame.xml` file at a regular interval to support updates to the library.

## File system watcher

RomM can also monitor the filesystem for events (files created/moved/deleted) and schedules a rescan of the platform (or entire library is a new platform was added).

The watcher can be enabled and configured with the following environment variables:

|Variable|Description|Value|
|---|---|:---:
|ENABLE_RESCAN_ON_FILESYSTEM_CHANGE|Enable rescanning of library when filesystem changes|`true`
|RESCAN_ON_FILESYSTEM_CHANGE_DELAY|Delay in minutes before rescanning library when filesystem changes|`5`|

The watcher will monitor the `/library/roms` folder for changes to the filesystem, such as files being added, moved or deleted. It will ignore certain events (like modifying the file content or metadata), and will skip default OS files (like `.DS_Store` on mac).

When a change is detected, a scan will be scheduled for sometime in the future (default 5 minutes). If other events are triggered between now and the time at which the scan starts, more platforms will be added to the scan list (or the scan may switch to a full scan). This is done to reduce the number of tasks scheduled when many big changes happen to the library (mass upload, new mount, etc.)