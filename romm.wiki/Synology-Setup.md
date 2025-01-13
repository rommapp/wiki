# Synology Setup Guide

## Prerequisites
This guide assumes you're familiar with Docker and have basic knowledge of server management. You'll need:
- A Synology NAS or similar server
- Docker installed
- Basic command line knowledge
- Access to manage network settings

## Setup Process

### 1. Folder Structure Setup

#### ROM Storage Folders

Create the following directory structure for game assets and configuration:

```bash
mkdir -p /volume1/data/media/games/assets
mkdir -p /volume1/data/media/games/config
```

#### ROM Library Structure

RomM requires a **very specific folder structure** for rom files:

```bash
mkdir -p /volume1/data/media/games/library/roms
mkdir -p /volume1/data/media/games/library/bios
```

Note: For supported platforms and their specific folder names, refer to the [official RomM wiki](https://github.com/rommapp/romm/wiki/Supported-Platforms).

#### Docker Data Folders

Create these folders for project and container data:

```bash
mkdir -p /volume1/docker/romm-project/
mkdir -p /volume1/docker/romm/resources
mkdir -p /volume1/docker/romm/redis-data
mkdir -p /volume1/docker/mariadb-romm
```

### 2. Network Bridge Setup

Create a new network bridge named `rommbridge` following standard Docker networking practices. You can use [Dr. Frankensteins' guide](https://drfrankenstein.co.uk/step-3-setting-up-a-docker-bridge-network-in-container-manager/) for reference.

### 3. Key Generation

#### Authentication Key

Generate your authentication key using:

```bash
openssl rand -hex 32
> 03a054b6ca27e0107c5eed552ea66bacd9f3a2a8a91e7595cd462a593f9ecd09
```
Save the output - you'll need it for the `ROMM_AUTH_SECRET_KEY` in your configuration.

#### API Integration Setup

RomM currecntly supports 3 metadata sources: IGDB, MobyGames and SteamGridDB. Follow the dedicated wiki page for  [API key generation](Generate-Api-Keys.md) to set up your API keys. We recommend setting up IGDG at the minimum.

### 4. MariaDB Configuration

#### Important Notes

- This guide uses a dedicated MariaDB container for RomM, but you can use an existing MariaDB instance if preferred
- We're using MariaDB version 10.7 for compatibility
- The container uses port 3306 internally, mapped to 3309 externally
- A simplified health check is implemented for stability

### 5. Docker Compose Configuration

Create a `docker-compose.yml` file with the following content:

```yaml
services:
  romm:
    image: rommapp/romm:latest
    container_name: romm
    restart: unless-stopped
    environment:
      - PUID=1234 #CHANGE_TO_YOUR_UID
      - PGID=12345 #CHANGE_TO_YOUR_GID
      - TZ=US/New_York #CHANGE_TO_YOUR_TZ
      - DB_HOST=mariadb-romm
      - DB_NAME=romm
      - DB_ROOT_PASSWORD=DB_ROOT_PASSWORD
      - DB_USER=romm-user
      - DB_PASSWD=DB_PASSWD
      - DB_PORT=3306
      - ROMM_AUTH_SECRET_KEY= # Add your generated key
      - IGDB_CLIENT_ID= # Add your IGDB ID
      - IGDB_CLIENT_SECRET= # Add your IGDB secret
    volumes:
      - /volume1/docker/romm/resources:/romm/resources
      - /volume1/docker/romm/redis-data:/redis-data
      - /volume1/data/media/games/library:/romm/library
      - /volume1/data/media/games/assets:/romm/assets
      - /volume1/data/media/games/config:/romm/config
    ports:
      - 7676:8080/tcp
    network_mode: rommbridge
    depends_on:
      mariadb-romm:
        condition: service_healthy

  mariadb-romm:
    image: mariadb:10.7
    container_name: mariadb-romm
    restart: unless-stopped
    environment:
      - MARIADB_ROOT_PASSWORD=MARIADB_ROOT_PASSWORD
      - PUID=1234 #CHANGE_TO_YOUR_UID
      - PGID=12345 #CHANGE_TO_YOUR_GID
      - TZ=US/New_York #CHANGE_TO_YOUR_TZ
      - MARIADB_DATABASE=romm
      - MARIADB_USER=romm-user
      - MARIADB_PASSWORD=MARIADB_PASSWORD
    ports:
      - "3309:3306"
    network_mode: rommbridge
    volumes:
      - /volume1/docker/mariadb-romm:/var/lib/mysql
    healthcheck:
      test: ["CMD", "healthcheck.sh", "--su-mysql", "--connect"]
      timeout: 20s
      retries: 10
      start_period: 30s
      interval: 10s
```

### 6. Initial Launch

1. Start the containers using Docker Compose
2. **Be patient!** The container can take a few minutes to setup on first launch
3. Monitor progress through container logs
4. Access RomM through your browser at `http://your-server-ip:7676`

## Important Notes

- Replace placeholder values (UIDs, GIDs, passwords, API keys) with your own
- Ensure proper permissions on all created directories
- Back up your configuration after successful setup
- Monitor logs during initial startup for any errors

## Troubleshooting

- If the web interface shows "page not found," wait for initial setup to complete
- For database connection issues, verify MariaDB container health status
- Check logs for both containers if experiencing issues
- Ensure all volumes are properly mounted with correct permissions

## Contributing

This guide is an abbridged version of ChopFoo's original guide. If you have any suggestions or improvements, please submit a pull request to the [RomM wiki](https://github.com/rommapp/wiki).
