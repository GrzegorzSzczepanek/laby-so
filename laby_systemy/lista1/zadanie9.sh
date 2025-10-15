#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
o=$(basename "$1")
> "$o"
while IFS= read -r line; do
    if [ -f "$line" ]; then
        echo "=== $line ===" >> "$o"
        cat "$line" >> "$o"
    fi
done < "$1"

# Łączy pliki wymienione w pliku listy w kolejności ich występowania na liście, dodając nagłówek z nazwą pliku, wynik zapisuje pod nazwą pliku listy.

