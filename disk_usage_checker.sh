#!/bin/bash

usage() {
    echo "Usage: $0 [-d] [-n N] directory"
    echo "-d: List all files and directories within the specified directory"
    echo "-n N: Return the top N entries. Default is 8."
    exit 1
}

# Default values
list_files=false
top_n=8

# Parse command line arguments
while getopts ":dn:" opt; do
    case $opt in
        d)
            list_files=true
            ;;
        n)
            top_n=$OPTARG
            ;;
        \?)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Check if directory is provided
if [ $# -eq 0 ]; then
    usage
fi

directory=$1

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# List files and directories if -d option is provided
if [ "$list_files" = true ]; then
    du -h -d 1 "$directory" | sort -hr | head -n "$top_n"
else
    du -h --max-depth=1 "$directory" | sort -hr | head -n "$top_n"
fi
