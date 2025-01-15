#!/usr/bin/env bash

echo $(docker-compose --profile cli run -T --entrypoint sh agent-bot \
    -c "yarn agent-bot listAgents -f FXRP -c ./config.json -s ./secrets.json")