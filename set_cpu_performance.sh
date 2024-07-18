#!/bin/bash

BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)
BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$BATTERY_STATUS" == "Charging" ]; then
    if [ "$BATTERY_CAPACITY" -gt 50 ]; then
        echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    else
        echo balance_performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    fi
elif [ "$BATTERY_STATUS" == "Discharging" ]; then
    if [ "$BATTERY_CAPACITY" -gt 50 ]; then
        echo balance_performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    else
        echo power | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    fi
fi
