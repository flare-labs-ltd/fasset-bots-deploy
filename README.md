# FASSET Bot Deploy

IMPORTANT: docker image for fasset-bots must be currently created manually. 

## Requirements
Docker version 25.0.4 or higher.

Docker Compose version v2.24.7 or higher

Tested on Ubuntu 22.04.4 LTS.

## Install

1. Clone repository.

2. Copy `.env.template` to `.env`. 

3. Copy `config.json.template` into `config.json`.

4. Run `docker compose pull`.

## Settings

Settings are in `.env`.

This must be set:
- machine address `MACHINE_NAME`

Optionaly set these:
- front end port `AGENT_UI_PORT`
- back end port `BACKEND_PORT`
- database password `FASSET_DB_PASSWORD` IMPORTANT: once database is created the password will not changed automatically by chainging it in `.env` file.

Profiles
- agent
- agent-ui
- liquidator

### Generate secrets.json

Run `./generateSecrets <your_agent_address>`.

Copy `secrets.new.json` into `secrets.json` and set file mode to 600 (`chmod 600 secrets.json`).

Make backup of the `secrets.json`.

### NGINX

Settings for nginx are:
```
        location /fasset-backend {
           rewrite /fasset-backend/(.*) /api/$1  break;
           proxy_set_header Host $http_host;
           proxy_pass         http://localhost:11234; # use BACKEND_PORT
        }

        location / {
           proxy_set_header Host $http_host;
           proxy_pass         http://localhost:3000; # use AGENT_UI_PORT
        }
```

### Start up

Run `docker compose up -d`.


## Update and restart
```
docker compose down
docker compose pull
docker compose up -d
```


