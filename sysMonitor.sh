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
#awk used to grab the CPUs idle percentage
#idle used to calculate the usage
get_cpu_usage() {
  cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' '{print $1}' | awk '{print $NF}')
  cpu_usage=$(echo "100 - $cpu_idle" | bc)
  echo "$cpu_usage"
}

get_ram_usage() {
  ram_free=$(top -bn1 | grep "MiB Mem" | awk -F'free,' '{print $1}' | awk '{print $NF}')
  ram_total=$(top -bn1 | grep "MiB Mem" | awk -F'total,' '{print $1}' | awk '{print $NF}')
  ram_usage=$(echo "scale=2; (($ram_total - $ram_free) / $ram_total) * 100" | bc)
  echo "$ram_usage"
}

#Loop to check usage 
system_monitor() {
  while true; do
    sys_usage=$($2) 
    if (( $(echo "$sys_usage < 50" | bc -l) )); then
      echo -e "${GREEN}$1 Usage: ${sys_usage}% (Low)${RESET}"
    elif (( $(echo "$sys_usage >= 50" | bc -l) )) && (( $(echo "$sys_usage < 80" | bc -l) )); then
      echo -e "${YELLOW}$1 Usage: ${sys_usage}% (Moderate)${RESET}"
    else
      echo -e "${RED}$1 Usage: ${sys_usage}% (High)${RESET}"
    fi
    
    sleep 1
  done
}

#switch based on user's choice
handle_choice() {
  case $1 in
    1)
      system_monitor "CPU" "get_cpu_usage" 
      ;;
    2)
      system_monitor "RAM" "get_ram_usage" 
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
  echo "Type 2 to monitor your RAM usage"
  echo "Type q to quit"
}

#inital menu for program
show_menu
read -r choice
handle_choice "$choice"
