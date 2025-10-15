#!/bin/bash
if [ $# -ne 2 ]; then
    exit 1
fi
for f in $1/*; do
    if [ -f "$f" ] && [ ! -d "$f" ]; then
        b=$(basename "$f")
        if ! grep -q "^$b$" "$2"; then
            echo "Brak na liście: $b"
        fi
    fi
done
while IFS= read -r line; do
    if [ ! -e "$1/$line" ]; then
        echo "Brak w katalogu: $line"
    fi
done < "$2"

# Porównuje zawartość katalogu z listą plików, pokazując pliki brakujące w katalogu i te, które są na liście, ale nie istnieją.
