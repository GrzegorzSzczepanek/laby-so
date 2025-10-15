#!/bin/bash
TEST_DIR="./test_files"

if [ -d "$TEST_DIR" ]; then
    rm -rf "$TEST_DIR"
    echo "Usunięto katalog testowy: $TEST_DIR"
else
    echo "Katalog testowy nie istnieje: $TEST_DIR"
fi

