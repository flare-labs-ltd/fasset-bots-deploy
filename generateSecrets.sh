#!/bin/bash
docker run --rm -v $PWD/config/secrets.json.template:/usr/src/app/secrets.json.template ghcr.io/flare-labs-ltd/fasset-bots:songbird-release yarn key-gen generateSecrets --agent $1 --merge secrets.json.template --other $2 > secrets.new.json
