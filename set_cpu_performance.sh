#!/bin/bash

# Configuration file path
CONFIG_FILE="/etc/cpu_performance_config.conf"

# Read configuration values for Charging section
CHARGING_ABOVE_THRESHOLD=$(awk -F "=" '/^above_threshold/ {print $2}' <(awk -v section=Charging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
CHARGING_BELOW_THRESHOLD=$(awk -F "=" '/^below_threshold/ {print $2}' <(awk -v section=Charging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
CHARGING_ABOVE=$(awk -F "=" '/^above=/ {print $2}' <(awk -v section=Charging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
CHARGING_BELOW=$(awk -F "=" '/^below=/ {print $2}' <(awk -v section=Charging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))

# Read configuration values for Discharging section
DISCHARGING_ABOVE_THRESHOLD=$(awk -F "=" '/^above_threshold/ {print $2}' <(awk -v section=Discharging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
DISCHARGING_BELOW_THRESHOLD=$(awk -F "=" '/^below_threshold/ {print $2}' <(awk -v section=Discharging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
DISCHARGING_ABOVE=$(awk -F "=" '/^above=/ {print $2}' <(awk -v section=Discharging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))
DISCHARGING_BELOW=$(awk -F "=" '/^below=/ {print $2}' <(awk -v section=Discharging '$0 ~ section {flag=1; next} flag && $1 == "" {exit} flag' $CONFIG_FILE))

# Get battery name, status and capacity
BATTERY_NAME=$(grep "name=" "$CONFIG_FILE" | sed 's/name=//')
BATTERY_STATUS=$(cat /sys/class/power_supply/$BATTERY_NAME/status)
BATTERY_CAPACITY=$(cat /sys/class/power_supply/$BATTERY_NAME/capacity)

# Set CPU performance based on battery status and capacity
if [ "$BATTERY_STATUS" == "Charging" ]; then
    if [ "$BATTERY_CAPACITY" -gt "$CHARGING_ABOVE_THRESHOLD" ]; then
        echo "$CHARGING_ABOVE" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    else
        echo "$CHARGING_BELOW" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    fi
elif [ "$BATTERY_STATUS" == "Discharging" ]; then
    if [ "$BATTERY_CAPACITY" -gt "$DISCHARGING_ABOVE_THRESHOLD" ]; then
        echo "$DISCHARGING_ABOVE" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    else
        echo "$DISCHARGING_BELOW" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    fi
fi
