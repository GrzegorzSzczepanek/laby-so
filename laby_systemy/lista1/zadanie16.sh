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


# Wyszukuje podkatalogi w danym katalogu, które nie zawierają żadnych plików wykonywalnych
