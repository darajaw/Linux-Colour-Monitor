#!/bin/bash

# Define corresponding colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

#loop code infinite

#Grabs the CPU idle usage percentage
# top: grabs system data
# -bn1: prints it as plain text
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' '{print $1}' | awk '{print $NF}')
echo "$cpu_stats"
#get cpu usage

# Check CPU usage and change color
  if (( $(echo "$cpu_usage < 50" | bc -l) )); then
    echo -e "${GREEN}CPU Usage: ${cpu_usage}% (Low)${RESET}"
  elif (( $(echo "$cpu_usage >= 50 && $cpu_usage < 80" | bc -l) )); then
    echo -e "${YELLOW}CPU Usage: ${cpu_usage}% (Moderate)${RESET}"
  else
    echo -e "${RED}CPU Usage: ${cpu_usage}% (High)${RESET}"
  fi
