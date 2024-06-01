# Use an official Python runtime as a parent image
FROM nvidia/cuda:12.5.0-devel-ubuntu22.04

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CUDA support and other required packages
# RUN pip3 install torch torchvision torchaudio \
    # --extra-index-url https://download.pytorch.org/whl/cu111

# Install PyTorch with CUDA support and other required packages
RUN pip3 install torch==2.0.0+cu117 torchvision==0.15.1+cu117 torchaudio==2.0.0+cu117 \
    --extra-index-url https://download.pytorch.org/whl/cu117

# Install any other needed packages specified in requirements.txt
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python3", "app.py"]
