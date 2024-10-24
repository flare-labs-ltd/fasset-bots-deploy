#!/bin/bash
docker run --rm fasset-bots yarn key-gen generateSecrets --agent $1 --other $2 > secrets.new.json
