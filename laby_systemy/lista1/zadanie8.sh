#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
c=0
for f in $1/*; do
    if [ -f "$f" ] && [ -w "$f" ]; then
        c=$((c+1))
    fi
done
echo $c

# Liczy i wyświetla ilość plików w katalogu, do których użytkownik ma prawo zapisu.
