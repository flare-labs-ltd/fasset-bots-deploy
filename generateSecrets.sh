#!/bin/bash
docker run --rm -v ($pwd)/secrets.json.template:/usr/src/app/secrets.json.template fasset-bots yarn key-gen generateSecrets --agent $1 --merge secrets.json.template --other $2 > secrets.new.json
