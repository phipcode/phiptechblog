#!/bin/bash
set -e

if [ -z "$AZP_URL" ] || [ -z "$AZP_TOKEN" ] || [ -z "$AZP_POOL" ]; then
  echo 1>&2 "Missing AZP_URL, AZP_TOKEN or AZP_POOL environment variable"
  exit 1
fi

cleanup() {
  echo "Cleanup. Removing Azure Pipelines agent..."
  ./config.sh remove --unattended --auth pat --token "$AZP_TOKEN"
}
trap 'cleanup; exit 0' SIGINT SIGTERM



AZP_AGENT_NAME=${AZP_AGENT_NAME:-$(hostname)}

echo "1. Configuring agent..."
./config.sh --unattended \
  --url "$AZP_URL" \
  --auth pat \
  --token "$AZP_TOKEN" \
  --pool "$AZP_POOL" \
  --agent "$AZP_AGENT_NAME" \
  --acceptTeeEula \
  --replace


echo "2. Running agent..."
./run.sh
