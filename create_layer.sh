#!/bin/bash

# Store the current working directory in the DIRECTORY variable
DIRECTORY="$(pwd)"

# Set the default layer name to "python-layer"
DEFAULT_LAYER_NAME="python-layer"

# Check if a layer name is provided as a command-line argument
# If no argument is provided, use the default layer name
# Otherwise, use the provided layer name
if [ -z "$1" ]; then
    LAYER_NAME=$DEFAULT_LAYER_NAME
else
    LAYER_NAME=$1
fi

# Build the Docker image using the Dockerfile in the current directory
# Tag the image as "lambda-layer"
docker build -t lambda-layer "$DIRECTORY"

# Run a container based on the "lambda-layer" image
# Name the container "lambda-layer-container"
# Mount the current directory as a volume at "/app" inside the container
docker run --name lambda-layer-container -v "$DIRECTORY:/app" lambda-layer

# Create a directory named "layers" if it doesn't exist
mkdir -p layers

# Move the generated "python-layer.zip" file to the "layers" directory
# Rename the file to match the specified layer name
mv "$DIRECTORY/python-layer.zip" "$DIRECTORY/layers/$LAYER_NAME.zip"

# Stop the running "lambda-layer-container"
docker stop lambda-layer-container

# Remove the stopped "lambda-layer-container"
docker rm lambda-layer-container

# Remove the "lambda-layer" image forcefully
docker rmi --force lambda-layer
