# Creating a Python Lambda Layer using Docker

This can be used to create Python Lambda layer using Docker. The provided code automates the process of building a Docker image, installing the required Python libraries specified in the `requirements.txt` file, and creating a ZIP file that can be used as a Lambda layer.

## Prerequisites

Before running the script, ensure that you have the following prerequisites:

- Docker installed and running on your system. If Docker is not installed, you can download and install it from the official Docker website: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
- The script expects the `Dockerfile` and `requirements.txt` files to be located in the same directory as the script.
- Make sure that the `create_layer.sh` script has executable permissions. If not, you can grant the necessary permissions by running the following command:
  ```
  chmod +x create_layer.sh
  ```
- Ensure that you have the required Python libraries listed in the `requirements.txt` file. The script will install these libraries in the Lambda layer.

## Script Details

The `create_layer.sh` script automates the process of creating a Python Lambda layer using Docker. Here's an overview of the script:

1. **Directory**: The script uses the current working directory (`pwd`) to locate the `Dockerfile` and `requirements.txt` files.

2. **Layer Name**: By default, the script uses `python-layer` as the name for the generated layer. You can provide a custom layer name as a command-line argument when running the script.

3. **Docker Image**: The script builds a Docker image named `lambda-layer` using the provided `Dockerfile`. The `Dockerfile` specifies the base image (`public.ecr.aws/sam/build-python3.12:latest`) and installs the necessary dependencies and Python libraries from the `requirements.txt` file.

4. **Creating the Layer**: The script runs a Docker container named `lambda-layer-container` based on the `lambda-layer` image. It mounts the current directory (`$DIRECTORY`) as a volume inside the container at `/app`.

5. **Output**: The script creates a directory named `layers` (if it doesn't exist) in the current directory and moves the generated ZIP file (`python-layer.zip`) from the container to the `layers` directory, renaming it to `$LAYER_NAME.zip`.

6. **Cleanup**: After creating the layer, the script stops and removes the `lambda-layer-container` container and removes the `lambda-layer` Docker image to free up resources.

## Running the Script

To run the script and create a Python Lambda layer, follow these steps:

1. Update `requirements.txt` file in the directory as the script, listing all the Python libraries you want to include in the layer. For example:
   ```
   requests
   openai
   transformers
   ```

2. Run the `create_layer.sh` script using one of the following commands:
   - To create a layer with a custom name:
     ```
     ./create_layer.sh "custom-layer-name"
     ```
   - To create a layer with the default name (`python-layer`):
     ```
     ./create_layer.sh
     ```

3. The script will build the Docker image, run the container, install the Python libraries, and create the layer ZIP file in the `layers` directory.

4. Once the script finishes executing, you will find the generated layer ZIP file (`custom-layer-name.zip` or `python-layer.zip`) in the `layers` directory.

## Dockerfile Details

The `Dockerfile` defines the instructions for building the Docker image used to create the Python Lambda layer. Here's an explanation of the Dockerfile:

```Dockerfile
FROM public.ecr.aws/sam/build-python3.12:latest

RUN dnf install -y python3

WORKDIR /app

RUN dnf upgrade && \
    dnf install -y zip && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install -r requirements.txt -t /opt/python/

CMD cd /opt && zip -r9 /app/python-layer.zip .
```

- The `FROM` instruction specifies the base image (`public.ecr.aws/sam/build-python3.12:latest`) to use for building the Lambda layer.
- The `RUN` instructions install the necessary dependencies and upgrades the package manager.
- The `WORKDIR` instruction sets the working directory inside the container to `/app`.
- The `COPY` instruction copies the `requirements.txt` file from the host machine to the container.
- The `RUN` instruction installs the Python packages listed in `requirements.txt` to the `/opt/python/` directory.
- The `CMD` instruction specifies the command to be executed when the container starts. It changes the directory to `/opt`, creates a ZIP file named `python-layer.zip` containing the installed packages, and saves it to the `/app` directory.

