#!/bin/bash

cmd=$1

if [ "$cmd" = "build_generator" ]; then
    docker build -t gen-image ./generator

elif [ "$cmd" = "run_generator" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" gen-image

elif [ "$cmd" = "create_local_data" ]; then
    mkdir -p local_data
    python3 generator/generate.py local_data

elif [ "$cmd" = "build_reporter" ]; then
    docker build -t rep-image ./reporter

elif [ "$cmd" = "run_reporter" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" rep-image

elif [ "$cmd" = "structure" ]; then
    find . -not -path "./.git*"

elif [ "$cmd" = "clear_data" ]; then
    rm -f data/*.csv data/*.html

elif [ "$cmd" = "inside_generator" ]; then
    docker run --rm -v "$(pwd)/data:/data" gen-image ls -la /data

elif [ "$cmd" = "inside_reporter" ]; then
    docker run --rm -v "$(pwd)/data:/data" rep-image ls -la /data

else
    echo "no such command: $cmd"

fi
