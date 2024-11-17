## IGDB

To access the IGDB API you'll need a Twitch account and a valid phone number for 2FA verification. Up-to-date instructions are available in the [IGDB API documentation](https://api-docs.igdb.com/#account-creation). When registering your application in the Twitch Developer Portal, fill out the form like so:

* Name: Something **unique or random** like `correct-horse-battery-staple` or `KVV8NDXMSRFJ2MRNPNRSL7GQT`
* OAuth Redirect URLs: `localhost`
* Category: `Application Integration`
* Client Type: `Confidential`

> [!IMPORTANT]  
> **The name you pick has to be unique! Picking an existing name will fail silently, with no error messages. We recommend using `romm-<random hash>`, like `romm-3fca6fd7f94dea4a05d029f654c0c44b`**

Note the client ID and secret that appear on screen, and use them to set `IGDB_CLIENT_ID` and `IGDB_CLIENT_SECRET` in your environment variables.

|![IGDB_Creation](https://github.com/rommapp/romm/assets/3247106/7a93bf68-f6d9-46a5-ab72-719f2d5ec9d3)|![IGDB_Secret](https://github.com/rommapp/romm/assets/3247106/7a9dc056-52be-41c4-aec5-e2758aa520b5)|
|---|---|

## Mobygames

To access the Mobygames API, [create a MobyGames account](https://www.mobygames.com/user/register/) and then visit your profile page. Click the 'API' link under your user name to sign up for an API key. Copy the key shown and use it to set `MOBYGAMES_API_KEY`.

> [!IMPORTANT]  
> **MobyGames API became a [paid feature](https://www.mobygames.com/info/api/#non-commercial). Any existing key can be used as usual, but any new API key created will be under a paywall**

## SteamGridDB

To access steamGridDB API, you need to login into their [website](https://www.steamgriddb.com/) with a [steam account](https://store.steampowered.com/join). Once logged in, go to your [API tab under the preferences page](https://www.steamgriddb.com/profile/preferences/api). Copy the key shown and use it to set `STEAMGRIDDB_API_KEY`.
