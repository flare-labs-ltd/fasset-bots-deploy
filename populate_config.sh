#!/usr/bin/env bash

source <(grep -v '^#' "./.env" | sed -E 's|^(.+)=(.*)$|: ${\1=\2}; export \1|g')

ROOT_DIR="$(pwd)"
CHAIN=songbird

echo "{
  \"extends\": \"songbird-bot-postgresql.json\",
  \"ormOptions\": {
    \"type\": \"postgresql\",
    \"host\": \"postgres\",
    \"dbName\": \"${FASSET_DB_NAME}\",
    \"port\": ${FASSET_DB_PORT}
  },
  \"apiNotifierConfigs\": [{
    \"apiKey\": \"$NOTIFIER_API_KEY\",
    \"apiUrl\": \"$MACHINE_ADDRESS:$BACKEND_PORT$BACKEND_PATH\"
  }]
}" > $ROOT_DIR/config.json