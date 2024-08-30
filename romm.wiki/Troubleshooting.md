## Scanning

### Scan is skipping all platforms/ends instantly

There are a few common reasons why a scan may end instantly/without scanning platforms

* Badly mounted library: verify that you mounted your roms folder at `/romm/library`
* Incorrect permissions: the app needs to read the files and folders in your library, check their permissions with `ls -lh`
* Invalid folder structure: verify that your folder structure matches the one in the [README](https://github.com/zurdi15/romm#-folder-structure)

### Roms not found for platform X, check romm folder structure

This is the same issue as the one above, and can be quickly solved by verifying your folder structure. RomM expects a library with a folder named `roms` in it, for example:
- `/server/media/library:/romm/library`
- `/server/media/games/roms:/romm/library/roms`

### Scan does not recognize a platform

When scanning the folders mounted in `/library/roms`, the scanner tries to match the folder name with the platform's slug in IGDB. If you notice that the scanner isn't detecting a platform, verify that the folder name matches the slug in the url of the [platform in IGDB](https://www.igdb.com/platforms). For example, the Nintendo 64DD has the URL https://www.igdb.com/platforms/nintendo-64dd, so the folder should be named `nintendo-64dd`.

### Scan times out after ~4 hours

The background scan task times out after 4 hours, which can happen if you have a very large library. The easiest work around is to keep running scans every 4 hours, **without** checking the "Complete rescan" option.

## Authentication

### Error: `403 Forbidden` 

When authentication is enabled, most endpoints will return a `403 Forbidden` response if you're not authenticated, or if your sessions is in a broken state. The session key can be reset by [clearing your cookies](https://support.google.com/accounts/answer/32050).

CSRF protection is also enabled, which helps to mitigates [CSRF attacks](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) (useful if your instance is public). If you encounter a `Forbidden (403) CSRF verification failed` error, simply reloading your browser should force it to fetch a fresh CSRF cookie.

### Error: `Unable to login: CSRF token verification failed`

This error is known to happen on Chrome, but could happen in other browsers; manually clear your cookies (specifically one called `csrftoken`) and hard reload your browser window (CMD+SHIFT+R on macOS, CTRL+F5 on Windows).

### Error: `400 Bad Request` on the Websocket endpoint

If you're running RomM behind a reverse-proxy (Caddy, NGINX, etc.), ensure that websockets are supported and enabled. This may vary depending on the reverse proxy solution being used. In the case of Nginx Proxy Manager, enable the "Websockets Support" toggle when editing the proxy host.

## Miscellaneous

### Restarting the container when using SQLite drops all the data/requires a full re-scan

Verify that the database is mapped to a persistent storage volume in your docker compose or Unraid template.

```
    "/path/to/database:/romm/database" # [Optional] Only needed if ROMM_DB_DRIVER=sqlite or not set
```

### Error: `Could not get twitch auth token: check client_id and client_secret`

This is likely due to misconfigured environment variables; verify that `CLIENT_ID` and `CLIENT_SECRET` are set correctly, and that both match the values in IGDB.
