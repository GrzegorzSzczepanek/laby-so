#!/bin/bash
if [ $# -ne 2 ]; then
    exit 1
fi
for f1 in $1/*; do
    if [ -f "$f1" ]; then
        b=$(basename "$f1")
        if [ -f "$2/$b" ]; then
            echo "$b"
        fi
    fi
done


# Porównuje dwa katalogi i wyświetla listę plików, które mają takie same nazwy w obu lokalizacjach, ignorując podkatalogi

