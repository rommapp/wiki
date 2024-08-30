## ⚠️ Support for webRcade will be removed in version 3.0 in favor the built-in [EmulatorJS player](https://github.com/zurdi15/romm/wiki/EmulatorJS-Player) ⚠️

[WebRcade](https://github.com/webrcade/webrcade) is a platform that enables playing games entirely within the context of the browser across a [wide variety of platforms](https://docs.webrcade.com/platforms/), with support for game pads (Bluetooth and USB) for both front-end navigation and in-game.

RomM exposes an API endpoint that serves a compatible JSON feed of supported platforms and games. Since webRcade runs within the context of your browser, you RomM instances _does not_ need to be exposed to the web. Further documentation can be found in the [User Guide](https://docs.webrcade.com/userguide/).

**IMPORTANT: You must set the `ROMM_HOST` environment variable to your host ip or domain name (including http(s)://, subdomain and port if needed).**

**IMPORTANT: Due to limitations with webRcade, RomM authentication must be DISABLED for the integration to work.**


### Some notes and limitations before starting

* Save & state files cannot be exported from webRcade
* The JSON feed does not currently support [BIOS files](https://docs.webrcade.com/apps/emulators/psx/#bios-files)
* [Local feeds](#customizing-the-feed) will not stay up-to-date with your RomM library
* A bug in the latest release causes the game covers not to load if RomM is not accessible to the internet

### Loading the RomM feed

Head to the [main page](https://play.webrcade.com/) and after hovering over "Categories" click "Show Feeds". Hit the "Add Feed" button at the bottom, select "URL" and paste the following URL, replacing `host` with the URL of your RomM instance: `https://<host>/api/platforms/webrcade/feed`.

|Home page|Feeds|Feed URL|
|---|---|---|
|<img width="1511" alt="Screenshot 2023-12-27 at 11 24 26 PM" src="https://github.com/zurdi15/romm/assets/3247106/29274192-29e3-485d-a5b7-5cdb689c13d9">|<img width="1507" alt="Screenshot 2023-12-27 at 11 24 41 PM" src="https://github.com/zurdi15/romm/assets/3247106/f42658ab-da29-4c00-ba5e-faec99ee1a16">|<img width="624" alt="Screenshot 2023-12-27 at 11 25 01 PM" src="https://github.com/zurdi15/romm/assets/3247106/5438387d-a1f1-4fa6-b7fa-26b623b85c13">|

At this point webRcade should automatically load your library; if it doesn't, head back to the Feeds list, select "RomM Feed" at the bottom and click "Load".

### Customizing the feed

WebRcade also boasts an [editor](https://editor.webrcade.com/) that can identify supported games and download custom assets. You can leverage this editor to enhance your RomM feed by loading content served by the API and saving the modified feed locally. In the editor, click "Import", paste the RomM feed URL (as above) and hit "Ok". The page should refresh with the contents of the RomM feed.

|Editor|Import|
|---|---|
|<img width="1507" alt="Screenshot 2023-12-27 at 11 23 56 PM" src="https://github.com/zurdi15/romm/assets/3247106/261b1d2a-c6f9-41e3-ac97-8139a1f43ad6">|<img width="617" alt="Screenshot 2023-12-27 at 10 39 24 PM" src="https://github.com/zurdi15/romm/assets/3247106/c0a3df8b-b76f-4151-a7cf-910011bb98ca">|

Now select one of the platforms (or all of them) and, under the 3-dot menu, hit "Analyze". A window will appear displaying the progress of the analysis; webRcade is fetching assets from [webrcade-assets](https://github.com/webrcade-assets).

|Analyze|Progress|
|---|---|
|<img width="1293" alt="Screenshot 2023-12-27 at 11 27 11 PM" src="https://github.com/zurdi15/romm/assets/3247106/af0d4380-56c4-41a6-bdb4-1847957c1bf8">|<img width="255" alt="Screenshot 2023-12-27 at 11 27 34 PM" src="https://github.com/zurdi15/romm/assets/3247106/26e6ef93-37aa-491a-bc2e-6879720a13ad">|

When you've finished analyzing your library (and making any edits), hit "Save" in the sidebar. A local feed will then be created and stored in the browser's cache, which you can export with the "Export" option in the sidebar. Back in the [main window](https://play.webrcade.com), the local should now appear in your Feed list.

### Screenshot

<img width="1509" alt="Screenshot 2023-12-27 at 11 28 14 PM" src="https://github.com/zurdi15/romm/assets/3247106/f10adeca-031e-4279-823a-08e1879d7256">