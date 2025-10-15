#!/bin/bash

# Create test directory
test_dir="test_files"
mkdir -p "$test_dir"

# Create empty files
touch "$test_dir/empty1.txt"
touch "$test_dir/empty2.log"
touch "$test_dir/empty3.cfg"

# Create non-empty files
echo "Sample data" > "$test_dir/file1.txt"
echo "Another line" > "$test_dir/file2.log"
printf "Non-empty config\noption=1" > "$test_dir/config.cfg"

# Create symbolic links (one to a non-empty file, one to an empty file)
ln -s "$test_dir/file1.txt" "$test_dir/symlink_to_file.txt"
ln -s "$test_dir/empty1.txt" "$test_dir/symlink_to_empty.txt"

echo "Test files created in '$test_dir/'"
echo "Files:"
ls -la "$test_dir/"

