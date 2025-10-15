#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
for f in $1/*; do
    if [ -f "$f" ] && [ ! -x "$f" ]; then
        rm "$f"
    fi
done


# Kasuje wszystkie pliki w katalogu, które nie są wykonywalne, pozostawiając tylko pliki z ustawionym bitem execute
