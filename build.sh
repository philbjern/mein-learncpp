#!/bin/bash

# This script compiles a C++ source file and places the executable
# directly in the source file's parent directory, naming it after the source file itself.
# It requires the C++ source file path as an argument.

# Function to display usage information.
display_usage() {
  echo "Usage: $0 <cpp_source_file>"
  echo "Example: $0 Variables/main.cpp"
  echo "The compiled executable will be saved directly in the source file's parent directory"
  echo "(e.g., 'Variables/main'), named after the source file (e.g., 'main')."
}

# Check if exactly one argument is provided.
if [ "$#" -ne 1 ]; then
  echo "Error: Incorrect number of arguments."
  display_usage
  exit 1
fi

SOURCE_FILE="$1"

# Check if the source file exists.
if [ ! -f "$SOURCE_FILE" ]; then
  echo "Error: Source file '$SOURCE_FILE' not found."
  exit 1
fi

# Get the current working directory (assumed to be the project root).
CURRENT_DIR=$(pwd)

# Extract the base name of the source file (e.g., "main" from "Variables/main.cpp").
BASE_NAME=$(basename "$SOURCE_FILE" .cpp)

# Extract the directory name relative to the current working directory (e.g., "Variables").
SOURCE_RELATIVE_DIR=$(dirname "$SOURCE_FILE")

# Determine the name for the executable: it will be the base name of the source file.
EXECUTABLE_NAME="$BASE_NAME"

# Define the output directory to be the source file's parent directory.
OUTPUT_DIR_PATH="$SOURCE_RELATIVE_DIR"

# Ensure the output directory exists. No 'bin' subdirectory is created here.
mkdir -p "$OUTPUT_DIR_PATH" || { echo "Error: Could not create output directory '$OUTPUT_DIR_PATH'. Aborting."; exit 1; }

# Define the full path for the executable.
EXECUTABLE_PATH="$OUTPUT_DIR_PATH/$EXECUTABLE_NAME"

echo "Attempting to compile '$SOURCE_FILE'..."
echo "Project root directory: '$CURRENT_DIR'"
echo "Output executable will be placed at: '$EXECUTABLE_PATH'"

# Compile the C++ file using g++.
# -o specifies the output file name and path directly.
# -Wall enables all common warnings.
# -std=c++11 specifies the C++ standard (can be changed to c++14, c++17, c++20 etc. if needed).
# No 'sudo' is needed here as we are writing to the current user's directory.
g++ "$SOURCE_FILE" -o "$EXECUTABLE_PATH" -Wall -std=c++11

# Check the exit status of the compilation command.
if [ $? -eq 0 ]; then
  echo "Compilation successful!"
  echo "Executable created at: $EXECUTABLE_PATH"

  # Make the executable runnable.
  chmod +x "$EXECUTABLE_PATH"
  echo "Permissions set to executable."
else
  echo "Compilation failed. Please check the errors above."
  exit 1
fi

