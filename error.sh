#!/bin/bash

function crt_dir() {
    mkdir sample
}

if ! crt_dir; then
    echo Directory is already present.
    exit '1'
fi

echo This will be printed if no error is there.
echo Directory created.