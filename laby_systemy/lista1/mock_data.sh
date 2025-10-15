#!/bin/bash
TEST_DIR="./test_files"
FILE_COUNT=${1:-10}
MIN_SIZE=${2:-100}
MAX_SIZE=${3:-1000}

mkdir -p "$TEST_DIR"
for i in $(seq 1 $FILE_COUNT); do
    size=$((MIN_SIZE + RANDOM % (MAX_SIZE - MIN_SIZE + 1)))
    file="$TEST_DIR/test_file_$i.txt"
    head -c $size < /dev/urandom > "$file"
    if ((i % 3 == 0)); then chmod +x "$file"; fi
    if ((i % 4 == 0)); then touch -d "2 days ago" "$file"; fi
done
echo "Utworzono $FILE_COUNT plików testowych w katalogu $TEST_DIR"

