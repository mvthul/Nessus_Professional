#!/bin/bash

# Exit immediately if a command fails
set -e

# Check if initialization has already been completed
if [ -f /temporary/.init-done ]; then
  echo "Initialization already completed. Skipping steps."
  exit 0
fi

echo "Starting initialization..."

# Ensure directories exist
mkdir -p /opt/nessus /temporary

# Step 1: Download nessus_update_debian_only.sh
echo "Downloading nessus_update_debian_only.sh..."
wget -q -O /opt/nessus/nessus_update_debian_only.sh \
  https://raw.githubusercontent.com/xiv3r/Nessus_Professional/refs/heads/main/nessus_update_debian_only.sh

# Step 2: Make the script executable
chmod +x /opt/nessus/nessus_update_debian_only.sh

# Step 3: Execute the script
echo "Running nessus_update_debian_only.sh..."
/opt/nessus/nessus_update_debian_only.sh

# Step 4: Copy files to /temporary
echo "Copying files from /opt/nessus to /temporary..."
cp -n -R /opt/nessus/* /temporary/

# Step 5: Mark initialization as done
touch /temporary/.init-done
echo "Initialization complete."
