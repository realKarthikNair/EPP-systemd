#!/usr/bin/bash

SERVICE_FILE="default-energy-performance-preference.service"
CPU_SCRIPT="set_cpu_performance.sh"
TIMER="default-energy-performance-preference.timer"
SYSTEMD_DIR="/etc/systemd/system"
LOCAL_BIN_DIR="/usr/local/bin"

sudo systemctl stop "$SERVICE_FILE"
sudo systemctl disable "$SERVICE_FILE"

sudo systemctl stop "$TIMER"
sudo systemctl disable "$TIMER"

sudo rm "$SYSTEMD_DIR/$SERVICE_FILE"
sudo rm "$SYSTEMD_DIR/$TIMER"
sudo rm "$LOCAL_BIN_DIR/$CPU_SCRIPT"

sudo systemctl daemon-reload

echo "Service, timer, and script have been removed."
