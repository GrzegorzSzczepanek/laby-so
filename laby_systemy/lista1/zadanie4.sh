#!/bin/bash
# Tworzy puste pliki bez prawa zapisu w katalogu, na podstawie listy nazw z pliku, nie nadpisując istniejących plików.
if [ $# -ne 2 ]; then
    exit 1
fi
while IFS= read -r line; do
    if [ ! -e "$1/$line" ]; then
        touch "$1/$line"
        chmod a-w "$1/$line"
    fi
done < "$2"

