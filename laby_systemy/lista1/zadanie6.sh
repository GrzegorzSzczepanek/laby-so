#!/bin/bash
if [ $# -ne 1 ]; then
    exit 1
fi
n=1
for f in $(ls -S $1/* 2>/dev/null); do
    if [ -f "$f" ] && [ -x "$f" ]; then
        mv "$f" "$f.$n"
        n=$((n+1))
    fi
done

# Numeruje pliki wykonywalne w katalogu według ich wielkości, dodając do nazwy kolejny numer jako dodatkowe rozszerzenie.
