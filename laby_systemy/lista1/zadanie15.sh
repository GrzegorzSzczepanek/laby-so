#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
for f in $1/*; do
    if [ -f "$f" ] && [ -w "$f" ]; then
        touch "$f"
    fi
done


# Ustawia aktualny czas jako czas ostatniej modyfikacji dla wszystkich plików w katalogu, do których mamy prawo zapisu

