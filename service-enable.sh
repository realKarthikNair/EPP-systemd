#!/bin/sh

SERVICE_FILE="default-energy-performance-preference.service"
CPU_SCRIPT="set_cpu_performance.sh"
TIMER="default-energy-performance-preference.timer"
SYSTEMD_DIR="/etc/systemd/system"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "Error: $SERVICE_FILE not found in the current directory."
  exit 1
fi

if [ ! -f "$CPU_SCRIPT" ]; then
  echo "Error: $CPU_SCRIPT not found in the current directory."
  exit 1
fi

if [ ! -f "$TIMER" ]; then
  echo "Error: $TIMER not found in the current directory."
  exit 1
fi

sudo cp "$SERVICE_FILE" "$SYSTEMD_DIR"
sudo cp "$CPU_SCRIPT" "/usr/local/bin"
sudo cp "$TIMER" "$SYSTEMD_DIR"
sudo systemctl daemon-reload
sudo systemctl enable "$TIMER"
sudo systemctl start "$TIMER"
sudo systemctl enable "$SERVICE_FILE"
sudo systemctl start "$SERVICE_FILE"

echo "Service has been enabled and started."