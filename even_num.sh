#!/bin/bash

read -p "Enter the max limit: " max
i=0

while [[ $i -le $max ]] 
do
    if [[ $((i%2)) -eq 0 ]]; then
        echo $i: even
    else
        echo $i: odd
    fi
    i=$((i+1))
done