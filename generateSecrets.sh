#!/bin/bash

source <(grep -v '^#' "./.env" | sed -E 's|^(.+)=(.*)$|: ${\1=\2}; export \1|g')

docker run --rm -v $PWD/config/secrets.json.template:/usr/src/app/secrets.json.template ghcr.io/flare-labs-ltd/fasset-bots:latest yarn key-gen generateSecrets --agent $1 --merge secrets.json.template --other $2 > secrets.new.json
sed -i "s|someAp1K3y|${NOTIFIER_API_KEY}|g" secrets.new.json
sed -i "s|\${FRONTEND_PASSWORD}|${FRONTEND_PASSWORD}|g" secrets.new.json
sed -i "s|\${FASSET_DB_USER}|${FASSET_DB_USER}|g" secrets.new.json
sed -i "s|\${FASSET_DB_PASSWORD}|${FASSET_DB_PASSWORD}|g" secrets.new.json
