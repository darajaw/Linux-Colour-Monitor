#!/bin/bash

#loop code infinite
#top: grabs system data
#-bn1: prints it as plain text
cpu_stats=$(top -bn1)

echo "$cpu_stats"
#get cpu usage

#change terminal color based on cpu usage

