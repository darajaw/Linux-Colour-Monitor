#!/bin/bash

#loop code infinite

#Grabs the CPU idle usage percentage
# top: grabs system data
# -bn1: prints it as plain text
cpu_stats=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' '{print $1}' | awk '{print $NF}')
echo "$cpu_stats"
#get cpu usage

#change terminal color based on cpu usage

