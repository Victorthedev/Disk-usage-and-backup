#!/bin/bash

usage() {
    echo "Usage: $0 source_directory destination_directory"
    exit 1
}

# Check if source and destination directories are provided
if [ $# -ne 2 ]; then
    usage
fi

source_dir=$1
destination_dir=$2

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory '$source_dir' does not exist."
    exit 1
fi

# Check if the destination directory exists
if [ ! -d "$destination_dir" ]; then
    echo "Error: Destination directory '$destination_dir' does not exist."
    exit 1
fi

# Create backup with timestamp
timestamp=$(date +"%Y%m%d%H%M%S")
backup_file="$destination_dir/backup_$timestamp.tar"

tar -cf "$backup_file" "$source_dir"
echo "Backup created: $backup_file"
