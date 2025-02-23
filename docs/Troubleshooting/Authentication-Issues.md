---
title: Troubleshooting Authentication
description: Troubleshooting issues relating to authentication
---

### Error: `403 Forbidden`

When authentication is enabled, most endpoints will return a `403 Forbidden` response if you're not authenticated, or if your sessions is in a broken state. The session key can be reset by [clearing your cookies](https://support.google.com/accounts/answer/32050).

CSRF protection is also enabled, which helps to mitigates [CSRF attacks](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html) (useful if your instance is public). If you encounter a `Forbidden (403) CSRF verification failed` error, simply reloading your browser should force it to fetch a fresh CSRF cookie.

### Error: `Unable to login: CSRF token verification failed`

This error is known to happen on Chrome, but could happen in other browsers; manually clear your cookies (specifically one called `csrftoken`) and hard reload your browser window (CMD+SHIFT+R on macOS, CTRL+F5 on Windows).

### Error: `400 Bad Request` on the Websocket endpoint

If you're running RomM behind a reverse-proxy (Caddy, Nginx, etc.), ensure that Websockets are supported and enabled. This may vary depending on the reverse proxy solution being used. In the case of Nginx Proxy Manager, enable the "Websockets Support" toggle when editing the proxy host.
