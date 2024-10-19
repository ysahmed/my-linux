#!/usr/bin/env bash

dir=$(pwd)
target='/opt/oracle'
base_url="https://download.oracle.com/otn_software/linux/instantclient/2350000"

# Check if dpkg is available
if command -v dpkg >/dev/null 2>&1; then
    echo "dpkg found. Proceeding with libaio1 installation..."

    # Check if libaio1 is already installed
    if ! dpkg -s libaio1 >/dev/null 2>&1; then
        echo "libaio1 not installed. Installing..."
        wget -q https://ftp.up.pt/ubuntu/ubuntu/pool/main/liba/libaio/libaio1_0.3.113-5_amd64.deb
        sudo dpkg -i libaio1_0.3.113-5_amd64.deb
        rm libaio1_0.3.113-5_amd64.deb
    else
        echo "libaio1 is already installed. Skipping installation."
    fi

    # Check if unzip is installed
    if ! dpkg -s unzip >/dev/null 2>&1; then
        echo "unzip not installed. Installing..."
        sudo apt-get update && sudo apt-get install -y unzip
    else
        echo "unzip is already installed. Skipping installation."
    fi
else
    echo "dpkg not found. Skipping libaio1 and unzip installation."
fi

# Disable SSL verification for Git
git config --global http.sslVerify false

# List of filenames
files=(
    "instantclient-basic-linux.x64-23.5.0.24.07.zip"
    "instantclient-sqlplus-linux.x64-23.5.0.24.07.zip"
    "instantclient-tools-linux.x64-23.5.0.24.07.zip"
)

# Download files if they don't exist
for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Downloading $file..."
        wget -q "$base_url/$file"
    else
        echo "File '$file' already exists. Skipping download."
    fi
done

# Create target directory and unzip files
sudo mkdir -p "$target"
for zip_file in "${files[@]}"; do
    sudo unzip -o "$zip_file" -d "$target"
done

sudo ldconfig
