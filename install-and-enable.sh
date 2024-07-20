#!/usr/bin/bash

SERVICE_FILE="default-energy-performance-preference.service"
CPU_SCRIPT="set_cpu_performance.sh"
TIMER="default-energy-performance-preference.timer"
SYSTEMD_DIR="/etc/systemd/system"
CONFIG_FILE="cpu_performance_config.conf"

BATTERY_NAME=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)
if [ -z "$BATTERY_NAME" ]; then
    echo "No battery found in /sys/class/power_supply/ - Are you sure this is a laptop? If so, please raise an issue at https://github.com/realKarthikNair/EPP-systemd/issues"
    exit 1
fi

sed -i "s/^name=.*/name=$BATTERY_NAME/" $CONFIG_FILE

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
sudo cp "$CONFIG_FILE" "/etc"
sudo systemctl daemon-reload
sudo systemctl enable "$TIMER"
sudo systemctl start "$TIMER"
sudo systemctl enable "$SERVICE_FILE"
sudo systemctl start "$SERVICE_FILE"

echo "Service has been enabled and started."