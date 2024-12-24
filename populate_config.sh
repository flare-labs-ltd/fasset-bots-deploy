#!/usr/bin/env bash

source <(grep -v '^#' "./.env" | sed -E 's|^(.+)=(.*)$|: ${\1=\2}; export \1|g')

ROOT_DIR="$(pwd)"

if [ -f $ROOT_DIR/config.json ]; then
  echo "config.json already exists. Delete manually if you know what you're doing."
  exit 0
fi

echo "{
  \"extends\": \"${CHAIN}-bot-postgresql.json\",
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