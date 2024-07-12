#!/bin/sh

SERVICE_FILE="default-energy-performance-preference.service"
SYSTEMD_DIR="/etc/systemd/system"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "Error: $SERVICE_FILE not found in the current directory."
  exit 1
fi

sudo cp "$SERVICE_FILE" "$SYSTEMD_DIR"
pkexec systemctl daemon-reload
pkexec systemctl enable "$SERVICE_FILE"
pkexec systemctl start "$SERVICE_FILE"

echo "Service has been enabled and started."