@echo off

rem Store the current working directory in the DIRECTORY variable
set DIRECTORY=%cd%

rem Set the default layer name to "python-layer"
set DEFAULT_LAYER_NAME=python-layer

rem Check if a layer name is provided as a command-line argument
rem If no argument is provided, use the default layer name
rem Otherwise, use the provided layer name
if "%1"=="" (
    set LAYER_NAME=%DEFAULT_LAYER_NAME%
) else (
    set LAYER_NAME=%1
)

rem Build the Docker image using the Dockerfile in the current directory
rem Tag the image as "lambda-layer"
docker build -t lambda-layer "%DIRECTORY%"

rem Run a container based on the "lambda-layer" image
rem Name the container "lambda-layer-container"
rem Mount the current directory as a volume at "/app" inside the container
docker run --name lambda-layer-container -v "%DIRECTORY%:/app" lambda-layer

rem Create a directory named "layers" if it doesn't exist
if not exist "layers" mkdir "layers"

rem Move the generated "python-layer.zip" file to the "layers" directory
rem Rename the file to match the specified layer name
move "%DIRECTORY%\python-layer.zip" "%DIRECTORY%\layers\%LAYER_NAME%.zip"

rem Stop the running "lambda-layer-container"
docker stop lambda-layer-container

rem Remove the stopped "lambda-layer-container"
docker rm lambda-layer-container

rem Remove the "lambda-layer" image forcefully
docker rmi --force lambda-layer
