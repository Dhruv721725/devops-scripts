#!/bin/bash

Log="/var/log/nginx/error.log"

if [ ! -f "$Log" ]; then
	echo "log file not found"
	exit 2
fi

count=$(grep -ic error "$Log")

if [ $count -gt 0 ]; then
	echo "error count > 0"
	exit 1
else
	echo "error count <= 0"
	exit 0
fi
