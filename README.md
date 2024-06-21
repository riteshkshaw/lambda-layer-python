# Lambda Layer Creation Script

This repository contains scripts and files to create a Lambda layer using Docker. The layer packages the Python libraries specified in the `requirements.txt` file.

## Prerequisites

Before running the scripts, ensure that you have the following prerequisites:

- Docker installed on your machine
- Access to the command line or terminal

## Script Files

The repository includes two script files:

1. `create_layer.sh`: This is a Bash script intended for Unix-based systems (Linux, macOS).
2. `create_layer.bat`: This is a batch file intended for Windows systems.

Use the appropriate script file based on your operating system. To execute the script, open a command line or terminal, navigate to the directory containing the script, and run the following command:

```
./create_layer.sh [layer_name]
```

or

```
create_layer.bat [layer_name]
```

Replace `[layer_name]` with the desired name for your Lambda layer. If no layer name is provided, the default name "python-layer" will be used.

## Requirements File and Dockerfile

The `requirements.txt` file lists the Python libraries that you want to include in your Lambda layer. Each library should be specified on a separate line. In this example, the `requests` library is included.

The `Dockerfile` contains the instructions for building the Docker image that will be used to create the Lambda layer. It specifies the base image, installs the necessary dependencies, copies the `requirements.txt` file, and installs the listed Python libraries.

## Usage guide

- Ensure that the `requirements.txt` file and the `Dockerfile` are located in the same directory as the script file.
- The script will create a `layers` directory in the current working directory to store the generated layer ZIP file.
- The script uses the `public.ecr.aws/sam/build-python3.12:latest` base image by default. If you need to use a different base image, modify the `FROM` instruction in the `Dockerfile`.
- The script installs the Python libraries specified in the `requirements.txt` file. To include additional libraries, add them to the `requirements.txt` file, each on a separate line.

## Modifying the Script

To manage the list of libraries included in the layer, modify the `requirements.txt` file. Add or remove libraries as needed, ensuring that each library is specified on a separate line.

To use a different base image, update the `FROM` instruction in the `Dockerfile`. Replace `public.ecr.aws/sam/build-python3.12:latest` with the desired base image. Make sure to choose a base image that is compatible with the Python version and any other dependencies required by your Lambda function.

## Base Image

The script uses the `public.ecr.aws/sam/build-python3.12:latest` base image by default. This image is provided by AWS and includes Python 3.12 and other necessary tools for building Lambda layers.

If you require a different Python version or have specific requirements, you can choose another base image. AWS provides various base images for different Python versions, such as `public.ecr.aws/sam/build-python3.9:latest` for Python 3.9. You can also use custom base images that meet your specific needs.

When selecting a base image, consider the compatibility with your Lambda function code and any additional dependencies or tools required. Update the `FROM` instruction in the `Dockerfile` to specify the desired base image.


