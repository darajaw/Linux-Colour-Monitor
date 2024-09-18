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
get_cpu_usage() {
  # Get CPU usage from 'top' command and format the output
  cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' '{print $1}' | awk '{print $NF}')
  cpu_usage=$(echo "100 - $cpu_idle" | bc)
  echo "$cpu_usage"
}

#Loop to check usage 
system_monitor() {
  while true; do
    cpu_usage=$(get_cpu_usage)  
    if (( $(echo "$cpu_usage < 50" | bc -l) )); then
      echo -e "${GREEN}CPU Usage: ${cpu_usage}% (Low)${RESET}"
    elif (( $(echo "$cpu_usage >= 50" | bc -l) && $(echo "$cpu_usage < 80" | bc -l) )); then
      echo -e "${YELLOW}CPU Usage: ${cpu_usage}% (Moderate)${RESET}"
    else
      echo -e "${RED}CPU Usage: ${cpu_usage}% (High)${RESET}"
    fi
    
    sleep 1
  done
}

#switch based on user's choice
handle_choice() {
  case $1 in
    1)
      system_monitor
      ;;
    q)
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
}

show_menu() {
  clear
  echo "What would you like to monitor?"
  echo "Type 1 to monitor your CPU usage"
  echo "Type q to quit"
}

#inital menu for program
show_menu
read -r choice
handle_choice "$choice"
read -r

