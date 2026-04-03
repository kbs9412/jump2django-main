#!/bin/bash
set -euo pipefail

# Only run in remote (web) environment
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

echo "==> Installing Python dependencies..."
pip install -r "$CLAUDE_PROJECT_DIR/requirements_local.txt" --quiet

echo "==> Creating logs directory..."
mkdir -p "$CLAUDE_PROJECT_DIR/logs"

echo "==> Running Django migrations..."
cd "$CLAUDE_PROJECT_DIR"
DJANGO_SETTINGS_MODULE=config.settings.local python manage.py migrate --run-syncdb 2>/dev/null || true

echo "==> Session start setup complete."
