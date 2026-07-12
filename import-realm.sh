#!/bin/bash
set -e

echo "=== Loading environment variables from .env ==="

# Load .env from the project root
if [ -f /opt/keycloak/.env ]; then
  set -a
  source /opt/keycloak/.env
  set +a
  echo "✅ Loaded .env successfully"
else
  echo "⚠️  Warning: .env not found at /opt/keycloak/.env"
fi

echo "=== Importing realm configuration ==="
/opt/keycloak/bin/kc.sh import --dir /opt/keycloak/data/import --override true

echo "=== Starting Keycloak server ==="
/opt/keycloak/bin/kc.sh start-dev --import-realm