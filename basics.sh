#!/bin/bash
#echo Enter user name: 
#read name

read -p "Enter user name: " name

echo "user name is $name and date is $(date)"

cat /etc/passwd

sudo useradd -m $name
echo User $name added.