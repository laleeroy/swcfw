#!/bin/bash

# Get the tag name from the environment variable
REPO_TAG_NAME=$1

# Define the output zip file name
ZIP_FILE="8BP-$REPO_TAG_NAME.zip"

# Find all files in the current directory except .sh files and the git related directories, and create a zip file
zip -r "$ZIP_FILE" . -x "*.sh" -x ".git/*" -x ".github/*"

echo "Files have been zipped into $ZIP_FILE, excluding all .sh files and the .git folder."
