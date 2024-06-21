# Use the official AWS SAM build image for Python 3.12 as the base image
FROM public.ecr.aws/sam/build-python3.12:latest

# Install Python 3 using the dnf package manager
RUN dnf install -y python3

# Set the working directory to /app
WORKDIR /app

# Upgrade the system packages and install the zip utility
# Clean up the package lists to reduce the image size
RUN dnf upgrade && \
    dnf install -y zip && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt file to the working directory
COPY requirements.txt .

# Install the Python dependencies specified in requirements.txt
# Store the dependencies in the /opt/python/ directory
RUN pip install -r requirements.txt -t /opt/python/

# Set the default command to be executed when the container starts
# Change directory to /opt and create a zip file of the Python dependencies
# Save the zip file as /app/python-layer.zip
CMD cd /opt && zip -r9 /app/python-layer.zip .
