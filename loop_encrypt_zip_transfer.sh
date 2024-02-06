#!/bin/bash

# Set your source and destination directories and server details
source_folder="/path/to/source/folder"
destination_folder="/path/to/destination/folder"
destination_server="username@destination-server"

# Create a temporary directory for processing
temp_dir=$(mktemp -d)

# Loop through each CSV file in the source folder
for file in "$source_folder"/*.csv; do
    if [ -f "$file" ]; then
        # Encrypt the CSV file using GPG
        gpg --output "$temp_dir/$(basename "$file").gpg" --encrypt --recipient "recipient@example.com" "$file"

        # Remove the original CSV file if you want to
        # rm "$file"
    fi
done

# Zip the encrypted files
zip -r "$temp_dir/files.zip" "$temp_dir"/*

# Transfer the zip file to the destination server
scp "$temp_dir/files.zip" "$destination_server:$destination_folder"

# Clean up temporary files
rm -r "$temp_dir"
