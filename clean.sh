#!/bin/bash

# Set the application directory
APP_DIR="/app"

# Prompt user for confirmation
read -p "This operation will stop and remove the OpenCEX containers, delete the application directory, and clean up Docker resources. Are you sure you want to proceed? (y/N): " confirm

# Check user confirmation
if [[ $confirm =~ ^[Yy]$ ]]; then
    # Stop and remove the containers
    cd "$APP_DIR/deploy" || exit
    docker-compose down --remove-orphans

    # Remove the application directory
    cd ..
    rm -rf "$APP_DIR"

    # Remove unused Docker images, containers, and volumes
    docker system prune -a --volumes --force

    # Remove unused Docker networks
    docker network prune --force

    # Remove Docker build cache
    docker builder prune --force

    echo "OpenCEX removal completed successfully."
else
    echo "OpenCEX removal aborted."
    exit 1
fi