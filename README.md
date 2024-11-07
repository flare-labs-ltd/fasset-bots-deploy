# FASSET Bot Deploy

## Requirements
Docker version 25.0.4 or higher.

Docker Compose version v2.24.7 or higher

Tested on Ubuntu 22.04.4 LTS.

Your agent management address must be whitelisted.

## Install

1. Clone repository.

2. Copy `.env.template` to `.env`. 

3. Copy `config.json.template` into `config.json`.

4. Run `docker compose pull`.

## Settings

All settings are in `.env`.

This must be set:
- machine address `MACHINE_ADDRESS`

Optionaly set these:
- front end port `FRONTEND_PORT`. Default front end port is 3000.
- front end url `FRONTEND_URL`. Default is `/` (example `/agent1`).
- front end password `FRONTEND_PASSWORD`
- back end port `BACKEND_PORT`. Default front end port is 4000.
- back end url `BACKEND_URL`. Default is `/fasset-backend`.
- database password `FASSET_DB_PASSWORD` IMPORTANT: once database is created the password will not changed automatically by chainging it in `.env` file.

Profiles
- agent
- agent-ui
- liquidator

### Generate secrets.json

Run `./generateSecrets <your_agent_address>`.

Copy `secrets.new.json` into `secrets.json` and set file mode to 600 (`chmod 600 secrets.json`).

Make backup of the `secrets.json`.

Fund your management address with native token (e.g. CFLR, SGB, FLR).

Fund your work address with native (e.g. CFLR, SGB, FLR) and vault token (e.g. testETH, testUSDT, ETH, USDT) (@secrets.json `owner.native.address`).

Fund your underlying address with underlying token (e.g. testXRP, testBTC, XRP, BTC) (e.g. @secrets.json `owner.testXRP.address`).)

Setup your work address `https://coston-explorer.flare.network/address/0x090a3E40E9E1e0Acfc5D78Ed201Ef25Deb3aB8C1/write-contract#address-tabs`

### NGINX

Default settings for nginx are:
```
        location /fasset-backend { # use BACKEND_URL
           rewrite /fasset-backend/(.*) /api/$1  break;
           proxy_set_header Host $http_host;
           proxy_pass         http://localhost:4000; # use BACKEND_PORT
        }

        location / { # use FRONTEND_URL
           proxy_set_header Host $http_host;
           proxy_pass         http://localhost:3000; # use FRONTEND_PORT
        }
```

### Start up

Run `docker compose up -d`.


### Test

Best way to test if back end is working is to check whitelisted address:
$API_URL/agent/whitelisted


## Update and restart
```
docker compose down
git pull
docker compose pull
docker compose up -d
```


