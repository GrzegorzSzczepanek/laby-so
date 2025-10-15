#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
for d in $1/*/; do
    if [ -d "$d" ]; then
        mv "$d"* "$1/" 2>/dev/null || true
        rmdir "$d"
    fi
done

# Usuwa podkatalogi z katalogu, przenosząc ich zawartość do katalogu nadrzędnego, działa tylko na jednym poziomie
