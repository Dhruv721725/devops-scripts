#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 <service-name>"
	exit 2
fi

service=$1

if systemctl is-active --quiet "$service"; then
	echo "$service is running"
	exit 0
else
	echo "$service is not running"
	exit 1
fi

