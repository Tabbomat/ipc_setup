#!/bin/bash

# Define variables
REPO_URL="https://github.com/Tabbomat/ipc_setup"
BRANCH="main"
ZIP_FILE="ipc_setup-main.zip"
DOWNLOAD_URL="$REPO_URL/archive/refs/heads/$BRANCH.zip"
TARGET_DIR="ipc_setup-main"

# Download the zip file
echo "Downloading $DOWNLOAD_URL ..."
curl -L -o $ZIP_FILE $DOWNLOAD_URL

# Check if the download was successful
if [ $? -ne 0 ]; then
  echo "Failed to download $ZIP_FILE"
  exit 1
fi

# Unzip the downloaded file
echo "Unzipping $ZIP_FILE ..."
unzip $ZIP_FILE

# Check if the unzip was successful
if [ $? -ne 0 ]; then
  echo "Failed to unzip $ZIP_FILE"
  exit 1
fi

# Change to the directory
cd $TARGET_DIR

# Run the setup.sh script
echo "Running setup.sh ..."
chmod +x setup.sh
./setup.sh

# Check if the script ran successfully
if [ $? -ne 0 ]; then
  echo "Failed to run setup.sh"
  exit 1
fi

# Cleanup
echo "Cleaning up ..."
cd ..
rm -rf $ZIP_FILE #$TARGET_DIR

echo "Done!"