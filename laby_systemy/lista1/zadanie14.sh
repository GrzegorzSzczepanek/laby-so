#!/bin/bash
if [ $# -ne 2 ]; then
    exit 1
fi
for f1 in $1/*; do
    if [ -f "$f1" ]; then
        b=$(basename "$f1")
        if [ -f "$2/$b" ] || [ -d "$2/$b" ]; then
            rm "$f1"
        fi
    fi
done


# Usuwa pliki z pierwszego katalogu, których nazwy pokrywają się z nazwami plików lub katalogów w drugim katalogu
