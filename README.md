# FAsset Agent Deployment

## Requirements
AMD64 machine.

Docker version 25.0.4 or higher.

Docker Compose version v2.24.7 or higher

Tested on Ubuntu 22.04.4 LTS.

## Prerequisites

- Your agent management address must be whitelisted.
- Procure underlying nodes rpc api keys (DOGE, XRP, BTC).

### Security

Make sure you follow best practices to protect you server and data.

## Install

1. Clone repository.

2. Copy `.env.template` to `.env`.

3. Copy `config.json.template` into `config.json`.

4. Run `docker compose pull`.

## Settings

All settings are in `.env`.

This must be set:
- machine address `MACHINE_ADDRESS`. This is either the IP or domain name of the machine running front and back end. For security reasons, it is recommended to use a local network IP.

Optionaly set these:
- front end port `FRONTEND_PORT`. Default front end port is 3000.
- front end url `FRONTEND_URL`. Default is `/` (example `/agent1`).
- front end password `FRONTEND_PASSWORD`
- back end port `BACKEND_PORT`. Default front end port is 4000.
- back end url `BACKEND_URL`. Default is `/fasset-backend` IMPORTANT this change must also be set in `config.json` `apiNotifierConfigs.apiUrl`.
- database password `FASSET_DB_PASSWORD` IMPORTANT: once database is created the password will not update automatically if changed in `.env` file.

Profiles
- agent
- agent-ui
- liquidator
- challenger

### Generate secrets.json

To generate accounts needed by the bot automatically, run `./generateSecrets.sh <your_agent_address>`.

Copy `secrets.new.json` into `secrets.json` and set file mode to 600 `chmod 600 secrets.json`.
Set file ownership to user 1000 `chown 1000:1000 secrets.json`.

Make backup of the `secrets.json`.

Setup nodes rpc api keys.

### Funding addresses
Fund your management address with native token (e.g. SGB, FLR).

Fund your work address with native token (e.g. SGB, FLR) and vault token (e.g. USDX) (get address from `secrets.json` using key `owner.native.address`).

Fund your underlying address with underlying token (e.g. XRP, BTC) (get addressed from file `secrets.json` key `owner.<token>.address`).


TODO: update setup address for Songbird and Flare

Setup your work address `https://coston-explorer.flare.network/address/0x48985D96B5758285cB2c1A528c02da08BB874651/write-contract#address-tabs`

### Start up

Run `docker compose up -d`.

## Update and restart
```
docker compose down
git pull
docker compose pull
docker compose up -d
```

### Backup

Make sure you backup at least:
- `.env`
- `secrets.json`
- `config.json`
-  database docker volume (default: `fasset-agent_postgres-db`)