#!/bin/bash
if [ $# -ne 2 ]; then
    exit 1
fi
> "$2"
for f in $1/*; do
    if [ -f "$f" ] && [ ! -L "$f" ] && [ ! -s "$f" ]; then
        echo "$f" >> "$2"
        rm "$f"
    fi
done

# Usuwa wszystkie puste pliki w katalogu, zapisując ich nazwy do osobnego pliku logu, ignorując dowiązania symboliczne
