#!/bin/bash

function is_happy() {
    read -p "Are you Happy? (yes/no): " ch
    if [[ $ch -eq "yes" ]]; then
        echo $1 is 😊
        return true;
    fi
    return false;
}

is_happy Dhruv
