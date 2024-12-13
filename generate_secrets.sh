#!/usr/bin/env bash

source <(grep -v '^#' "./.env" | sed -E 's|^(.+)=(.*)$|: ${\1=\2}; export \1|g')

docker run --rm \
    -v $PWD/config/secrets.json.template:/usr/src/app/secrets.json.template \
        ghcr.io/flare-labs-ltd/fasset-bots:songbird-release yarn key-gen generateSecrets \
    --agent $1 --other $2 --merge secrets.json.template -c './packages/fasset-bots-core/run-config/songbird-bot.json' > secrets.new.json
sed -i "s|\${NOTIFIER_API_KEY}|${NOTIFIER_API_KEY}|g" secrets.new.json
sed -i "s|\${FRONTEND_PASSWORD}|${FRONTEND_PASSWORD}|g" secrets.new.json
sed -i "s|\${FASSET_DB_USER}|${FASSET_DB_USER}|g" secrets.new.json
sed -i "s|\${FASSET_DB_PASSWORD}|${FASSET_DB_PASSWORD}|g" secrets.new.json
