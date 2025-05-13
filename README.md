# FAsset Agent Deployment

## Repository Transferred

The development of FAsset protocol was commissioned for and on behalf of the Flare Foundation, accordingly all completed repos for the protocol have been moved to [Flare Foundation Github](https://github.com/flare-foundation), the protocol's ultimate owner.
[New repository](https://github.com/flare-foundation/fasset-bots-deploy)

## Requirements
AMD64 machine.

Docker version 25.0.4 or higher.

Docker Compose version v2.24.7 or higher

Tested on Ubuntu 22.04.4 LTS.

## Prerequisites

- Your agent management address must be whitelisted.
- Procure underlying nodes rpc api keys (XRP, DOGE, BTC).

### Security

Make sure you follow best practices to protect your server and data.

## Install

1. Clone repository.

2. Copy `.env.template` to `.env`.

3. Run `docker compose pull`.

## Settings

All settings are in `.env.template`.

This must be set:
- machine address `MACHINE_ADDRESS`. This is either the IP or domain name of the machine running front and back end.
For security reasons, it is recommended to use a local network IP or configure firewall so that `MACHINE_ADDRESS` can be access only from your IP.

Profiles
- agent
- agent-ui
- liquidator
- challenger

### Generate secrets.json

To generate accounts needed by the bot automatically, choose a secure agent management EVM address and write it under `AGENT_MANAGEMENT_ADDRESS` inside `.env` file, then run `bash populate_config.sh`.

Set file mode to 600 `chmod 600 secrets.json` and file ownership to user 1000 `chown 1000:1000 secrets.json`.

Make backup of the `secrets.json`.

Make sure to setup rpc/DAL/FDC api keys.

### Generate / update configuration

To generate or update configuration after `.env` file change, run
```
bash populate_config.sh
```

### Funding addresses

Fund your management address with native token (e.g. SGB, FLR).

Fund your work address with native token (e.g. SGB, FLR) and vault token (e.g. USDX) (get address from `secrets.json` using key `owner.native.address`).

Fund your underlying address with underlying token (e.g. XRP, BTC) (get addressed from file `secrets.json` key `owner.<token>.address`).

Setup your work address:
- on [Songbird](https://songbird-explorer.flare.network/address/0xa7f5d3C81f55f2b072FB62a0D4A03317BFd1a3c0/write-contract#address-tabs).

### Start up

Run `docker compose up -d`.

## Update and restart
```
docker compose down
git pull
docker compose pull
docker compose up -d
```

### Execute Agent Bot Commands

To execute agent bot commands, use the `cli` profile and `agent-bot` Docker container.
For example to get agents running use this command:

```bash
docker compose --profile cli run agent-bot listAgents --fasset FASSET
```

### Execute User Bot Commands

To execute user bot commands use the `cli` profile and `user-bot` Docker container.
For example to the FAsset system info use this command:

```bash
docker compose --profile cli run user-bot info --fasset FASSET
```

### Backup

Make sure you backup at least:
- `.env`
- `secrets.json`
- `config.json`
-  database docker volume (default: `fasset-agent_postgres-db`)