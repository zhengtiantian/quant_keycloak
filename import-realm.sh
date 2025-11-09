#!/bin/bash
set -e

echo "=== Importing realm configuration ==="
/opt/keycloak/bin/kc.sh import --dir /opt/keycloak/data/import --override true

echo "=== Starting Keycloak server ==="
/opt/keycloak/bin/kc.sh start-dev