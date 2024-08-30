## Video tutorial

[AlienTech42](https://www.youtube.com/@AlienTech42) has published [a great video](https://www.youtube.com/watch?v=ls5YcsFdwLQ) on installing and running RomM on Unraid. Check it out!

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/ls5YcsFdwLQ/0.jpg)](https://www.youtube.com/watch?v=ls5YcsFdwLQ)


## Prerequisites

Before getting started, install the [Community Apps plugin](https://forums.unraid.net/topic/38582-plug-in-community-applications/) for Unraid.

If you're planning to use MariaDB as your database, install it from the plugin registry. Both the [official](https://hub.docker.com/_/mariadb) and [linuxserver](https://github.com/linuxserver/docker-mariadb/pkgs/container/mariadb) versions are supported.

|Official|Linuxserver|
|---|---|
|<img width="658" alt="Screenshot 2023-08-07 at 12 38 48 PM" src="https://github.com/rommapp/romm/assets/3247106/27b8ec77-413b-45e2-89f9-9d1984cef7f6">|<img width="658" alt="Screenshot 2023-08-07 at 12 38 44 PM" src="https://github.com/rommapp/romm/assets/3247106/45cabc99-8fbc-458c-8579-ef39b1cf498b">|

## Installation

From the Unraid dashboard, click `APPS` in the navbar. In the search bar, search for `rommapp romm`; no results will appear, but that's normal. On the right side of the screen, click `Click Here To Get More Results From DockerHub`.

![258859203-2582da70-dcae-4505-8463-23f8f2e6c64b](https://github.com/rommapp/romm/assets/3247106/cd7c3eb0-2b12-4836-94e7-f485c64e51a4)

One of the first results should be `romm` by `rommapp`. Once you find it, click `Install`.

![258859891-6efb8696-d5d7-45dd-b1b3-d6365ee4ff07](https://github.com/rommapp/romm/assets/3247106/29c56fa4-a923-40e4-951a-0348f8551c86)

If a confirmation window appears, click `YES` and CA will attempt to determine paths, ports and variables from the template.

![258860339-5fc2c451-bfa9-4871-8bee-b04a72d602ca](https://github.com/rommapp/romm/assets/3247106/826890e1-4727-4638-acfd-b124806c5be5)

Once the installation finishes, the configuration page will appear and should look something like this:

![258861319-88c331d0-4586-444e-b922-d2465fd14c96](https://github.com/rommapp/romm/assets/3247106/4898e62c-6f76-43cf-a516-eed4d13ba46b)


## Configuration

Configure the required environment variables, ports and paths as per the [example docker-compose.yml](https://github.com/rommapp/romm/blob/release/examples/docker-compose.example.yml) file.

![258862729-c0e0ae7e-c3e2-46c8-91f8-2c5ca2a1039e](https://github.com/rommapp/romm/assets/3247106/427d9f98-ea34-4bf4-9acf-ee1a57c8a91d)

### MariaDB

To use the MariaDB container setup in #prerequisites, add config options for the environment variables. Descriptions of the config options and sensible defaults are listed in the [example docker-compose.yml](https://github.com/rommapp/romm/blob/release/examples/docker-compose.example.yml) file.

- DB_HOST
- DB_PORT
- DB_USER
- DB_NAME
- DB_PASSWD

## Troubleshooting

[Open an issue](https://github.com/rommapp/romm/issues) if you're having trouble getting RomM to run. State that you're trying to run RomM in Unraid, be specific about the issue, and append screenshots of your configuration.

### Updating

To update to the latest version, select `force update` from the container list. **It's strongly recommended to backup the `appdata` folder (or mount it in a safe location) before updating, since tearing down the container will wipe the resources (covers, screenshots, etc.)

## Shoutouts

We want to give a special shoutout to @Smurre95 and @sfumat0 for their help documenting this process, and working towards getting RomM listed in CA. 🤝 