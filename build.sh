#!/bin/bash

# This script compiles a C++ source file and places the executable in the /bin directory.
# It requires the C++ source file path as an argument.

# Function to display usage information.
display_usage() {
  echo "Usage: $0 <cpp_source_file>"
  echo "Example: $0 my_program.cpp"
  echo "The compiled executable will be saved in /bin with the same name as the source file (without the .cpp extension)."
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

# Extract the base name of the file (e.g., "my_program" from "my_program.cpp").
BASE_NAME=$(basename "$SOURCE_FILE" .cpp)

# Define the output directory.
OUTPUT_DIR="./bin"

# Define the full path for the executable.
EXECUTABLE_PATH="$OUTPUT_DIR/$BASE_NAME"

echo "Attempting to compile '$SOURCE_FILE'..."
echo "Output executable: '$EXECUTABLE_PATH'"

# Compile the C++ file using g++.
# -o specifies the output file name.
# -Wall enables all common warnings.
# -std=c++17 specifies the C++ standard (can be changed to c++14, c++17, c++20 etc. if needed).
g++ "$SOURCE_FILE" -o "$EXECUTABLE_PATH" -Wall -std=c++17

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

#!/bin/bash

# This script compiles a C++ source file and attempts to place the executable
# in /usr/local/bin, which is a common location for user-installed binaries.
# It requires the C++ source file path as an argument.

# Function to display usage information.
display_usage() {
  echo "Usage: $0 <cpp_source_file>"
  echo "Example: $0 my_program.cpp"
  echo "The compiled executable will be saved in /usr/local/bin (requires sudo for this location)."
  echo "Alternatively, you can manually change OUTPUT_DIR to a user-writable location like ~/bin."
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

# Extract the base name of the file (e.g., "my_program" from "my_program.cpp").
BASE_NAME=$(basename "$SOURCE_FILE" .cpp)

# Define the output directory.
# Changed from /bin to /usr/local/bin.
# Note: Writing to /usr/local/bin typically requires root privileges (sudo).
# For personal executables, consider using: OUTPUT_DIR="$HOME/bin"
OUTPUT_DIR="/usr/local/bin"

# Ensure the output directory exists.
# Using 'sudo' here for mkdir in case it's needed for /usr/local/bin
sudo mkdir -p "$OUTPUT_DIR" || { echo "Error: Could not create output directory '$OUTPUT_DIR'. Aborting."; exit 1; }

# Define the full path for the executable.
EXECUTABLE_PATH="$OUTPUT_DIR/$BASE_NAME"

echo "Attempting to compile '$SOURCE_FILE'..."
echo "Output executable will be placed in: '$EXECUTABLE_PATH'"

# Compile the C++ file using g++.
# -o specifies the output file name.
# -Wall enables all common warnings.
# -std=c++17 specifies the C++ standard (can be changed to c++14, c++17, c++20 etc. if needed).
# The compilation itself often doesn't need sudo, but moving the file might.
g++ "$SOURCE_FILE" -o /tmp/"$BASE_NAME" -Wall -std=c++17

# Check the exit status of the compilation command.
if [ $? -eq 0 ]; then
  echo "Compilation successful!"

  # Move the compiled executable to the final destination using sudo.
  echo "Moving executable to '$EXECUTABLE_PATH' (requires sudo)..."
  sudo mv /tmp/"$BASE_NAME" "$EXECUTABLE_PATH"

  if [ $? -eq 0 ]; then
    echo "Executable moved successfully to: $EXECUTABLE_PATH"

    # Make the executable runnable.
    echo "Setting executable permissions for '$EXECUTABLE_PATH' (requires sudo)..."
    sudo chmod +x "$EXECUTABLE_PATH"
    echo "Permissions set to executable."
  else
    echo "Error: Failed to move executable to '$EXECUTABLE_PATH'. Please check your sudo permissions."
    exit 1
  fi
else
  echo "Compilation failed. Please check the errors above."
  exit 1
fi

